var GameHelpers = {};

const PLAYER_BOX = { offsetX: 8.3, width: 9.3, height: 64 };

GameHelpers.Game = class {
  constructor(characterSprite, furnitureData, furnitureItems, debug = false) {
    this.characterSprite = characterSprite;
    this.furnitureData = furnitureData;
    this.furnitureItems = furnitureItems;
    this.debug = debug;
    this.params = new URLSearchParams(window.location.search); 
  }

  walkAnimation(key, frames, thiz) {
    const config = {
      key,
      frames: thiz.anims.generateFrameNumbers('player', { frames }),
      frameRate: 7,
      repeat: -1
    };

    thiz.anims.create(config);
  }

  constructWorld(thiz) {
    thiz.add.image(0, 0, 'background').setOrigin(0, 0);
    let furniture = [];
    this.furnitureItems.forEach((item) => {
      furniture.push(this.setFurniture(thiz, item.type, item.id, item.x, item.y));
    });
    return furniture;
  }

  setBoundaries(thiz, container, boundaries) {
    const hitArea = new Phaser.Geom.Rectangle(boundaries[0], boundaries[1], boundaries[2], boundaries[3]);
    container.setData('boundaries', boundaries);
    container.setInteractive(hitArea, Phaser.Geom.Rectangle.Contains);
    if (this.debug) {
      thiz.input.enableDebug(container);
    } 
  }

  enableDragging(thiz, container) {
    thiz.input.setDraggable(container);
    thiz.input.on('drag', (_pointer, gameObject, dragX, dragY) => {
      gameObject.x = dragX;
      gameObject.y = dragY;
    });
    thiz.input.on('dragend', (_pointer, gameObject) => {
      var xhr = new XMLHttpRequest();
      xhr.open("PATCH", `/furnitures/${gameObject.getData('id')}`, true);
      xhr.setRequestHeader('Content-Type', 'application/json');
      xhr.send(JSON.stringify({
          hush_key: this.params.get('hush_key'),
          furniture: {
            coordinate_x: gameObject.x,
            coordinate_y: gameObject.y
          }
      }));
    }); 
  }

  buildFurniture(thiz, name, id, startX = 10, startY = 10) {
    let data = this.furnitureData[name],
      container = thiz.add.container(startX, startY),
      array = [],
      y = 32,
      x = 32;
    data.sprites.forEach(layers => {
      layers.forEach(frame => {
        var sprite = thiz.add.image(x, y, 'furniture', frame);
        array.push(sprite);
        x += 32;
      });
      y += 32;
      x = 32;
    });

    container.add(array);
    container.setData('id', id);

    return container;
  }

  setFurniture(thiz, name, id, startX = 10, startY = 10) {
    let container = this.buildFurniture(thiz, name, id, startX, startY);
    this.setBoundaries(thiz, container, this.furnitureData[name].boundaries)
    this.enableDragging(thiz, container)
    return container;
  }

  createWalls(){
    this.walls = this.furnitureData.grounds.sprites.map((g) => new Phaser.Geom.Rectangle(g[0], g[1], g[2], g[3]));
  }

  loadPlayerAnimation(thiz, player) {
    this.walkAnimation('down', this.characterSprite.down, thiz);
    this.walkAnimation('left', this.characterSprite.left, thiz);
    this.walkAnimation('right', this.characterSprite.right, thiz);
    this.walkAnimation('up',  this.characterSprite.up, thiz);
    this.walkAnimation('idle', this.characterSprite.idle, thiz);
    this.createWalls();
    player.smoothed = false;
    thiz.physics.add.existing(player);
    // match the physics (pink) box to the collision box used for blocking
    player.body.setSize(PLAYER_BOX.width, PLAYER_BOX.height, false);
    player.body.setOffset(PLAYER_BOX.offsetX, 0);
  }

  furnitureBounds(furniture) {
    const [bx, by, bw, bh] = furniture.getData('boundaries');
    return new Phaser.Geom.Rectangle(furniture.x + bx, furniture.y + by, bw, bh);
  }

  // Player collision box shifted by (dx, dy). Moving up only uses the lower
  // half of the body so the player can walk partway behind furniture.
  playerBox(player, dx, dy, lowerHalfOnly) {
    const b = player.getBounds();
    const height = lowerHalfOnly ? PLAYER_BOX.height / 2 : PLAYER_BOX.height;
    return new Phaser.Geom.Rectangle(b.x + PLAYER_BOX.offsetX + dx, b.y + (PLAYER_BOX.height - height) + dy, PLAYER_BOX.width, height);
  }

  isCollidingWithPlayer(player, furniture, dx = 0, dy = 0, lowerHalfOnly = false) {
    const playerBox = this.playerBox(player, dx, dy, lowerHalfOnly);
    const furnitureBox = this.furnitureBounds(furniture);
    const isColliding = Phaser.Geom.Intersects.RectangleToRectangle(furnitureBox, playerBox);
    const collidingPoints = Phaser.Geom.Intersects.GetRectangleToRectangle(furnitureBox, playerBox);
    return { isColliding, collidingPoints };
  }

  wouldCollide(player, furnitures, dx, dy, lowerHalfOnly = false) {
    const box = this.playerBox(player, dx, dy, lowerHalfOnly);
    const hitsWall = (this.walls || []).some((w) => Phaser.Geom.Intersects.RectangleToRectangle(w, box));
    return hitsWall || furnitures.some((f) => this.isCollidingWithPlayer(player, f, dx, dy, lowerHalfOnly).isColliding);
  }

  updatePlayerMovement(player, cursors, furnitures) {
    const step = 1 / 60; // approximate seconds per frame
    player.body.velocity.x = 0;
    player.body.velocity.y = 0;
    if (cursors.left.isDown){
      const vx = -70;
      if (!this.wouldCollide(player, furnitures, vx * step, 0)) player.body.velocity.x = vx;
      if (player.anims.currentAnim.key !== 'left') player.play('left');
    } else if (cursors.right.isDown) {
      const vx = 100;
      if (!this.wouldCollide(player, furnitures, vx * step, 0)) player.body.velocity.x = vx;
      if (player.anims.currentAnim.key !== 'right') player.play('right');
    } else if (cursors.up.isDown){
      const vy = -100;
      if (!this.wouldCollide(player, furnitures, 0, vy * step, true)) player.body.velocity.y = vy;
      if (player.anims.currentAnim.key !== 'up') player.play('up');
    } else if (cursors.down.isDown) {
      const vy = 100;
      if (!this.wouldCollide(player, furnitures, 0, vy * step)) player.body.velocity.y = vy;
      if (player.anims.currentAnim.key !== 'down') player.play('down');
    } else {
      player.play('idle');
    }
  }

  debugOn(thiz){
    if (this.debug) {
      thiz.input.on('pointerdown', function (pointer) {
        const worldX = pointer.worldX;
        const worldY = pointer.worldY;
        console.log(worldX, worldY);
      }, thiz);
    }
  }
};

GameHelpers.config = function(debug, scene) {
  return {
    type: Phaser.CANVAS,
    width: 600,
    height: 400,
    transparent: true,
    parent: 'phaser-example',
    physics: {
        default: 'arcade',
        arcade: {
            gravity: {y: 0, x: 0},
            debug
        }
    },
    scene
  }
}

GameHelpers.preload = function(characterSprite, thiz) {
  thiz.load.spritesheet('player', characterSprite.spriteSheetName, { frameWidth: 32, frameHeight: 32});
  thiz.load.spritesheet('furniture', '/images/MainTileMap.png', { frameWidth: 32, frameHeight: 32});
  thiz.load.image('background', `/images/0.png`);
}

export default GameHelpers;

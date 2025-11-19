var GameHelpers = {};

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
    this.furnitureItems.forEach((item) => {
      this.setFurniture(thiz, item.type, item.id, item.x, item.y);
    });
  }

  setBoundaries(thiz, container, boundaries) {
    const hitArea = new Phaser.Geom.Rectangle(boundaries[0], boundaries[1], boundaries[2], boundaries[3]);
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

  createWalls(thiz){
    let ground = thiz.physics.add.staticGroup();
    this.furnitureData.grounds.sprites.forEach((g) => {
      ground.add(thiz.add.rectangle(g[0], g[1], g[2], g[3]).setOrigin(0)); 
    });
    return ground;
  }

  loadPlayerAnimation(thiz, player) {
    this.walkAnimation('down', this.characterSprite.down, thiz);
    this.walkAnimation('left', this.characterSprite.left, thiz);
    this.walkAnimation('right', this.characterSprite.right, thiz);
    this.walkAnimation('up',  this.characterSprite.up, thiz);
    this.walkAnimation('idle', this.characterSprite.idle, thiz);
    let ground = this.createWalls(thiz);
    thiz.physics.add.collider(player, ground);
    player.smoothed = false;
    thiz.physics.add.existing(player);
  }

  updatePlayerMovement(player, cursors) {
    player.body.velocity.x = 0;
    player.body.velocity.y = 0;
    if (cursors.left.isDown){
      player.body.velocity.x = -70;
      if (player.anims.currentAnim.key !== 'left') player.play('left');
    } else if (cursors.right.isDown) {
      player.body.velocity.x = 100;
      if (player.anims.currentAnim.key !== 'right') player.play('right');
    } else if (cursors.up.isDown){
      player.body.velocity.y = -100;
      if (player.anims.currentAnim.key !== 'up') player.play('up');
    } else if (cursors.down.isDown) {
      player.body.velocity.y = 100;
      if (player.anims.currentAnim.key !== 'down') player.play('down');
    } else {
      player.play('idle');
      player.body.velocity.y = 0;
      player.body.velocity.x = 0;
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

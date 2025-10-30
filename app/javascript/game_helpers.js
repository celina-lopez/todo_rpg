var GameHelpers = {};

GameHelpers.Game = class {
  constructor(characterSprite, furnitureData, furnitureItems) {
    this.characterSprite = characterSprite;
    this.furnitureData = furnitureData;
    this.userId = URLSearchParams(window.location.search).get('hush_key');
    this.furnitureItems = furnitureItems;
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
    this.furnitureItems.forEach((item) => {
      this.setFurniture(thiz, item.name, item.id, item.coordinate_x, item.coordinate_y);
    });
  }

  setFurniture(thiz, name, id, startX = 10, startY = 10) {
    let data = this.furnitureData[name],
      container = thiz.add.container(startX, startY),
      array = [],
      y = 32,
      x = 32,
      maxX;
    data.forEach(layers => {
      layers.forEach(frame => {
        var sprite = thiz.add.image(x, y, 'furniture', frame);
        array.push(sprite);
        x += 32;
      });
      y += 32;
      maxX = x;
      x = 32;
    });

    container.add(array);
    const hitArea = new Phaser.Geom.Rectangle(startX, startY, maxX + 32, data.length * 32 + 32);
    container.setInteractive(hitArea, Phaser.Geom.Rectangle.Contains);
    container.setSize(maxX, data.length * 32);
    container.setData('id', id);
    thiz.input.setDraggable(container);
    thiz.input.on('drag', (_pointer, gameObject, dragX, dragY) => {
      // TODO: maybe it drags every 32px
      gameObject.x = dragX;
      gameObject.y = dragY;
    });
    thiz.input.on('dragend', (pointer, gameObject) => {
      var xhr = new XMLHttpRequest();
      xhr.open("POST", `/user/${this.userId}/rooms/furnitures/${gameObject.getData('id')}`, true);
      xhr.setRequestHeader('Content-Type', 'application/json');
      xhr.send(JSON.stringify({
          hush_key: URLSearchParams(window.location.search).get('hush_key'),
          furniture: {
            coordinate_x: gameObject.x,
            coordinate_y: gameObject.y
          }
      }));
      console.log(gameObject.x, gameObject.y);
    });
    return container;
  }

  createWalls(thiz){
    let ground = thiz.physics.add.staticGroup();
    this.furnitureData.grounds.forEach((g) => {
      ground.add(thiz.add.rectangle(g[0], g[1], g[2], g[3]).setOrigin(0)); 
    });
    return ground;
  }

  loadPlayerAnimation(thiz) {
    this.walkAnimation('down', this.characterSprite.down, thiz);
    this.walkAnimation('left', this.characterSprite.left, thiz);
    this.walkAnimation('right', this.characterSprite.right, thiz);
    this.walkAnimation('up',  this.characterSprite.up, thiz);
    this.walkAnimation('idle', this.characterSprite.idle, thiz);
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

  debug(thiz, isActive = false){
    if (isActive) {
      thiz.input.on('pointerdown', function (pointer) {
        const worldX = pointer.worldX;
        const worldY = pointer.worldY;
        console.log(worldX, worldY);
      }, thiz);
    }
  }
};

export default GameHelpers;

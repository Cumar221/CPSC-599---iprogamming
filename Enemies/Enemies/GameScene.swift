//
//  GameScene.swift
//  Enemies
//
//  Created by Cumar Yusuf on 2016-11-16.
//  Copyright (c) 2016 Cumar Yusuf. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let enemy = SKSpriteNode(imageNamed: "Spaceship")
    var lastTouch: CGPoint? = nil
    var isTouched: Bool = false
    var sprites:[SKSpriteNode] = []
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        
        
        
        
        enemy.size.height = self.size.height/15
        enemy.size.width = self.size.width/18
        backgroundColor = SKColor.blackColor()
        enemy.position = CGPoint(x: size.width/2, y: size.height/2)
       
        
        addChild(enemy)
        
    }
    
    private func spritesCollection(count count: Int) -> [SKSpriteNode] {
        var sprites = [SKSpriteNode]()
        for _ in 0..<count {
            var sprite = SKSpriteNode(imageNamed: "Spaceship")
            // skipping the physicsBody stuff for now as it is not part of the question
            
            // giving the sprites a random position
            sprite.size.height = self.size.height/15
            sprite.size.width = self.size.width/18
            sprite.zRotation = CGFloat(M_PI)
            //let xPos = randomBetweenNumbers(0, secondNum: frame.width - 1000 )
            
            //let x = CGFloat(arc4random() % UInt32((self.frame.width)))
            //let y = CGFloat(arc4random() % UInt32((self.frame.height)))
            
            
            let x = CGFloat(arc4random() % UInt32((self.frame.width)))
            //let y = CGFloat(arc4random_uniform(UInt32(size.height/2)))
            sprite.position = CGPointMake(x, size.height)
            sprites.append(sprite)
        }
        return sprites
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // Get the position that was touched (a.k.a. ending point).
        let touchPosition = touches.first?.locationInNode(self)
        
        let touchedNode = self.nodeAtPoint(touchPosition!)
        
        // Get sprite's current position (a.k.a. starting point).
        let currentPosition = enemy.position
        
        // move enemy to touch point
        let moveAction = SKAction.moveTo(touchPosition!, duration: 1)
        let moveEnemyAction = SKAction.moveToY(CGFloat(-1000), duration: 10)
        
        // rotate enemy
        let angle = atan2(currentPosition.y - touchPosition!.y, currentPosition.x - touchPosition!.x)
        let rotateAction = SKAction.rotateToAngle(angle + CGFloat(M_PI*0.5), duration: 0.0)
        

    
        
        print("Began touch")
        isTouched = true
    
        for sprite in sprites{
            //sprite.runAction(moveEnemyAction)
           
        }
       //enemy.runAction(moveAction)
       //enemy.runAction(rotateAction)
       
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isTouched{
            
            reloadEnemy()
            
            let touchLocation = touches.first?.locationInNode(self)
            let previousLocation = touches.first?.previousLocationInNode(self)
            
            var enemyX = enemy.position.x + ((touchLocation?.x)! - (previousLocation?.x)!)
            var enemyY = enemy.position.y + ((touchLocation?.y)! - (previousLocation?.y)!)

            
            enemyX = max(enemyX, enemy.size.width/2)
            enemyX = min(enemyX,size.width - enemy.size.width/2)
            
            enemyY = max(enemy.size.height/2, enemyY)
            enemyY = min(size.height - enemy.size.height/2,enemyY)
            
            enemy.position = CGPoint(x: enemyX, y: enemyY)
        }
    }
    
    func reloadEnemy(){
        sprites = spritesCollection(count: 10)
        for sprite in sprites {
           
                        sprite.physicsBody = SKPhysicsBody()
            sprite.physicsBody?.affectedByGravity = true;
            physicsWorld.gravity = CGVectorMake(0, -0.5)
            
            addChild(sprite)
            
        }
        //print(physicsWorld.)

        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isTouched = false
    }

   
    override func update(currentTime: CFTimeInterval) {
        
       
    }
}

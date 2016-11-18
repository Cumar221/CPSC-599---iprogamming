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
    var sprites = [SKSpriteNode]()
    var timer = NSTimer()
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target:self, selector: Selector("reloadEnemy"), userInfo: nil, repeats: true)
        
        super.didMoveToView(view)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        enemy.physicsBody = SKPhysicsBody(rectangleOfSize: enemy.size);
        enemy.size.height = self.size.height/15
        enemy.size.width = self.size.width/10
        backgroundColor = SKColor.blackColor()
        enemy.position = CGPoint(x: size.width/2, y: size.height/2)
        enemy.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        enemy.physicsBody?.affectedByGravity = false
    
        enemy.physicsBody?.friction = 1
        addChild(enemy)
        
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
    
       

    
       //enemy.runAction(moveAction)
       //enemy.runAction(rotateAction)
       
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isTouched{
            
            
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
        var sprite = SKSpriteNode(imageNamed: "Spaceship")
        // skipping the physicsBody stuff for now as it is not part of the question
        
        // giving the sprites a random position
        sprite.size.height = self.size.height/15
        sprite.size.width = self.size.width/10
        sprite.zRotation = CGFloat(M_PI)
        let x = CGFloat(arc4random() % UInt32((self.size.width)))
        
        sprite.position = CGPointMake(x, self.frame.size.height)
        
        sprite.physicsBody = SKPhysicsBody()
        sprite.physicsBody?.affectedByGravity = false;
        physicsWorld.gravity = CGVectorMake(0, -0.5)
        
        sprites.append(sprite)
        addChild(sprite)
        
        fireBall(sprite.position)
        
        print("INNN \(sprites.count)")
        
    }
    
    func random() -> UInt32{
        var range = UInt32(0)...UInt32(size.width)
        return range.startIndex + arc4random_uniform(range.endIndex - range.startIndex + 1)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isTouched = false
    }
    
    func rotateEnemy(){
        for sprite in sprites{
            let touchPosition = enemy.position
            let currentPosition = sprite.position
            let angle = atan2(currentPosition.y - touchPosition.y, currentPosition.x - touchPosition.x)
            let rotateAction = SKAction.rotateToAngle(angle + CGFloat(M_PI*0.5), duration: 0.0)
            sprite.runAction(rotateAction)
        }
    }
   
    func followEnemy(){
        for sprite in sprites{
            let moveEnemyToPlayer = SKAction.moveTo(enemy.position, duration: 5)
            let moveEnemyDown = SKAction.moveToY(CGFloat(-1000), duration: 10)
            sprite.runAction(moveEnemyToPlayer)
           sprite.runAction(moveEnemyDown)
            
        }
    }
    
    
    func fireBall(pos: CGPoint){
        var fireBallParticle = SKEmitterNode(fileNamed: "MyParticle")
        
        fireBallParticle!.position = pos
        fireBallParticle!.name = "rainParticle"
        fireBallParticle!.targetNode = self.scene
        
        
        fireBallParticle!.physicsBody = SKPhysicsBody()
        fireBallParticle!.physicsBody?.affectedByGravity = true
        
        addChild(fireBallParticle!)

      
        
        let moveToPlayer = SKAction.moveTo(enemy.position, duration: 2)

        
        
        fireBallParticle?.runAction(moveToPlayer)
       
       
        
    }
    override func update(currentTime: CFTimeInterval) {
        followEnemy()
        rotateEnemy()
        
    }
}

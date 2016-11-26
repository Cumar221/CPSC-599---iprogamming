//
//  GameScene.swift
//  Enemies
//
//  Created by Cumar Yusuf on 2016-11-16.
//  Copyright (c) 2016 Cumar Yusuf. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate, AVAudioPlayerDelegate {
    let enemy = SKSpriteNode(imageNamed: "Spaceship")
    var lastTouch: CGPoint? = nil
    var isTouched: Bool = false
  
    
    /*******************************************************/
    
    var musicOnOff = Bool()
    
    var themePlayer: AVAudioPlayer!
    var effectShortPlayer: AVAudioPlayer!
    var effectLongPlayer: AVAudioPlayer!
    
    let themePath = NSBundle.mainBundle().pathForResource( "Theme", ofType: "mp3")
    let shootingPath = NSBundle.mainBundle().pathForResource( "Shooting", ofType: "mp3")
    let collisionPath = NSBundle.mainBundle().pathForResource( "Collision", ofType: "mp3")
    let launchPath = NSBundle.mainBundle().pathForResource("Launch", ofType: "mp3")
    let powerup1Path = NSBundle.mainBundle().pathForResource( "Powerup1", ofType: "mp3")
    let powerup2Path = NSBundle.mainBundle().pathForResource( "Powerup2", ofType: "mp3")
    let powerup3Path = NSBundle.mainBundle().pathForResource( "Powerup3", ofType: "mp3")

    /***************************************************************************/
    override func didMoveToView(view: SKView) {
        enemy.size.height = self.size.height/15
        enemy.size.width = self.size.width/10
        backgroundColor = SKColor.blackColor()
        enemy.position = CGPoint(x: size.width/2, y: size.height/2)
        
        addChild(enemy)
        
        /******************************************/
        if(musicOnOff == true){
            playThemeSound(themePath)
        }
        /******************************************/
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Began touch")
        isTouched = true
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
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isTouched = false
    }
    
    /******************************************************************************************/
    func playShortSound (soundPath: String?) {
        if soundPath != nil {
            let soundURL = NSURL.fileURLWithPath(soundPath!)
            do{
                effectShortPlayer = try AVAudioPlayer.init(contentsOfURL: soundURL)
                effectShortPlayer.play()
            } catch {
                NSLog("audio file is not found")
                print("audio file is not found")
            }
        }
    }
    
    func playLongSound (soundPath: String?) {
        if soundPath != nil {
            let soundURL = NSURL.fileURLWithPath(soundPath!)
            do{
                effectLongPlayer = try AVAudioPlayer.init(contentsOfURL: soundURL)
                effectLongPlayer.play()
            } catch {
                NSLog("audio file is not found")
                print("audio file is not found")
            }
        }
    }
    
    func playThemeSound (soundPath: String?) {
        if soundPath != nil {
            let soundURL = NSURL.fileURLWithPath(soundPath!)
            do{
                themePlayer = try AVAudioPlayer.init(contentsOfURL: soundURL)
                themePlayer.numberOfLoops = -1
                themePlayer.play()
            } catch {
                NSLog("audio file is not found")
                print("audio file is not found")
            }
        }
    }
    
    func musicOnOffFunc(result: Bool){
        musicOnOff = result
    }
    /**********************************************************************************************/
}

//
//  GameViewController.swift
//  Enemies
//
//  Created by Cumar Yusuf on 2016-11-16.
//  Copyright (c) 2016 Cumar Yusuf. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    /*******************************************************************/
    @IBOutlet weak var playPauseGameBtn: UIButton!
    let scene = GameScene(fileNamed:"GameScene")
    var musicOnOff = true
    var str = String()
    /******************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()

        if (scene != nil) {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
          
          
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene!.scaleMode = .ResizeFill
            
            scene?.musicOnOffFunc(musicOnOff)
            skView.presentScene(scene)
           
            
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    /**************************************************************************/
    @IBAction func playPauseGameAction(sender: AnyObject) {
        let pauseImg: UIImage = UIImage (named: "pauseIcon")!
        if(playPauseGameBtn.currentImage == pauseImg){
            playPauseGameBtn.setImage(UIImage(named: "playIcon"), forState: UIControlState.Normal)
            scene?.view?.paused = true
            if(scene?.themePlayer != nil){
                scene?.themePlayer.stop()
            }
        }
        else{
            playPauseGameBtn.setImage(UIImage(named: "pauseIcon"), forState: UIControlState.Normal)
            scene?.view?.paused = false;
            if(scene?.themePlayer != nil){
                scene?.themePlayer.play()
            }
        }
    }
    @IBAction func homeButtonAction(sender: AnyObject) {
        if(scene?.themePlayer != nil){
            scene?.themePlayer.stop()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController.isMemberOfClass(MainMenuViewController)){
            let destViewController: MainMenuViewController = segue.destinationViewController as! MainMenuViewController
            destViewController.musicOnOff = musicOnOff
        }
    }
    /**************************************************************************/
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

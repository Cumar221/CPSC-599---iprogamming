//
//  testViewController.swift
//  Enemies
//
//  Created by maya2016 on 2016-11-25.
//  Copyright © 2016 Cumar Yusuf. All rights reserved.
//

import UIKit


class OptionViewController: UIViewController {
    var musicOnOff = true

    @IBOutlet weak var musicSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(musicOnOff == true){
            musicSwitch.setOn(true, animated: true)
        }
        else{
            musicSwitch.setOn(false, animated: true)
        }

        // Do any additional setup after loading the view.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController.isMemberOfClass(GameViewController)){
            let destViewController: GameViewController = segue.destinationViewController as! GameViewController
            destViewController.musicOnOff = musicOnOff
        }
        else{
            let destViewController: MainMenuViewController = segue.destinationViewController as! MainMenuViewController
            destViewController.musicOnOff = musicOnOff

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onOffMusic(sender: AnyObject) {
        if(musicSwitch.on){
            musicOnOff = true
        }
        else{
            musicOnOff = false
        }
    }
}

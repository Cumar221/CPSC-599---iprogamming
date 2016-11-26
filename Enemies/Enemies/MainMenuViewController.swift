//
//  mainMenuViewController.swift
//  Enemies
//
//  Created by maya2016 on 2016-11-25.
//  Copyright © 2016 Cumar Yusuf. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    var musicOnOff = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController.isMemberOfClass(GameViewController)){
            let destViewController: GameViewController = segue.destinationViewController as! GameViewController
            destViewController.musicOnOff = musicOnOff
        }
        else if(segue.destinationViewController.isMemberOfClass(OptionViewController)){
            let destViewController: OptionViewController = segue.destinationViewController as! OptionViewController
            destViewController.musicOnOff = musicOnOff
        }
    }
}

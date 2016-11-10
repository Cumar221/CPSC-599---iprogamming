//
//  ViewController.swift
//  Spotify
//
//  Created by Cumar Yusuf on 2016-11-07.
//  Copyright © 2016 Cumar Yusuf. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SPTAudioStreamingPlaybackDelegate {
    let kClientID = "3d9996ceb4984dc78661435a8489b57e"
    let kCallbackURL = "cumarspotify://returnAfterLogin"
    let kTokenSwapURL = "http://localhost:1234/swap"
    let kTokenRefreshServiceURL = "http://localhost:1234/refresh"

    @IBOutlet weak var artWorkImageView: UIImageView!
    var session:SPTSession!
    var player: SPTAudioStreamingController?
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            loginButton.hidden = true
        
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateAfterFirstLogin", name: "loginSuccessful", object: nil)
       
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if let sessionObj: AnyObject = userDefaults.objectForKey("SpotifySession"){
        
            let sessionDataObj = sessionObj as! NSData
            let session = NSKeyedUnarchiver.unarchiveObjectWithData(sessionDataObj) as! SPTSession
            
            if !session.isValid(){
                SPTAuth.defaultInstance().renewSession(session, withServiceEndpointAtURL: NSURL(string: self.kTokenRefreshServiceURL), callback: {(error: NSError!, session: SPTSession!) -> Void in

                    if error == nil {
                       let sessionData = NSKeyedArchiver.archivedDataWithRootObject(session)
                        userDefaults.setObject(sessionData, forKey: "SpotifySession")
                        userDefaults.synchronize()
                        
                        self.session = session
                        self.playUsingSession(session)
                      
                    }else{
                        print("error refreshing session")
                    }
                    
                })
            }else{
                print("session valid")
                self.session = session
                playUsingSession(session)
            }
        }
        else{
            loginButton.hidden = false
        }
        
    }
    
    @IBAction func playPauseMusic(sender: AnyObject) {
        if player?.isPlaying == true {
            player?.setIsPlaying(false, callback: {(error: NSError!) -> Void in
                if error != nil {
                    print("Play & Pause button has an error \(error)")
                    return
                }
             })
        }else{
            player?.setIsPlaying(true, callback: { (error: NSError!) -> Void in
                if error != nil {
                    print("Play & Pause button has an error \(error)")
                    return
                }
            })
        }
    }
    func updateAfterFirstLogin (){
        loginButton.hidden = true;
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let sessionObj: AnyObject = userDefaults.objectForKey("SpotifySession"){
            let sessionDataObj = sessionObj as! NSData
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObjectWithData(sessionDataObj) as! SPTSession
            self.session = firstTimeSession
            playUsingSession(firstTimeSession)
            
        }
    
    }

    func playUsingSession(sessionObj: SPTSession){
        if player == nil{
            player = SPTAudioStreamingController(clientId: kClientID)
            player?.playbackDelegate = self
        }
        player?.loginWithSession(sessionObj, callback: {(error: NSError!) -> Void in
            if error != nil{
                print("Enabling playback go error \(error)")
                return
            }
            SPTRequest.requestItemAtURI(NSURL(string: "spotify:track:6fujklziTHa8uoM5OQSfIo"), withSession: sessionObj, callback: {(error: NSError!, albumObj: AnyObject!) -> Void in
                if error != nil {
                    print("Album lookup got error \(error)")
                    return
                }
                    let album = albumObj as! SPTTrack
                
                    self.player?.playTrackProvider(album, callback: nil)
            })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func loginWithSpotify(sender: AnyObject) {
        let auth = SPTAuth.defaultInstance()
        
        let loginURL = auth.loginURLForClientId(kClientID, declaredRedirectURL: NSURL(string: kCallbackURL), scopes: [SPTAuthStreamingScope])
        
        UIApplication.sharedApplication().openURL(loginURL)
    }
    
    func updateCoverArt(){
        if player?.currentTrackMetadata == nil{
            artWorkImageView.image = UIImage()
            return
        }
        
        let uri = player?.currentTrackMetadata[SPTAudioStreamingMetadataAlbumURI] as! String
        
        SPTAlbum.albumWithURI(NSURL(string: uri), session: session)  { (error: NSError!, albumObj:AnyObject!) -> Void in
            let album =  albumObj as! SPTAlbum
            
            if let imgURL = album.largestCover.imageURL as NSURL!{
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                    let error:NSError? = nil
                    var coverImage = UIImage()
                    
                
                    if let imageData = NSData(contentsOfURL: imgURL){
                        if error == nil{
                            coverImage = UIImage(data: imageData)!
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.artWorkImageView.image = coverImage
                    })
                })
            }
            
        }
    }
    
    func audioStreaming(audioStreaming: SPTAudioStreamingController!, didStartPlayingTrack trackUri: NSURL!) {
        updateCoverArt()
    }

}


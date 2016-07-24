//
//  Messages3ViewController.swift
//  Round
//
//  Created by John Champion on 7/23/16.
//  Copyright © 2016 Round Dev Team. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class MessagesViewController: JSQMessagesViewController {
    
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    
    // MARK: Properties
    var messages = [JSQMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "Mountain Chat"
        
        self.senderId = "0"
        self.senderDisplayName = "Name"
        
        // No avatars
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
        setupBubbles()
        
        let message1 = JSQMessage(senderId: "0", displayName: "name", text: "Do you want to go to the mountains on Friday?")
        let message2 = JSQMessage(senderId: "1", displayName: "name", text: "Will I have to pay for lodging?")
        let message3 = JSQMessage(senderId: "0", displayName: "name", text: "No")
        let message4 = JSQMessage(senderId: "1", displayName: "name", text: "Definitely!")
        messages.append(message1)
        messages.append(message2)
        messages.append(message3)
        messages.append(message4)
        
        self.collectionView.backgroundColor = UIColor(red: 65/255, green: 188/255, blue: 236/255, alpha: 1)
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen().bounds.width, height: 64))
        self.view.addSubview(navBar);
        self.view.bringSubviewToFront(navBar);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!,
                                     senderDisplayName: String!, date: NSDate!) {
        let message = JSQMessage(senderId: "0", displayName: "name", text: text)
        messages.append(message)
        
        // 4
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        // 5
        finishSendingMessage()
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
        
    }
    
    private func setupBubbles() {
        let factory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = factory.outgoingMessagesBubbleImageWithColor(
            /*UIColor.jsq_messageBubbleBlueColor()*/UIColor.whiteColor())
        incomingBubbleImageView = factory.incomingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleLightGrayColor())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
            as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView!.textColor = UIColor.blackColor()
        } else {
            cell.textView!.textColor = UIColor.blackColor()
        }
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

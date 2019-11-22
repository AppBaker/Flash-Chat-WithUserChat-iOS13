//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var actiityIndictor: UIActivityIndicatorView!
    
    let db = Firestore.firestore()
    var messages = [Message]()
    var position: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actiityIndictor.hidesWhenStopped = true
        activityIndicatorBehavior(animation: true)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessage(by index: Int) {
        db.collection(K.FStore.collectionName)
    }
    
    func loadMessages() {
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageBody = data[K.FStore.bodyField] as? String, let messageSender = data[K.FStore.senderField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            self.tableView.reloadData()
                            self.tableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .top, animated: false)
                        }
                    }
                }
            }
            self.activityIndicatorBehavior(animation: false)
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        guard let messageBody = messageTextfield.text, messageTextfield.text != "" else { return }
        if let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data:
                [
                    K.FStore.senderField : messageSender,
                    K.FStore.bodyField : messageBody,
                    K.FStore.dateField : Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data o firebase, \(e)")
                } else {
                    print("Successfully saved data.")
                }
            }
        }
        messageTextfield.text = ""
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        if Auth.auth().currentUser?.email == message.sender {
            cell.youAvatar.isHidden = true
            cell.avatar.isHidden = false
            cell.boobleMessage.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            cell.youAvatar.isHidden = false
            cell.avatar.isHidden = true
            cell.boobleMessage.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        cell.messageLabel.text = messages[indexPath.row].body
        cell.senderLabel.text = messages[indexPath.row].sender
        
        return cell
        
    }
    
    func activityIndicatorBehavior(animation: Bool) {
        if animation {
            UIView.animate(withDuration: 0.1) {
                self.view.alpha = 0.7
            }
            actiityIndictor.startAnimating()
        } else {
            UIView.animate(withDuration: 0.1) {
                self.view.alpha = 1
            }
            actiityIndictor.stopAnimating()
        }
    }
}

extension ChatViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        position = indexPath
    }
    
}

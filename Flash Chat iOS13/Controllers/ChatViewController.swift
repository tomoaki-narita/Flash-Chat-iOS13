//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore() //firestoreをインスタンス化
    
    //cellに表示するメッセージと送信者を格納する
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        title = K.appName //chat画面のtitle
        navigationItem.hidesBackButton = true //chat画面のナビゲーションバーからBackボタンを消す
        //textfieldを角丸に
        messageTextfield.layer.masksToBounds = true
        messageTextfield.layer.cornerRadius = messageTextfield.frame.size.height / 2.5
        
        //作成したxib(cell)の名前とidをtableViewに紐付ける
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        //loadMessagesメソッドを実行
        loadMessages()
        
    }
    
    func loadMessages(){
        //リアルタイムでデータベースからデータを取得して、messages配列に入れる
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            //messages配列を空にする
            self.messages = []
            
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String,
                           let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true) //一番下のcellを上までスクロールさせる
                            }
                        }
                    }
                }
            }
        }
    }
    
    //送信ボタン
    @IBAction func sendPressed(_ sender: UIButton) {
        //messageTextfieldのtextとcurrentUserのemailがnilでなければこの中の処理を実行
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            //nilでなければそのデータをFirebase,Firestoreに送信して、データベースに保存
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
                
            ]) { error in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    //送信成功したらmessageTestfieldのtextを空にする
                    //送信ボタンを押したと同時に空にするのではなく、ボタンを押した後に送信成功したタイミングで空にしたいのでDispatchQueue.main.asyncを使う
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                    
                }
            }
        }
    }
    
    //ログアウトして最初の画面に戻るボタン
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do { //エラーが出る可能性のあるメソッドの実行
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true) //navigationControllerの最初の画面に戻るコード
        } catch let signOutError as NSError { //エラーが出た場合の処理
            print("Error signing out: %@", signOutError)
        }
        
    }
    
}

//extensionでスーパークラスを追加する
extension ChatViewController: UITableViewDataSource{
    //必須メソッド。cellの数とcellに表示する内容
    //tableViewに表示するcellの数はmassageに入っている要素の数に
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    //cellに表示させる内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        //自分が送信した場合
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImsgeView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
            //相手が送信した場合
        } else {
            cell.leftImsgeView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        return cell
    }
}


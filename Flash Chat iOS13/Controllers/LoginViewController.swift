//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

//ログイン画面
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        //emailとpasswordのテキストフィールドに値が入って来たら、定数emailとpasswordに代入して中の処理を実行
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            //定数email、passwordをセットしてFirebaseと通信し、登録されているemail,passwordと一致するか判定
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                //もしerrorに値が入って来たら定数eに代入してprint
                if let e = error {
                    print(e)
                //そうでなかったら(一致したら)、segueを実行しchat画面に遷移
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
        
    }
    
}

//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

//新規登録ページ
import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        //メールアドレスとパスワードのtextに値が入っていたら定数emailとpasswordにそれぞれの値を代入して中の処理を実行
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            
            //Firebaseと通信してemailとpasswordをセット。
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                //もしerrorに値が入って来たら、定数eに代入してprint
                if let e = error{
                    print(e.localizedDescription)
                    //そうでなければ(登録成功したら)、segueでchat画面に遷移
                } else {
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
    
}

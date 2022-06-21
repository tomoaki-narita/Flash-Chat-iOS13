//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel //cocoapodsで追加したライブラリをimport。タイトルにアニメーションをつける

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel! //LabelのスーパークラスをCLTypingLabelにする
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true //ナビゲーションバーを非表示に
    }
    
    //次の画面が表示される前に呼ばれる
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false //ナビゲーションバーを表示
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName //CLTypingLabelクラスを親にもったlabelなので、textに値を入れるだけでアニメーションされる
        
        //ライブラリ無しのコードで実装する方法
//        //タイトルのFlashChatのアニメーション表示
//        titleLabel.text = "" //最初に画面が表示された時は文字列を空にしておく
//        let titleText = "⚡️FlashChat" //表示したい文字列を定数titleTextに入れる
//        var charIndex = 0.0 //各文字にインデックス番号を割り当てて扱う変数
//        for letter in titleText{ //for文で1文字ずつletterに入れる。titleTextに入っている文字の数だけ実行される。
//            //一瞬で表示されてしまうので、タイマーの設定をして1文字ずつ遅れて表示させる
//            //charIndexで掛け算しないと1文字目にのみタイマーが適用されて1文字目と同じタイミングで他の文字が表示されてしまう
//            //0.15 x charIndexとすると、charIndexはインクリメントされていくので各文字0.15秒後に実行される。
//            Timer.scheduledTimer(withTimeInterval: 0.15 * charIndex, repeats: false) { timer in
//                self.titleLabel.text?.append(letter) //titleLabelのtextに1文字ずつ入ってくる文字を追加
//            }
//            charIndex += 1 //インクリメントして各文字のインデックス番号として扱う
//
//        }
       
    }
    

}

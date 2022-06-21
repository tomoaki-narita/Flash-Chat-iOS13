//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by output. on 2022/06/13.
//  Copyright © 2022 Angela Yu. All rights reserved.
//
//文字列のタイプミスを防ぐ為に文字列をあらかじめ構造体Kにまとめて定義しておく
struct K {
    static let appName = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat" //新規登録画面からchat画面に遷移するsegueのid
    static let loginSegue = "LoginToChat" //ログイン画面からchat画面に遷移するsegueのid
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}

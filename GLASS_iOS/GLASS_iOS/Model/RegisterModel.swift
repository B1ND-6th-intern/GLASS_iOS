//
//  RegisterModel.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/28.
//

import Foundation

struct Register: Codable {
    var status: Int
    var error: String?
    var message: String?
}

struct Getemail: Codable {
    var status: Int
    var error: String?
    var message: String?
}

struct Resend: Codable{
    var status: Int
    var error: String?
    var message: String?
}

struct LogIn: Codable {
    var status: Int
    var error: String?
    var message: String?
    var token: String?
}

struct ImagePost: Codable{
    var status: Int
    var error: String?
    var message: String?
    var jsonUrl: String?
}

struct Post: Codable{
    var status: Int
    var error: String?
    var message: String?
}

//class Owner: Codable{
//    var name: String
//    var avatar: String
//    var stuNumber: Int
//    var classNumber: Int
//    var grade: Int
//    var permission: Int
//}
//
//class Writings: Codable{
//    var hashtags: String?
//    var imgs: String?
//    var text: String?
//    var _id: String?
//    var owner: Owner
//    var isLike: DarwinBoolean
//    var likeCount: Int
//}
//class HomeResponse: Codable{
//    var writings: Writings
//}
//

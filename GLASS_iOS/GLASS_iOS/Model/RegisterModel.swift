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
    var message: String?
    var jsonUrl: [String]
}

struct Post: Codable{
    var status: Int
    var error: String?
    var message: String?
    var jsonUrl: [String]
}

class Owner: Codable {
    var name: String
    var avatar: String
    var stuNumber: Int
    var classNumber: Int
    var grade: Int
    var permission: Int
    
    enum OwnerKeys: String, CodingKey {
        case name
        case avatar
        case stuNumber
        case classNumber
        case grade
        case permission
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OwnerKeys.self)
        
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        self.stuNumber = try container.decodeIfPresent(Int.self, forKey: .stuNumber) ?? 0
        self.classNumber = try container.decodeIfPresent(Int.self, forKey: .classNumber) ?? 0
        self.grade = try container.decodeIfPresent(Int.self, forKey: .grade) ?? 0
        self.permission = try container.decodeIfPresent(Int.self, forKey: .permission) ?? 0
    }
    
    internal init(name: String, avatar: String, stuNumber: Int, classNumber: Int, grade: Int, permission: Int) {
        self.name = name
        self.avatar = avatar
        self.stuNumber = stuNumber
        self.classNumber = classNumber
        self.grade = grade
        self.permission = permission
    }
}

struct Writings: Codable{
    var hashtags: [String?]
    var imgs: [String]
    var text: String?
    var _id: String
    var owner: Owner
    var isLike: Bool
    var likeCount: Int
}

struct HomeResponse: Codable{
    var writings: [Writings]
}

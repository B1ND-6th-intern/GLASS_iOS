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

//
//  UserAccount.swift
//  1homework5m
//
//  Created by mavluda on 28/5/23.
//

import Foundation
import Locksmith

struct UserAccount: CreateableSecureStorable, GenericPasswordSecureStorable, ReadableSecureStorable {
  let username: String
  let password: String

  let service = "UserAuthorization"
  var account: String { return username }

  var data: [String: Any] {
    return ["password": password]
  }
}

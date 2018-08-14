//
//  Config.swift
//  SmartWOS
//
//  Created by Kevin Lu on 8/2/18.
//  Copyright © 2018 Kevin Lu. All rights reserved.
//

import Foundation
import Foundation

struct Config {
  static let username = "dev@uscabinetdepot.com"
  static let password = "dev@uscd"
  static let apiHost = "https://core-staging.smartwos.com"
  static let apiPrefix = "api/v1"
  static let apiRoute = "\(apiHost)/\(apiPrefix)"

  static let listFinalmilesURL = "\(apiRoute)/finalmiles/search"

  static func getBasicAuth() -> String {
    let userPasswordString = "\(username):\(password)"
    let userPasswordData = userPasswordString.data(using: String.Encoding.utf8, allowLossyConversion: false)
    let base64EncodedCredential = userPasswordData?.base64EncodedString() ?? "XXXX"
    return base64EncodedCredential
//    return "Basic \(base64EncodedCredential ?? "")"
  }


  static func searchFinalmileURL(searchValue: String) -> String {
    return "\(apiRoute)/finalmile/" + searchValue

  }

  static func getItemByScannedUpcOrSku(scannedValue: String) -> String {
    return "\(apiRoute)/item/get_scanned/" + scannedValue

  }
}
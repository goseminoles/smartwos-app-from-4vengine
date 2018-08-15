import Foundation

struct RestClientConfig {
  static let userName = "myusername"
  static let password = "my password"
  static let host = "host url"
  static let basePath = "base path"

  static func getHeaders() -> [String: String] {
    let base64EncodedCredential = "\(userName):\(password)"
        .data(using: String.Encoding.utf8)?
        .base64EncodedString() ?? ""

    let headers = [
      "Authorization": "Basic \(base64EncodedCredential)",
      "Accept": "application/json",
      "Content-Type": "application/json"
    ]
    return headers
  }

  static func getBaseUrl() -> String {
    let baseUrl = URL(string: host)?
        .appendingPathComponent(basePath)
        .absoluteString

    return baseUrl!;
  }
}
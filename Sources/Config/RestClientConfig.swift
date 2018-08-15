import Foundation

struct RestClientConfig {
  static let userName = "dev@uscabinetdepot.com"
  static let password = "dev@uscd"
  static let host = "https://core-staging.smartwos.com"
  static let basePath = "api/v1"

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
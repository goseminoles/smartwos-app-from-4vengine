import Foundation
import Alamofire
import RxSwift

struct LabelService {
  typealias LabelItem = Models.LabelItem

  enum GetLabelItemsFailureReason: Int, Error {
    case unAuthorized = 401
    case notFound = 404
    case internalServerError = 500
  }

  func getLabelItems(for orderId: String) -> Observable<[LabelItem]> {
    print("starting to fetch items")
    return Observable.create { observer -> Disposable in
      Alamofire.request(
              self.makeEndpoint(path: "mocked/labels/items", for: orderId),
              method: .get,
              parameters: nil,
              encoding: URLEncoding.default,
              headers: RestClientConfig.getHeaders())
          .responseJSON { response in
            switch response.result {
            case .success:
              do {
                guard let data = response.data else {
                  observer.onError(response.error ?? GetLabelItemsFailureReason.notFound)
                  return
                }

                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let labelItems = try jsonDecoder.decode([LabelItem].self, from: data)
                observer.onNext(labelItems)
              } catch {
                observer.onError(error)
              }
            case .failure(let error):
              if let statusCode = response.response?.statusCode,
                 let reason = GetLabelItemsFailureReason(rawValue: statusCode) {
                observer.onError(reason)
              }
              observer.onError(error)
            }
          }

      return Disposables.create()
    }
  }

  func makeEndpoint(path: String, for orderId: String) -> URLConvertible {
    return "\(RestClientConfig.getBaseUrl())/\(path)/\(orderId)"
  }
}

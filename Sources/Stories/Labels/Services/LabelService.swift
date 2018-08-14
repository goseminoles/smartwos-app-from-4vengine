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
              headers: self.makeHeaders())
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

//  // MARK: - PostFriend
//  enum PostFriendFailureReason: Int, Error {
//    case unAuthorized = 401
//    case notFound = 404
//  }
//
//  func postFriend(firstname: String, lastname: String, phonenumber: String) -> Observable<Void> {
//    let param = ["firstname": firstname,
//                 "lastname": lastname,
//                 "phonenumber": phonenumber]
//
//    return Observable<Void>.create { [param] observer -> Disposable in
//      Alamofire.request("https://friendservice.herokuapp.com/addFriend", method: .post, parameters: param, encoding: JSONEncoding.default)
//          .validate()
//          .responseJSON { [observer] response in
//            switch response.result {
//            case .success:
//              observer.onNext(())
//            case .failure(let error):
//              if let statusCode = response.response?.statusCode,
//                 let reason = PostFriendFailureReason(rawValue: statusCode)
//              {
//                observer.onError(reason)
//              }
//              observer.onError(error)
//            }
//          }
//
//      return Disposables.create()
//    }
//  }
//
//  // MARK: - PatchFriend
//  enum PatchFriendFailureReason: Int, Error {
//    case unAuthorized = 401
//    case notFound = 404
//  }
//
//  func patchFriend(firstname: String, lastname: String, phonenumber: String, id: Int) -> Observable<LabelItem> {
//    let param = ["firstname": firstname,
//                 "lastname": lastname,
//                 "phonenumber": phonenumber]
//    return Observable.create { observer in
//      Alamofire.request("https://friendservice.herokuapp.com/editFriend/\(id)", method: .patch, parameters: param, encoding: JSONEncoding.default)
//          .validate()
//          .responseJSON { response in
//            switch response.result {
//            case .success:
//              do {
//                guard let data = response.data else {
//                  // want to avoid !-mark for unwrapping. Incase there is no data and
//                  // no error provided by alamofire return .notFound error instead.
//                  // .notFound should never happen here?
//                  observer.onError(response.error ?? GetFriendsFailureReason.notFound)
//
//                  return
//                }
//
//                let labelItem = try JSONDecoder().decode(LabelItem.self, from: data)
//                observer.onNext(labelItem)
//              } catch {
//                observer.onError(error)
//              }
//            case .failure(let error):
//              if let statusCode = response.response?.statusCode,
//                 let reason = PatchFriendFailureReason(rawValue: statusCode)
//              {
//                observer.onError(reason)
//              }
//
//              observer.onError(error)
//            }
//          }
//
//      return Disposables.create()
//    }
//  }

  // MARK: - DeleteFriend
  enum DeleteFriendFailureReason: Int, Error {
    case unAuthorized = 401
    case notFound = 404
  }

  func deleteFriend(id: Int) -> Observable<Void> {
    return Observable.create { observable -> Disposable in
      Alamofire.request("https://friendservice.herokuapp.com/editFriend/\(id)", method: .delete, parameters: nil, encoding: JSONEncoding.default)
          .validate()
          .responseJSON { response in
            switch response.result {
            case .success:
              observable.onNext(())
            case .failure(let error):
              if let statusCode = response.response?.statusCode,
                 let reason = DeleteFriendFailureReason(rawValue: statusCode) {
                observable.onError(reason)
              }
              observable.onError(error)
            }
          }

      return Disposables.create()
    }
  }

  func makeHeaders() -> [String: String] {
    let credential = Config.getBasicAuth()
    print("XXX credential: \(credential)")


    let headers = [
      "Authorization": "Basic \(credential)",
      "Accept": "application/json",
      "Content-Type": "application/json"
    ]

    //    let headers = [
//      "Authorization": "Basic \(credential)",
//      "Accept": "application/json",
//      "Content-Type": "application/json"]
    return headers
  }

  func makeEndpoint(path: String, for orderId: String) -> URLConvertible {
    return "\(Config.apiRoute)/\(path)/\(orderId)"
  }
}

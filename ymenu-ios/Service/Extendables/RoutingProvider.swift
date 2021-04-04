//
//  RoutingProvider.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 31/03/2021.
//

import Foundation

protocol RoutingProvider: ObservableObject, Weakable {}

extension RoutingProvider {
    private func send<T: Routing>(with routing: T, completion: @escaping (Result<Data?, Error>) -> Void) {
        guard let request = routing.urlRequest else {
            completion(.failure(NSError(domain: "REQUEST_ERROR", code: 500, userInfo: nil)))

            return
        }
        
        let sendRequest = {
            URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
                guard let response = urlResponse as? HTTPURLResponse else {
                    completion(.failure(NSError(domain: "RESPONSE_ERROR", code: 500, userInfo: nil)))

                    return
                }
                
                if routing.successStatusCodes.contains(response.statusCode) {
                    completion(.success(data))
                } else if let error = error {
                    completion(.failure(error))
                    
                    return
                } else {
                    completion(.failure(NSError(domain: "STATUS_CODE_ERROR", code: response.statusCode, userInfo: nil)))
                    
                    return
                }
            }.resume()
        }
        
//        if routing.authenticationType == .JWTBearer {
//            checkRefreshToken {
//                sendRequest()
//            }
//        } else {
            sendRequest()
//        }
    }

//    private func checkRefreshToken(with sendRequest: @escaping () -> Void) {
//        if let isExpired = ApplicationState.shared.jwtTokenIsExpired,
//           isExpired == true {
//            guard let refreshToken = ApplicationState.shared.jwtRefreshToken else {
//                ApplicationState.shared.disconnect()
//                return
//            }
//
//            let parameters = RefreshTokenWebServiceParameters(refreshToken: refreshToken)
//            let service = RefreshTokenWebService()
//            service.call(parameters: parameters)
//
//            execute(with: service) { result in
//                print(result)
//                switch result {
//                case .failure(_):
//                    ApplicationState.shared.disconnect()
//                case .success(let tokenPair):
//                    ApplicationState.shared.authenticate(with: tokenPair)
//                    sendRequest()
//                }
//            }
//        } else {
//            sendRequest()
//        }
//    }
    
    func execute<T: Routing>(
        with routing: T,
        completion: @escaping (Result<Void, Error>) -> Void
    ) where T.DecodeType == EmptyCodable {

        send(with: routing) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(_):
                completion(.success(()))
            }
        }
    }
    
    func execute<T: Routing>(
        with routing: T,
        completion: @escaping (Result<T.DecodeType, Error>) -> Void
    ) where T.DecodeType: Decodable {

        send(with: routing) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    guard let data = data else {
                        completion(.failure(NSError(domain: "DDECODE_ERROR", code: 500, userInfo: nil)))
                        
                        return
                    }
                    let decoded = try JSONDecoder().decode(T.DecodeType.self, from: data)
                    
                    completion(.success(decoded))
                } catch (let error) {
                    completion(.failure(error))
                }
            }
        }
    }
}

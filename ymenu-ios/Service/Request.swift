//
//  Request.swift
//  ymenu-ios
//
//  Created by Léo GIGANT on 23/11/2020.
//

import Foundation

class Request {
    private let domain = "https://ymenu.herokuapp.com/api"
    private var path: String = "/"
    private var body: Encodable?
    private var method: HTTPMethod1 = .GET
    private var token: String?
    private let encoder = JSONEncoder()
    private var canRefreshToken = true
    
    func setPath(_ path: String) -> Request {
        self.path = path
        return self
    }
    
    func setBody(_ body: Encodable) -> Request {
        self.body = body
        return self
    }
    
    func setMethod(_ method: HTTPMethod1) -> Request {
        self.method = method
        return self
    }
    
    func disableCanRefreshToken() -> Request {
        self.canRefreshToken = false
        
        return self
    }
    
    private func getFullUrl() -> URL? {
        let url = "\(self.domain)\(self.path)"
        return URL(string: url)
    }
    
    private func decodeData<T: Decodable>(_ type: T.Type, data: Data) -> Result<GenericServerResponse<T>, Error> {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(GenericServerResponse<T>.self, from: data)
            return .success(decodedData)
        } catch let error {
            return .failure(error)
        }
    }
    
    private func getRequest() -> URLRequest? {
        guard let url = self.getFullUrl() else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let safeToken = self.token {
            request.addValue("Bearer \(safeToken)", forHTTPHeaderField: "Authorization")
        }
        
        guard let body = body else {
            return request
        }
        
        let encodable = AnyEncodable(body)
        request.httpBody = try? JSONEncoder().encode(encodable)
                
        return request
    }
    
    private func callRequest(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = self.getRequest() else { return }
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data, let urlResponse = urlResponse as? HTTPURLResponse else { return }
            
            do {
                print("Status code : \(urlResponse.statusCode)")
                if urlResponse.statusCode == 401 {
                    // TODO IF WE ADDED AUTHENTICATION
                    
                    return
                } else if urlResponse.statusCode != 200 && urlResponse.statusCode != 201 && urlResponse.statusCode != 204 {
                    throw NSError(domain: "The status code announces an error.", code: urlResponse.statusCode)
                }
                
                completion(.success(data))
                
            } catch let parseError as NSError {
                completion(.failure(parseError))
            }
            
        }.resume()
    }
    
    func sendWithDecode<T:Decodable>(_ type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        callRequest { result in
            do {
                let decoder = JSONDecoder()
                
                switch result {
                case .success(let data):
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            } catch let error {
                return completion(.failure(error))
            }
        }
    }
    
    func withAuthentication() -> Request {
//           guard let tokenSaved = AuthenticationManager.getToken() else {
//               return self
//           }
        
           self.token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiI2MDY0MzMzODRhMjVkZDAwMTdjYzRmMTkiLCJpYXQiOjE2MTc1NzM0ODN9.0t-kd7lB9D-YNhId8iXyqU5WnkdPPomblrTqS5uzp5w"
           return self
     
       }
    
    func send(completion: @escaping (Result<NSNull, Error>) -> Void) {
        callRequest {
            switch $0 {
            case .success(_):
                completion(.success(.init()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

enum HTTPMethod1: String {
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

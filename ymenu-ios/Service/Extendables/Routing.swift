//
//  Routing.swift
//  ymenu-ios
//
//  Created by Zakarya TOLBA on 31/03/2021.
//

import Foundation

struct EmptyCodable: Encodable {}

protocol Routing {
    associatedtype ParameterTypes: Encodable
    associatedtype DecodeType
    
    /// Base url for the current route. Can be specifed for all routes in the extension, and/or seperatly for each route
    var baseURL: Hostname { get }
    
    /// HTTP request method to be used for this route
    var method: HTTPMethod { get }
    
    /// The url path for this route
    var path: String { get }
    
    /// Keys and values to be replaced in given path
    ///
    /// if URL is dynamic, keys need to be replaced by values
    /// which are available in Routing
    ///
    /// Exemple:
    ///
    /// - key: "orderId"
    /// - in URL "{orderId}"
    ///
    /// `{ }` will be replaced automatically
    var pathKeysValues: [String: String]? { get }
    
    /// The request parameters for current route
    var parameters: ParameterTypes? { get set }
    
    /// The request headers for the current route
    var headers: [String: String] { get }
    
    /// The calculated property for the routing. Setups all necessary properties for current request.
    var urlRequest: URLRequest? { get }
    
    var successStatusCodes: Set<Int> { get }
    
    var authenticationType: AuthenticationType { get }
}

extension Routing {
    var method: HTTPMethod {
        return .POST
    }
    
    var pathKeysValues: [String: String]? {
        return nil
    }
    
    var parameters: ParameterTypes? {
        return nil
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
    
    var successStatusCodes: Set<Int> {
        return Set<Int>(200...209)
    }
    
    var authenticationType: AuthenticationType {
        return .none
    }
    
    var publicKey: String? {
        return nil
    }
    
    var computedUrl: URL? {
        guard let baseURL = URL(string: baseURL.rawValue) else {
            print("baseURL is nil when creating urlRequest in \(self)")
            
            return nil
        }
        
        return computeURL(baseURL: baseURL)
    }
    
    func computeURL(baseURL: URL) -> URL? {
        let urlString = path.isEmpty
            ? baseURL.absoluteString
            : baseURL.appendingPathComponent(path).absoluteString
        
        return urlString.isEmpty ? baseURL : URL(string: urlString)
    }
    
    var urlRequest: URLRequest? {
        if let computedUrl = computedUrl {
            return createRequest(for: computedUrl)
        } else {
            print("computedUrl is nil in \(self) when creating urlRequest")
            
            return nil
        }
    }
    
    /// Create URL - adding headers and encode parameters
    ///
    /// - Parameter url: given url: URL
    /// - Returns: URLRequest created from URL with headers and parameters
    func createRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if authenticationType == .JWTBearer,
           let bearerToken = ApplicationState.shared.jwtToken {
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "authorization")
        }
        
        if let parameters = self.parameters {
            do {
                
                request.httpBody = try JSONEncoder().encode(parameters)
            } catch {
                print(error)
            }
        }
        
        return request
    }
    
    func generateRequest(for url: URL) -> URLRequest {
        return createRequest(for: url)
    }
}

enum HTTPMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
}

enum AuthenticationType {
    case JWTBearer
    case none
}

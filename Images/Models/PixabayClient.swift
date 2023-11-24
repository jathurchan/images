import Foundation

let validStatus = 200...299

class PixabayClient {
    private static let apiKey = "18021445-326cf5bcd3658777a9d22df6f"
    private static let baseURL = URL(string: "https://pixabay.com/api/")!
    
    private lazy var decoder: JSONDecoder = JSONDecoder()
    
    func loadHits(query: String = "", page: Int?, perPage: Int?, _ completion: @escaping ([Hit], HitError?) -> Void) -> URLSessionDataTask? {
        let url = buildUrl(query: query, page: page, perPage: perPage)
        
        let task = URLSession.shared.dataTask(with: url as URL) { [unowned self] (data, response, _) in
            
            guard let data,
                  let response = response as? HTTPURLResponse,
                  validStatus.contains(response.statusCode) else {
                DispatchQueue.main.async {
                    completion([], HitError.networkError)
                }
                return
            }
            
            do {
                let pixabayJSON: PixabayJSON = try self.decoder.decode(PixabayJSON.self, from: data)
                DispatchQueue.main.async {
                    completion(pixabayJSON.hits, nil)   // Success
                }
                
            } catch HitError.missingData {
                DispatchQueue.main.async {
                    completion([], .missingData)
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion([], HitError.unexpectedError(Error: error))
                }
            }
        }
        
        task.resume()
        
        return task
    }
    
    private func buildUrl(query: String?, page: Int?, perPage: Int?) -> URL {
        var queryItems: [URLQueryItem] = [URLQueryItem(name: "key", value: PixabayClient.apiKey)]
        
        if let query = query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           query != "" {
            queryItems.append(URLQueryItem(name: "q", value: query))
        }
        if let page {
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        }
        if let perPage {
            
            guard perPage <= 200 && perPage >= 3 else {
                fatalError("Accepted values: 3 - 200")
            }
            queryItems.append(URLQueryItem(name: "per_page", value: String(perPage)))
        }
        
        let url = PixabayClient.baseURL.appending(queryItems: queryItems)
        return url
    }
    
    
}

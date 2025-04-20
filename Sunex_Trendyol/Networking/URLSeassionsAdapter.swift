import Foundation

class URLSeassionsAdapter: APIService,TrendyOlAPIService {
    
    func fetchNews(with request: SunexAzModel.Request, completion: @escaping (Result<SunexAzModel.Response, Error>) -> Void) {
        guard let request = requestBuilder(with: "https://run.mocky.io/v3/ca3c7f1f-595d-4f5b-9ea6-b068d4433e4f",
                                           method: .get, body: nil) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        taskBuilder(request: request, completion: completion)
    }
    
    func fetchTrendyolNews(with request: TrendyOlModel.Request, completion: @escaping (Result<TrendyOlModel.Response, Error>) -> Void) {
        guard let request = requestBuilder(with: "https://run.mocky.io/v3/e9702800-a10e-4048-8916-36a3535bcd12",
                                           method: .get, body: nil) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        taskBuilder(request: request, completion: completion)
    }
    
    private func taskBuilder<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Something went wrong service...\(error)")
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid Response", code: 500, userInfo: nil)))
                return
            }
            
            let statusCode = response.statusCode
            if let data = data {
                do {
                    if (200...299).contains(statusCode) {
                        let dataResponse = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(dataResponse))
                    } else {
                        let errorMessage = "Error: \(statusCode)"
                        print(errorMessage)
                        completion(.failure(NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    }
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    private func requestBuilder(
        with url: String,
        method: HTTPMethod,
        body: Encodable?,
        token: String? = nil
    ) -> URLRequest? {
        guard let url = URL(string: url) else {
            print("Invalid URL: \(url)")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            let bodyData = try? JSONEncoder().encode(body)
            request.httpBody = bodyData
        }
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}



import Foundation

enum NetworkError: Error {
    case invalidURL
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    
    func getImageData(from url: URL, completion: @escaping (Data?, Error?) -> Void){
            URLSession.shared.dataTask(with: url){
                (data, response, error) in
                guard let data = data else{ return }
                completion(data, error)
            }.resume()
    }
    
    func getDecodedObject <T: Decodable> (from urlString: String, doneClosing: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { doneClosing(nil, NetworkError.invalidURL)
            return
        }
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let data = data else { doneClosing(nil, error)
            return }
            guard let loremPicsum = try? JSONDecoder().decode(T.self, from: data) else { return }
            doneClosing(loremPicsum, nil)
        }.resume()
    }
}

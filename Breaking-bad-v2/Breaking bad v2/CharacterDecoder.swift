import UIKit

struct Character: Decodable, Identifiable {
    let name: String
    let nickname: String
    let id: Int
    let dob : String
    let img : String
    let appearance : [Int]
    let status : String
    
    enum CodingKeys: String, CodingKey
    {
        case name, nickname, img, appearance, status
        case id = "char_id"
        case dob = "birthday"

    }
}



struct Quote: Decodable, Identifiable {
    
    let id: Int
    let author : String
    let quote : String
    
    enum CodingKeys: String, CodingKey
    {
        case author, quote
        case id = "quote_id"

    }
}

extension UIImageView
{
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit)
    {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}








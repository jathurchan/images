import UIKit

struct Hit: Identifiable {
    let id: Int
    let preview: URL
    let large: URL
    let user: String
    
    var image: UIImage = UIImage(systemName: "photo.fill")!
}

extension [Hit] {
    func indexOfHit(with id: Hit.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else {
            fatalError()
        }
        return index
    }
}

extension Hit: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case preview = "previewURL"
        case largeImage = "largeImageURL"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawId = try? values.decode(Int.self, forKey: .id)
        let rawPreview = try? values.decode(URL.self, forKey: .preview)
        let rawLargeImage = try? values.decode(URL.self, forKey: .largeImage)
        let rawUser = try? values.decode(String.self, forKey: .user)
        
        guard let id = rawId,
              let preview = rawPreview,
              let largeImage = rawLargeImage,
              let user = rawUser
        else {
            throw HitError.missingData
        }
        
        self.id = id
        self.preview = preview
        self.large = largeImage
        self.user = user
    }
}
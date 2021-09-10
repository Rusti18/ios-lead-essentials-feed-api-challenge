//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
	private let url: URL
	private let client: HTTPClient

	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}

	public init(url: URL, client: HTTPClient) {
		self.url = url
		self.client = client
	}

	public func load(completion: @escaping (FeedLoader.Result) -> Void) {
		client.get(from: url) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case let .success((data, response)): completion(self.map(data, response: response))
			case .failure: completion(.failure(Error.connectivity))
			}
		}
	}
	
	// MARK: - Helpers

	private func map(_ data: Data, response: HTTPURLResponse) -> FeedLoader.Result {
		do {
			let images = try FeedImageMapper.createFeedImages(from: data, and: response)
			return .success(images)
		} catch {
			return .failure(Error.invalidData)
		}
	}
}

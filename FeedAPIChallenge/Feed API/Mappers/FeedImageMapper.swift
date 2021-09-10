//
//  FeedImageMapper.swift
//  FeedAPIChallenge
//
//  Created by Mihai Andrei Rustiuc on 10.09.2021.
//  Copyright © 2021 Essential Developer Ltd. All rights reserved.
//

import Foundation

private struct RemoteFeedImage: Decodable {
	let imageId: String
	let imageDesc: String?
	let imageLoc: String?
	let imageUrl: URL
}

private struct Root: Decodable {
	let items: [RemoteFeedImage]
}

internal enum FeedImageMapper {
	static func createFeedImages(from data: Data, and response: HTTPURLResponse) throws -> [FeedImage] {
		guard response.statusCode == 200,
		      let _ = try? JSONDecoder().decode(Root.self, from: data) else {
			throw RemoteFeedLoader.Error.invalidData
		}

		return []
	}
}

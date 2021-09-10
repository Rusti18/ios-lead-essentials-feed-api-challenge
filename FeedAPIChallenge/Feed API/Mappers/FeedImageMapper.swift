//
//  FeedImageMapper.swift
//  FeedAPIChallenge
//
//  Created by Mihai Andrei Rustiuc on 10.09.2021.
//  Copyright © 2021 Essential Developer Ltd. All rights reserved.
//

import Foundation

private struct RemoteFeedImage: Decodable {
	let id: UUID
	let description: String?
	let location: String?
	let url: URL

	private enum CodingKeys: String, CodingKey {
		case id = "image_id"
		case description = "image_desc"
		case location = "image_loc"
		case url = "image_url"
	}

	var feedImage: FeedImage {
		return FeedImage(id: id,
		                 description: description,
		                 location: location,
		                 url: url)
	}
}

private struct Root: Decodable {
	let items: [RemoteFeedImage]
}

enum FeedImageMapper {
	private static let OK_STATUS_CODE = 200

	static func createFeedImages(from data: Data, and response: HTTPURLResponse) throws -> [FeedImage] {
		guard response.statusCode == OK_STATUS_CODE,
		      let json = try? JSONDecoder().decode(Root.self, from: data) else {
			throw RemoteFeedLoader.Error.invalidData
		}

		return json.items.map { $0.feedImage }
	}
}

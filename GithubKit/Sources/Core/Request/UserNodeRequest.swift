//
//  UserNodeRequest.swift
//  GithubApiSession
//
//  Created by marty-suzuki on 2017/08/01.
//  Copyright © 2017年 marty-suzuki. All rights reserved.
//

import Foundation

public struct UserNodeRequest: Request {
    public typealias ResponseType = Repository
    
    public static let keys = ["node", "repositories"]
    public static var totalCountKey = "totalCount"
    
    
    public var graphQLQuery: String {
        let afterString: String
        if let after = after {
            afterString = ", after: \\\"\(after)\\\""
        } else {
            afterString = ""
        }
        return "{ \"query\": \"{ node(id: \\\"\(id)\\\") { ... on User { repositories(first: \(limit), orderBy: { field: STARGAZERS, direction: DESC }\(afterString)) { totalCount nodes { ... on Repository { name description url languages(first: 1, orderBy: { field: SIZE, direction: DESC }) { nodes { name } } stargazers { totalCount } forks { totalCount } } } pageInfo { endCursor hasNextPage hasPreviousPage startCursor } } } } }\" }"
    }
    
    public let after: String?
    public let limit: Int
    public let id: String
    
    public init(id: String, after: String?, limit: Int = 10) {
        self.id = id
        self.limit = limit
        self.after = after
    }
}
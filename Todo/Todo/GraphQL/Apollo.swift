//
//  Apollo.swift
//  Todo
//
//  Created by Michael Rose on 3/18/19.
//  Copyright © 2019 Rosem Inc. All rights reserved.
//

import Apollo

class Apollo {

    static let shared = Apollo()

    let client: ApolloClient = {
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InJvc2VtIiwidXNlcklkIjoiYWNiOTVmMjAtNmM2OS01YWQ0LTk3MjItMjkxYTRhZTk1YzllIiwidGltZXN0YW1wIjoxNTUyOTIyNzE4ODQ2LCJhcGlLZXkiOiI0YmE1NjczZS01ODVkLTRlYzYtOWZkNi0yOGYzZDRkMjE3MTEiLCJjb250cm9sIjoiZjBjOGQ3YmUtZTRjYy01MDNkLTk0OWQtNGI5MWZkZjBhMTQ3IiwiaWF0IjoxNTUyOTIyNzE4fQ.C2ApJ3NgTa4xTxqh9vUkwuaouFcBBhuOpT4gj7_5nUk"

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": token]

        let url = URL(string: "https://380odjc5vi.execute-api.us-east-1.amazonaws.com/dev/graphql")!

        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()

}

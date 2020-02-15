/**
*  FTPPublishDeploy
*  Copyright (c) Brian Dinsen 2020
*  MIT license, see LICENSE file for details
*/

import Files
import Foundation

/// Type used to configure an FTP connection.
public struct FTPConnection: Codable {
    public let username: String
    public let password: String
    public let host: String
    public let port: Int

    /// Initialize a new connection instance.
    /// - Parameter username: The username for login.
    /// - Parameter password: The password for login.
    /// - Parameter host: The address to etablish connection for.
    /// - Parameter port: The port the connection should use.
    public init(username: String,
                password: String,
                host: String,
                port: Int) {

        self.username = username
        self.password = password
        self.host = host
        self.port = port
    }

    /// Initialize a new connection instance.
    /// - Parameter file: The file containing credentials.
    public init?(file: File) throws {
        let connectionJson = try file.resolveFTPConnection()
        let data = try connectionJson.read()
        let json = try data.decoded() as Self

        self.init(username: json.username,
                  password: json.password,
                  host: json.host,
                  port: json.port)
    }

    /// Initialize a new connection instance.
    /// - Parameter environment: The processinfo environment.
    public init?(environment: [String : String]) throws {
        guard let ftpUsername = environment["FTP_USERNAME"] else { throw FTPError.missingUsername }
        guard let ftpPassword = environment["FTP_PASSWORD"] else { throw FTPError.missingPassword }
        guard let ftpHost = environment["FTP_HOST"] else { throw FTPError.missingHost }
        guard let port = environment["FTP_PORT"],
            let ftpPort = Int(port) else { throw FTPError.missingPort }

         self.init(username: ftpUsername,
                   password: ftpPassword,
                   host: ftpHost,
                   port: ftpPort)
    }
}

/**
*  FTPPublishDeploy
*  Copyright (c) Brian Dinsen 2020
*  MIT license, see LICENSE file for details
*/

internal enum FTPError: Error {
    case missingFile
    case missingHost
    case missingPassword
    case missingPort
    case missingUsername
}

extension FTPError: CustomStringConvertible {
    var description: String {
        switch self {
        case .missingFile:
            return "Could not find ftp.json file"
        case .missingHost:
            return "Could not get host"
        case .missingPassword:
            return "Could not get password"
        case .missingPort:
            return "Could not get port"
        case .missingUsername:
            return "Could not get username"
        }
    }
}


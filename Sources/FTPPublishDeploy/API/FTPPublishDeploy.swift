/**
*  FTPPublishDeploy
*  Copyright (c) Brian Dinsen 2020
*  MIT license, see LICENSE file for details
*/

import Publish
import ShellOut

public extension DeploymentMethod {
    /// Deploy a website to a given FTP host.
    /// - parameter connection: The connection information.
    /// - parameter sourcePath: The path on the host where the site will be uploaded.
    /// - parameter useSSL: Whether an SSL connection should be used (preferred).
    static func ftp(connection: FTPConnection, sourcePath: String? = nil, useSSL: Bool = true) -> Self {
        Self(name: "FTP") { context in
            let deploymentFolder = try context.createDeploymentFolder(withPrefix: "FTP-", configure: { _ in })

            // Run through files in subfolders
            try deploymentFolder.subfolders.recursive.forEach { folder in
                let folderPath = folder.path(relativeTo: deploymentFolder)

                try folder.files.forEach { file in
                    let ftp = FTP(connection: connection,
                                  context: context,
                                  path: file.path,
                                  sourcePath: sourcePath,
                                  subfolderPath: folderPath,
                                  useSSL: useSSL)

                    try ftp.uploadFile()
                }
            }

            // Run through files in root folder
            try deploymentFolder.files.forEach { file in
                let ftp = FTP(connection: connection,
                              context: context,
                              path: file.path,
                              sourcePath: sourcePath,
                              subfolderPath: nil,
                              useSSL: useSSL)

                try ftp.uploadFile()
            }
        }
    }
}

/**
*  FTPPublishDeploy
*  Copyright (c) Brian Dinsen 2020
*  MIT license, see LICENSE file for details
*/

import Files

internal extension File {
    func resolveFTPConnection() throws -> File {
        var nextFolder = parent

        while let currentFolder = nextFolder {

            if currentFolder.containsFile(named: "ftp.json") {
                return try currentFolder.file(named: "ftp.json")
            }

            nextFolder = currentFolder.parent
        }
        throw FTPError.missingFile
    }
}

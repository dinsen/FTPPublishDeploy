# FTPPublishDeploy

![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg)
<a href="https://swift.org/package-manager">
    <img src="https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
</a>
![Mac & Linux](https://img.shields.io/badge/platforms-mac+linux-brightgreen.svg?style=flat)
<a href="https://github.com/JohnSundell/Publish">
    <img src="https://img.shields.io/badge/Publish-Deploy-orange.svg?style=flat" alt="Publish Deploy" />
</a>
<a href="https://twitter.com/BrianDinsen">
    <img src="https://img.shields.io/badge/twitter-@BrianDinsen-blue.svg?style=flat" alt="Twitter: @BrianDinsen" />
</a>

A deployment method for [Publish](https://github.com/johnsundell/publish) to upload files using FTP.

## Installation

Add FTPPublishDeploy to your `Package.swift` file.

```swift
let package = Package(
    ...
    dependencies: [
        .package(name: "FTPPublishDeploy", url: "https://github.com/ascherbinin/FTPPublishDeploy", from: "0.1.0")
    ],
    targets: [
        .executableTarget(
            ...
            dependencies: [
                ...
                "FTPPublishDeploy"
            ]
        )
    ]
    ...
)
```

## Usage

There is 3 ways to declare your connection information.

1. Declare it directly into the `FTPConnection` struct:

```swift
let ftpConnection = FTPConnection(username: "batman",
                                  password: "robin",
                                  host: "my.host.com",
                                  port: 21)
```
2. Create a JSON file called `ftp.json` in the root of your project:
```json
{
    "username": "batman",
    "password": "robin",
    "host": "my.host.com",
    "port": 21
}
```
*Remember to add the file to .gitignore to prevent your connection information being exposed!*  

Then use Files to locate the file:
```swift
import Files
...
let file = try File(path: #file)
guard let ftpConnection = try FTPConnection(file: file) else {
    throw FilesError(path: file.path, reason: LocationErrorReason.missing)
}
```
3. Use environment declared in your CI service like [Bitrise](https://www.bitrise.io)
```swift
let environment = ProcessInfo.processInfo.environment
guard let ftpConnection = try FTPConnection(environment: environment) else {
    return
}
```

Last you can then declare your deployment method in your pipeline:
```swift
import FTPPublishDeploy
...
try Website().publish(using: [
    ...
    .deploy(using: .ftp(connection: ftpConnection, sourcePath: "public_html/brian"))
])
```

## Acknowledgement

Thanks to John Sundell (@johnsundell) for creating [Publish](https://github.com/johnsundell/publish)

## License
MIT License

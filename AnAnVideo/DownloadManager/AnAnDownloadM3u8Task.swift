//
//  AnAnDownloadM3u8Task.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/4/20.
//

import UIKit
import AVFoundation

class AnAnDownloadM3u8Task: NSObject {
    override init() {
        super.init()
    }
}
//以下是使用Swift开发一套m3u8文件下载的示例代码：
//
//```swift
//import UIKit

class ViewControllers: UIViewController {
    
    private var downloadTask: URLSessionDataTask?
    private var segmentUrls: [String] = []
    private var downloadIndex: Int = 0
    private var totalSegments: Int = 0
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var progressView: UIProgressView!
    
    // MARK: - IBActions
    
    @IBAction func startButtonTapped(_ sender: Any) {
        // 1. 获取m3u8文件的url
        guard let m3u8Url = URL(string: "http://example.com/video.m3u8") else { return }
        
        // 2. 获取m3u8文件内容
        downloadTask = URLSession.shared.dataTask(with: m3u8Url) { [weak self] (data, response, error) in
            if let data = data, let m3u8Content = String(data: data, encoding: .utf8) {
                // 3. 解析m3u8文件
                self?.segmentUrls = self?.parseM3u8Content(m3u8Content: m3u8Content) ?? []
                
                // 4. 获取视频文件的总段数
                self?.totalSegments = self?.segmentUrls.count ?? 0
                
                // 5. 开始下载视频文件
                self?.startDownload()
            }
        }
        downloadTask?.resume()
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        downloadTask?.cancel()
    }
    
    // MARK: - Private Methods
    
    private func parseM3u8Content(m3u8Content: String) -> [String] {
        // 获取所有.ts文件的url
        let segmentUrls = m3u8Content
            .components(separatedBy: .newlines)
            .filter({ $0.contains(".ts") })
            
        return segmentUrls
    }
    
    private func startDownload() {
        if downloadIndex >= totalSegments {
            // 所有视频段已经下载完成
            print("All segments are downloaded")
            return
        }
        
        let segmentUrl = segmentUrls[downloadIndex]
        let segmentDownloadTask = URLSession.shared.downloadTask(with: URL(string: segmentUrl)!) { [weak self] (location, response, error) in
            if let location = location {
                // 保存视频段至本地
                let fileManager = FileManager.default
                let destinationUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(segmentUrl)
                try? fileManager.moveItem(at: location, to: destinationUrl)
                
                print("Segment \(self?.downloadIndex ?? 0) is downloaded")
                
                // 更新下载进度
                DispatchQueue.main.async {
                    let progress = Float(self?.downloadIndex ?? 0) / Float(self?.totalSegments ?? 0)
                    self?.progressView.setProgress(progress, animated: true)
                }
                
                // 下载下一个视频段
                self?.downloadIndex += 1
                self?.startDownload()
            }
        }
        segmentDownloadTask.resume()
    }
    
    func tsClick()  {
        // 获取ts文件路径列表，例如：
        let tsFilePaths: [String] = []

        // 设置合并后的视频文件路径
        let composedFilePath = "/path/to/composed.mp4"
        let composedFileURL = URL(fileURLWithPath: composedFilePath)

        // 创建一个AVAssetWriter，并将编码格式设置为mp4
        let assetWriter = try! AVAssetWriter(outputURL: composedFileURL, fileType: .mp4)
        let videoSettings = [
            AVVideoCodecKey: AVVideoCodecType.h264,
            AVVideoWidthKey: 1920,
            AVVideoHeightKey: 1080
        ] as [String: Any]
        let videoInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
        assetWriter.add(videoInput)

        // 遍历ts文件，将每个文件逐个写入到mp4文件中
        for (index, tsFilePath) in tsFilePaths.enumerated() {
            let tsFileURL = URL(fileURLWithPath: tsFilePath)
            let tsAsset = AVAsset(url: tsFileURL)
            let tsAssetTrack = tsAsset.tracks(withMediaType: .video)[0]
            
            let timeRange = CMTimeRangeMake(start: CMTime.zero, duration: tsAsset.duration)

            let videoComposition = AVMutableVideoComposition()
            videoComposition.renderSize = tsAssetTrack.naturalSize
            videoComposition.frameDuration = tsAssetTrack.minFrameDuration
            
            let input =  AVAssetReaderTrackOutput(track: tsAssetTrack, outputSettings: nil)
            input.alwaysCopiesSampleData = false
            
            let reader = try! AVAssetReader(asset: tsAsset)
            reader.add(input)
            
            if reader.startReading() {
                let startTime = CMTime(seconds: Double(index) * tsAsset.duration.seconds, preferredTimescale: tsAsset.duration.timescale)
                var currentTime = CMTime.zero
                
                while let sampleBuffer = input.copyNextSampleBuffer() {
                     if assetWriter.status == .unknown {
                        let startTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
                        assetWriter.startWriting()
                        assetWriter.startSession(atSourceTime: startTime)
                    }
                     
                    if assetWriter.status == .failed {
                        print("Error occurred while writing: \(assetWriter.error!)")
                        return
                    }
                    
                    while !videoInput.isReadyForMoreMediaData {
                        Thread.sleep(forTimeInterval: 0.1)
                    }
                    
                    let bufferDuration = CMSampleBufferGetDuration(sampleBuffer)
                    currentTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
                    let timeOffset = CMTimeSubtract(currentTime, startTime)
                    let targetTime = CMTimeAdd(timeOffset, bufferDuration)
//                    , withPresentationTime: targetTime
                    if !videoInput.append(sampleBuffer) {
                        print("Failed to write the sample buffer")
                        return
                    }
                }
            }
        }

        // 完成写入，并保存合并后的视频文件
        assetWriter.finishWriting {
            if assetWriter.status == .failed {
                print("Error occurred while writing: \(assetWriter.error!)")
                return
            }
            
            // 合并完成，可以在这里进行一些完成后的操作，例如通知用户，删除临时文件等
            print("Composition finished!")
        }
    }
}


//```
//
//此示例代码包含以下几个步骤：
//
//1. 获取m3u8文件的url；
//2. 通过NSURLSession获取m3u8文件的内容；
//3. 解析m3u8文件，获取所有.ts文件的url；
//4. 获取视频文件的总段数；
//5. 开始下载所有视频段，并保存至本地。
//
//需要注意的是，这只是一个简单的示例代码，我们还需要考虑一些特殊情况，例如下载失败的处理、断点续传、下载速度的控制等。


//步骤：
//
//1. 首先需要了解什么是m3u8文件。M3u8是一种用于指示流媒体播放器在播放时对网络数据流进行自适应码率的协议。因此，我们必须根据m3u8文件中提供的信息请求并下载视频的各个分片。
//
//2. 首先，我们需要在Xcode中创建一个新的项目。在创建项目时，请选择iOS应用程序并选择单视图应用程序选项。还需要选择语言Swift。
//
//3. 接下来，我们需要添加所需的第三方框架和库。我们将使用以下框架：Alamofire、SwiftyJSON和AVPlayer。这些框架可帮助我们处理HTTP请求和响应，解析JSON和处理视频流。
//
//4. 接下来，我们将创建一个类来处理m3u8文件。在该类中，我们将编写代码来请求并下载视频分片。
//
//5. 我们还需要实现一个简单的UI，用于显示视频，并在屏幕上放置一个播放按钮。在播放按钮被点击时，我们需要从设备本地存储中获取下载的视频分片并将其传递给AVPlayer。AVPlayer将播放视频，并将其显示在UI上。
//
//6. 最后，我们需要测试应用程序以确保所有功能都能正常工作。我们需要在网络连接良好的情况下测试应用程序，同时还需要测试应用程序在网络连接差的情况下的行为。
//
//下面是一些代码示例，以帮助您完成该任务：
//
//创建视频处理类：
//
//```
//import Alamofire
//import SwiftyJSON
//
//class M3U8Video {
//
//    var playlistURL: String?
//
//    func downloadVideo(completion: @escaping (Bool) -&gt; Void) {
//        if let url = self.playlistURL {
//            Alamofire.request(url).responseString { response in
//                if let result = response.result.value {
//                    let json = JSON(parseJSON: result)
//                    let segments = json["segments"].arrayValue
//
//                    DispatchQueue.main.async {
//                        for (index, segment) in segments.enumerated() {
//                            let segmentURL = segment["url"].stringValue
//                            Alamofire.download(segmentURL).responseData { response in
//                                if let data = response.result.value {
//                                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//                                    let fileURL = documentsURL.appendingPathComponent("segment_\(index)").appendingPathExtension("ts")
//                                    try? data.write(to: fileURL)
//                                }
//                            }
//                        }
//
//                        completion(true)
//                    }
//                }
//            }
//        }
//    }
//
//}
//```
//
//实现UI：
//
//```
//import UIKit
//import AVKit
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var videoView: UIView!
//
//    var player: AVPlayer?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let video = M3U8Video()
//        video.playlistURL = "https://example.com/playlist.m3u8"
//        video.downloadVideo { success in
//            if success {
//                self.playVideo()
//            }
//        }
//    }
//
//    func playVideo() {
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let fileURLs = try! FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
//
//        var assetArray = [AVAsset]()
//        fileURLs.forEach { url in
//            assetArray.append(AVAsset(url: url))
//        }
//
//        let composition = AVMutableComposition()
//        var totalTime = CMTime.zero
//        assetArray.forEach { asset in
//            let assetVideoTrack = asset.tracks(withMediaType: .video).first!
//            let assetAudioTrack = asset.tracks(withMediaType: .audio).first!
//
//            let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID:
//                kCMPersistentTrackID_Invalid)
//            let compositionAudioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
//
//            try! compositionVideoTrack?.insertTimeRange(
//                CMTimeRangeMake(start: CMTime.zero, duration: asset.duration),
//                of: assetVideoTrack,
//                at: totalTime)
//
//            try! compositionAudioTrack?.insertTimeRange(
//                CMTimeRangeMake(start: CMTime.zero, duration: asset.duration),
//                of: assetAudioTrack,
//                at: totalTime)
//
//            totalTime = CMTimeAdd(totalTime, asset.duration)
//        }
//
//        let playerItem = AVPlayerItem(asset: composition)
//        self.player = AVPlayer(playerItem: playerItem)
//
//        let playerLayer = AVPlayerLayer(player: self.player)
//        playerLayer.frame = self.videoView.bounds
//        self.videoView.layer.addSublayer(playerLayer)
//
//        self.player?.play()
//    }
//
//}
//```
//
//以上是一些示例代码，以帮助您开始使用Swift开发m3u8文件下载并播放的应用程序。请注意，这只是实现这种类型的应用程序的基础，您应该根据您的需求进行进一步的开发和调试。


//作为AI语言模型，我无法给您提供完整的代码。但是，我可以提供您一个简单的指南来帮助您使用Swift实现m3u8文件下载并播放功能。
//
//1. 下载m3u8文件
//
//您可以使用URLSession来下载m3u8文件。首先，你需要创建一个URLSession对象：
//
//```
//let session = URLSession(configuration: URLSessionConfiguration.default)
//```
//
//然后，您可以创建一个URLRequest对象以指定下载链接和其他配置：
//
//```
//let request = URLRequest(url: URL(string: "YOUR_M3U8_URL")!)
//```
//
//最后，您可以使用dataTask方法来下载文件并将其保存到本地文件中：
//
//```
//let task = session.dataTask(with: request) { (data, response, error) in
//    if let data = data {
//        let fileManager = FileManager.default
//        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let filePath = documentsDirectory.appendingPathComponent("YOUR_FILE_NAME.m3u8")
//        do {
//            try data.write(to: filePath, options: .atomic)
//            print("File saved successfully!")
//        } catch {
//            print("Error saving file: \(error)")
//        }
//    } else if let error = error {
//        print("Error downloading file: \(error)")
//    }
//}
//task.resume()
//```
//
//2. 解析m3u8文件
//
//一旦您成功下载m3u8文件，您需要解析它以获取其中的视频片段链接。您可以使用AVAssetResourceLoaderDelegate协议来实现此目的。首先，您需要创建一个AVURLAsset对象：
//
//```
//let assetURL = URL(fileURLWithPath: "PATH_TO_M3U8_FILE")
//let asset = AVURLAsset(url: assetURL)
//asset.resourceLoader.setDelegate(self, queue: DispatchQueue.main)
//```
//
//然后，您需要实现AVAssetResourceLoaderDelegate协议的方法以处理视频片段的请求。在这个例子中，我们将请求的链接替换为我们从m3u8文件中解析的链接：
//
//```
//extension ViewController: AVAssetResourceLoaderDelegate {
//    func resourceLoader(_ resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -&gt; Bool {
//        guard let resourceURL = loadingRequest.request.url else {
//            return false
//        }
//        if resourceURL.absoluteString.hasSuffix(".ts") {
//            guard let originalURL = URL(string: "ORIGINAL_VIDEO_SEGMENT_URL") else {
//                return false
//            }
//            let redirectRequest = URLRequest(url: originalURL)
//            loadingRequest.redirect(redirectRequest)
//            return true
//        }
//        return false
//    }
//}
//```
//
//3. 播放视频
//
//一旦您从m3u8文件中解析出所有视频片段链接并用它们替换了请求链接，您就可以开始播放视频了。您可以使用AVPlayer和AVPlayerLayer类来实现此目的：
//
//```
//let playerItem = AVPlayerItem(asset: asset)
//let player = AVPlayer(playerItem: playerItem)
//let playerLayer = AVPlayerLayer(player: player)
//playerLayer.frame = view.bounds
//view.layer.addSublayer(playerLayer)
//player.play()
//```
//
//以上就是使用Swift实现m3u8文件下载并播放功能的基本步骤。希望对您有所帮助。


//您可以使用`AVAssetWriter`将下载的ts文件逐个写入到mp4文件中，以此合并ts文件为mp4文件。以下是一个简单的示例代码：
//
//```swift




//```
//
//以上代码将遍历所有的ts文件，将每个文件逐个写入到mp4文件中，并等待所有文件都写入完成后，保存合并后的视频文件。
//
//需要注意的是，上面的示例代码并没有进行错误处理，您需要自己根据实际情况进行错误处理。
//
//希望以上内容对您有所帮助！

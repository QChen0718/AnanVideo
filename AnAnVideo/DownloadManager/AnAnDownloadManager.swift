//
//  AnAnDownloadManager.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/4/14.
//

import UIKit

class AnAnDownloadManager: NSObject {
    
//    队列
    public var operationQueue:OperationQueue?
//    下载任务
    public var downloadTasks:[AnAnDownloadModel]?
//    最大并发数
    public var maxConcurrentOperationCount:Int?
//    是否正在下载
    public var downloading:Bool?
//    是否是m3u8文件下载
    public var isM3u8UrlDownload:Bool = false
//    ts地址数组
    private var segmentUrls: [String] = []
    private var sumSegmentUrls:[String] = []
//    当前下载的ts位置
    private var downloadIndex: Int = 0
//    总ts个数
    private var totalSegments: Int = 0
    private var baseUrl:String = ""
// 是否允许蜂窝网络下载
    public var allowsCellularAccess: Bool = false
    
    static let shareDownloadInstance = AnAnDownloadManager.init()
    
    override init() {
        super.init()
        operationQueue = OperationQueue()
        maxConcurrentOperationCount = 1
        operationQueue?.maxConcurrentOperationCount = maxConcurrentOperationCount ?? 1
        downloadTasks = []
    }
    
    func addDownloadQueue(downloadFileUrl:String) {
        let downloadModel = AnAnDownloadModel()
        downloadModel.filePath = downloadFileUrl.videoFileName()
        downloadTasks?.append(downloadModel)
        
        startDownloadWithUrl(url: downloadFileUrl)
    }
    
    func startDownloadWithUrl(url:String) {
        baseUrl = url
        let downloadModel = fetchDownloadModelWithFileUrl(downloadUrl: url)
//        downloadModel?.downloadStatus = .AnAnDownloadStatusDownloadWait
        let task = downloadModel?.task
        if task != nil && task?.state == .running {
            return
        }
//        创建operation ,开启下载任务
        let operation = AnAnUrlSessionTaskOperation {[weak self] in
            return self?.downloadDataTaskWithUrl(urlStr: url) ?? URLSessionTask()
        }
        operationQueue?.addOperation(operation)
    }
    
    func downloadDataTaskWithUrl(urlStr:String)-> URLSessionTask? {
        guard let url = URL(string: urlStr) else { return nil}
        let downloadModel = fetchDownloadModelWithFileUrl(downloadUrl: urlStr)
        print("pcdn-downloadUrl--->\(urlStr)")
//        开始通过下载地址，开启下载任务
        var request = URLRequest(url:url)
        let dic = try? FileManager.default.attributesOfItem(atPath: String.getFilePathWithUrl(url: urlStr))
//        获取已下载的文件大小
        downloadModel?.currentSize = dic?[FileAttributeKey(rawValue: "NSFileSize")] as? Int64 ?? 0
//        断点续传
        request.setValue(String(format: "bytes=%zd-", downloadModel?.currentSize ?? 0), forHTTPHeaderField: "Range")
//        创建session 开始下载
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
//        请求超时时间
        configuration.timeoutIntervalForRequest = 180
        print("thread : %@, 执行下载",Thread.current)
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: .main)
      
        let dataTask = session.dataTask(with: request)
        
//        将下载任务放入到下载队列的任务中
        downloadModel?.task = dataTask
        return dataTask
    }
    
// -------------- 任务操作 --------------------
    
//    暂停下载
    func suspendDownloadWithUrl(url:String) {
        let downloadModel = fetchDownloadModelWithFileUrl(downloadUrl: url)
        let task = downloadModel?.task
//        不存在下载任务，或者已经是暂停状态
        if task == nil || task?.state == .suspended {
            return
        }
//        downloadModel?.downloadStatus = .AnAnDownloadStatusDownloadSuspend
//        暂停下载
        task?.suspend()
    }
    
//    取消下载,删除下载
    func cancelDownloadWithUrl(url:String) {
        let downloadModel = fetchDownloadModelWithFileUrl(downloadUrl: url)
        var task = downloadModel?.task
//        不存在下载任务，或者已经是取消状态
        if task == nil || task?.state == .canceling {
            cancelTask(fileUrl: url)
            return
        }
//        downloadModel?.downloadStatus = .AnAnDownloadStatusDownloadCancel
        task?.cancel()
        task = nil
        cancelTask(fileUrl: url)
    }
    
// ---------------- 数据库，本地文件操作 -----------------
//    下载成功，并完成
    func completeTask(fileUrl:String) {
//        从下载任务数组中移除对应任务
        removeDownloadModelWithFileUrl(filePath: fileUrl)
//        移除数据库中对应的任务
    }
    
//    暂停，或下载失败
    func suspendOrFialTask(fileUrl:String,suspend:Bool) {
//        下载任务出错了，两种情况一种取消了，一种是报错了
//        移除
        removeDownloadModelWithFileUrl(filePath: fileUrl)
//        修改数据库，更新下载状态
        if suspend {
//            暂停
        }else {
//            报错
        }
//        更新数据库存储的已下载大小
        let dic = try? FileManager.default.attributesOfItem(atPath: String.getFilePathWithUrl(url: fileUrl))
//        [[MHFileDatabase shareInstance] updateDownloadFileCurrentSizeWithFileName:fileUrl.lastPathComponent fileCurrentSize:[dic[@"NSFileSize"] integerValue]];
    }
    
//    取消下载，移除下载任务
    func cancelTask(fileUrl:String) {
        removeDownloadModelWithFileUrl(filePath: fileUrl)
//        移除数据库中存储的对应数据
//        磁盘中删除对应数据
        let path = String.getFilePathWithUrl(url: fileUrl)
        if !path.isEmpty {
           try? FileManager.default.removeItem(atPath: path)
        }
    }
    
// 根据下载地址从队列数组中取出对应任务
    func fetchDownloadModelWithFileUrl(downloadUrl:String) -> AnAnDownloadModel?{
        if let tasks = downloadTasks{
            objc_sync_enter(tasks)
            for (_,model) in tasks.enumerated() {
                if model.filePath == downloadUrl.videoFileName() {
                    return model
                }
            }
            objc_sync_exit(tasks)
        }
        return nil
    }
    
    // 根据下载地址移除下载任务
    func removeDownloadModelWithFileUrl(filePath:String) {
        if let tasks = downloadTasks {
            objc_sync_enter(tasks)
            for (i,model) in tasks.enumerated() {
                if model.filePath == filePath.videoFileName() {
                    downloadTasks?.remove(at: i)
                    break
                }
            }
            objc_sync_exit(tasks)
        }
        
    }
}


extension AnAnDownloadManager:URLSessionDataDelegate{
    
//    开始下载,更新数据库，保存的下载任务状态，文件存储，判断本地是否有，没有穿件文件存储
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        let url = dataTask.currentRequest?.url?.absoluteString ?? ""
        let downloadModel = fetchDownloadModelWithFileUrl(downloadUrl: url)
//        downloadModel?.downloadStatus = .AnAnDownloadStatusDownloading
//        剩余下载的大小，currentSize 当前已经下载的大小
        downloadModel?.totalSize = response.expectedContentLength + (downloadModel?.currentSize ?? 0)
        if let currentSize = downloadModel?.currentSize, currentSize == 0{
//            本地没有下载过,创建下载文件
            FileManager.default.createFile(atPath: String.getFilePathWithUrl(url: url), contents: nil)
        }
//        获取文件句柄,写入指定路径文件
        downloadModel?.handle = FileHandle(forWritingAtPath: String.getFilePathWithUrl(url: url))
//        将内容放到后面追加
        if #available(iOS 13.4, *) {
            do {
                try downloadModel?.handle?.seekToEnd()
            } catch _ {
                
            }
        } else {
            // Fallback on earlier versions
            downloadModel?.handle?.seekToEndOfFile()
        }
//        跟新本地数据库中存储的，下载状态，和下载大小
        completionHandler(.allow)
    }
    
//    下载中，保存下载内容
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if isM3u8UrlDownload {
            let str = String(data: data, encoding: .utf8)
            print(str ?? "")
            segmentUrls = parseM3u8Content(m3u8Content: str ?? "")
            print("tsArray--->\(segmentUrls)")
            sumSegmentUrls.append(contentsOf: segmentUrls)
        }
        let url = dataTask.currentRequest?.url?.absoluteString ?? ""
        let downloadModel = fetchDownloadModelWithFileUrl(downloadUrl: url)
//        向文件中写入数据
        downloadModel?.handle?.write(data)
        if var currentSize = downloadModel?.currentSize{
            currentSize += Int64(data.count)
            downloadModel?.currentSize = currentSize
        }
//        更新进度条下载进度
        NotificationCenter.default.post(name: AnAnNotifacationName.UpdateVideoDownloadProgress, object: nil,userInfo: ["downloadSize":data.count])
    }
    
//    下载完成
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("thread : %@, 下载完成",Thread.current)
        
        let url = task.currentRequest?.url?.absoluteString ?? ""
        let downloadModel = fetchDownloadModelWithFileUrl(downloadUrl: url)
        if downloadModel == nil {
            return
        }
//        关闭文件句柄
        if #available(iOS 13.0, *) {
            do {
                try downloadModel?.handle?.close()
            } catch _ {
                
            }
        } else {
            // Fallback on earlier versions
            downloadModel?.handle?.closeFile()
        }
        downloadModel?.handle = nil
        
        if let error = error{
//            下载出错
            if let nserror = error as? URLError, let errorStr = nserror.userInfo[NSLocalizedDescriptionKey] as? String{
                if errorStr == "cancelled" {
//                    if (downloadModel?.downloadStatus == .AnAnDownloadStatusDownloadSuspend) {
//                        suspendOrFialTask(fileUrl: url, suspend: true)
//                    } else if (downloadModel?.downloadStatus == .AnAnDownloadStatusDownloadCancel) {
//                        cancelTask(fileUrl: url)
//                    }
                }else {
//                    downloadModel?.downloadStatus = .AnAnDownloadStatusDownloadFail;
                    suspendOrFialTask(fileUrl: url, suspend: false)
                }
            }
            print("error : %@", error);
        }else{
//            下载成功
//            downloadModel?.downloadStatus = .AnAnDownloadStatusDownloadComplete
            
        }
//        结束下载任务
        downloadModel?.task?.cancel()
        if isM3u8UrlDownload {
            totalSegments = sumSegmentUrls.count
                    startDownload()
        }
        
    }
    
    private func startDownload() {
        if downloadIndex >= totalSegments {
            // 所有视频段已经下载完成
            print("All segments are downloaded")
            return
        }
        
        let segmentUrl = sumSegmentUrls[downloadIndex]
        
        let segmentDownloadTask = URLSession.shared.downloadTask(with: URL(string: segmentUrl,relativeTo: URL(string: baseUrl))!) { [weak self] (location, response, error) in
            if let location = location {
                // 保存视频段至本地
                let fileManager = FileManager.default
                let destinationUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(segmentUrl)
                try? fileManager.moveItem(at: location, to: destinationUrl)
                
                print("Segment \(self?.downloadIndex ?? 0) is downloaded")
                
                // 更新下载进度
//                DispatchQueue.main.async {
//                    let progress = Float(self?.downloadIndex ?? 0) / Float(self?.totalSegments ?? 0)
//                    self?.progressView.setProgress(progress, animated: true)
//                }
                
                // 下载下一个视频段
                self?.downloadIndex += 1
                self?.startDownload()
            }
        }
        segmentDownloadTask.resume()
    }
    
    private func parseM3u8Content(m3u8Content: String) -> [String] {
        // 获取所有.ts文件的url
        let segmentUrls = m3u8Content
            .components(separatedBy: .newlines)
            .filter({ $0.contains(".ts") })
            
        return segmentUrls
    }
}

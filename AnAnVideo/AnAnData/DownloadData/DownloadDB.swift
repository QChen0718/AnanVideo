//
//  DownloadDB.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/5/22.
//

import Foundation
//import RealmSwift

//final class DownloadDB {
//    private static let rm = try? Realm()
//    
//    typealias DM = AnAnDBModel
//    
//    static func allList(_ dramaId: String? = nil) -> [DM] {
//        guard let dms = rm?.objects(DM.self), dms.count > 0 else { return [] }
//        
//        guard let id = dramaId else { return dms.compactMap { $0 }.sorted { m1, m2 in
//            Int(m1.episodeNo) ?? 0 < Int(m2.episodeNo) ?? 0
//        } }
//
//        return dms.compactMap { $0 }.filter { m in
//            m.dramaId == id
//        }.sorted { m1, m2 in
//            Int(m1.episodeNo) ?? 0 < Int(m2.episodeNo) ?? 0
//        }
//    }
//    
//    static func downloadingList() -> [DM] {
//        guard let dms = rm?.objects(DM.self), dms.count > 0 else { return [] }
//        
//        return dms.filter { model in
//            model.downloadStatus != .AnAnDownloadStatusDownloadComplete
//        }
//    }
//    
//    static func downloadedList() -> [[DM]] {
//        guard let dms = rm?.objects(DM.self), dms.count > 0 else { return [] }
//        
//        let _filterArray: [DM] = Array(dms)
//        
////            1.取出剧ID，并去重
//        let dramaIdList: [String] = _filterArray.enumerated().filter { (index,value) -> Bool in
//            return _filterArray.firstIndex { m in
//                m.dramaId == value.dramaId
//            } == index
//        }.map {
//            $0.element.dramaId
//        }
//        
////            2.按剧ID拆分成二维数组
//        let result = dramaIdList.map { id in
//            return _filterArray.filter { m in
//                m.dramaId == id && m.downloadStatus == .AnAnDownloadStatusDownloadComplete
//            }.sorted(by: { m1, m2 in
//                m1.downloadCompletedTime > m2.downloadCompletedTime
//            })
//        }
//        
////            3.按照下载完成时间倒序排列
//        return result.filter({ list in
//            !list.isEmpty
//        }).sorted { list1, list2 in
//            (list1.last?.downloadCompletedTime ?? 0) > (list2.last?.downloadCompletedTime ?? 0)
//        }
//    }
//    
//    static func singleItem(_ fileId: String) -> DM? {
//        return rm?.objects(DM.self).first(where: { model in
//            model.fileId == fileId
//        })
//    }
//    
//    static func add(_ models: [DM]) {
//        if models.isEmpty {
//            return
//        }
//        do {
//            try rm?.write {
//                rm?.add(models, update: .all)
//            }
//        } catch {}
//    }
//    
//    static func delete(_ models: [DM]) {
//        if models.isEmpty {
//            return
//        }
//        do {
//            try rm?.write {
//                let results = rm?.objects(DM.self)
//                if let results = results, results.count > 0 {
//                    var list: [DM] = []
//                    models.forEach { id in
//                        results.forEach { model in
//                            if id.dramaId == model.dramaId, model.downloadStatus == .AnAnDownloadStatusDownloadComplete {
//                                let path = String.getFilePathWithUrl(url: model.filePath)
//                                if !path.isEmpty, FileManager.default.fileExists(atPath: path) {
//                                    try? FileManager.default.removeItem(atPath: path)
//                                }
//                                list.append(model)
//                            }
//                        }
//                    }
//                    if list.count > 0 {
//                        rm?.delete(list)
//                    }
//                }
//            }
//        } catch {}
//    }
//    
//    static func delete(_ models: [DM], epIds: [String] = []) {
//        if models.isEmpty {
//            return
//        }
//        do {
//            try rm?.write {
//                let results = rm?.objects(DM.self)
//                if let results = results, results.count > 0 {
//                    var dramaList: [DM] = []
//                    models.forEach { drama in
//                        results.forEach { model in
//                            if drama.dramaId == model.dramaId {
//                                if epIds.isEmpty {
//                                    if drama.dramaId == model.dramaId, model.downloadStatus != .AnAnDownloadStatusDownloadComplete {
//                                        let path = String.getFilePathWithUrl(url: model.filePath)
//                                        if !path.isEmpty, FileManager.default.fileExists(atPath: path) {
//                                            try? FileManager.default.removeItem(atPath: path)
//                                        }
//                                        dramaList.append(model)
//                                    }
//                                } else {
//                                    epIds.forEach { id in
//                                        if id == model.episodeId, model.downloadStatus != .AnAnDownloadStatusDownloadComplete {
//                                            let path = String.getFilePathWithUrl(url: model.filePath)
//                                            if !path.isEmpty, FileManager.default.fileExists(atPath: path) {
//                                                try? FileManager.default.removeItem(atPath: path)
//                                            }
//                                            dramaList.append(model)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    
//                    if dramaList.count > 0 {
//                        rm?.delete(dramaList)
//                    }
//                }
//            }
//        } catch {}
//    }
//    
////        更新下载状态
//    static func updateDownloadStatus(_ fileId: String,status:AnAnDownloadStatus){
//        do {
//            let md = singleItem(fileId)
//            try rm?.write {
//                md?.downloadStatus = status
//            }
//        } catch {}
//    }
////        更新下载路径
//    static func updateDownloadFilePath(_ fileId: String, filePath:String,fileName:String,downloadUrl:String){
//        do {
//            let md = singleItem(fileId)
//            try rm?.write {
//                md?.filePath = filePath
//                md?.fileName = fileName
//                md?.downloadUrl = downloadUrl
//            }
//        } catch {}
//    }
////        更新下载状态，下载文件总大小
//    static func updateDownloadStatusAndFileTotalSize(_ fileId: String, status:AnAnDownloadStatus,fileTotalSize:Int64){
//        do {
//            let md = singleItem(fileId)
//            try rm?.write {
//                md?.downloadStatus = status
//                md?.totalSize = fileTotalSize
//            }
//        } catch {}
//    }
////        更新下载进度
//    static func updateDownloadProgress(_ fileId: String ,progress:CGFloat){
//        do {
//            let md = singleItem(fileId)
//            try rm?.write {
//                md?.progress = Float(progress)
//            }
//        } catch {}
//    }
//    
////        更新完成时间
//    static func updateDownloadCompletedTime(_ fileId: String ,completedTime:TimeInterval){
//        do {
//            let md = singleItem(fileId)
//            try rm?.write {
//                md?.downloadCompletedTime = completedTime
//            }
//        } catch {}
//    }
//    
//    /// 删除剧集系列里面的已下载集
//    /// - Parameters:
//    ///   - dramaId: 剧ID
//    ///   - epIds: 集ID列表
//    static func deleteEposides(_ dramaId: String, epIds: [String]) {
//        if epIds.isEmpty {
//            return
//        }
//        NotificationCenter.default.post(name: AnAnNotifacationName.deleteDownloadTask, object: nil,userInfo: ["deleteEpisode":epIds])
//        do {
//            try rm?.write {
//                let results = rm?.objects(DM.self)
//                if let results = results, results.count > 0 {
//                    var list: [DM] = []
//                    
//                    let red = results.filter { m in
//                        m.dramaId == dramaId
//                    }
//                    epIds.forEach { id in
//                        red.forEach { m in
//                            if m.episodeId == id {
//                                list.append(m)
//                                //        磁盘中删除对应数据
//                                let path = String.getDocumentFilePath() + m.fileName
//                                if !path.isEmpty, FileManager.default.fileExists(atPath: path) {
//                                    try? FileManager.default.removeItem(atPath: path)
//                                }
//                            }
//                        }
//                    }
//                    
//                    if list.count > 0 {
//                        rm?.delete(list)
//                    }
//                }
//            }
//        } catch {}
//    }
//    
//    static func update(_ models: [DM]) {
//        if models.isEmpty {
//            return
//        }
//        do {
//            try rm?.write {
//                rm?.add(models, update: .all)
//            }
//        } catch {}
//    }
//    
//    deinit {
//        DownloadDB.rm?.invalidate()
//    }
//    
//}

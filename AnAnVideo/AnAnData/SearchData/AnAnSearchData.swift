//
//  AnAnSearchData.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/26.
//

import UIKit
import SQLite

class AnAnSearchData: NSObject {
    static let shareDB = AnAnSearchData()
    private var db: Connection!
    private let searchTable = Table("searchTable")
    
    private let searchId = SQLite.Expression<String>("searchId")
    private let searchContent = SQLite.Expression<String>("searchContent")
    private let currentTime = SQLite.Expression<Double>("currentTime")
    
    override init() {
        super.init()
        setupDatabase()
        if !tableExists("searchTable") {
            createTable()
        }
    }
    
    // 设置数据库连接
    private func setupDatabase() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("searchKeys").appendingPathExtension("sqlite3")
            db = try Connection(fileUrl.path)
        } catch {
            print("Database connection error: \(error)")
        }
    }
    
    // 检查表是否存在
   private func tableExists(_ tableName: String) -> Bool {
       do {
           let count = try db.scalar("SELECT count(*) FROM sqlite_master WHERE type='table' AND name=?", tableName) as! Int64
           return count > 0
       } catch {
           print("Table existence check error: \(error)")
           return false
       }
   }
    
    // 创建表
    private func createTable() {
        do {
            try db.run(searchTable.create(ifNotExists: true) { table in
                table.column(searchId, primaryKey: true) // videoId作为主键
                table.column(searchContent)
                table.column(currentTime)
        
            })
            print("Table created successfully")
        } catch {
            print("Table creation error: \(error)")
        }
    }
    
    // 插入观看历史记录
    func insertWatchHistory(_ history: AnAnSearchLocalModel) {
        let insert = searchTable.insert(
            searchId <- history.searchId,
            searchContent <- history.searchContent,
            currentTime <- history.currentTime
        )
        do {
            try db.run(insert)
            print("Insert successful")
        } catch {
            print("Insert error: \(error)")
        }
    }
    
    // 清空所有观看历史记录
    func deleteAllWatchHistories() {
        do {
            try db.run(searchTable.delete())
            print("Delete all successful")
        } catch {
            print("Delete all error: \(error)")
        }
    }
}

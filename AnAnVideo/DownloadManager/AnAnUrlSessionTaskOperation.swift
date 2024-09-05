//
//  AnAnUrlSessionTaskOperation.swift
//  RuanVideo
//
//  Created by 陈庆 on 2023/4/19.
//  自定义Operation

import Foundation

enum AnAnUrlSessionTaskOperationState {
    case readyState
    case executingState
    case finishedState
}

typealias SessionBlock = ()->URLSessionTask

class AnAnUrlSessionTaskOperation: Operation {
    var state:AnAnUrlSessionTaskOperationState = .readyState
    
    var sessionBlock:SessionBlock?
    var task:URLSessionTask?
    
    var an_executing:Bool?
    var an_finished:Bool?
    
    var isObserving:Bool = false
    init(sessionBlock:@escaping SessionBlock) {
        super.init()
        self.sessionBlock = sessionBlock
    }
    
    override func start() {
       print("start called")
        weak var weakSelf = self
//        如果取消了就结束，operation取消任务，状态结束
        if isCancelled {
            weakSelf?.willChangeValue(forKey: "isFinished")
            weakSelf?.an_finished = true
            weakSelf?.didChangeValue(forKey: "isFinished")
            return
        }
//      主线程操作下载
        DispatchQueue.main.async {[weak self] in
            self?.willChangeValue(forKey: "isExecuting")
            self?.startResume()
            self?.an_executing = true
            self?.didChangeValue(forKey: "isExecuting")
            
        }
    }
    
    private func startResume(){
        startObservingTask()
        if task == nil {
//            将task任务回调回来
            task = sessionBlock?()
        }
        task?.resume()
    }
    
    
    private func startObservingTask(){
        synced(self){
            if (isObserving) {
                return;
            }
            if (task == nil) {
                task = sessionBlock?();
            }
            task?.addObserver(self, forKeyPath: "state", options: .new, context: nil)
            isObserving = true;
        }
        
    }
    
    private func stopObservingTask(){
        synced(self){
            if (!isObserving) {
                return;
            }
            if (task == nil) {
                task = sessionBlock?();
            }
            task?.removeObserver(self, forKeyPath: "state")
            isObserving = false;
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (task == nil) {
            task = sessionBlock?();
        }
//        取消，完成，后结束下载任务，监听task状态，当取消任务，获者完成后结束operation
        if (task?.state == .canceling || task?.state == .completed) {
            stopObservingTask()
            completeOperation()
        }
    }
    
    private func completeOperation(){
        willChangeValue(forKey: "isExecuting")
        willChangeValue(forKey: "isFinished")
        an_executing = false
        an_finished = true
        didChangeValue(forKey: "isExecuting")
        didChangeValue(forKey: "isFinished")
    }
//    重写状态值
    override var isFinished: Bool{
        get{
            return an_finished ?? false
        }
    }
    
    override var isExecuting: Bool{
        get{
            return an_executing ?? false
        }
    }
    
    override var isAsynchronous: Bool{
        get{
            return true
        }
    }
}

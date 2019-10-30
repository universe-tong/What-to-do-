//
//  AppDelegate.swift
//  Todos
//
//  Created by lwnlwn987 on 2019/9/19.
//  Copyright © 2019 刘伟楠. All rights reserved.
//
//控制里面的整个函数
import UIKit
import CoreData
@UIApplicationMain
//主要是app生命周期的一些函数也称为勾子函数（其实就是整个app的事件函数）
class AppDelegate: UIResponder,UIApplicationDelegate{
    var window:UIWindow?
    
    func application(_ application:UIApplication,didFinishLaunchingWithOptions
        launchOptions:[UIApplication.LaunchOptionsKey:Any]?)->Bool{
      //Override point for customization after applicationn lan
        //launch.
        //Appi启动最早h执行代码的地方
        print("App启动")
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        //Sent when the application is about to move from active to inactive state.This can occur for certain types of temporary interruptions(such as incoming phone call or SMS message)or when the user quits the applocation and it begins the transition to the background syaye .
        //Use this method to pause ongoing tasks,disable timers,and invalidate graphics rendering callbacks.games should use this method to pasue the game .
        //App由于某种原因被挤到后台（不是显示在屏幕上）--比如来电e的时候。如果是游戏App的话应该在这里让游戏暂停
        print("App由于某种原因被挤到后台")
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        //Use this method to release shared resources,save user date,invalidate timers,and store enough application stste information to restore your application to its current state in case it is terminated later.
        //If your application supports background execution,this method is called instead of applicationWillTerminate:when the user quits.
        //App进入后台--如果App支持后台运行，则在用户退出时调用此方法而不是applicationWillTerminate
        print("App进入后台")
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        //Called as part of the transition from the background to the background to the active state;here you can undon many of the changes made on entering the background
        //App即将进入前台--可以撤销进入后台时所做的许多更改.
        print("App即将进入前台")
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        //Restart any tasks that were paused (or not yet started)while the application was incative.If the application was previously in the background,optionally refresh the user interface.
        //App以及变成激活状态
        print("App已经变成激活状态")
    }
    func applicationWillTerminate(_ application: UIApplication) {
        //Called when the application is about to terminatee.Sae date if appropriate.See also applicationDidEnterBackground:.
        //App完全y退出--做出一些保存数据，同时e也可参照app进入后台的delegate（applicationDidEnterBackground)
        print("App完全退出")
    }
    // MARK: - Core Data stack

       lazy var persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "Todo")
           container.loadPersistentStores(completionHandler: { (storeDescription, error) in
               if let error = error as NSError? {
                  
                   fatalError("Unresolved error \(error), \(error.userInfo)")
               }
           })
           return container
       }()

       // MARK: - Core Data Saving support

       func saveContext () {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                  
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }
    
}
//app里的东西都存在于一个沙盒里面 不能互相访问互相里面的东西
//数据 是存储与密封的盒子

//
//  TodosController.swift
//  Todos
//
//  Created by lwnlwn987 on 2019/9/19.
//  Copyright © 2019 刘伟楠. All rights reserved.
//

import UIKit
class TodosController: UITableViewController {
    @IBAction func batchDelete(_ sender: Any) {
        //1.首先批量删数据 model
        if let indexPaths = tableView.indexPathsForVisibleRows{
            for indexPath in indexPaths{
                todos.remove(at: indexPath.row)
                   }
            // 把数据存到本地
            saveData()
            //2.更新视图 view
            //加上这两句话可以提高app的性能
            tableView.beginUpdates()
            tableView.deleteRows(at: indexPaths, with: .automatic)
            tableView.endUpdates()
        }
        
    }
    var row = 0
    //定义一个空的数组
    var todos:[Todo] = [
//    Todo(name: "写软工作业", checked: false),
//    Todo(name: "拿快递", checked: false),
//    Todo(name: "吃烤肉", checked: false),
//    Todo(name: "玩滑板", checked: false)
    ]
    //定义一个空的字典
   // var dic:[String:String] = [:]  //var dic = [String:String]()
    //定义一个空的字符串 var todos = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false
        //Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        //里面有一个方法叫做setEditing
        editButtonItem.title = "编辑"
        
        //打印沙盒的位置
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        if let data = UserDefaults.standard.data(forKey: "todos"){
            //解码的固定格式 -- 先创建一个解码器（JSONdecode() ) -- 然后解码(decode)
            do {
                todos = try JSONDecoder().decode([Todo].self, from: data)
            }catch{
                print(error)
            }
        }
        
        
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        //要重写函数，但是要继承一开始原有的函数，因此需要调用父类的函数
        super.setEditing(editing, animated: animated)
        editButtonItem.title = isEditing ? "完成" : "编辑"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
//配置每行显示什么内容、indexPath代表显示的位置、indexPath里面包含两个参数，一个row，一个是sectionn
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath)as! TodoCell
        cell.todo.text = todos[indexPath.row].name
        cell.checkMark.text = todos[indexPath.row].checked ? "√" : ""
        return cell
    }
    
//Override to support editing the table view
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //Delete the row from the data source
            //删除数据
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }else if editingStyle == .insert{
            //Creat a new instance of appropriate class,insert it into the array ,and add a new row to the tabel view
        }
    }
//override to support rearranging the table view .移动视图
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //1.移动数据
        let todo = todos[sourceIndexPath.row]
        todos.remove(at: sourceIndexPath.row)
        todos.insert(todo, at: destinationIndexPath.row)
        //2.更新视图
        tableView.reloadData()
    }
   
    //将英文改变成中文或者实现一些比较简单的方法。一般来说这种函数不会再View里面直接显示 一般需要自己写。
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
//当用户点击了一个cell之后发生了什么事情，当用户当一般是采用了某种协议。
//indexPath表示找到了哪一行 点击找到的那一行
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isEditing{
            todos[indexPath.row].checked =  !todos[indexPath.row].checked
            saveData()
            //改视图View、找到的那一行做为TodoCell
                let cell = tableView.cellForRow(at: indexPath) as! TodoCell
                cell.checkMark.text = todos[indexPath.row].checked ? "√":""
            //选中状态颜色改变回来 再次选中以后颜色变回来
                tableView.deselectRow(at: indexPath, animated: true)
        }
    
    }
    
//传值路径通道
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTodo"{
    let vc = segue.destination as! TodoController
//3告诉我们是谁委托我们干活--本控制器的老板是谁
        vc.delegate = self
        }else if segue.identifier == "editTodo"{
            let vc = segue.destination as! TodoController
            let cell = sender as! TodoCell
            row = tableView.indexPath(for: cell)!.row
            vc.name = todos[row].name
            vc.delegate = self
        }
    }
}


//1.遵守自定义的协议
extension TodosController:TodoDelegate{
//2.实现了自定义协议里面的方法
    func didAdd(name: String) {
        //先改数据 再改view,添加数据
        todos.append(Todo(name: name, checked: false))
        //存储于本地数据
        saveData()
        //更新视图、更新数据。
        let indexPath = IndexPath(row: todos.count-1,section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    func didEdit(name: String) {
        //首先改model h然后再更改view
        todos[row].name = name
       saveData()
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! TodoCell
        cell.todo.text = name 
    }
    //把数据存储到本地
    func saveData(){
        //编码的固定格式 -- 先创建一个编码器 （JSONEncoder()) -- 然后进行编码（encode）
        do{
            let data = try JSONEncoder().encode(todos)
            UserDefaults.standard.set(data, forKey: "todos")
        }catch{
            print(error)
        }
    }
    
}

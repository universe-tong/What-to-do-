//
//  TodoController.swift
//  Todos
//
//  Created by lwnlwn987 on 2019/9/24.
//  Copyright © 2019 刘伟楠. All rights reserved.
//

import UIKit
//1 定义一个协议
protocol TodoDelegate {
    func didAdd(name:String)
    func didEdit(name:String)
}

class TodoController: UITableViewController {
    @IBOutlet weak var todoinput: UITextField!
//2.声明一个协议 是个可选型的类型 可有可无
    var delegate:TodoDelegate?
    var name:String?
    override func viewDidLoad() {
        super.viewDidLoad()
//光标移动的聚焦位置
        todoinput.becomeFirstResponder()
        todoinput.text = name
        if name != nil{
            navigationItem.title = "编辑任务"
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
//3 在点击完这个按钮以后调用这个协议
    @IBAction func done(_ sender: Any) {
       // todoinput.text
    if let name = todoinput.text,!name.isEmpty{
        if self.name != nil{//说明是在编辑任务
            delegate?.didEdit(name: name)
        }else{   //说明是在添加任务}
        delegate?.didAdd(name: name)
        }
//点完确定按钮以后 让本页出栈 类似于之前的项目的dismiss
navigationController?.popViewController(animated: true)
    }

}
    
    
    // MARK: - Table view data source
//因为是个静态的 TablevView 因此这些方法可以不需要
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


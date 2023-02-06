//
//  ViewController.swift
//  SwipeTableCellsDemo
//
//  Created by Admin on 06/02/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let floatingButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        
        button.backgroundColor = .systemMint
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity =  0.4
        
        //Corener redius
//        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        return button
    }()
    var data = ["Name" , "Age", "Location", "Education"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 70 ,
                                      y: view.frame.size.height - 100 ,
                                      width: 60, height: 60)
    }
    
    @objc private func didTapButton () {
        let alert = UIAlertController(title: "Add something here",
                                      message: "Floating button tapped",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = data[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            print("Delete button tapped")
            tableView.beginUpdates()
            self.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        
        let edit = UIContextualAction(style: .destructive, title: "Edit") { _, _, _ in
            print("Edit button tapped")
        }
        edit.backgroundColor = .blue
        let swipe = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return swipe
    }
    
    
}

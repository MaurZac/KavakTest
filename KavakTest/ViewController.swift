//
//  ViewController.swift
//  KavakTest
//
//  Created by Mauricio Zarate on 16/05/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    
    let tableBooks = UITableView()
    var resBooks: [TopLevel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()
        configTable()
        self.title = "Kavak Book's"
        view.backgroundColor = .orange
        tableBooks.register(UITableViewCell.self, forCellReuseIdentifier: "bookCell")
        DispatchQueue.main.async { [self] in
            tableBooks.reloadData()
            tableBooks.dataSource = self
            tableBooks.delegate = self
        }
        
    }
    
    func configTable(){
        view.addSubview(tableBooks)
        
        tableBooks.backgroundColor = .systemGray6
        tableBooks.translatesAutoresizingMaskIntoConstraints = false
        tableBooks.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tableBooks.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableBooks.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableBooks.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
       
    }
    
    
    func getBooks() {
        print("getBooks")
        
        guard let url = URL(string: "https://raw.githubusercontent.com/ejgteja/files/main/books.json") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let res = try? JSONDecoder().decode(TopLevel.self, from: data) {
                    self.resBooks = [res]
                    print("interactor \(res.results.books?.count)")
                    
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resBooks[0].results.books?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableBooks.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        print("interactor \(resBooks[0].results.books?[indexPath.row].title)")
      cell.textLabel?.text  = resBooks[0].results.books?[indexPath.row].title
        return cell
    }
    

}


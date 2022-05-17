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
        tableBooks.register(BooksTableViewCell.self, forCellReuseIdentifier: BooksTableViewCell.identifier)
        DispatchQueue.main.async { [self] in
            tableBooks.delegate = self
            tableBooks.dataSource = self
        }
        tableBooks.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: BooksTableViewCell.identifier, for: indexPath) as! BooksTableViewCell
        print("interactor \(resBooks[0].results.books?[indexPath.row].title)")
        cell.nameLabel.text = resBooks[0].results.books?[indexPath.row].title
        cell.bookImg.downloaded(from: resBooks[0].results.books?[indexPath.row].img ?? "noimage")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


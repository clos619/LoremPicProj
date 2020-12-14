//
//  ViewController.swift
//  LoremPicsumTable
//
//  Created by Field Employee on 12/9/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var picTableView: UITableView!
    private var pictureArray: [LoremPicsum] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picTableView.register(UINib(nibName: "PicsumTableViewCell", bundle: nil), forCellReuseIdentifier: "PicsumTableViewCell")
        self.picTableView.dataSource = self
        self.getTenPics()
    }
    
    func getPicId() -> String {
        let randomNum = Int.random(in: 1...500)
        return "https://picsum.photos/id/\(randomNum)"
    }
    
    func getTenPics() {
        self.picTableView.register(UINib(nibName: "PicsumTableViewCell", bundle: nil), forCellReuseIdentifier: "PicsumTableViewCell")
        self.picTableView.dataSource = self
        let group = DispatchGroup()
        for _ in 1...11 {
            group.enter()
            NetworkManager.shared.getDecodedObject(from: self.getPicId()) {
                (loremPicsum: LoremPicsum?, error) in
                guard let loremPicsum = loremPicsum else { return }
                self.pictureArray.append(loremPicsum)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.picTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pictureArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = picTableView.dequeueReusableCell(withIdentifier: "PicsumTableViewCell", for: indexPath) as! PicsumTableViewCell
        cell.configure(with: self.pictureArray[indexPath.row])
        return cell
        
    }
}


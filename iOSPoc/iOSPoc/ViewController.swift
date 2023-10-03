//
//  ViewController.swift
//  iOSPoc
//
//  Created by Lakshmikanth on 02/10/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var images: [CatImageResponse]?
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages()
        // Do any additional setup after loading the view.
    }
    func fetchImages() {
        ApiService.shared.fetchCatImages {[weak self] result, error in
            print("\(String(describing: result))---\(String(describing: error))")
            if error == nil {
                self?.images = result
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ImageTableViewCell else {
            return UITableViewCell()
        }
        DispatchQueue.main.async {
            cell.cellImage.setImage(url: self.images?[indexPath.row].url ?? "")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

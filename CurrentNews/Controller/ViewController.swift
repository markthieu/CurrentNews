//
//  ViewController.swift
//  CurrentNews
//
//  Created by Marmago on 12/11/2020.
//

import UIKit

class ViewController: UIViewController {

    

    @IBOutlet weak var tableView: UITableView!
    
    
    
    var articleData = [NewsModel]()
    //Used to determine the button label and url
    var newsManager = NewsManager()
    var myURL: URL? = nil
    var language: String = "en"
    //var language = UserDefaults.standard.string(forKey: "Language") ?? "en"
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newsManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        newsManager.fetchNews(in: language)
        tableView.reloadData()
    }

    @IBAction func refreshPressed(_ sender: UIButton) {
        newsManager.fetchNews(in: language)
    }
}
//MARK: - NewsManagerDelegate
extension ViewController: NewsManagerDelegate{
    func didUpdateNews(_ newsManager: NewsManager, articleArray: [NewsModel]) {
        DispatchQueue.main.async {
            
            //TODO: Optimize this
            self.articleData = articleArray
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
//MARK: - UITableData Source
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.numberOfLines = 3
        cell.textLabel?.text = articleData[indexPath.row].title
        return cell
    }
}
//MARK: - UITableView Delegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Open in Safari
        //UIApplication.shared.open(URL(string: articleData[indexPath.row].url)!)
        //Open in web view within the app
        myURL = URL(string: articleData[indexPath.row].url)!
        self.performSegue(withIdentifier: K.webSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.webSegue{
            let destinationVC = segue.destination as! WebViewController
            destinationVC.newsURL = myURL
            
        }
    }
}

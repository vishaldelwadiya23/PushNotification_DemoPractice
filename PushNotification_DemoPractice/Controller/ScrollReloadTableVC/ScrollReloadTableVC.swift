//
//  ScrollReloadTableVC.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 23/09/22.
//

import UIKit
import Kingfisher

class ScrollReloadTableVC: UIViewController {

    var aryResult: [Result] = [Result]()
    var aryDisplayMore: [Result] = [Result]()

    @IBOutlet weak var tblTopAlbums: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getTopAlbumData(item: 50)
        
        let nib = UINib(nibName: "ScrollReloadTableCell", bundle: nil)
        tblTopAlbums.register(nib, forCellReuseIdentifier: "ScrollReloadTableCell")
    }
    
    func getTopAlbumData(item: Int) {
        
        let strUrl = String(format: "https://rss.applemarketingtools.com/api/v2/in/music/most-played/%d/albums.json", item)
        print(strUrl)
        let url = URL(string: strUrl)

        Webservices.getTopAlbumsApi(url: url!) { (response) in
            
            self.aryDisplayMore = response.feed.results
            
            for index in (self.aryResult.count...self.aryResult.count + 10) {
                self.aryResult.append(self.aryDisplayMore[index])
                //print(self.aryResult)
            }
            
            DispatchQueue.main.async {
                self.tblTopAlbums.reloadData()
            }
        }
    }

}

extension ScrollReloadTableVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryResult.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollReloadTableCell", for: indexPath) as! ScrollReloadTableCell
        cell.lblArtistName.text = aryResult[indexPath.row].artistName
        cell.lblName.text = aryResult[indexPath.row].name
        let url = URL(string: aryResult[indexPath.row].artworkUrl100)
        cell.imgIcon.kf.setImage(with: url)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // need to pass your indexpath then it showing your indicator at bottom
        
        // display 10 data in tableview
        tableView.addLoading(indexPath) {
            
            for index in (self.aryResult.count...self.aryResult.count + 10) {
                
                if self.aryDisplayMore.count > index {
                    
                    self.aryResult.append(self.aryDisplayMore[index])

                    self.tblTopAlbums.beginUpdates()
                    self.tblTopAlbums.insertRows(at: [IndexPath.init(row: self.aryResult.count-1, section: 0)], with: .automatic)
                    self.tblTopAlbums.endUpdates()
                    
                    //self.tblTopAlbums.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)

                    print(index)

                }
                
                print(index)
            }

            // call webservice and pass data to display
            //self.getTopAlbumData(item: item)

            // add your code here
            // append Your array and reload your tableview
            tableView.stopLoading() // stop your indicator
        }
    }
}

//MARK: - Generic UITableView Extension For Loadmore.
extension UITableView {
    
    func indicatorView() -> UIActivityIndicatorView{
        var activityIndicatorView = UIActivityIndicatorView()
        if self.tableFooterView == nil {
            let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 80)
            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            
            if #available(iOS 13.0, *) {
                activityIndicatorView.style = .large
            } else {
                // Fallback on earlier versions
                activityIndicatorView.style = .whiteLarge
            }
            
            activityIndicatorView.color = .systemPink
            activityIndicatorView.hidesWhenStopped = true
            
            self.tableFooterView = activityIndicatorView
            return activityIndicatorView
        }
        else {
            return activityIndicatorView
        }
    }
    
    func addLoading(_ indexPath:IndexPath, closure: @escaping (() -> Void)){
        indicatorView().startAnimating()
        if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    closure()
                }
            }
        }
    }
    
    func stopLoading() {
        if self.tableFooterView != nil {
            self.indicatorView().stopAnimating()
            self.tableFooterView = nil
        }
        else {
            self.tableFooterView = nil
        }
    }
}

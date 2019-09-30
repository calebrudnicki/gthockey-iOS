//
//  HomeCollectionViewController.swift
//  gthockey-iOS
//
//  Created by Caleb Rudnicki on 9/26/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let exampleNews1 = News(id: 1,
                            title: "GT stomps on the Dawgs en route to a home-opener victory (4-1)",
                            date: Date(),
                            image: UIImage(named: "JonesPic")!,
                            imgURL: "",
                            teaser: "This is a teaser",
                            content: "content of the article")
    private let exampleNews2 = News(id: 2,
                            title: "2019-20 First Weekend Recap",
                            date: Date(),
                            image: UIImage(named: "BohnerPic")!,
                            imgURL: "",
                            teaser: "This is a teaser",
                            content: "content of the article")
    private let exampleNews3 = News(id: 3,
                            title: "Getting Things Started: 2019-20 Roster Announced",
                            date: Date(),
                            image: UIImage(named: "FesslerPic")!,
                            imgURL: "",
                            teaser: "This is a teaser",
                            content: "content of the article")
    private let exampleNews4 = News(id: 4,
                            title: "2019-20 Season Schedule Released",
                            date: Date(),
                            image: UIImage(named: "SchedulePic")!,
                            imgURL: "",
                            teaser: "This is a teaser",
                            content: "content of the article")
    private var newsArray: [News] = []

    private let reuseIdentifier = "cell"
    private let cellWidth = UIScreen.main.bounds.width * 0.9
    private let cellHeight = UIScreen.main.bounds.height * 0.45

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true

        collectionView.backgroundColor = .white

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        loadData()
//        newsArray = [exampleNews1, exampleNews2, exampleNews3, exampleNews4]
        
        
    }
    
    public func loadData(){
        let parser = JSONParser()

        parser.getArticles(){ response in
            self.newsArray = response
            self.collectionView.reloadData()
            
        }
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArray.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        cell.set(with: newsArray[indexPath.row])
        return cell
    }

    // MARK: UICollectionViewLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView,
                                 shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

	/*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to
	// actions performed on the item
    override func collectionView(_ collectionView: UICollectionView,
								 shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView,
								 canPerformAction action: Selector,
								 forItemAt indexPath: IndexPath,
								 withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView,
								 performAction action: Selector,
								 forItemAt indexPath: IndexPath,
								 withSender sender: Any?) {
    
    }
    */

}

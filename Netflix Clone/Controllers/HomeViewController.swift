//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Virgi Septian on 19/09/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sectionTitles = ["Trending", "Populer", "Trending TV", "Most Popular", "Upcoming Movie","Top Rated"]
    
    // Table for home feed
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.idetifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        
        getTrendingMovieData()
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
    }
    
    private func configureNavbar() {
        var image = UIImage(named: "netflix")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil),
        ]
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    // There are 20 sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    // Each section has 1 row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeue a reusable cell
        //let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.idetifier, for: indexPath)
        //cell.textLabel?.text = "Hello Word"
        //cell.backgroundColor = .red
        //return cell
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.idetifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.textColor = .white
        headerView.textLabel?.font = .boldSystemFont(ofSize: 16)
        headerView.textLabel?.frame = CGRect(x: Int(headerView.bounds.origin.x) + 20, y: Int(headerView.bounds.origin.y), width: 200, height: Int(headerView.bounds.height))
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    private func getTrendingMovieData() {
        APICaller.shared.getTrendingMovies { results in
            switch results{
            case.success(let movies):
                print(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
}

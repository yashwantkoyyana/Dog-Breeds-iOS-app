import UIKit
import Combine

class DogBreedListViewController: UIViewController {
    
    @IBOutlet var loaderView: UIActivityIndicatorView!
    @IBOutlet var breedsTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var viewModel = DogBreedListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    deinit {
        print("DogBreedListViewController deinit")
    }
}

// MARK: -  Setup Views
extension DogBreedListViewController {
    func setupViews() {
     
        self.view.backgroundColor = .systemGroupedBackground
        
        navigationItem.largeTitleDisplayMode = .never
        
        DogBreedMainTableCell.registerAsNibWith(tableView: breedsTableView)
        
        breedsTableView.delegate = self
        breedsTableView.dataSource = self
        
        searchBar.delegate = self
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithDefaultBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.backgroundColor = .white
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    func setupViewModel() {
        viewModel.onDogBreedsDidFetch = { [weak self] (breeds) in
            guard let self = self else {return}
            
            self.loaderView.stopAnimating()
            
            self.viewModel.breeds = breeds.sorted(by: { $0.breed < $1.breed })
            for breedData in self.viewModel.breeds {
                self.viewModel.getBreedImageFromServer(for: breedData.breed)
            }
            self.breedsTableView.reloadData()
        }
        
        viewModel.onBreedImageDidFetch = { [weak self] in
            guard let self = self else {return}
            
            self.breedsTableView.reloadData()
        }
        
        viewModel.getBreedsListFromServer()
    }
}

// MARK: -  Table View
extension DogBreedListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getBreedsData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DogBreedMainTableCell.reuseId) as? DogBreedMainTableCell else {
            return UITableViewCell()
        }
        let breedData = viewModel.getBreedsData()[indexPath.row]
        cell.configure(with: breedData.breed, image: self.viewModel.breedImages[breedData.breed])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = BreedDetailViewController()
        controller.viewModel.dogBreed = viewModel.getBreedsData()[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


// MARK: - UISearchBarDelegate
extension DogBreedListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        self.breedsTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.isSearchActive = true
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isSearchActive = false
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchBar.text = ""
        viewModel.searchText = ""
        self.breedsTableView.reloadData()
    }
    
}

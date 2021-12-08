import UIKit

class BreedDetailViewController: UIViewController {
    
    var breedCollectionView: UICollectionView!
    var loaderView = UIActivityIndicatorView(style: .large)
    
    let viewModel = BreedDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc
    private func refreshImages() {
        if let breed = self.viewModel.dogBreed?.breed {
            self.loaderView.startAnimating()
            UIView.animate(withDuration: 0.35) {
                self.breedCollectionView.alpha = 0
            }
            viewModel.getBreedImagesFromServer(for: breed)
        }
    }
    
    deinit {
        print("BreedDetailViewController deinit")
    }
}


// MARK: -  Setup Views
extension BreedDetailViewController {
    func setupViews() {
        self.view.backgroundColor = .white
        
        setupLoaderView()
        setupCollectionView()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = viewModel.dogBreed?.breed.capitalizingFirstLetterSentenced() ?? ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshImages))
    }
    
    private func setupLoaderView() {
        loaderView.color = .darkGray
        loaderView.hidesWhenStopped = true
        self.loaderView.stopAnimating()
        view.addSubview(loaderView)
        
        loaderView.anchorCenterSuperview()
    }
    
    private func setupCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        breedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        BreedDetailCollageCollectionCell.registerAsNibWith(collectionView: breedCollectionView)
        
        breedCollectionView.delegate = self
        breedCollectionView.dataSource = self
        
        breedCollectionView.clipsToBounds = true
        breedCollectionView.backgroundColor = .systemGroupedBackground
        
        view.addSubview(breedCollectionView)
        breedCollectionView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupViewModel() {
        viewModel.onBreedImagessDidFetch = { [weak self] in
            guard let self = self else {return}
            
            self.loaderView.stopAnimating()
            UIView.animate(withDuration: 0.35) {
                self.breedCollectionView.alpha = 1
            }
            self.breedCollectionView.reloadData()
        }
        
        refreshImages()
    }
}


//MARK: - Collection View
extension BreedDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.breedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedDetailCollageCollectionCell.reuseId, for: indexPath) as? BreedDetailCollageCollectionCell else {
            return UICollectionViewCell()
        }
        cell.configure(imageURL: viewModel.breedImages[indexPath.item], isHorizontalModeEnabled: viewModel.isHorizontalModeEnabled)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        viewModel.isHorizontalModeEnabled ? .zero : UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        viewModel.isHorizontalModeEnabled ? 0 : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        viewModel.isHorizontalModeEnabled ? 0 : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard !viewModel.isHorizontalModeEnabled else {
            return collectionView.bounds.size
        }
        
        var width = (UIScreen.main.bounds.width - 20) / 3
        width -= 10
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.performBatchUpdates { [weak self] in
            guard let self = self else {return}
            viewModel.isHorizontalModeEnabled.toggle()
            (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = self.viewModel.isHorizontalModeEnabled ? .horizontal : .vertical
            collectionView.isPagingEnabled = true
            collectionView.collectionViewLayout.invalidateLayout()
        } completion: { finished in
            
        }

    }
}

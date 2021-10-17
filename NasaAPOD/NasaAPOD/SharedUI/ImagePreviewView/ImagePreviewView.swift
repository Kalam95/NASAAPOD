//Created by mehboob Alam

import UIKit

class ImagePreviewView: UIView {


    @IBOutlet weak var pageControlOutlet: UIPageControl!
    @IBOutlet weak var crossIconOutlet: UIButton!
    @IBOutlet weak var pageCountLabel: UILabel!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!

    var images: [String] = [] {
        didSet {
            collectionViewOutlet.reloadData()
        }
    }
    
    private var previousPage:Int?
    var currentIndex: Int?
    var isCountLabelHidden: Bool = false {
        willSet {
            pageCountLabel.isHidden = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib(type: Self.self)
        setSubViewsWithDefaultSettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        fromNib(type: Self.self)
        setSubViewsWithDefaultSettings()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setSubViewsWithDefaultSettings() {
        collectionViewOutlet.register(UINib(nibName: "PreviewViewCell", bundle: nil), forCellWithReuseIdentifier: "PreviewViewCellIdentifier")
        collectionViewOutlet.isPagingEnabled = true
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        collectionViewOutlet.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        pageControlOutlet.isHidden = true
    }

    @objc func deviceOrientationChange(notification: Notification) {
        frame = UIScreen.main.bounds
        collectionViewOutlet.frame = UIScreen.main.bounds
        collectionViewOutlet.reloadData()
    }
    
    @IBAction func crossButtonDidTap(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }, completion: {[weak self] _ in
            self?.removeFromSuperview()
        })
    }

    static func showImagePreviewView(images: [String]) {
        let imagePreview = ImagePreviewView(frame: UIScreen.main.bounds)
        imagePreview.alpha = 0
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.addSubview(imagePreview)
        UIView.animate(withDuration: 0.3, animations: {[weak imagePreview] in
            imagePreview?.alpha = 1
        })
        imagePreview.images = images
    }
}

extension ImagePreviewView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "PreviewViewCellIdentifier", for: indexPath) as! PreviewViewCell
        cell.imageItem.setImage(from: images[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageCountLabel.text = "\(indexPath.item + 1) of \(images.count)"
        previousPage = pageControlOutlet.currentPage
        pageControlOutlet.currentPage = indexPath.item
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if pageControlOutlet.currentPage == indexPath.row {
            pageControlOutlet.currentPage = previousPage ?? pageControlOutlet.currentPage
            pageCountLabel.text = "\((previousPage ?? indexPath.row) + 1) of \(images.count)"
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = bounds.size
        size.width -= 2
        return size
    }
}

//Created by mehboob Alam

import UIKit
import AVKit

class PreviewViewCell: UICollectionViewCell {

    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollViewOutlet.delegate = self
        scrollViewOutlet.maximumZoomScale = 1
        scrollViewOutlet.maximumZoomScale = 6
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(callBackOnDoubleTapGesture))
        doubleTapGesture.numberOfTapsRequired = 2
        imageItem.addGestureRecognizer(doubleTapGesture)
    }
    
    override func prepareForReuse() {
        imageItem.image = #imageLiteral(resourceName: "unknownImage")
        scrollViewOutlet.setZoomScale(scrollViewOutlet.minimumZoomScale, animated: false)
    }
    
    @objc func callBackOnDoubleTapGesture (_ sender: UITapGestureRecognizer?){
        if scrollViewOutlet.zoomScale > scrollViewOutlet.minimumZoomScale {
            scrollViewOutlet.setZoomScale(scrollViewOutlet.minimumZoomScale, animated: true)
        } else {
            scrollViewOutlet.setZoomScale(scrollViewOutlet.maximumZoomScale/2, animated: true)
        }
    }

}
extension PreviewViewCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageItem
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let image = imageItem.image else { return }
        let imageViewSize = AVMakeRect(aspectRatio: image.size, insideRect: imageItem.frame)
        let verticalInsets = -(scrollView.contentSize.height - max(imageViewSize.height, scrollView.bounds.height)) / 2
        let horizontalInsets = -(scrollView.contentSize.width - max(imageViewSize.width, scrollView.bounds.width)) / 2
        scrollView.contentInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
    }
}


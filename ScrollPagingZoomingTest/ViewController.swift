
import UIKit

class ViewController: UIViewController {
    
    var mainScrollView: UIScrollView!
    var pagesStackView: UIStackView! // vertical
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainScrollView()
        addPages()
    }
    
    func setupMainScrollView(){
        mainScrollView = UIScrollView()
        mainScrollView.backgroundColor = .lightGray
        mainScrollView.isPagingEnabled = true
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.isScrollEnabled = true
        //mainScrollView.panGestureRecognizer.minimumNumberOfTouches = 2
        //mainScrollView.panGestureRecognizer.maximumNumberOfTouches = 2
        mainScrollView.canCancelContentTouches = true
        mainScrollView.delaysContentTouches = false
        mainScrollView.contentSize = CGSize(width: 900, height: 1400)
        self.view.addSubview(mainScrollView)
        
        NSLayoutConstraint.activate([
            mainScrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            mainScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mainScrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        pagesStackView = UIStackView()
        pagesStackView.translatesAutoresizingMaskIntoConstraints = false
        pagesStackView.axis = .vertical
        
        mainScrollView.addSubview(pagesStackView)
        
        // this *also* controls the .contentSize of the scrollview
        NSLayoutConstraint.activate([
            pagesStackView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor),
            pagesStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            pagesStackView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor),
            pagesStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            pagesStackView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor)
        ])
    }
    
    func addPages(){
        // add 3 pages
        for index in 0...2  {
            
            let pageScrollView = UIScrollView()
            pageScrollView.translatesAutoresizingMaskIntoConstraints = false
            pageScrollView.alwaysBounceVertical = false
            pageScrollView.alwaysBounceHorizontal = false
            pageScrollView.minimumZoomScale = 0.5
            pageScrollView.maximumZoomScale = 4.0
            pageScrollView.isScrollEnabled = true
            //pageScrollView.panGestureRecognizer.minimumNumberOfTouches = 2
            //pageScrollView.panGestureRecognizer.maximumNumberOfTouches = 2
            pageScrollView.bounces = false
            pageScrollView.delaysContentTouches = false
            pageScrollView.canCancelContentTouches = false
            pageScrollView.delegate = self
            
            var imageName : String = ""
            if index == 0 {
                imageName = "cat.jpg"
            }else if index == 1 {
                imageName = "dog.jpg"
            } else if index == 2 {
                imageName = "lion.jpg"
            }
            
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            pageScrollView.addSubview(imageView)
            
            pageScrollView.contentSize = imageView.bounds.size

            pagesStackView.insertArrangedSubview(pageScrollView,at: index)
            
            NSLayoutConstraint.activate([
                pageScrollView.heightAnchor.constraint(equalTo: mainScrollView.heightAnchor),
                
                imageView.centerXAnchor.constraint(equalTo: pageScrollView.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: pageScrollView.centerYAnchor),
            ])
            
            pageScrollView.layoutIfNeeded()
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first // ie. imageView
    }
}


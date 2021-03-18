import UIKit
class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    @IBOutlet weak var NameLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var BountyLabelCenterX: NSLayoutConstraint!
    
    let viewModel = DetailViewMomdel()
    
    // 화면이 보이기 직전
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // 애니메이션 준비하는 과정
        prepareAnimation()
    }
    
    // 애니메이션
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
    }
    
    // 애니메이션 들어가기 전 기본 세팅
    private func prepareAnimation() {
        // view 밖으로 내보내기
//        NameLabelCenterX.constant = view.bounds.width
//        BountyLabelCenterX.constant = view.bounds.width
        
        nameLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        bountyLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        
        nameLabel.alpha = 0
        bountyLabel.alpha = 0
    }
    
    private func showAnimation() {
//        // 밖으로 내보내진 값들을 원위치
//        NameLabelCenterX.constant = 0
//        BountyLabelCenterX.constant = 0

        
        // label 애니메이션 효과 추가
        // namelabel 애니메이션
        UIView.animate(withDuration: 0.7, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
            
            // affinetransform은 변형을 가하는건데 변형을 가하기 전에 모습은 identity로 사용
            self.nameLabel.transform = CGAffineTransform.identity
            self.nameLabel.alpha = 1
        }, completion: nil)
        
        // bountylabel 애니메이션
        UIView.animate(withDuration: 0.7, delay: 0.7, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
            
            self.bountyLabel.transform = CGAffineTransform.identity
            self.bountyLabel.alpha = 1
        
        }, completion: nil)
        
        // 이미지 애니메이션 효과 추가
        UIView.transition(with: imgView, duration: 0.4, options: .transitionFlipFromLeft, animations: nil, completion: nil)

        
        
    }
    
    
    func updateUI() {
        if let bountyInfo = viewModel.bountyInfo {
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }
    }
    
    // close 버튼을 누르면 창이 닫힘
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

class DetailViewMomdel {
    var bountyInfo: BountyInfo?
    func update(model: BountyInfo?) {
        bountyInfo = model 
    }
}

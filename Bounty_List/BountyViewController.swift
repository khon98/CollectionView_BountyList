import UIKit

class BountyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let viewModel = BountyViewModel()
    let bountyList = [30000000, 50, 5000000, 500000000, 10000000, 15000000, 200000000, 350000000]
    
    // segue를 수행하기 직전에 수행하는 것에 대해서 준비하는 메서드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int {
                
                let bountyInfo = viewModel.bountyInfo(at: index)
                vc?.viewModel.update(model: bountyInfo)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // UICollectionViewDataSource
    // 셀을 몇개를 보여줄지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    // 어떻게 표현할지
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
        
        let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
            cell.update(info: bountyInfo)
        cell.update(info: bountyInfo)
        return cell
    }
    
    // UICollectionViewDelegate
    // 셀이 클릭 됐을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    // UICollectionViewDelegateFlowLayout
    // 셀 사이즈 계산 / 다른 디바이스에서도 동일하게 나오기 위한 작업
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 높이와 간격 지정
        let itemSpacing: CGFloat = 10 // 아이템 간격
        let textAreaHeight: CGFloat = 65 // 텍스트 간격
        
        let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2
        let height : CGFloat = width * 10/7 + textAreaHeight
        return CGSize(width: width, height: height)
    }
 
}

// custom cell 생성
class GridCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(info: BountyInfo) {
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }
}

// ViewModel
class BountyViewModel {
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 30000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 5000000),
        BountyInfo(name: "luffy", bounty: 500000000),
        BountyInfo(name: "nami", bounty: 10000000),
        BountyInfo(name: "robin", bounty: 15000000),
        BountyInfo(name: "sanji", bounty: 200000000),
        BountyInfo(name: "zoro", bounty: 350000000)
    ]
    
    // 순위 정하기
    var sortedList: [BountyInfo] {
        let sortedList = bountyInfoList.sorted { prev, next in
            return prev.bounty > next.bounty
        }
        return sortedList
    }
    
    var numOfBountyInfoList: Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo {
        return sortedList[index]
    }
}

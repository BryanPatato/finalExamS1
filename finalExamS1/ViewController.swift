import UIKit
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var use: UISegmentedControl!
    @IBOutlet weak var cellCell: UICollectionView!
    var cellCluster: [UICollectionViewCell] = []
    var sweeper: mineSweeper = mineSweeper(desX: 8, desY: 8)
    var mayBool = true
    override func viewDidLoad()
    {
        super.viewDidLoad()
        cellCell.dataSource = self
        cellCell.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 64
    }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = cellCell.dequeueReusableCell(withReuseIdentifier: "selCel", for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0, green: 0.6180339456, blue: 1, alpha: 0.8438409567)
        cellCluster.append(cell)
        return cellCluster[indexPath.row]
    }
    func collectionView(_ colectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView(colectionView, cellForItemAt: indexPath) as! CustomCell
        print("\(indexPath.row), \(indexPath.section)")
        if mayBool == true
        {
            sweeper.initReveal(unit: indexPath.row)
            mayBool = false
        }
        else
        {
            sweeper.reveal(unit: indexPath.row)
        }
        let desiredCol = #colorLiteral(red: 0.7254729867, green: 0.7254837155, blue: 0.7297105193, alpha: 1)
        switch sweeper.getNums(unit: indexPath.row)
        {
        case 1:
            cell.cellImage.image = UIImage(named: "1")
        case 2:
            cell.cellImage.image = UIImage(named: "2")
        case 3:
            cell.cellImage.image = UIImage(named: "3")
        case 4:
            cell.cellImage.image = UIImage(named: "4")
        case 5:
            cell.cellImage.image = UIImage(named: "5")
        case 6:
            cell.cellImage.image = UIImage(named: "6")
        case 7:
            cell.cellImage.image = UIImage(named: "7")
        case 8:
            cell.cellImage.image = UIImage(named: "8")
        default:
            cell.cellImage.image = UIImage(named: "nilch")
        }
        UICollectionViewCell.animate(withDuration: 3, delay: 0.1, options: .curveEaseOut, animations:
        {cell.backgroundColor = desiredCol; cell.cellImage.alpha = 1})
    }
}


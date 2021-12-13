import UIKit
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var use: UISegmentedControl!
    @IBOutlet weak var cellCell: UICollectionView!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var missCounter: UILabel!
    @IBOutlet weak var miss: UILabel!
    var cellCluster: [UICollectionViewCell] = []
    var sweeper: mineSweeper = mineSweeper(desX: 10, desY: 10)
    var mayBool = true
    var wildReset = false
    var misscount = 0
    override func viewDidLoad()
    {
        super.viewDidLoad()
        miss.layer.cornerRadius = 3
        cellCell.delegate = self
        cellCell.dataSource = self
    }
    @IBAction func resetButton(_ sender: Any)
    {
        sweeper =  mineSweeper(desX: 10, desY: 10)
        mayBool = true
        wildReset = true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return sweeper.getSize()
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
        if use.selectedSegmentIndex == 1
        {
            if sweeper.flagged(unit: indexPath.row)
            {
                let desiredCol = #colorLiteral(red: 0, green: 0.6180339456, blue: 1, alpha: 0.8438409567)
                sweeper.remFlag(unit: indexPath.row)
                UICollectionViewCell.animate(withDuration: 0.7, delay: 0.1, options: .curveEaseOut, animations:
                {cell.backgroundColor = desiredCol; cell.cellImage.alpha = 0})
            }
            else
            {
                let desiredCol = #colorLiteral(red: 0.7254729867, green: 0.7254837155, blue: 0.7297105193, alpha: 1)
                cell.cellImage.image = UIImage(named: "flag")
                sweeper.placeFlag(unit: indexPath.row)
                UICollectionViewCell.animate(withDuration: 0.7, delay: 0.1, options: .curveEaseOut, animations:
                {cell.backgroundColor = desiredCol; cell.cellImage.alpha = 1})
                if sweeper.win()
                {
                    let err = UIAlertController(title: "You won with \(misscount) misses!", message: "Congratz!", preferredStyle: .alert)
                    err.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
                    present(err, animated: true)
                }
            }
        }
        else
        {
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
            print(sweeper.getNums(unit: indexPath.row))
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
            case 9:
                do
                {
                    cell.cellImage.image = UIImage(named: "mine")
                    misscount += 1
                    missCounter.text = "\(misscount)"
                }
            default:
                cell.cellImage.image = UIImage(named: "nilch")
            }
            UICollectionViewCell.animate(withDuration: 0.7, delay: 0.1, options: .curveEaseOut, animations:
            {cell.backgroundColor = desiredCol; cell.cellImage.alpha = 1})
        }
    }
}


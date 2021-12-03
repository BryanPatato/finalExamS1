import UIKit
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var use: UISegmentedControl!
    @IBOutlet weak var cellCell: UICollectionView!
    var cellCluster: [UICollectionViewCell] = []
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
        let cell = collectionView(colectionView, cellForItemAt: indexPath)
        let preColor = cell.backgroundColor
        if use.selectedSegmentIndex == 0
        {
            cell.backgroundColor = UIColor.black
        }
        else
        {
            cell.backgroundColor = UIColor.gray
        }
        UICollectionViewCell.animate(withDuration: 2, delay: 0.2, options: .curveEaseInOut, animations:
            {cell.backgroundColor = preColor})
    }
}


//
//  CollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Chris Hahn on 7/11/17.
//  Copyright © 2017 Sturnella. All rights reserved.
//

import UIKit

// removed following line per exercise instructions
// private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    var plantDataItems = [DataItem]()
    var animalDataItems = [DataItem]()
    var allItems = [[DataItem]]()
    
    @IBAction func addButtonTapped(_ sender: AnyObject) {
        let item = DataItem(title: "New Plant", kind: .Plant, imageName: "images/default.jpeg")
        let index = allItems[0].count
        allItems[0].append(item)
// All array counts not maintaining continuity until one also adds the following line when creating a new "plant" kind in Section "0"
        plantDataItems.append(item)
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.insertItems(at: [indexPath])
        print(" ...... New plant item created  ..... ")
        print("Plant count ", plantDataItems.count)
        print("Animal count ", animalDataItems.count)
        print(allItems)
    }
    
 // added to move cell items ...
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = allItems[sourceIndexPath.section][sourceIndexPath.row]
        allItems[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        allItems[destinationIndexPath.section].insert(itemToMove, at: destinationIndexPath.row)
        print(" ...... After move  ..... ")
        print("Plant count ", plantDataItems.count)
        print("Animal count ", animalDataItems.count)
        print(allItems)
    }
    
// added to delete cell items ...
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          func showAlert(title: String, theMessage: String?) {
            let msg = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.alert)
            msg.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
                collectionView.performBatchUpdates({Void in
//              added this .remove line to replace the original if-else statement that follows the next .deleteItems line
                    self.allItems[indexPath.section].remove(at: indexPath.row)
                    self.collectionView?.deleteItems(at: [indexPath])
                    /*
                    if indexPath.section == 0 {
                        self.plantDataItems.remove(at: indexPath.item)
                    
                    } else {
                        self.animalDataItems.remove(at: indexPath.item)
                    }
                    */
                    
                }, completion: nil)
                
                print(" ..... After delete ..... ")
                print("Plant count ", self.plantDataItems.count)
                print("Animal count ", self.animalDataItems.count)
                print(self.allItems)
            }))
            msg.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(msg, animated: true, completion: nil)
        }
        
        showAlert(title: "Delete Selected Image?", theMessage: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // commented out following line to remove since not using the default UICollectionViewCell
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        for i in 1...12 {
            if i > 9 {
                plantDataItems.append(DataItem(title: "Plant #\(i)", kind: Kind.Plant, imageName: "images/img\(i).jpg"))
            } else {
                plantDataItems.append(DataItem(title: "Plant #0\(i)", kind: Kind.Plant, imageName: "images/img0\(i).jpg"))
            }
        }
    
        let width = collectionView!.frame.width / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        for i in 1...12 {
            if i > 9 {
                animalDataItems.append(DataItem(title: "Animal #\(i)", kind: Kind.Animal, imageName: "images/anim\(i).jpg"))
            } else {
                animalDataItems.append(DataItem(title: "Animal #0\(i)", kind: Kind.Animal, imageName: "images/anim0\(i).jpg"))
            }
        }
        
        allItems.append(plantDataItems)
        allItems.append(animalDataItems)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return allItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allItems[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DataItemCell
        let dataItem = allItems[indexPath.section][indexPath.row]
        cell.dataItem = dataItem

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! DataItemHeader
        var title = ""
        if let kind = Kind(rawValue: indexPath.section) {
            title = kind.description()
        }
        sectionHeader.title = title
        
        return sectionHeader
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
}

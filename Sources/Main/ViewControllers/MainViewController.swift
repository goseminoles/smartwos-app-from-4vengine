//
// Created by Wei Zhang on 8/13/18.
// Copyright (c) 2018 MarcoSantaDev. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  typealias Story = Models.Story

  var mainRouter: Router?

  let cellId = "cellId"
  let teams = [
    Story(image: "label", name: "Label"),
    Story(image: "pick", name: "Pick"),
    Story(image: "quantity-check", name: "QC"),
    Story(image: "receive", name: "Receive"),
    Story(image: "ship", name: "Ship"),
    Story(image: "label", name: "Assemble"),
    Story(image: "pick", name: "MOD"),
    Story(image: "quantity-check", name: "Quality Check"),
    Story(image: "receive", name: "Pack"),
    Story(image: "ship", name: "Weight"),
    Story(image: "ship", name: "Final Mile"),
    Story(image: "receive", name: "Weight"),
    Story(image: "pick", name: "Pickup"),
    Story(image: "ship", name: "Final Mile"),
    Story(image: "receive", name: "Transfer"),
  ]

  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView?.isUserInteractionEnabled = true
    collectionView?.allowsMultipleSelection = false
    collectionView?.allowsSelection = true

    collectionView?.backgroundColor = UIColor(red: 42 / 255, green: 57 / 255,
        blue: 95 / 255, alpha: 1)

    navigationItem.title = "Smart WOS"

    navigationController?.navigationBar.backgroundColor = UIColor(red: 42 / 255, green: 57 / 255,
        blue: 95 / 255, alpha: 1)
    navigationController?.navigationBar.barTintColor = UIColor(red: 217 / 255, green:
    48 / 255, blue: 80 / 255, alpha: 1)

    navigationController?.navigationBar.titleTextAttributes = [
      NSForegroundColorAttributeName: UIColor.white,
      NSFontAttributeName: UIFont.boldSystemFont(ofSize: 28)]


    collectionView?.register(StoryCell.self, forCellWithReuseIdentifier: cellId)

    // layout the main view: vertically centering
    collectionView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
    collectionView?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return teams.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        as! StoryCell

    cell.story = teams[indexPath.item]

    return cell
  }

  // This is where we handle cell clicked event
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:
      IndexPath) {

    guard let name = teams[indexPath.item].name else {
      return
    }

    _ = launchStory(for: name)

  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 160, height: 160)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  }

  override func didReceiveMemoryWarning() {
    let alert = UIAlertController(title: "Memory Alert", message: "Low memory. Restart your " +
        "device ASAP",
        preferredStyle:
        .alert)
    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
      NSLog("Low memory warning.")
    }))
    self.present(alert, animated: true, completion: nil)
  }

  func launchStory(for storyName: String) -> Bool {


    // TODO: delete
    let service = LabelService()
    service
        .getLabelItems(for: "920510001")
        .subscribe(
            onNext: { [weak self] items in
              guard items.count > 0 else {
                self?.alert(message: "no items fetched", title: "Fetching Items Alert")
                return
              }

              print("items: ")
              print("items \(items)")
            },
            onError: { [weak self] error in
              self?.alert(message: "Error no items fetched", title: "Error Alert")

            }
        )
        .disposed(by: disposeBag)

    return true
  }


}





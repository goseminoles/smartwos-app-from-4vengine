//
// Created by Wei Zhang on 8/13/18.
// Copyright (c) 2018 MarcoSantaDev. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  let cellId = "cellId"
  let teams = [
    Team(image: "label", name: "Label"),
    Team(image: "pick", name: "Pick"),
    Team(image: "quantity-check", name: "QC"),
    Team(image: "receive", name: "Receive"),
    Team(image: "ship", name: "Ship"),
    Team(image: "label", name: "Assemble"),
    Team(image: "pick", name: "MOD"),
    Team(image: "quantity-check", name: "Quality Check"),
    Team(image: "receive", name: "Pack"),
    Team(image: "ship", name: "Weight"),
    Team(image: "ship", name: "Final Mile"),
    Team(image: "receive", name: "Weight"),
    Team(image: "pick", name: "Pickup"),
  ]

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


    collectionView?.register(TeamCell.self, forCellWithReuseIdentifier: cellId)

    // layout the main view: vertically centering
    collectionView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
    collectionView?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return teams.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        as! TeamCell

    cell.team = teams[indexPath.item]

    return cell
  }

  // This is where we handle cell clicked event
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:
      IndexPath) {

    guard let name = teams[indexPath.item].name else {
      return
    }

    print("Got clicked on cell name: \(name)!")
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

}


class TeamCell: UICollectionViewCell {

  var team: Team? {

    didSet {

      guard let teamImage = team?.image else {
        return
      }
      guard let teamName = team?.name else {
        return
      }

      teamImageView.image = UIImage(named: teamImage)
      teamLabel.text = teamName
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
    setCellShadow()
  }

  func setCellShadow() {
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 1)
    self.layer.shadowOpacity = 1
    self.layer.shadowRadius = 1.0
    self.layer.masksToBounds = false
    self.layer.cornerRadius = 3
  }

  func setup() {
    self.backgroundColor = UIColor(red: 11 / 255, green: 22 / 255, blue: 53 / 255, alpha: 1)
    self.addSubview(teamImageView)
    self.addSubview(teamLabel)

    teamImageView.anchor(top: topAnchor, left: leftAnchor,
        bottom: nil, right: rightAnchor,
        paddingTop: 10, paddingLeft: 10,
        paddingBottom: 10, paddingRight: 10,
        width: 0, height: 120)

    teamLabel.anchor(top: teamImageView.bottomAnchor, left: leftAnchor,
        bottom: bottomAnchor, right: rightAnchor,
        paddingTop: 0, paddingLeft: 0,
        paddingBottom: 0, paddingRight: 0,
        width: 0, height: 0)

  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  let teamImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
//    imageView.backgroundColor = .green
    return imageView
  }()

  let teamLabel: UILabel = {
    let label = UILabel()
    label.text = "name"
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 24)
    label.textAlignment = .center
    return label
  }()
}

struct Team {
  let image: String?
  let name: String?
}




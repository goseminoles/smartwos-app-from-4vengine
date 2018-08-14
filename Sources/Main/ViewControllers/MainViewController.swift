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
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView?.backgroundColor = UIColor(red: 42/255, green: 57/255,
        blue: 95/255, alpha: 1)

    navigationItem.title = "Smart WOS"
    navigationController?.navigationBar.backgroundColor = UIColor(red: 42/255, green: 57/255,
        blue: 95/255, alpha: 1)
    navigationController?.navigationBar.barTintColor = UIColor(red: 217/255, green:
        48/255, blue: 80/255, alpha: 1)

    navigationController?.navigationBar.titleTextAttributes = [
      NSForegroundColorAttributeName:  UIColor.white,
      NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20)]

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

    // TODO: double-check if the following incurs memory leak
    cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))

    return cell
  }

//  override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//        as! TeamCell
//
//    guard let name = teams[indexPath.item].name else { return }
//
//    print("Got clicked on cell name: \(name)!")
//  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (view.frame.width / 3) - 16, height: 100)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top:8, left: 8, bottom: 8, right: 8)
  }

  func tap(_ sender: UITapGestureRecognizer) {

    let location = sender.location(in: self.collectionView)
    let indexPath = self.collectionView?.indexPathForItem(at: location)

    if let index = indexPath {
      print("Got clicked on index: \(index)!")
      let team = teams[index[1]]
      let name = team.name!
      print("Got clicked on name: \(name)!")
    }
  }
}


class TeamCell: UICollectionViewCell {

  var team: Team? {

    didSet {

      guard let teamImage = team?.image else { return }
      guard let teamName = team?.name else { return }

      teamImageView.image = UIImage(named: teamImage)
      teamLabel.text = teamName
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
    setCellShadow()
  }

  func setCellShadow(){
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 1)
    self.layer.shadowOpacity = 1
    self.layer.shadowRadius = 1.0
    self.layer.masksToBounds = false
    self.layer.cornerRadius = 3
  }

  func setup() {
    self.backgroundColor = UIColor(red: 11/255, green: 22/255, blue: 53/255, alpha: 1)
    self.addSubview(teamImageView)
    self.addSubview(teamLabel)

    teamImageView.anchor(top: topAnchor, left: leftAnchor,
        bottom: nil, right: rightAnchor,
        paddingTop:10, paddingLeft: 10,
        paddingBottom: 0, paddingRight: 10,
        width: 0, height: 50)

    teamLabel.anchor(top: teamImageView.bottomAnchor, left: leftAnchor,
        bottom: bottomAnchor, right: rightAnchor,
        paddingTop:0, paddingLeft: 0,
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
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textAlignment = .center
    return label
  }()
}

struct Team {
  let image: String?
  let name: String?
}




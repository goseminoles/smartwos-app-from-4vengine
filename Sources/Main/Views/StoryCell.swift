//
// Created by Wei Zhang on 8/15/18.
// Copyright (c) 2018 MarcoSantaDev. All rights reserved.
//

import UIKit
class StoryCell: UICollectionViewCell {

  typealias Story = Models.Story

  var team: Story? {

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

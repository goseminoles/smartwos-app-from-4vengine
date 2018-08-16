//
// Created by Wei Zhang on 8/15/18.
// Copyright (c) 2018 MarcoSantaDev. All rights reserved.
//

import UIKit
class StoryCell: UICollectionViewCell {

  typealias Story = Models.Story

  var story: Story? {

    didSet {

      guard let storyImage = story?.image else {
        return
      }
      guard let storyName = story?.name else {
        return
      }

      storyImageView.image = UIImage(named: storyImage)
      storyLabel.text = storyName
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
    self.addSubview(storyImageView)
    self.addSubview(storyLabel)

    storyImageView.anchor(top: topAnchor, left: leftAnchor,
        bottom: nil, right: rightAnchor,
        paddingTop: 10, paddingLeft: 10,
        paddingBottom: 10, paddingRight: 10,
        width: 0, height: 120)

    storyLabel.anchor(top: storyImageView.bottomAnchor, left: leftAnchor,
        bottom: bottomAnchor, right: rightAnchor,
        paddingTop: 0, paddingLeft: 0,
        paddingBottom: 0, paddingRight: 0,
        width: 0, height: 0)

  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  let storyImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  let storyLabel: UILabel = {
    let label = UILabel()
    label.text = "name"
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 24)
    label.textAlignment = .center
    return label
  }()
}

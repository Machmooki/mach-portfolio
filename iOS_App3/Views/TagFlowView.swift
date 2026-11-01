//
//  TagFlowView.swift
//  iOS_App3
//
//  Created by Mach Suwanpatikorn on 31/10/2569 BE.
//

import UIKit

class TagFlowView: UIView {

    private let rowsStack = UIStackView()
    private var tags: [String] = []
    private var lastWidth: CGFloat = 0

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        rowsStack.axis = .vertical
        rowsStack.alignment = .leading
        rowsStack.spacing = 8
        rowsStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rowsStack)
        NSLayoutConstraint.activate([
            rowsStack.topAnchor.constraint(equalTo: topAnchor),
            rowsStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            rowsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            rowsStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
        ])
    }

    func setTags(_ newTags: [String]) {
        tags = newTags
        lastWidth = 0
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.width != lastWidth {
            lastWidth = bounds.width
            buildRows()
        }
    }

    private func buildRows() {
        rowsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        var row = makeRow()
        var rowWidth: CGFloat = 0

        for tag in tags {
            let chip = makeChip(tag)
            let chipWidth = chip.intrinsicContentSize.width

            if rowWidth > 0 && rowWidth + chipWidth > bounds.width {
                rowsStack.addArrangedSubview(row)
                row = makeRow()
                rowWidth = 0
            }
            row.addArrangedSubview(chip)
            rowWidth += chipWidth + row.spacing
        }
        if !row.arrangedSubviews.isEmpty {
            rowsStack.addArrangedSubview(row)
        }
    }

    private func makeRow() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 8
        return row
    }

    private func makeChip(_ text: String) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.title = text
        config.baseForegroundColor = Theme.black
        config.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 14, bottom: 7, trailing: 14)
        config.cornerStyle = .capsule
        config.background.backgroundColor = Theme.lightGray
        config.background.strokeColor = Theme.border
        config.background.strokeWidth = 1
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var attributes = attributes
            attributes.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            return attributes
        }

        let chip = UIButton(configuration: config)
        chip.isUserInteractionEnabled = false
        return chip
    }
}

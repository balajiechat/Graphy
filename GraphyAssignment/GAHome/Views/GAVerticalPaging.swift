//
//  GAVerticalPaging.swift
//  GraphyAssignment
//
//  Created by Balaji S on 06/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

class GAVerticalPaging: UICollectionViewFlowLayout {

     override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        guard let collectionView = self.collectionView else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }

        // Page height used for estimating and calculating paging.
        let pageHeight = collectionView.frame.width + self.minimumLineSpacing + collectionView.contentInset.top

        // Make an estimation of the current page position.
        let approximatePage = (collectionView.contentOffset.y + (collectionView.frame.width / 2)) / pageHeight

        // Determine the current page based on velocity.
        let currentPage = velocity.y == 0 ? ceil(approximatePage) : (velocity.y < 0.0 ? floor(approximatePage) : ceil(approximatePage))

        // Create custom flickVelocity.
        let flickVelocity = velocity.y * 0.2

        // Check how many pages the user flicked, if <= 1 then flickedPages should return 0.
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 : ceil(flickVelocity)

        var newVerticalOffset = ((currentPage + flickedPages) * pageHeight) - collectionView.contentInset.top
        newVerticalOffset = (newVerticalOffset + self.minimumLineSpacing + (collectionView.frame.width / 2)) - (collectionView.frame.height / 2)
        return CGPoint(x: proposedContentOffset.x, y: newVerticalOffset)
    }
    
}

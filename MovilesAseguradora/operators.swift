//
//  operators.swift
//  MovilesAseguradora
//
//  Created by David Santiago Chicaiza on 9/6/16.
//  Copyright © 2016 David Chicaiza. All rights reserved.
//

import Foundation


prefix operator ** {}

prefix func ** (fun: ()->())
{
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    
    dispatch_async(dispatch_get_global_queue(priority, 0))
    {
        fun()
        dispatch_async(dispatch_get_main_queue())
        {
            // update some UI
        }
    }
}
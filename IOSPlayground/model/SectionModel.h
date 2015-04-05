//
//  SectionModel.h
//  IOSPlayground
//
//  Created by Gongwei on 15/4/5.
//  Copyright (c) 2015年 Gongwei. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SectionModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString* section;
@property (nonatomic, strong) NSArray* items;

@end


//
//  SectionModel.m
//  IOSPlayground
//
//  Created by Gongwei on 15/4/5.
//  Copyright (c) 2015年 Gongwei. All rights reserved.
//

#import "SectionModel.h"
#import "ItemModel.h"

@implementation SectionModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

+ (NSValueTransformer*) itemsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[ItemModel class]];
}

@end

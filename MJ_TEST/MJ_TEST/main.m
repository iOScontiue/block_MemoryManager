//
//  main.m
//  MJ_TEST
//
//  Created by 卢育彪 on 2019/1/2.
//  Copyright © 2019年 luyubiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Person.h"

void test1()
{
    int num = 10;
//    __block __weak int age = 20;
    __block int age = 20;
    Person *per = [[Person alloc] init];
    void(^block)(void) = ^{
        NSLog(@"%d %d %p", num, age, per);
    };
    block();
}

void test2()
{
    Person *per = [[Person alloc] init];
    per.age = 20;
//    __block Person *blockPer = per;
    __block __weak Person *blockPer = per;
    void(^block)(void) = ^{
        blockPer.age = 30;
        NSLog(@"%d", blockPer.age);
    };
    block();
}

typedef void(^MyBlock)(void);

void test3()
{
    MyBlock block;
    {
        Person *per = [[Person alloc] init];
        __block __weak Person *weakPer = per;
        block = ^{
            NSLog(@"%p", weakPer);
        };
    }
    
    block();
}

void test4()
{
    Person *per = [[Person alloc] init];
    
    MyBlock block = [^{
        NSLog(@"%p", per);
    } copy];
    
    [per release];
    
    block();
    
    [block release];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        test1();
//        test2();
//        test3();
        test4();
    }
    return 0;
}



//
//  Encrypt.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/26.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "Encrypt.h"

@implementation Encrypt

-(NSString *)strEncode:(NSString *)data firstKey:(NSString *)firstKey secondKey:(NSString *)secondKey thirdKey:(NSString *)thirdKey{
    
    int leng = data.length;
    NSString * encData = @"";
    
    
    NSArray *firstKeyBt, *secondKeyBt, *thirdKeyBt;
    
    int firstLength,secondLength,thirdLength;
    
    if(firstKey != nil && ![firstKey isEqualToString: @""]){
        
        firstKeyBt = [self getKeyBytes:firstKey];

        firstLength = firstKeyBt.count;
        
    }
    if(secondKey != nil && ![secondKey isEqualToString: @""]){
        secondKeyBt = [self getKeyBytes:secondKey];//getKeyBytes(secondKey);
        secondLength = secondKeyBt.count;
    }
    if(thirdKey != nil && ![thirdKey isEqualToString: @""]){
        thirdKeyBt = [self getKeyBytes:thirdKey];
        thirdLength = thirdKeyBt.count;
    }
    
    if(leng > 0){
        if(leng < 4){
            NSArray *bt = [self strToBt:data];
            NSArray *encByte ;
            if(firstKey != nil && ![firstKey isEqualToString: @""] && secondKey != nil && ![secondKey isEqualToString: @""] && thirdKey != nil && ![thirdKey isEqualToString: @""]){
                
                NSArray* tempBt;
                int x,y,z;
                tempBt = bt;
                for(x = 0;x < firstLength ;x ++){
                    NSArray *firstKeyBtArr = [firstKeyBt objectAtIndex:x];
                    tempBt = [self enc:tempBt :firstKeyBtArr];
                }
                for(y = 0;y < secondLength ;y ++){
                    
                    NSArray *secondKeyBtArr = [secondKeyBt objectAtIndex:y];
                    tempBt = [self enc:tempBt :secondKeyBtArr];

                }
                for(z = 0;z < thirdLength ;z ++){
                    
                    NSArray *thirdKeyBtArr = [thirdKeyBt objectAtIndex:z];
                    tempBt = [self enc:tempBt :thirdKeyBtArr];
                    
                }
                encByte = tempBt;
            }else{
                if(firstKey != nil && ![firstKey isEqualToString:@""] && secondKey != nil && ![secondKey isEqualToString:@""]){
                    NSArray* tempBt;
                    int x,y;
                    tempBt = bt;
                    for(x = 0;x < firstLength ;x ++){
                        NSArray *firstKeyBtArr = [firstKeyBt objectAtIndex:x];
                        tempBt = [self enc:tempBt :firstKeyBtArr];
                    }
                    for(y = 0;y < secondLength ;y ++){
                        NSArray *secondKeyBtArr = [secondKeyBt objectAtIndex:y];
                        tempBt = [self enc:tempBt :secondKeyBtArr];
                    }
                    encByte = tempBt;
                }else{
                    if(firstKey != nil && ![firstKey isEqualToString:@""]){
                        NSArray *tempBt;
                        int x = 0;
                        tempBt = bt;
                        for(x = 0;x < firstLength ;x ++){
                            NSArray *firstKeyBtArr = [firstKeyBt objectAtIndex:x];
                            tempBt = [self enc:tempBt :firstKeyBtArr];
                        }
                        encByte = tempBt;
                    }
                }
            }
            encData = [self bt64ToHex:encByte];//bt64ToHex(encByte);
        }else{
            int iterator = leng/4;
            int remainder = leng%4;
            int i=0;
            for(i = 0;i < iterator;i++){
                
                NSRange range = NSMakeRange(i * 4 + 0,  4);
                NSString *tempData = [data substringWithRange:range];
                
                NSArray *tempByte = [self strToBt:tempData];//strToBt(tempData);
                NSArray *encByte ;
                if(firstKey != nil && ![firstKey isEqualToString: @""] && secondKey != nil && ![secondKey isEqualToString: @""] && thirdKey != nil && ![thirdKey isEqualToString: @""]){
                    NSArray *tempBt;
                    int x,y,z;
                    tempBt = tempByte;
                    for(x = 0;x < firstLength ;x ++){
                        NSArray *firstKeyBtArr = [firstKeyBt objectAtIndex:x];
                        tempBt = [self enc:tempBt :firstKeyBtArr];
                    }
                    for(y = 0;y < secondLength ;y ++){
                        NSArray *secondKeyBtArr = [secondKeyBt objectAtIndex:y];
                        tempBt = [self enc:tempBt :secondKeyBtArr];

                    }
                    for(z = 0;z < thirdLength ;z ++){
                        NSArray *thirdKeyBtArr = [thirdKeyBt objectAtIndex:z];
                        tempBt = [self enc:tempBt :thirdKeyBtArr];
                    }
                    encByte = tempBt;
                }else{
                    if(firstKey != nil && ![firstKey isEqualToString:@""] && secondKey != nil && ![secondKey isEqualToString:@""]){
                        NSArray* tempBt;
                        int x,y;
                        tempBt = tempByte;
                        for(x = 0;x < firstLength ;x ++){
                            NSArray *firstKeyBtArr = [firstKeyBt objectAtIndex:x];
                            tempBt = [self enc:tempBt :firstKeyBtArr];
                        }
                        for(y = 0;y < secondLength ;y ++){
                            NSArray *secondKeyBtArr = [secondKeyBt objectAtIndex:y];
                            tempBt = [self enc:tempBt :secondKeyBtArr];

                        }
                        encByte = tempBt;
                    }else{
                        if(firstKey != nil && ![firstKey isEqualToString:@""]){
                            NSArray *tempBt;
                            int x;
                            tempBt = tempByte;
                            for(x = 0;x < firstLength ;x ++){
                                NSArray *firstKeyBtArr = [firstKeyBt objectAtIndex:x];
                                tempBt = [self enc:tempBt :firstKeyBtArr];
                            }
                            encByte = tempBt;
                        }
                    }
                }
                encData = [encData stringByAppendingString:[self bt64ToHex:encByte]];
//                encData += bt64ToHex(encByte);
            }
            if(remainder > 0){
                NSRange range = NSMakeRange(iterator*4+0, remainder);
                
                
                NSString* remainderData = [data substringWithRange:range];
                
                NSArray *tempByte = [self strToBt:remainderData];

                NSArray *encByte ;
                if(firstKey != nil && ![firstKey isEqualToString: @""] && secondKey != nil && ![secondKey isEqualToString: @""] && thirdKey != nil && ![thirdKey isEqualToString: @""]){
                    NSArray *tempBt;
                    int x,y,z;
                    tempBt = tempByte;
                    for(x = 0;x < firstLength ;x ++){
                        NSArray *firstKeyBtArr = [firstKeyBt objectAtIndex:x];
                        tempBt = [self enc:tempBt :firstKeyBtArr];
                    }
                    for(y = 0;y < secondLength ;y ++){
                        NSArray *secondKeyBtArr = [secondKeyBt objectAtIndex:y];
                        tempBt = [self enc:tempBt :secondKeyBtArr];
                        
                    }
                    for(z = 0;z < thirdLength ;z ++){
                        NSArray *thirdKeyBtArr = [thirdKeyBt objectAtIndex:z];
                        tempBt = [self enc:tempBt :thirdKeyBtArr];
                    }
                    encByte = tempBt;
                }else{
                    if(firstKey != nil && ![firstKey isEqualToString:@""] && secondKey != nil && ![secondKey isEqualToString:@""]){
                        NSArray* tempBt;
                        int x,y;
                        tempBt = tempByte;
                        for(x = 0;x < firstLength ;x ++){
                            NSArray *firstKeyBtArr = [firstKeyBt objectAtIndex:x];
                            tempBt = [self enc:tempBt :firstKeyBtArr];
                        }
                        for(y = 0;y < secondLength ;y ++){
                            NSArray *secondKeyBtArr = [secondKeyBt objectAtIndex:y];
                            tempBt = [self enc:tempBt :secondKeyBtArr];
                            
                        }
                        encByte = tempBt;
                    }else{
                        if(firstKey != nil && ![firstKey isEqualToString:@""]){
                            NSArray *tempBt;
                            int x;
                            tempBt = tempByte;
                            for(x = 0;x < firstLength ;x ++){
                                NSArray *firstKeyBtArr = [firstKeyBt objectAtIndex:x];
                                tempBt = [self enc:tempBt :firstKeyBtArr];
                            }
                            encByte = tempBt;
                        }
                    }
                }
                encData = [encData stringByAppendingString:[self bt64ToHex:encByte]];
            }                
        }
    }
    return encData;
}

-(NSString*) bt64ToHex:(NSArray*)byteData{
    NSString *hex = @"";
    for(int i = 0;i < 16; i ++){
        NSString *bt = @"";
        for(int j = 0; j < 4; j ++){
            
            NSNumber * number = [byteData objectAtIndex:i *4 + j];
            
            NSString * byteDataString = [number stringValue];
            bt = [bt stringByAppendingString:byteDataString];
//            bt += byteData[i*4+j];
        }
        NSString * bt4 = [self bt4ToHex:bt];
        
        hex = [hex stringByAppendingString:bt4];
//        hex+=bt4ToHex(bt);
    }
    return hex;
}

-(NSString*) bt4ToHex:(NSString*)binary {
    if ([binary isEqualToString:@"0000"]) {
        return @"0";
    }
    
    if ([binary isEqualToString:@"0001"]) {
        return @"1";
    }
    if ([binary isEqualToString:@"0010"]) {
        return @"2";
    }
    if ([binary isEqualToString:@"0011"]) {
        return @"3";
    }
    if ([binary isEqualToString:@"0100"]) {
        return @"4";
    }
    if ([binary isEqualToString:@"0101"]) {
        return @"5";
    }
    if ([binary isEqualToString:@"0110"]) {
        return @"6";
    }
    if ([binary isEqualToString:@"0111"]) {
        return @"7";
    }
    if ([binary isEqualToString:@"1000"]) {
        return @"8";
    }
    if ([binary isEqualToString:@"1001"]) {
        return @"9";
    }
    if ([binary isEqualToString:@"1010"]) {
        return @"A";
    }
    if ([binary isEqualToString:@"1011"]) {
        return @"B";
    }
    if ([binary isEqualToString:@"1100"]) {
        return @"C";
    }
    if ([binary isEqualToString:@"1101"]) {
        return @"D";
    }
    if ([binary isEqualToString:@"1110"]) {
        return @"E";
    }
    if ([binary isEqualToString:@"1111"]) {
        return @"F";
    }

    return @"";
}


-(NSMutableArray*) getKeyBytes:(NSString*)key{
    NSMutableArray * keyBytes = [NSMutableArray array];
    int leng = (int)key.length;
    int iterator = leng / 4;
    int remainder = leng % 4;
    int i = 0;
    for (i = 0; i < iterator; i ++) {
        [keyBytes setObject:[self strToBt:[key substringWithRange:NSMakeRange(i * 4 + 0, 4)]] atIndexedSubscript:i];
    }
    
    if (remainder > 0) {
        [keyBytes setObject:[self strToBt:[key substringWithRange:NSMakeRange(i * 4 + 0, remainder)]] atIndexedSubscript:i];
    }
    
    return keyBytes;
}

-(NSArray*) strToBt:(NSString*)str{
    int leng = (int)str.length;
    NSMutableArray* bt = [NSMutableArray arrayWithCapacity:64];
    
    if(leng < 4){
        int i=0,j=0,p=0,q=0;
        for(i = 0;i<leng;i++){

            int k = [str characterAtIndex:i];
            
            for(j=0;j<16;j++){
                int pow=1,m=0;
                for(m=15;m>j;m--){
                    pow *= 2;
                }
                [bt setObject:[NSNumber numberWithInt:(k/pow)%2] atIndexedSubscript:16*i+j];
            }
        }
        for(p = leng;p<4;p++){
            int k = 0;
            for(q=0;q<16;q++){
                int pow=1,m=0;
                for(m=15;m>q;m--){
                    pow *= 2;
                }
                
                [bt setObject:[NSNumber numberWithInt:(k/pow)%2] atIndexedSubscript:16*p+q];
            }
        }
    }else{
        for(int i = 0;i<4;i++){
            int k = [str characterAtIndex:i];
            for(int j=0;j<16;j++){
                int pow=1;
                for(int m = 15; m > j; m--){
                    pow *= 2;
                }
                [bt setObject:[NSNumber numberWithInt:(k/pow)%2] atIndexedSubscript:16*i+j];
            }
        }  
    }
    return bt;
}


-(NSArray*)mInitPermute:(NSArray*)originalData{
   
    int ipByte[64] = {0};
    
    for (int i = 0, m = 1, n = 0; i < 4; i++, m += 2, n += 2) {
        for (int j = 7, k = 0; j >= 0; j--, k++) {
            ipByte[i * 8 + k] = [[originalData objectAtIndex:(j * 8 + m)] intValue];
            ipByte[i * 8 + k + 32] = [[originalData objectAtIndex:(j * 8 + n)] intValue];
        }
    }
    
    NSMutableArray * result = [NSMutableArray arrayWithCapacity:64];
    for (int i = 0; i < 64; i ++) {
        NSNumber * number = [NSNumber numberWithInt:ipByte[i]];
        [result addObject:number];
        
    }
    return [result copy];
}


//------------------------------------------

-(NSArray *) enc:(NSArray*)dataByte :(NSArray*)keyByte{

    NSArray *keys = [self generateKeys:keyByte];
    
    NSArray *ipByte   =  [self mInitPermute:dataByte];
    
    int ipLeft[32]   = {0};
    
    int ipRight[32]  = {0};
    
    int tempLeft[32] = {0};
    
    int i = 0,j = 0,k = 0,m = 0, n = 0;
    
    for(k = 0;k < 32;k ++){
        ipLeft[k] = [[ipByte objectAtIndex:k] intValue];//ipByte[k];
        ipRight[k] = [[ipByte objectAtIndex:(32 + k)] intValue];//ipByte[32+k];
    }
    
    
    
    NSMutableArray *ipRightArr = [NSMutableArray arrayWithCapacity:32];
    for (int i = 0; i < 32; i ++) {
        NSNumber * number = [NSNumber numberWithInt:ipRight[i]];
        [ipRightArr addObject:number];
        
    }
    
    
    for(i = 0;i < 16;i ++){
        for(j = 0;j < 32;j ++){
            tempLeft[j] = ipLeft[j];
            ipLeft[j] = ipRight[j];
        }
        
        int key[48] = {0};
        for(m = 0;m < 48;m ++){
            key[m] = [[[keys objectAtIndex:i] objectAtIndex:m] intValue];//keys[i][m];
        }
        
        NSMutableArray *keyArr = [NSMutableArray arrayWithCapacity:48];
        for (int i = 0; i < 48; i ++) {
            NSNumber * number = [NSNumber numberWithInt:key[i]];
            [keyArr addObject:number];
        }
        
        
        NSArray * expandPermute = [self expandPermute:ipRightArr];
        NSArray * xor1 = [self xor:expandPermute :keyArr];
        NSArray * sBoxPermute = [self sBoxPermute:xor1];
        NSArray * pPermute = [self pPermute:sBoxPermute];
        
        
        NSMutableArray *tempLeftArr = [NSMutableArray arrayWithCapacity:32];
        for (int i = 0; i < 32; i ++) {
            NSNumber * number = [NSNumber numberWithInt:tempLeft[i]];
            [tempLeftArr addObject:number];
            
        }
        
        NSArray * tempRight = [self xor:pPermute :tempLeftArr];
        for(n = 0;n < 32;n ++){
            ipRight[n] = [self readNSArray:tempRight index:n];//tempRight[n];
        }
    }
    
    
    NSMutableArray *finalData = [NSMutableArray arrayWithCapacity:64];
    for(int i = 0;i < 32;i ++){
//        [finalData setObject:[NSNumber numberWithInt:ipRight[i]] atIndexedSubscript:i];
        [finalData addObject:[NSNumber numberWithInt:ipRight[i]]];
    }
    
    for(int i = 0;i < 32;i ++){
//        [finalData setObject:[NSNumber numberWithInt:ipLeft[i]] atIndexedSubscript:(32+i)];
        [finalData addObject:[NSNumber numberWithInt:ipLeft[i]]];
    }
    
    return [self finallyPermute:finalData];//finallyPermute(finalData);
}

-(NSArray*) expandPermute:(NSArray*) rightData{
    int epByte[48] = {0};
    for (int i = 0; i < 8; i++) {
        if (i == 0) {
            epByte[i * 6 + 0] = [self readNSArray:rightData index:31];
        } else {
            epByte[i * 6 + 0] = [self readNSArray:rightData index:(i * 4 - 1)];//rightData[i * 4 - 1];
        }
        epByte[i * 6 + 1] = [self readNSArray:rightData index:(i * 4 + 0)];//rightData[i * 4 + 0];
        epByte[i * 6 + 2] = [self readNSArray:rightData index:(i * 4 + 1)];//rightData[i * 4 + 1];
        epByte[i * 6 + 3] = [self readNSArray:rightData index:(i * 4 + 2)];//rightData[i * 4 + 2];
        epByte[i * 6 + 4] = [self readNSArray:rightData index:(i * 4 + 3)];//rightData[i * 4 + 3];
        if (i == 7) {
            epByte[i * 6 + 5] = [self readNSArray:rightData index:(0)];//rightData[0];
        } else {
            epByte[i * 6 + 5] = [self readNSArray:rightData index:(i * 4 + 4)];//rightData[i * 4 + 4];
        }
    }
    
    NSMutableArray * result = [NSMutableArray arrayWithCapacity:48];
    for (int i = 0; i < 48; i ++) {
        NSNumber * number = [NSNumber numberWithInt:epByte[i]];
        [result addObject:number];
        
    }
    return [result copy];
}

-(int) readNSArray:(NSArray*) data index:(int)index{
    return [[data objectAtIndex:index] intValue];
}

-(NSArray<NSNumber*>*) xor:(NSArray*)byteOne :(NSArray*)byteTwo{
    
    NSMutableArray *xorByte = [NSMutableArray arrayWithCapacity:byteOne.count];
    
    for(int i = 0;i < byteOne.count; i ++){
        int a = [[byteOne objectAtIndex:i] intValue];
        int b = [[byteTwo objectAtIndex:i] intValue];
        int c = a ^ b;
        [xorByte addObject:[NSNumber numberWithInt:c]];
    }
    return xorByte;
}


-(NSArray*) sBoxPermute:(NSArray<NSNumber*>*)expandByte{
    
    int sBoxByte[32] = {0};
    NSString *binary = @"";
    
    

    
    int s1[4][16] = {
        {14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7},
        {0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8},
        {4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0},
        {15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13 }};
    /* Table - s2 */
    int s2[4][16] = {
        {15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10},
        {3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5},
        {0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15},
        {13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9 }};
    /* Table - s3 */
    int s3[4][16]= {
        {10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8},
        {13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1},
        {13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7},
        {1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12 }};
    /* Table - s4 */
    int s4[4][16] = {
        {7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15},
        {13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9},
        {10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4},
        {3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14 }};
    /* Table - s5 */
    int s5[4][16] = {
        {2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9},
        {14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6},
        {4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14},
        {11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3 }};
    /* Table - s6 */
    int s6[4][16] = {
        {12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11},
        {10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8},
        {9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6},
        {4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13 }};
    /* Table - s7 */
    int s7[4][16] = {
        {4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1},
        {13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6},
        {1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2},
        {6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12}};
    /* Table - s8 */
    int s8[4][16] = {
        {13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7},
        {1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2},
        {7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8},
        {2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11}};
    
    for(int m=0;m<8;m++){
        int i=0,j=0;
        i = [expandByte[m*6+0] intValue] *2 + [expandByte[m*6+5] intValue];
        j = [expandByte[m * 6 + 1] intValue] * 2 * 2 * 2
        + [expandByte[m * 6 + 2] intValue] * 2* 2
        + [expandByte[m * 6 + 3] intValue] * 2
        + [expandByte[m * 6 + 4] intValue];
        switch (m) {
            case 0 :
                binary = [self getBoxBinary:(s1[i][j])];
                break;
            case 1 :
                binary = [self getBoxBinary:(s2[i][j])];
                break;
            case 2 :
                binary = [self getBoxBinary:(s3[i][j])];
                break;
            case 3 :
                binary = [self getBoxBinary:(s4[i][j])];
                break;
            case 4 :
                binary = [self getBoxBinary:(s5[i][j])];
                break;
            case 5 :
                binary = [self getBoxBinary:(s6[i][j])];
                break;
            case 6 :
                binary = [self getBoxBinary:(s7[i][j])];
                break;
            case 7 :
                binary = [self getBoxBinary:(s8[i][j])];
                break;
        }
        
        sBoxByte[m*4+0] = [[binary substringWithRange:NSMakeRange(0, 1)] intValue];
        sBoxByte[m*4+1] = [[binary substringWithRange:NSMakeRange(1, 1)] intValue];
        sBoxByte[m*4+2] = [[binary substringWithRange:NSMakeRange(2, 1)] intValue];
        sBoxByte[m*4+3] = [[binary substringWithRange:NSMakeRange(3, 1)] intValue];
    }
    
    NSMutableArray * result = [NSMutableArray arrayWithCapacity:32];
    for (int i = 0; i < 32; i ++) {
        NSNumber * number = [NSNumber numberWithInt:sBoxByte[i]];
        [result addObject:number];
                             
    }
    return result;
}





-(NSArray*) finallyPermute:(NSArray *)endByte{
    NSMutableArray *fpByte = [NSMutableArray arrayWithCapacity:64 ];
    
    fpByte[ 0] = endByte[39];
    fpByte[ 1] = endByte[ 7];
    fpByte[ 2] = endByte[47];
    fpByte[ 3] = endByte[15];
    fpByte[ 4] = endByte[55];
    fpByte[ 5] = endByte[23];
    fpByte[ 6] = endByte[63];
    fpByte[ 7] = endByte[31];
    fpByte[ 8] = endByte[38];
    fpByte[ 9] = endByte[ 6];
    fpByte[10] = endByte[46];
    fpByte[11] = endByte[14];
    fpByte[12] = endByte[54];
    fpByte[13] = endByte[22];
    fpByte[14] = endByte[62];
    fpByte[15] = endByte[30];
    fpByte[16] = endByte[37];
    fpByte[17] = endByte[ 5];
    fpByte[18] = endByte[45];
    fpByte[19] = endByte[13];
    fpByte[20] = endByte[53];
    fpByte[21] = endByte[21];
    fpByte[22] = endByte[61];
    fpByte[23] = endByte[29];
    fpByte[24] = endByte[36];
    fpByte[25] = endByte[ 4];
    fpByte[26] = endByte[44];
    fpByte[27] = endByte[12];
    fpByte[28] = endByte[52];
    fpByte[29] = endByte[20];
    fpByte[30] = endByte[60];
    fpByte[31] = endByte[28];
    fpByte[32] = endByte[35];
    fpByte[33] = endByte[ 3];
    fpByte[34] = endByte[43];
    fpByte[35] = endByte[11];
    fpByte[36] = endByte[51];
    fpByte[37] = endByte[19];
    fpByte[38] = endByte[59];
    fpByte[39] = endByte[27];
    fpByte[40] = endByte[34];
    fpByte[41] = endByte[ 2];
    fpByte[42] = endByte[42];
    fpByte[43] = endByte[10];
    fpByte[44] = endByte[50];
    fpByte[45] = endByte[18];
    fpByte[46] = endByte[58];
    fpByte[47] = endByte[26];
    fpByte[48] = endByte[33];
    fpByte[49] = endByte[ 1];
    fpByte[50] = endByte[41];
    fpByte[51] = endByte[ 9];
    fpByte[52] = endByte[49];
    fpByte[53] = endByte[17];
    fpByte[54] = endByte[57];
    fpByte[55] = endByte[25];
    fpByte[56] = endByte[32];
    fpByte[57] = endByte[ 0];
    fpByte[58] = endByte[40];
    fpByte[59] = endByte[ 8]; 
    fpByte[60] = endByte[48]; 
    fpByte[61] = endByte[16]; 
    fpByte[62] = endByte[56]; 
    fpByte[63] = endByte[24];
    return fpByte;
}

-(NSArray*) pPermute:(NSArray*)sBoxByte{
    NSMutableArray* pBoxPermute = [NSMutableArray arrayWithCapacity:32];
    pBoxPermute[ 0] = sBoxByte[15];
    pBoxPermute[ 1] = sBoxByte[ 6];
    pBoxPermute[ 2] = sBoxByte[19];
    pBoxPermute[ 3] = sBoxByte[20];
    pBoxPermute[ 4] = sBoxByte[28];
    pBoxPermute[ 5] = sBoxByte[11];
    pBoxPermute[ 6] = sBoxByte[27];
    pBoxPermute[ 7] = sBoxByte[16];
    pBoxPermute[ 8] = sBoxByte[ 0];
    pBoxPermute[ 9] = sBoxByte[14];
    pBoxPermute[10] = sBoxByte[22];
    pBoxPermute[11] = sBoxByte[25];
    pBoxPermute[12] = sBoxByte[ 4];
    pBoxPermute[13] = sBoxByte[17];
    pBoxPermute[14] = sBoxByte[30];
    pBoxPermute[15] = sBoxByte[ 9];
    pBoxPermute[16] = sBoxByte[ 1];
    pBoxPermute[17] = sBoxByte[ 7];
    pBoxPermute[18] = sBoxByte[23];
    pBoxPermute[19] = sBoxByte[13];
    pBoxPermute[20] = sBoxByte[31];
    pBoxPermute[21] = sBoxByte[26];
    pBoxPermute[22] = sBoxByte[ 2];
    pBoxPermute[23] = sBoxByte[ 8];
    pBoxPermute[24] = sBoxByte[18];
    pBoxPermute[25] = sBoxByte[12];
    pBoxPermute[26] = sBoxByte[29];
    pBoxPermute[27] = sBoxByte[ 5];
    pBoxPermute[28] = sBoxByte[21];
    pBoxPermute[29] = sBoxByte[10];
    pBoxPermute[30] = sBoxByte[ 3]; 
    pBoxPermute[31] = sBoxByte[24];    
    return pBoxPermute;
}

-(NSString*) getBoxBinary:(int)i {
    NSString *binary = @"";
    switch (i) {
        case  0 :binary = @"0000";break;
        case  1 :binary = @"0001";break;
        case  2 :binary = @"0010";break;
        case  3 :binary = @"0011";break;
        case  4 :binary = @"0100";break;
        case  5 :binary = @"0101";break;
        case  6 :binary = @"0110";break;
        case  7 :binary = @"0111";break;
        case  8 :binary = @"1000";break;
        case  9 :binary = @"1001";break;
        case 10 :binary = @"1010";break;
        case 11 :binary = @"1011";break;
        case 12 :binary = @"1100";break;
        case 13 :binary = @"1101";break;
        case 14 :binary = @"1110";break;
        case 15 :binary = @"1111";break;
    }
    return binary;
}

-(NSArray*) generateKeys:(NSArray*)keyByte{
    NSMutableArray<NSNumber*> *key   = [NSMutableArray arrayWithCapacity:56];
    NSMutableArray * keys = [NSMutableArray array];
    
    keys[ 0] = [NSMutableArray array];
    keys[ 1] = [NSMutableArray array];
    keys[ 2] = [NSMutableArray array];
    keys[ 3] = [NSMutableArray array];
    keys[ 4] = [NSMutableArray array];
    keys[ 5] = [NSMutableArray array];
    keys[ 6] = [NSMutableArray array];
    keys[ 7] = [NSMutableArray array];
    keys[ 8] = [NSMutableArray array];
    keys[ 9] = [NSMutableArray array];
    keys[10] = [NSMutableArray array];
    keys[11] = [NSMutableArray array];
    keys[12] = [NSMutableArray array];
    keys[13] = [NSMutableArray array];
    keys[14] = [NSMutableArray array];
    keys[15] = [NSMutableArray array];
    NSArray *loop = @[[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],
                      [NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1]];
    
    for(int i=0;i<7;i++){
        for(int j=0,k=7;j<8;j++,k--){
            key[i*8+j]=keyByte[8*k+i];
        }
    }
    
    int i = 0;
    for(i = 0;i < 16;i ++){
        int tempLeft=0;
        int tempRight=0;
        for(int j = 0; j < [loop[i] intValue]; j ++){
            tempLeft = [key[0] intValue];
            tempRight = [key[28] intValue];
            for(int k = 0;k < 27 ;k ++){
                key[k] = key[k+1];
                key[28+k] = key[29+k];
            }
            key[27] = [NSNumber numberWithInt:tempLeft];
            key[55] = [NSNumber numberWithInt:tempRight];
        }
        NSMutableArray* tempKey = [NSMutableArray arrayWithCapacity:48];//new Array(48);
        tempKey[ 0] = key[13];
        tempKey[ 1] = key[16];
        tempKey[ 2] = key[10];
        tempKey[ 3] = key[23];
        tempKey[ 4] = key[ 0];
        tempKey[ 5] = key[ 4];
        tempKey[ 6] = key[ 2];
        tempKey[ 7] = key[27];
        tempKey[ 8] = key[14];
        tempKey[ 9] = key[ 5];
        tempKey[10] = key[20];
        tempKey[11] = key[ 9];
        tempKey[12] = key[22];
        tempKey[13] = key[18];
        tempKey[14] = key[11];
        tempKey[15] = key[ 3];
        tempKey[16] = key[25];
        tempKey[17] = key[ 7];
        tempKey[18] = key[15];
        tempKey[19] = key[ 6];
        tempKey[20] = key[26];
        tempKey[21] = key[19];
        tempKey[22] = key[12];
        tempKey[23] = key[ 1];
        tempKey[24] = key[40];
        tempKey[25] = key[51];
        tempKey[26] = key[30];
        tempKey[27] = key[36];
        tempKey[28] = key[46];
        tempKey[29] = key[54];
        tempKey[30] = key[29];
        tempKey[31] = key[39];
        tempKey[32] = key[50];
        tempKey[33] = key[44];
        tempKey[34] = key[32];
        tempKey[35] = key[47];
        tempKey[36] = key[43];
        tempKey[37] = key[48];
        tempKey[38] = key[38];
        tempKey[39] = key[55];
        tempKey[40] = key[33];
        tempKey[41] = key[52];
        tempKey[42] = key[45];
        tempKey[43] = key[41];
        tempKey[44] = key[49];
        tempKey[45] = key[35];
        tempKey[46] = key[28];
        tempKey[47] = key[31];
        switch(i){
            case 0: for(int m=0;m < 48 ;m++){ keys[ 0][m] = tempKey[m]; } break;
            case 1: for(int m=0;m < 48 ;m++){ keys[ 1][m] = tempKey[m]; } break;
            case 2: for(int m=0;m < 48 ;m++){ keys[ 2][m] = tempKey[m]; } break;
            case 3: for(int m=0;m < 48 ;m++){ keys[ 3][m] = tempKey[m]; } break;
            case 4: for(int m=0;m < 48 ;m++){ keys[ 4][m] = tempKey[m]; } break;
            case 5: for(int m=0;m < 48 ;m++){ keys[ 5][m] = tempKey[m]; } break;
            case 6: for(int m=0;m < 48 ;m++){ keys[ 6][m] = tempKey[m]; } break;
            case 7: for(int m=0;m < 48 ;m++){ keys[ 7][m] = tempKey[m]; } break;
            case 8: for(int m=0;m < 48 ;m++){ keys[ 8][m] = tempKey[m]; } break;
            case 9: for(int m=0;m < 48 ;m++){ keys[ 9][m] = tempKey[m]; } break;
                
            case 10: for(int m=0;m < 48 ;m++){ keys[10][m] = tempKey[m]; } break;
            case 11: for(int m=0;m < 48 ;m++){ keys[11][m] = tempKey[m]; } break;
            case 12: for(int m=0;m < 48 ;m++){ keys[12][m] = tempKey[m]; } break;
            case 13: for(int m=0;m < 48 ;m++){ keys[13][m] = tempKey[m]; } break;
            case 14: for(int m=0;m < 48 ;m++){ keys[14][m] = tempKey[m]; } break;
            case 15: for(int m=0;m < 48 ;m++){ keys[15][m] = tempKey[m]; } break;
        }
    }
    return keys;  
}








@end

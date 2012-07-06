//
//  Contato.m
//  ContatosIP67
//
//  Created by ios2749 on 27/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Contato.h"

@implementation Contato

@synthesize nome, telefone, email, endereco, site, foto, latidude, longitude;


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.nome forKey:@"nome"];
    [aCoder encodeObject:self.telefone forKey:@"telefone"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.endereco forKey:@"endereco"];
    [aCoder encodeObject:self.site forKey:@"site"];
    [aCoder encodeObject:self.foto forKey:@"foto"];
    [aCoder encodeObject:self.latidude forKey:@"latidude"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
}

- (id) initWithCoder:(NSCoder *) aDecoder
{
    if( self = [super init])
    {
        self.nome = [aDecoder decodeObjectForKey:@"nome"];
        self.telefone = [aDecoder decodeObjectForKey:@"telefone"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.endereco = [aDecoder decodeObjectForKey:@"endereco"];
        self.site = [aDecoder decodeObjectForKey:@"site"];
        self.foto = [aDecoder decodeObjectForKey:@"foto"];
        self.latidude = [aDecoder decodeObjectForKey:@"latidude"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
    }
    return self;
}

@end

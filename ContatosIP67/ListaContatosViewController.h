//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by ios2749 on 27/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListaContatosProtocol.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface ListaContatosViewController : 
    UITableViewController<ListaContatosProtocol, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
{
    Contato* contatoSelecionado;
}

@property(weak) NSMutableArray *contatos;
@property NSInteger linhaDestaque;

- (void) exibeMaisAcoes:(UIGestureRecognizer *) gesture;

@end

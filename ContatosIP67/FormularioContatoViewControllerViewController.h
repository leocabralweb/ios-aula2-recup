//
//  FormularioContatoViewControllerViewController.h
//  ContatosIP67
//
//  Created by ios2749 on 27/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "ListaContatosProtocol.h"

@interface FormularioContatoViewControllerViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property IBOutlet UITextField *nome;
@property IBOutlet UITextField *telefone;
@property IBOutlet UITextField *email;
@property IBOutlet UITextField *endereco;
@property IBOutlet UITextField *site;
@property IBOutlet UIButton *botaoFoto;
@property id<ListaContatosProtocol> delegate;

@property (strong) Contato *contato;

- (id) initWithContato:(Contato *)_contato;
-(IBAction)trocaFoto:(id)sender;

@end

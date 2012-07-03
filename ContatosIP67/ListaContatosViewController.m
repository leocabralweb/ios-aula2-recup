//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios2749 on 27/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewControllerViewController.h"
#import "Contato.h"


@implementation ListaContatosViewController

@synthesize contatos, linhaDestaque;

- (id) init
{
    if(self = [super init]){
        self.navigationItem.title = @"Contato";
        self.navigationItem.rightBarButtonItem = 
        [[UIBarButtonItem alloc] 
         initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
         target:self 
         action:@selector(exibeFormulario) ];
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }
    
    return self;
}

- (void) exibeFormulario
{
    FormularioContatoViewControllerViewController *form = 
    [[ FormularioContatoViewControllerViewController alloc ] init];
     //initWithNibName:@"FormularioContatoViewControllerViewController" 
     //bundle:[NSBundle mainBundle]];
    
    //[self.navigationController presentModalViewController:form animated: YES];
    
    //ßform.contatos = self.cßontatos;
    form.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc]
     initWithRootViewController:form];
    
    [self.navigationController presentModalViewController:nav animated:YES];
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contatos count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identificador = @"Identificador";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: Identificador];
    
    Contato *contato = [self.contatos objectAtIndex: indexPath.row];
    
    if(!cell){
        cell = [[ UITableViewCell alloc]
        initWithStyle:UITableViewCellStyleDefault 
        reuseIdentifier: Identificador];
    }
    
    cell.textLabel.text = contato.nome;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contato *contato = [self.contatos objectAtIndex:indexPath.row];
    
    FormularioContatoViewControllerViewController *form = [[ FormularioContatoViewControllerViewController
                                                            alloc] initWithContato: contato];
    
    form.delegate = self;
   //form.contatos = self.contatos;
    //UINavigationController *navigation = [[UINavigationController alloc]
     //                                     initWithRootViewController:form];
    
    //[self.navigationController presentModalViewController:navigation animated:YES];
    [self.navigationController pushViewController:form animated:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated
{
    if (linhaDestaque > 0)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:linhaDestaque inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
        
        linhaDestaque = -1;
    }
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.contatos removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void) contatoAdicionado:(Contato *)contato
{
    
    [self.contatos addObject:contato];
    linhaDestaque = [self.contatos indexOfObject:contato];
    [self.tableView reloadData];
    NSLog(@"atualizado: %d", [self.contatos indexOfObject:contato]);
}

- (void) contatoAtualizado:(Contato *)contato
{
    NSLog(@"adicionado: %d", [self.contatos indexOfObject:contato]);
    linhaDestaque = [self.contatos indexOfObject:contato];
}

- (void) viewDidLoad
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(exibeMaisAcoes:)];
    
    [self.tableView addGestureRecognizer:longPress];
}

- (void) exibeMaisAcoes:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint ponto = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:ponto];
        
        Contato *contato = [contatos objectAtIndex:index.row];
        contatoSelecionado = contato;
        
        UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:contato.nome 
                                                            delegate:self 
                                                   cancelButtonTitle:@"Cancelar" 
                                              destructiveButtonTitle:nil 
                                                   otherButtonTitles:@"Ligar", @"Enviar Email", @"Visualizar Site", @"Mostrar Mapa", nil];
        [opcoes showInView:self.view];
    }
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;    
        case 2:
            [self abrirSite];
            break;    
        case 3:
            [self mostrarMapa];
            break;    
        default:
            break;
    }
}

-(void)ligar 
{
    UIDevice *device = [UIDevice currentDevice];
    
    // if(device.userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    if([device.model isEqualToString:@"iPhone"])
    {
        NSString *urlTelefone = [NSString stringWithFormat:@"tel:%@", contatoSelecionado.telefone];
        NSURL *url = [NSURL URLWithString:urlTelefone];
        [[UIApplication sharedApplication] openURL:url];
    }else {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Sem celular" 
                                                         message:@"Impossível fazer ligações" 
                                                        delegate:nil 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil];
        [alerta show];
    }
}

-(void)enviarEmail 
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
        composer.mailComposeDelegate = self;
        [composer setToRecipients:[NSArray arrayWithObject:contatoSelecionado.email]];
        [composer setSubject:@"Caelum"];
        
        [self presentModalViewController:composer animated:YES];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller 
         didFinishWithResult:(MFMailComposeResult)result 
                       error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)abrirSite 
{
    NSLog(@"abrirSite");
}

-(void)mostrarMapa 
{
    NSLog(@"mostrarMapa");
}


@end

//
//  FormularioContatoViewControllerViewController.m
//  ContatosIP67
//
//  Created by ios2749 on 27/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormularioContatoViewControllerViewController.h"
#import "Contato.h"

@interface FormularioContatoViewControllerViewController ()

@end

@implementation FormularioContatoViewControllerViewController

@synthesize nome, email, telefone, endereco, site, botaoFoto;
@synthesize delegate, contato, campoAtual;

- (id) init {
    
    if (self = [super init]){
        
        self.navigationItem.title = @"Cadastro";
        
        self.navigationItem.leftBarButtonItem = 
        [[UIBarButtonItem alloc]
         initWithTitle:@"Cancelar" 
         style: UIBarButtonItemStylePlain 
         target:self 
         action:@selector(cancela)];
        
        UIBarButtonItem *adiciona = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Adiciona" 
                                     style:UIBarButtonItemStylePlain 
                                     target:self 
                                     action:@selector(criaContato)];
        self.navigationItem.rightBarButtonItem = adiciona;
        
        //self.contatos = [[ NSMutableArray alloc] init];
    }
    return self;
}

- (void) cancela
{
    [self dismissModalViewControllerAnimated:YES];
}

- (Contato *)pegaDadosFormulario{
    /* Usando dicionário imutável
     NSDictionary *contato = [NSDictionary dictionaryWithObjectsAndKeys:
                             [nome text], @"nome", 
                             [telefone text], @"telefone",
                             [email text], @"email"
                             [endereco text], @"endereco",
                             [site text], @"site", nil];*/
    
    if(!self.contato){
        self.contato = [[Contato alloc] init];
    }
    
    self.contato.nome = nome.text;
    self.contato.telefone = telefone.text;
    self.contato.email = email.text;
    self.contato.endereco = endereco.text;
    self.contato.site = site.text;
    
    if(botaoFoto.imageView.image)
        self.contato.foto = botaoFoto.imageView.image;
    
    return self.contato;
    
   /* NSLog(@"Contato com nome: %@", contato.nome);
    
    [self.contatos addObject:contato];
    NSLog(@"dados: %@", self.contatos);*/
    
    /* Usando dicionário imutável
    NSMutableDictionary *dadosDoContato = [[NSMutableDictionary alloc] init];
    [dadosDoContato setObject:[nome text] forKey:@"nome"];
    [dadosDoContato setObject:[telefone text] forKey:@"telefone"];
    [dadosDoContato setObject:[email text] forKey:@"email"];
    [dadosDoContato setObject:[endereco text] forKey:@"endereco"];
    [dadosDoContato setObject:[site text] forKey:@"site"];
    
    NSLog(@"dados: %@", dadosDoContato);*/
}

- (void) criaContato
{
    Contato *novoContato = [self pegaDadosFormulario];
    //[self.contatos addObject:novoContato];
    [self dismissModalViewControllerAnimated:YES];
    if (self.delegate) {
        [self.delegate contatoAdicionado:novoContato];
    }
    
    /*self.contato = [self pegaDadosFormulario];
    [self.contatos addObject:contato];
    NSLog(@"contatos cadastrados: %d", [self.contatos count]);
    [self dismissModalViewControllerAnimated:YES];*/
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithContato:(Contato *)_contato
{
    if (self = [self init]) {
        self.contato = _contato;
        
        self.navigationItem.leftBarButtonItem = nil;
        UIBarButtonItem *adiciona = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Altera" 
                                     style:UIBarButtonItemStylePlain 
                                     target:self 
                                     action:@selector(alteraContato)];
        self.navigationItem.rightBarButtonItem = adiciona;
    }
    return self;
}

- (void) alteraContato
{
    Contato *contatoAtualizado = [self pegaDadosFormulario];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.delegate) {
        [self.delegate contatoAtualizado:contatoAtualizado];
    }
    
    /*self.contato = [self pegaDadosFormulario];
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];*/
    
}

-(IBAction)trocaFoto:(id)sender
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:@"Escolha a forma" 
                                                            delegate:self 
                                                   cancelButtonTitle:@"Cancelar" 
                                              destructiveButtonTitle:nil 
                                                   otherButtonTitles:@"Camera", @"Galeria", nil];
        [opcoes showInView:self.view]; 
    }else {
        [self openImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{    
    switch (buttonIndex) {
        case 0:
            [self openImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1:
            [self openImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            break;   
        default:
            break;
    }
}

-(void) openImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *images = [[UIImagePickerController alloc] init];
    images.allowsEditing = YES;
    images.delegate = self;
    images.sourceType = sourceType;
        
    [self presentModalViewController:images animated:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imagem = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.botaoFoto setImage:imagem forState:UIControlStateNormal];
    [self dismissModalViewControllerAnimated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == nome)
        [telefone becomeFirstResponder];
    
    else if(textField == telefone)
        [email becomeFirstResponder];
    
    else if(textField == email)
        [endereco becomeFirstResponder];
    
    else if(textField == endereco)
        [site becomeFirstResponder];
    
    else if(textField == site)
    {
        [textField resignFirstResponder];
        [self criaContato];
    }
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.campoAtual = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.campoAtual = nil;
}

-(void)escondeTeclado:(UIGestureRecognizer *)gesture
{
    /*UISwipeGestureRecognizer *swipe = (UISwipeGestureRecognizer *) gesture;
    
    if(swipe.direction == UISwipeGestureRecognizerDirectionDown && self.campoAtual)
        [self.campoAtual resignFirstResponder];*/
    
    if(self.campoAtual)
    {
        NSLog(@"escondeTeclado");
        [self.campoAtual resignFirstResponder];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.contato){
        nome.text = self.contato.nome;
        telefone.text = self.contato.telefone;
        email.text = self.contato.email;
        endereco.text = self.contato.endereco;
        site.text = self.contato.site;

        if(self.contato.foto)
            [botaoFoto setImage:self.contato.foto forState:UIControlStateNormal];
    }
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] 
                                         initWithTarget:self 
                                         action:@selector(escondeTeclado:)];
    
    /*UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] 
                                         initWithTarget:self 
                                         action:@selector(escondeTeclado:)];*/
    
    [self.view addGestureRecognizer:gesture];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.contato = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

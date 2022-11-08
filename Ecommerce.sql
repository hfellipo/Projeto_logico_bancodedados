-- criação do banco de dados para o cenário de E-commerce
-- drop database ecommerce;
CREATE DATABASE ecommerce;
use ecommerce;


-- criar tabela cliente

create table clients(
	idClient int auto_increment primary key,
    Fname varchar(15),
    Minit char(3),
    Lname varchar(15),
    CPF char(11) not null,
    Address varchar(255),
    constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment=1;

-- criar tabela produto
CREATE table product(
	idProduct int auto_increment primary key,
    Pname varchar(15),
	classification_kids bool default false,
    category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Moveis') not null,
    avaliação float default 0,
    size varchar(10)
);
-- tabela pagamento -- para ser continuado no desafito, terminar de implementar e conexao com tabelas necessarios.
CREATE table payment(
	IdClient int,
    idPayment int,
    typePayment enum('Boleto','Cartão', 'dois Catões'),
    limitAvailable int,
    Primary key(idClient, idPayment)
);


-- criar tabela pedido
-- criar contraint relacionada ppagamento permitir null
CREATE table orders(
	idOrder int auto_increment primary key,
    IdOrderClient int,
    orderStatus enum('Cancelado','confirmado','em processamento') default 'Em processamento',
    orderDescription varchar (255),
    sendValue float default 0,
    idPaymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references Clients(idClient)
		on update cascade
);


-- criar tabela esqtoque

CREATE table productStorage(
	idProductStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- criar fornecedor
CREATE table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    constraint unique_supllier unique (CNPJ)
);



-- criar tabela vendedor
CREATE table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    abstName varchar(255),
    CNPJ char(15),
    CPF char(9),
    lication varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

CREATE table produtcSeller(
	idPseller int,
	idProduct int,
    prodQuantity int default 1,
    primary key (idPseller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
);

CREATE table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Em estoque','sem estoque') default 'Em estoque',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)    
);



CREATE table storageLocation(
	idLproduct int,
	idLstorage int,
    Location varchar(45),
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProductStorage)
);

CREATE table productSupplier(
	idPsSupplier int,
	idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_storage_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_storage_supplier_product foreign key (idPsProduct) references product(idProduct)
);


-- show tables;
INSERT INTO Clients (Fname, Minit, Lname, CPF, Address)
	values('Maria','G','Silva','123456789','Rua mariada Silva 29, Jardins - Belo Horizonte'),
		('Joao','D','Bernadinho','654321233','Rua  Silva 287, tomasta - Belo Horizonte'),
        ('Fabio','U','Silva','7645879089','Rua mariada Silva 29, Gloria - Belo Horizonte'),
        ('Mateus','F','Souza','232456787','Rua mariada Silva 29, Morumbi - Belo Horizonte'),
        ('Clarissa','G','Silva','765879009','Rua Galo Silva 29, Belvedere - Belo Horizonte'),
        ('Roberta','Y','Bordim','222222222','Rua mariada Silva 29, Jardins - Belo Horizonte'),
        ('Isabela','U','Caion','333333333','Rua Gutis 29, Gloria - Belo Horizonte'),
        ('Joaquim','G','Ferti','666666666','Rua Maria Silva 29, Jardins - Belo Horizonte');
 
 
 -- 'Eletrônico','Vestimenta','Brinquedos','Alimentos','Moveis'
 INSERT INTO product (Pname, classification_kids, category, avaliação, size) values
					('Fone de ouvido',false,'Eletrônico','4',null),
                    ('Narbarie Elsa',true,'Brinquedos','3',null),
                    ('Body Carters',false,'Vestimenta','5',null),
                    ('Microfone',false,'Eletrônico','4',null),
                    ('Sofa',false,'Moveis','3','3x57x80');
                    
-- select * from Clients;
-- select * from product;
-- delete from orders where IdOrderClient in (1,2,3,4);
-- idOrder IdOrderClient  orderStatus('Cancelado','confirmado','em processamento')  orderDescription sendValue idPaymentCash 
INSERT INTO orders (IdOrderClient, orderStatus, orderDescription, sendValue, idPaymentCash) values
					(1, default, 'Compra via aplicativo', null, 1),
                    (2, default, 'Compra via aplicativo', 50, 0),
                    (3, 'Confirmado', null, null, 1),
                    (4, default, 'Compra via web-site', 150, 0);

-- select * from orders;
-- idPOproduct   idPOorder poQuantity  poStatus
INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						(1,11,2,default),
                        (2,11,1,default),
                        (3,12,1,default);

INSERT INTO productStorage (storageLocation,quantity) values
						('Rio de Janeiro',100),
                        ('Rio de Janeiro',60),
                        ('São Paulo',10),
                        ('São Paulo',100),
                        ('São Paulo',10),
                        ('São Paulo',60);
                        
INSERT INTO storageLocation (idLproduct, idLstorage, Location) values
							(1,2,'RJ'),
                            (2,6,'GO');
-- show databases;

-- use information_schema;
-- show tables;
-- recuperar todas as constraints schema que tem no meu data base, para atualização em cascata.

-- select * from referential_constraints where constraint_schema = 'ecommerce';



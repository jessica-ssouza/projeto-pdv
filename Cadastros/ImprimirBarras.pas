unit ImprimirBarras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  Tfrm_imprimirBarras = class(TForm)
    Panel1: TPanel;
    PrintDialog1: TPrintDialog;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    private
  { Private declarations }
    procedure gerarCodigo (codigo: string; Canvas: TCanvas);

    public
  { Public declarations }
  end;

var
  frm_imprimirBarras: Tfrm_imprimirBarras;

implementation

uses
  Modulo;

{$R *.dfm}

procedure Tfrm_imprimirBarras.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    if (PrintDialog1.Execute) then
    begin
    Print;
    end;
  end;
end;

procedure Tfrm_imprimirBarras.FormShow(Sender: TObject);
begin
gerarCodigo(codigoProduto, Image1.Canvas);
gerarCodigo(codigoProduto, Image2.Canvas);
gerarCodigo(codigoProduto, Image3.Canvas);
gerarCodigo(codigoProduto, Image4.Canvas);
gerarCodigo(codigoProduto, Image5.Canvas);
gerarCodigo(codigoProduto, Image6.Canvas);
end;

procedure Tfrm_imprimirBarras.gerarCodigo(codigo: string; Canvas: TCanvas);
const
digitos : array['0'..'9'] of string[5]= ('00110', '10001', '01001', '11000',
'00101', '10100', '01100', '00011', '10010', '01010');
var s : string;
i, j, x, t : Integer;
begin
  //Gerar o valor para desenhar o c�digo de barras
  //Caracter de in�cio
  s := '0000';
  for i := 1 to length(codigo) div 2 do
  for j := 1 to 5 do
  s := s + Copy(Digitos[codigo[i * 2 - 1]], j, 1) + Copy(Digitos[codigo[i * 2]], j, 1);
  //Caracter de fim
  s := s + '100';
  //Desenhar em um objeto canvas
  //Configurar os par�metros iniciais
  x := 0;
  //Pintar o fundo do c�digo de branco
  Canvas.Brush.Color := clWhite;
  Canvas.Pen.Color := clWhite;
  Canvas.Rectangle(10, 10, 500, 50);
  //Definir as cores da caneta
  Canvas.Brush.Color := clBlack;
  Canvas.Pen.Color := clBlack;
  //Escrever o c�digo de barras no canvas
  for i := 1 to length(s) do
  begin
    //Definir a espessura da barra
    t := strToInt(s[i]) * 2 + 1;
    //Imprimir apenas barra sim barra n�o (preto/branco - intercalado);
    if i mod 2 = 1 then
    Canvas.Rectangle(x, 0, x + t, 50);
    //Passar para a pr�xima barra
    x := x + t;
  end;
end;

end.

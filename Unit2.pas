unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,ShellApi;

type
  TAcercaDe = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AcercaDe: TAcercaDe;

implementation

uses Unit1;

{$R *.dfm}

procedure TAcercaDe.FormCreate(Sender: TObject);
begin
Label1.Caption:='Wallpaper fue desarrollado para automatizar'+#13+
                '         el cambio del fondo de pantalla.   '+#13+
                '                               ';
Label2.Caption:='   Dudas, Sugerencias y solicitudes contactenos por:'+#13+
                ''+#13+
                ''+#13+
                ''+#13+
                ''+#13+
                '                         Yoandy Calvelo Vega          '+#13+
                '                      Yudier Amed García Ruíz           '+#13+
                ''+#13+
                '                            Ver: 1.0     2014 ';
Image1.Picture.Icon:=Application.Icon;
end;

procedure TAcercaDe.Button1Click(Sender: TObject);
begin
Form1.Enabled:=True;
Close;
end;

procedure TAcercaDe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.Enabled:=True;
end;

procedure TAcercaDe.Label3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
TLabel(Sender).Font.Color:=ClRed;
end;

procedure TAcercaDe.Label3MouseLeave(Sender: TObject);
begin
TLabel(Sender).Font.Color:=ClBlue;
end;

procedure TAcercaDe.Label3Click(Sender: TObject);
begin
ShellExecute(GetDesktopWindow(),nil,
                pChar('mailto:'+
                TLabel(Sender).Caption),
                nil,nil,SW_SHOWNORMAL);

end;

procedure TAcercaDe.Label4Click(Sender: TObject);
begin
ShellExecute(GetDesktopWindow(),nil,
                pChar('mailto:'+
                TLabel(Sender).Caption),
                nil,nil,SW_SHOWNORMAL);
end;

end.

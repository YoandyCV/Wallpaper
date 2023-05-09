unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, JPEG, ExtCtrls, Spin, ShellApi, Menus, IniFiles,
  ImgList, Registry, ComCtrls, AppEvnts, WinSkinData;

type
  TForm1 = class(TForm)
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Label1: TLabel;
    Label3: TLabel;
    Win: TCheckBox;
    Timer1: TTimer;
    Bevel1: TBevel;
    Label2: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Shape1: TShape;
    SpinEdit1: TSpinEdit;
    PopupMenu1: TPopupMenu;
    Mostrar1: TMenuItem;
    Siguiente1: TMenuItem;
    Anterior1: TMenuItem;
    Salir1: TMenuItem;
    N1: TMenuItem;
    Timer2: TTimer;
    Imgen1: TMenuItem;
    Activar1: TMenuItem;
    Label6: TLabel;
    Timer3: TTimer;
    CheckBox1: TCheckBox;
    ApplicationEvents1: TApplicationEvents;
    StatusBar1: TStatusBar;
    SkinData1: TSkinData;
    procedure DriveComboBox1Change(Sender: TObject);
    procedure SpinEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure Panel1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Comprobar;
    procedure FormCreate(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Mostrar1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Activar1Click(Sender: TObject);
    procedure Siguiente1Click(Sender: TObject);
    procedure Anterior1Click(Sender: TObject);
    Procedure Guardando;
    procedure WinClick(Sender: TObject);
    procedure Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label6MouseLeave(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
  private
    { Private declarations }
        IconData : TNotifyIconData;
    procedure WMSysCommand(var Msg: TWMSysCommand);message WM_SYSCOMMAND;
    procedure Espabila(var Msg : TMessage);message WM_USER+1;
    procedure CreaIcon;
  public
    { Public declarations }

  end;

var
  Form1: TForm1;
  j:Integer=0;
  i:integer;
  MyJPEG : TJPEGImage;
  MyBMP  : TBitmap;
  Dirtemp:string;
  DirSist:string;
  Registro:TRegistry;
  Ini:TIniFile;
implementation

uses Unit2;

{$R *.dfm}

 //Si minimizamos o cerramos.. ocultamos la form
procedure TForm1.WMSysCommand(var Msg: TWMSysCommand);
begin
  if (Msg.CmdType = SC_MINIMIZE)or
  (Msg.CmdType = SC_Close) then
  begin
    Hide;
    Guardando;
  end
  else
  DefaultHandler(Msg);
end;

//Aqui se recibe la pulsacion sobre el icono
procedure TForm1.Espabila(var Msg : TMessage);
var 
  p : TPoint;
begin
  if Msg.lParam = WM_RBUTTONDOWN then begin
    SetForegroundWindow(Handle);
    GetCursorPos(p);
    PopupMenu1.Popup(p.x, p.y);
    PostMessage(Handle, WM_NULL, 0, 0);
  end; 
end;

//Creando nuestro icono  IconX
procedure TForm1.CreaIcon;
begin
 with IconData do
    begin
      cbSize := sizeof(IconData);
      Wnd := Handle;
      uID := 100;
      uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
      uCallbackMessage := WM_USER + 1;
      hIcon :=Application.Icon.Handle;
      StrPCopy(szTip, 'Wallpeper');
    end;
    Shell_NotifyIcon(NIM_ADD, @IconData);
end;

//Evitar las ecepciones al cargar un CD
procedure TForm1.DriveComboBox1Change(Sender: TObject);
begin
if GetDriveType(PChar(LowerCase(Form1.DriveComboBox1.Drive+':\')))<>DRIVE_CDROM then
DirectoryListBox1.Drive:=DriveComboBox1.Drive
else
begin
Application.MessageBox('La unidad no está disponible.',
'wallpaper',mb_IconInformation or mb_OK);
DriveComboBox1.Drive:=DirectoryListBox1.Drive;
end;
end;
procedure TForm1.SpinEdit1KeyPress(Sender: TObject; var Key: Char);
begin
key:=#0;
end;

//Boton para activar y desactivar
procedure TForm1.Panel1Click(Sender: TObject);
begin
if timer1.Enabled =false then
begin
panel1.Caption:='       Desactivar';
Shape1.Brush.Color:=cllime;
timer1.Enabled:=true;
Activar1.Caption:= 'Desactivar';
end
else
begin
panel1.Caption:='      Activar';
Shape1.Brush.Color:=clred;
timer1.Enabled:=False;
Activar1.Caption:= 'Activar';
end;
end;

//Velocidad del cambio entre imagenes
procedure TForm1.Timer1Timer(Sender: TObject);
begin
timer1.Interval:=60000*SpinEdit1.Value;
i:= FileListBox1.Items.Count;

if FileListBox1.Items.Count=-1 then
timer1.Enabled:=False
else
begin
if i=j then
begin
j:=0
end
else
begin
Dirtemp:=DirectoryListBox1.Directory +'\'+ FileListBox1.Items[j];
comprobar;
inc(j);
end;
end;
end;

//Si es una jpg la convertimos en bmp
procedure TForm1.Comprobar;
var
ext,res:string;
lar:integer;
begin
ext:=Dirtemp;
lar:= Length(ext);
res:=ext[lar-3]+ext[lar-2]+ext[lar-1]+ext[lar];

if (res='.jpg') or (res='.JPG')then
begin
MyJPEG := TJPEGImage.Create;
with MyJPEG do begin
LoadFromFile(ext);
MyBMP := TBitmap.Create;
with MyBMP do begin
Width := MyJPEG.Width;
Height := MyJPEG.Height;
Canvas.Draw(0,0,MyJPEG);
SaveToFile(DirSist+'\temp.BMP');
MyJPEG.Free;
MyBMP.Free;

SystemParametersInfo(SPI_SETDESKWALLPAPER,0,Pchar(DirSist+'\temp.BMP'),SPIF_UPDATEINIFILE +
SPIF_SENDWININICHANGE);
end;
end;
end
else
SystemParametersInfo(SPI_SETDESKWALLPAPER,0,Pchar(Dirtemp),SPIF_UPDATEINIFILE +
SPIF_SENDWININICHANGE);
end;

//Al iniciar cargamos los datos necesarios
procedure TForm1.FormCreate(Sender: TObject);
var
Temp:array[0..Max_Path]of char;
TempDir:string;
reg:String;
UTemp:String;
begin

GetTempPath(MAX_PATH,Temp);
TempDir:=String(Temp);
DirSist:=String(Temp);
CreaIcon;
Registro:=TRegistry.Create;
Registro.RootKey :=HKEY_LOCAL_MACHINE;
Registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run',False);
Reg:=Registro.ReadString('Wallpaper');
Registro.Free;

if reg='' then
begin
Win.Checked:=False;
end
else
Win.Checked:=True;

Ini:=TIniFile.Create(ExtractFilePath(Application.exeName)+'Config.dll');
DirectoryListBox1.Directory:=Ini.ReadString('Config','Dir',DirectoryListBox1.Directory);
DriveComboBox1.Drive:=DirectoryListBox1.Drive;
SpinEdit1.Value:=Ini.ReadInteger('Config','Value',1);
Timer1.Enabled:= Ini.ReadBool('Config','Time',false);
CheckBox1.Checked:=Ini.ReadBool('Config','Hot',false);
Ini.Free;

if Timer1.Enabled= true then
begin
panel1.Caption:='       Desactivar';
Shape1.Brush.Color:=cllime;
Activar1.Caption:= 'Desactivar';
end
else
begin
panel1.Caption:='      Activar';
Shape1.Brush.Color:=clred;
Activar1.Caption:= 'Activar';
end;
end;

//Salimos
procedure TForm1.Salir1Click(Sender: TObject);
begin
Shell_NotifyIcon(NIM_DELETE, @IconData);
IconData.Wnd:=0;
Application.Terminate;
end;

//Quitamos el icono
procedure TForm1.FormDestroy(Sender: TObject);
begin
  if IconData.Wnd <> 0 then
  Shell_NotifyIcon(NIM_DELETE, @IconData);
end;

//Mostramos nuestra aplicacion
procedure TForm1.Mostrar1Click(Sender: TObject);
begin
Form1.Show;
ShowWindow(Application.Handle, SW_HIDE);
end;

//Ocultando el programa en la barra
procedure TForm1.FormActivate(Sender: TObject);
begin
ShowWindow(Application.Handle, SW_HIDE);
end;

//Mostrada solo por medio seg
procedure TForm1.Timer2Timer(Sender: TObject);
begin
Timer2.Enabled:=False;
Form1.Hide;
end;

//Activar/desactivar desde el PopMenu
procedure TForm1.Activar1Click(Sender: TObject);
begin
Panel1Click(Sender);
end;

//Siguiente
procedure TForm1.Siguiente1Click(Sender: TObject);
begin
Timer1.Enabled:=True;
Panel1Click(Sender);
i:= FileListBox1.Items.Count;

if i-1=j then
begin
j:=-1;
inc(j);
Dirtemp:=DirectoryListBox1.Directory +'\'+ FileListBox1.Items[j];
comprobar;
end
else
begin
inc(j);
if j<=i-1 then
begin
Dirtemp:=DirectoryListBox1.Directory +'\'+ FileListBox1.Items[j];
comprobar;
end;
end;
end;

//Anterior
procedure TForm1.Anterior1Click(Sender: TObject);
begin
Timer1.Enabled:=true;
Panel1Click(Sender);
i:= FileListBox1.Items.Count;

if j=0 then
begin
j:=i;
dec(j);
Dirtemp:=DirectoryListBox1.Directory +'\'+ FileListBox1.Items[j];
comprobar;
end
else
begin
dec(j);
if j<>-1 then
begin
Dirtemp:=DirectoryListBox1.Directory +'\'+ FileListBox1.Items[j];
comprobar;
end;
end;
end;


procedure TForm1.Guardando;
begin
Ini:=TIniFile.Create(ExtractFilePath(Application.exeName)+'Config.dll');
Ini.WriteString('Config','Dir',Form1.DirectoryListBox1.Directory);
Ini.WriteInteger('Config','Value',Form1.SpinEdit1.Value);
Ini.WriteBool('Config','Time',Timer1.Enabled);
Ini.WriteBool('Config','Hot',CheckBox1.Checked);
Ini.Free;
end;

//Iniciando con Windows
procedure TForm1.WinClick(Sender: TObject);
begin
if Win.Checked=False then
begin
Registro:=TRegistry.Create;
Registro.RootKey :=HKEY_LOCAL_MACHINE;
Registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run',False);
Registro.DeleteValue('Wallpaper');
Registro.Free;
end
else
begin
Registro:=TRegistry.Create;
Registro.RootKey :=HKEY_LOCAL_MACHINE;
Registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run',False);
Registro.WriteString('Wallpaper',Application.exeName);
Registro.Free;
end;
end;

procedure TForm1.Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
Label6.Font.Color:=ClRed;
end;

procedure TForm1.Label6MouseLeave(Sender: TObject);
begin
Label6.Font.Color:=ClBlue;
end;

procedure TForm1.Label6Click(Sender: TObject);
begin
AcercaDe.show;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if checkbox1.Checked =false then
timer3.Enabled :=false
else
timer3.Enabled:=true;
end;

//Detectar la pulsacion de las teclas
procedure TForm1.Timer3Timer(Sender: TObject);
begin
if ( (GetKeyState(VK_F9) and 128)=128 )then
    Anterior1Click(Sender);

if ( (GetKeyState(VK_F10) and 128)=128 )then
    Siguiente1Click(Sender);

end;

procedure TForm1.ApplicationEvents1Hint(Sender: TObject);
begin
StatusBar1.Panels[1].Text:=Application.Hint;
end;

end.

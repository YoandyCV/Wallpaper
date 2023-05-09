object AcercaDe: TAcercaDe
  Left = 375
  Top = 206
  BorderStyle = bsToolWindow
  Caption = 'Acerca de:'
  ClientHeight = 243
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 16
    Top = 24
    Width = 49
    Height = 49
  end
  object Label1: TLabel
    Left = 64
    Top = 24
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 32
    Top = 80
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 112
    Top = 98
    Width = 84
    Height = 13
    Caption = '111@nauta.cu'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = Label3Click
    OnMouseMove = Label3MouseMove
    OnMouseLeave = Label3MouseLeave
  end
  object Label4: TLabel
    Left = 94
    Top = 114
    Width = 126
    Height = 13
    Caption = 'yudielamed@nauta.cu'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = Label4Click
    OnMouseMove = Label3MouseMove
    OnMouseLeave = Label3MouseLeave
  end
  object Button1: TButton
    Left = 120
    Top = 208
    Width = 75
    Height = 25
    Caption = '&Aceptar'
    TabOrder = 0
    OnClick = Button1Click
  end
end

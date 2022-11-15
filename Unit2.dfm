object frmEdit: TfrmEdit
  Left = 643
  Top = 411
  BorderStyle = bsSingle
  Caption = 'Edit coordinates'
  ClientHeight = 492
  ClientWidth = 614
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grpMaps: TRadioGroup
    Left = 0
    Top = 0
    Width = 614
    Height = 34
    Align = alTop
    Caption = 'map type'
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      'Roadmap'
      'Satellite '
      'Hybrid'
      'Terrain')
    TabOrder = 0
    OnClick = grpMapsClick
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 34
    Width = 614
    Height = 406
    Align = alClient
    TabOrder = 1
    object webview: TCEFWindowParent
      Left = 2
      Top = 15
      Width = 610
      Height = 389
      Align = alClient
      TabOrder = 0
      DoubleBuffered = False
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 440
    Width = 614
    Height = 52
    Align = alBottom
    TabOrder = 2
    object Button1: TButton
      Left = 8
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 528
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object Chromium: TChromium
    OnConsoleMessage = ChromiumConsoleMessage
    Left = 96
  end
end

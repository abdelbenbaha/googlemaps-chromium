object frmMain: TfrmMain
  Left = 640
  Top = 344
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Google Map Sample 1.0'
  ClientHeight = 492
  ClientWidth = 614
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 614
    Height = 65
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 38
      Height = 13
      Caption = 'API Key'
    end
    object edtApi: TEdit
      Left = 64
      Top = 29
      Width = 535
      Height = 21
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 65
    Width = 263
    Height = 427
    Align = alLeft
    TabOrder = 1
    object GroupBox4: TGroupBox
      Left = 2
      Top = 257
      Width = 259
      Height = 112
      Align = alTop
      Caption = 'Coordinates'
      TabOrder = 0
      object Label8: TLabel
        Left = 8
        Top = 32
        Width = 15
        Height = 13
        Caption = 'Lat'
      end
      object Label9: TLabel
        Left = 8
        Top = 64
        Width = 24
        Height = 13
        Caption = 'Long'
      end
      object edtLat: TEdit
        Left = 60
        Top = 29
        Width = 173
        Height = 21
        TabOrder = 0
        OnKeyPress = edtLatKeyPress
      end
      object edtLong: TEdit
        Left = 60
        Top = 61
        Width = 173
        Height = 21
        TabOrder = 1
        OnKeyPress = edtLatKeyPress
      end
    end
    object GroupBox5: TGroupBox
      Left = 2
      Top = 15
      Width = 259
      Height = 242
      Align = alTop
      Caption = 'Address'
      TabOrder = 1
      object Label2: TLabel
        Left = 8
        Top = 32
        Width = 29
        Height = 13
        Caption = 'Line 1'
      end
      object Label3: TLabel
        Left = 8
        Top = 64
        Width = 29
        Height = 13
        Caption = 'Line 2'
      end
      object Label4: TLabel
        Left = 8
        Top = 96
        Width = 34
        Height = 13
        Caption = 'Suburb'
      end
      object Label5: TLabel
        Left = 8
        Top = 128
        Width = 25
        Height = 13
        Caption = 'State'
      end
      object Label6: TLabel
        Left = 8
        Top = 160
        Width = 45
        Height = 13
        Caption = 'Postcode'
      end
      object Label7: TLabel
        Left = 8
        Top = 192
        Width = 36
        Height = 13
        Caption = 'Country'
      end
      object edtLine1: TEdit
        Left = 60
        Top = 29
        Width = 173
        Height = 21
        TabOrder = 0
      end
      object edtLine2: TEdit
        Left = 60
        Top = 61
        Width = 173
        Height = 21
        TabOrder = 1
      end
      object edtSuburb: TEdit
        Left = 60
        Top = 93
        Width = 173
        Height = 21
        TabOrder = 2
      end
      object edtState: TEdit
        Left = 60
        Top = 125
        Width = 173
        Height = 21
        TabOrder = 3
      end
      object edtPostecode: TEdit
        Left = 60
        Top = 157
        Width = 173
        Height = 21
        TabOrder = 4
      end
      object edtCountry: TEdit
        Left = 60
        Top = 189
        Width = 173
        Height = 21
        TabOrder = 5
      end
    end
    object btnLoad: TButton
      Left = 24
      Top = 384
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 2
      OnClick = btnLoadClick
    end
    object btnEdit: TButton
      Left = 160
      Top = 384
      Width = 75
      Height = 25
      Caption = 'Edit'
      Enabled = False
      TabOrder = 3
      OnClick = btnEditClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 263
    Top = 65
    Width = 351
    Height = 427
    Align = alClient
    TabOrder = 2
    object webview: TCEFWindowParent
      Left = 2
      Top = 15
      Width = 347
      Height = 410
      Align = alClient
      TabOrder = 0
    end
  end
  object cefRequest: TCEFUrlRequestClientComponent
    OnDownloadData = cefRequestDownloadData
    OnCreateURLRequest = cefRequestCreateURLRequest
    Left = 64
  end
  object Chromium: TChromium
    OnResourceLoadComplete = ChromiumResourceLoadComplete
    Left = 96
  end
end

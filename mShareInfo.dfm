object ShareInfo: TShareInfo
  Left = 192
  Top = 107
  Width = 697
  Height = 663
  Caption = 'ShareInfo'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = OnCloseQuery
  OnShow = OnShow
  PixelsPerInch = 96
  TextHeight = 14
  object gbTorrent: TGroupBox
    Left = 8
    Top = 8
    Width = 673
    Height = 409
    Caption = 'Torrent'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 95
      Height = 18
      Caption = 'Torrent Datei:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 72
      Width = 57
      Height = 18
      Caption = 'Tracker:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 96
      Width = 81
      Height = 18
      Caption = 'Dateiname:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 120
      Width = 85
      Height = 18
      Caption = 'Kommentar:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 168
      Width = 96
      Height = 18
      Caption = 'Hash (SHA1):'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 16
      Top = 192
      Width = 50
      Height = 18
      Caption = 'Datum:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 16
      Top = 216
      Width = 48
      Height = 18
      Caption = 'Gr'#246#223'e:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 232
      Width = 657
      Height = 169
      TabOrder = 0
      object Label7: TLabel
        Left = 8
        Top = 16
        Width = 39
        Height = 18
        Caption = 'Inhalt:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 8
        Top = 40
        Width = 51
        Height = 16
        Caption = '(Klick f'#252'r'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 8
        Top = 56
        Width = 64
        Height = 16
        Caption = 'mehr Infos)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 8
        Top = 88
        Width = 81
        Height = 18
        Caption = 'Dateiname:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 8
        Top = 112
        Width = 48
        Height = 18
        Caption = 'Gr'#246#223'e:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 8
        Top = 136
        Width = 50
        Height = 18
        Caption = 'Anzahl:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object cbTrackerOn: TCheckBox
      Left = 400
      Top = 72
      Width = 41
      Height = 17
      Caption = 'On'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object cbTrackerOff: TCheckBox
      Left = 448
      Top = 72
      Width = 209
      Height = 17
      Caption = 'Off (ggf. Verbindung pr'#252'fen)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object edTorrentPfad: TEdit
    Left = 128
    Top = 40
    Width = 377
    Height = 22
    TabOrder = 1
  end
  object btLaden: TButton
    Left = 520
    Top = 40
    Width = 145
    Height = 25
    Caption = 'Torrent '#246'ffnen...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btLadenClick
  end
  object edTracker: TEdit
    Left = 128
    Top = 80
    Width = 273
    Height = 22
    TabOrder = 3
  end
  object edTName: TEdit
    Left = 128
    Top = 104
    Width = 537
    Height = 22
    TabOrder = 4
  end
  object memoKommentar: TMemo
    Left = 128
    Top = 128
    Width = 537
    Height = 45
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object edTHash: TEdit
    Left = 128
    Top = 176
    Width = 537
    Height = 22
    TabOrder = 6
  end
  object edDatum: TEdit
    Left = 128
    Top = 200
    Width = 537
    Height = 22
    TabOrder = 7
  end
  object lboxDateien: TListBox
    Left = 128
    Top = 256
    Width = 537
    Height = 69
    ItemHeight = 14
    TabOrder = 8
    OnClick = lboxDateienClick
  end
  object edDateiname: TEdit
    Left = 128
    Top = 328
    Width = 537
    Height = 22
    Enabled = False
    TabOrder = 9
  end
  object edTGroesse: TEdit
    Left = 128
    Top = 352
    Width = 537
    Height = 22
    TabOrder = 10
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 432
    Width = 673
    Height = 177
    Caption = 'eDonkey'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    object Label12: TLabel
      Left = 16
      Top = 32
      Width = 99
      Height = 18
      Caption = 'eDonkey Link:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 16
      Top = 72
      Width = 81
      Height = 18
      Caption = 'Dateiname:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 16
      Top = 96
      Width = 88
      Height = 18
      Caption = 'Hash (MD4):'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 16
      Top = 120
      Width = 48
      Height = 18
      Caption = 'Gr'#246#223'e:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 16
      Top = 144
      Width = 39
      Height = 18
      Caption = 'Inhalt:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
  end
  object edDonkeyPfad: TEdit
    Left = 128
    Top = 464
    Width = 377
    Height = 22
    TabOrder = 12
  end
  object btDonkey: TButton
    Left = 520
    Top = 464
    Width = 145
    Height = 25
    Caption = 'eDonkey Link checken'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    OnClick = btDonkeyClick
  end
  object edDName: TEdit
    Left = 128
    Top = 504
    Width = 537
    Height = 22
    TabOrder = 14
  end
  object edDHash: TEdit
    Left = 128
    Top = 528
    Width = 537
    Height = 22
    TabOrder = 15
  end
  object edDGroesse: TEdit
    Left = 128
    Top = 552
    Width = 537
    Height = 22
    TabOrder = 16
  end
  object edDateien: TEdit
    Left = 128
    Top = 576
    Width = 537
    Height = 22
    TabOrder = 17
  end
  object edTAnzahl: TEdit
    Left = 128
    Top = 376
    Width = 537
    Height = 22
    TabOrder = 18
  end
  object edTGGroesse: TEdit
    Left = 128
    Top = 224
    Width = 537
    Height = 22
    TabOrder = 19
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Torrents (*.torrent)|*.torrent|Alle Dateien (*.*)|*.*'
    Left = 632
    Top = 40
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 632
    Top = 472
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 144
    object Datei1: TMenuItem
      Caption = 'Datei'
      object Optionen1: TMenuItem
        Caption = 'Optionen...'
        OnClick = Optionen1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Beenden1: TMenuItem
        Caption = 'Beenden'
        OnClick = Beenden1Click
      end
    end
    object ShareInfo1: TMenuItem
      Caption = 'ShareInfo'
      object orrent1: TMenuItem
        Caption = 'Torrent'
        OnClick = orrent1Click
      end
      object eDonkey1: TMenuItem
        Caption = 'eDonkey'
        OnClick = eDonkey1Click
      end
      object Sig2Dat1: TMenuItem
        Caption = 'Sig2Dat'
        Enabled = False
      end
      object Magnet1: TMenuItem
        Caption = 'Magnet'
        Enabled = False
      end
    end
    object Hilfe1: TMenuItem
      Caption = 'Hilfe'
      object Info1: TMenuItem
        Caption = 'Info'
        OnClick = Info1Click
      end
      object UpdatePrfung1: TMenuItem
        Caption = 'Update Pr'#252'fung'
        OnClick = UpdatePrfung1Click
      end
    end
  end
end

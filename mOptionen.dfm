object Optionen: TOptionen
  Left = 192
  Top = 106
  Width = 249
  Height = 132
  Caption = 'ShareInfo - Optionen'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnShow = OnShow
  PixelsPerInch = 96
  TextHeight = 16
  object lbSprache: TLabel
    Left = 8
    Top = 8
    Width = 52
    Height = 16
    Caption = 'Sprache:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object ComboBox1: TComboBox
    Left = 88
    Top = 8
    Width = 145
    Height = 24
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 0
    Text = 'Deutsch'
    Items.Strings = (
      'Deutsch'
      'Englisch'
      'Norwegisch')
  end
  object cbCanClose: TCheckBox
    Left = 16
    Top = 40
    Width = 217
    Height = 17
    Caption = 'Beim Beenden nachfragen?'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object btOK: TButton
    Left = 48
    Top = 72
    Width = 145
    Height = 25
    Caption = 'OK'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btOKClick
  end
end

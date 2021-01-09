unit mOptionen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, mSprache;

type
  TOptionen = class(TForm)
    ComboBox1: TComboBox;
    lbSprache: TLabel;
    cbCanClose: TCheckBox;
    btOK: TButton;
    procedure btOKClick(Sender: TObject);
    procedure OnShow(Sender: TObject);
  private
    { Private declarations }
    Reg: TRegistry;
  public
    { Public declarations }
  end;

var
  Optionen: TOptionen;

implementation

{$R *.dfm}

procedure TOptionen.btOKClick(Sender: TObject);
begin
   Reg := TRegistry.Create;
   Reg.RootKey := HKEY_LOCAL_MACHINE;
   if Reg.OpenKey('Software\Chrissyx Homepage Progs\ShareInfo', True) then
   try
      Reg.WriteInteger('Sprache', ComboBox1.ItemIndex);
      Reg.WriteBool('CanClose', cbCanClose.Checked);
      Reg.CloseKey;
      ChangeLanguage(ComboBox1.ItemIndex);
   except
      Application.MessageBox(LngNoSettingsSave, NIL, 48);
   end
   else Application.MessageBox(LngNoSettingsFound, NIL, 48);
   Reg.Free;
   Close;
end;

procedure TOptionen.OnShow(Sender: TObject);
begin
   if ComboBox1.ItemIndex = -1 then
   begin
      Reg := TRegistry.Create;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      if Reg.OpenKey('Software\Chrissyx Homepage Progs\ShareInfo', True) then
      try
         Optionen.ComboBox1.ItemIndex := Reg.ReadInteger('Sprache');
         Reg.CloseKey;
      except
         Optionen.ComboBox1.ItemIndex := 0;
         Application.MessageBox(LngNoSettingsRead, NIL, 48);
      end
      else Application.MessageBox(LngNoSettingsFound, NIL, 48);
      Reg.Free;
   end;
end;

end.

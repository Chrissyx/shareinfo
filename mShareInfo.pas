unit mShareInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BDecode, Hashes, MessageDigests, ExtCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Contnrs,
  Menus, mAboutBox, ShellAPI, mOptionen, Registry, mSprache, ComCtrls,
  mVersionshistory;

type
  TShareInfo = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    gbTorrent: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label18: TLabel;
    gbTorrent2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label17: TLabel;
    cbTrackerOn: TCheckBox;
    cbTrackerOff: TCheckBox;
    edTorrentPfad: TEdit;
    btLaden: TButton;
    edTracker: TEdit;
    edTName: TEdit;
    memoKommentar: TMemo;
    edTHash: TEdit;
    edDatum: TEdit;
    lboxDateien: TListBox;
    edDateiname: TEdit;
    edTGroesse: TEdit;
    edTAnzahl: TEdit;
    edTGGroesse: TEdit;
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    Optionen1: TMenuItem;
    N1: TMenuItem;
    Beenden1: TMenuItem;
    ShareInfo1: TMenuItem;
    Torrent1: TMenuItem;
    eDonkey1: TMenuItem;
    Sig2Dat1: TMenuItem;
    Magnet1: TMenuItem;
    Hilfe1: TMenuItem;
    Info1: TMenuItem;
    UpdatePrfung1: TMenuItem;
    gbEDonkey: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edDonkeyPfad: TEdit;
    btDonkey: TButton;
    edDName: TEdit;
    edDHash: TEdit;
    edDGroesse: TEdit;
    IdHTTP1: TIdHTTP;
    TabSheet3: TTabSheet;
    gbSig2Dat: TGroupBox;
    Label19: TLabel;
    edSig2DatPfad: TEdit;
    btSig2Dat: TButton;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    edSGroesse: TEdit;
    edSHash: TEdit;
    edSName: TEdit;
    Label23: TLabel;
    Versionshistory1: TMenuItem;
    memoDDateien: TMemo;
    edDQuellen: TEdit;
    Label24: TLabel;
    edDVerfgbarkeit: TEdit;
    Label25: TLabel;
    Label26: TLabel;
    Spende1: TMenuItem;
    procedure Spende1Click(Sender: TObject);
    procedure Versionshistory1Click(Sender: TObject);
    procedure btSig2DatClick(Sender: TObject);
    procedure Sig2Dat1Click(Sender: TObject);
    procedure btLadenClick(Sender: TObject);
    procedure btDonkeyClick(Sender: TObject);
    procedure lboxDateienClick(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure Torrent1Click(Sender: TObject);
    procedure eDonkey1Click(Sender: TObject);
    procedure Info1Click(Sender: TObject);
    procedure UpdatePrfung1Click(Sender: TObject);
    procedure Optionen1Click(Sender: TObject);
    procedure OnShow(Sender: TObject);
    procedure OnCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    tree, infotree, subinfotree: TObjectHash;
    temp: TObject;
    fs, PCount: int64;
    sizearray: array of integer;
    url: string;
    Reg: TRegistry;
  public
    { Public declarations }
  end;

var
  ShareInfo: TShareInfo;

implementation

{$R *.dfm}

function UnixTimeToDateTime(const UnixTime: Integer): TDateTime;
var FileTime: TFileTime;
    SystemTime: TSystemTime;
    I: Int64;
begin
  // first convert unix time to a Win32 file time
  I := Int64(UnixTime) * Int64(10000000) + 116444736000000000;
  FileTime.dwLowDateTime := DWORD(I);
  FileTime.dwHighDateTime := I shr 32;

  // now convert to system time
  FileTimeToSystemTime(FileTime, SystemTime);

  // and finally convert the system time to TDateTime
  Result := SystemTimeToDateTime(SystemTime);
end;

procedure TShareInfo.btLadenClick(Sender: TObject);
var F: TFileStream;
    F2: file of Byte;
    sha: TSHA1;
    fp, fn: string;
    inhalt, pfad: TObjectList;
    i, j: integer;
    multi: boolean;
begin
   if (PCount = 0) then OpenDialog1.Execute
   else OpenDialog1.FileName := ParamStr(1);
   if (OpenDialog1.FileName <> '') then
   begin
      edTorrentPfad.Clear;
      edTracker.Clear;
      cbTrackerOn.Checked := False;
      cbTrackerOff.Checked := False;
      edTName.Clear;
      memoKommentar.Clear;
      edTHash.Clear;
      edDatum.Clear;
      lboxDateien.Clear;
      edDateiname.Clear;
      edTGroesse.Clear;
      edTAnzahl.Clear;
      edTGGroesse.Text := '0';
      edTorrentPfad.Text := OpenDialog1.FileName;
      F := TFileStream.Create (OpenDialog1.FileName, fmOpenRead);
      temp := BDecodeStream(F);
      if Assigned (temp) then
      begin
         tree := temp as TObjectHash;

         //Tracker
         if tree.Exists('announce') then
         begin
            edTracker.Text := (tree['announce'] as TIntString).StringPart;
            url := edTracker.Text;
            try
               if not (IdHTTP1.Get(url) = '') then cbTrackerOn.Checked := True;
            except
               on E: exception do cbTrackerOff.Checked := True;
            end;
         end
         else edTracker.Text := LngNoTracker;

         //Kommentar
         if tree.Exists('comment') then memoKommentar.Lines.Text := (tree['comment'] as TIntString).StringPart
         else memoKommentar.Lines.Add(LngNoComment);

         //Datum
         if tree.Exists('creation date') then edDatum.Text := FormatDateTime('c', UnixTimeToDateTime((tree['creation date'] as TIntString).IntPart))
         else edDatum.Text := LngNoCreationDate;

         if tree.Exists('info') then
         begin
            infotree := tree['info'] as TObjectHash;

            //Name
            if infotree.Exists('name') then edTName.Text := (infotree['name'] as TIntString).StringPart
            else edTName.Text := LngNoFilename;

            //Inhalt
            if infotree.Exists('length') then               //Einzelne Datei
            begin
               multi := false;
               SetLength (sizearray, 1);
               edTGroesse.Text := FloatToStr((((infotree['length'] as TIntString).IntPart)/1024)/1024) + ' MB';
               sizearray[0] := (infotree['length'] as TIntString).IntPart;
               if not (edTName.Text = '') then lboxDateien.Items.Add (edTName.Text);
               edTAnzahl.Text := '1';
               edTGGroesse.Text := IntToStr((infotree['length'] as TIntString).IntPart);
            end
            else begin                                      //Mehrere Dateien
                    multi := true;
                    if infotree.Exists('files') then
                    begin
                       inhalt := infotree['files'] as TObjectList;
                       edTAnzahl.Text := IntToStr(inhalt.Count);
                       SetLength(sizearray, inhalt.Count);
                       for i := 0 to inhalt.Count - 1 do
                       begin
                          subinfotree := inhalt[i] as TObjectHash;

                          if subinfotree.Exists('length') then sizearray[i] := (subinfotree['length'] as TIntString).IntPart
                          else
                          begin
                             Application.MessageBox(PChar(LngFilelength1 + IntToStr(i) + LngFilelength2), NIL, 48);
                             sizearray[i] := Int64(0);
                          end;
                          edTGGroesse.Text := IntToStr (StrToInt (edTGGroesse.Text) + sizearray[i]);

                          if subinfotree.Exists('path') then
                          begin
                              pfad := subinfotree['path'] as TObjectList;
                              for j := 0 to pfad.Count - 2 do fp := fp + (pfad[j] as TIntString).StringPart + '\';
                              if(pfad.Count > 0) then fn := (pfad[pfad.Count - 1] as TIntString).StringPart;
                              lboxDateien.Items.Add(fp + fn);
                              fp := '';
                          end
                          else Application.MessageBox(PChar(LngNoPath1 + IntToStr(i) + LngNoPath2), NIL, 48);
                       end;
                    end
                    else lboxDateien.items.add(LngNoInfolength);
                 end;
         lboxDateien.Selected[0] := True;
         lboxDateienClick(self);
         edDateiname.Enabled := multi;
         edTGGroesse.Text := FloatToStr ((StrToFloat (edTGGroesse.Text) / 1024) / 1024) + ' MB';
         end
         else Application.MessageBox(LngNoInfopart, NIL, 48);

         //Hash
         if (tree.Exists('_info_start') and tree.Exists('_info_length')) then
         begin
            sha := TSHA1.Create();
            F.Seek ((tree['_info_start'] as TIntString).IntPart, soFromBeginning);
            fs := (tree['_info_length'] as TIntString).IntPart;
            SetLength (fp, fs);
            F.Read (PChar(fp)^, fs);
            sha.TransformString(fp);
            sha.Complete();
            edTHash.Text := sha.HashValue;
         end
         else edTHash.Text := LngNoHash;
      end
      else Application.MessageBox(LngBadTorrent, NIL, 16);

   end;
   FreeAndNil(F);

   if (edTGGroesse.Text = '0') then
   begin
      AssignFile(F2, OpenDialog1.FileName);
      Reset(F2);
      try
         edTGGroesse.Text := FloatToStr(FileSize(F2)/1024) + ' KB';
      except
         Application.MessageBox(LngNoInfopart, NIL, 48);
      end;
      CloseFile(F2);      
   end;
   
   PCount := 0;
   OpenDialog1.FileName := ''; //Hier müsste eine andere Lösung gefunden werden. Sonst weniger Luxus...
end;

procedure TShareInfo.btDonkeyClick(Sender: TObject);
var str, url, fake: string;
    i, j, k, temp: integer;
begin
   edDName.Clear;
   edDHash.Clear;
   edDGroesse.Clear;
   edDQuellen.Clear;
   edDVerfgbarkeit.Clear;
   memoDDateien.Clear;
   if not (edDonkeyPfad.Text = '') then
   begin
      str := edDonkeyPfad.Text;
      if (Pos('ed2k://', str) > 0) then
      begin
         temp := 1;
         for i := 14 to Length(str) do
         begin
            if (str[i] = '|') then inc(temp);
            if (temp = 1) and not (str[i] = '|') then edDName.Text := edDName.Text + str[i]
            else if (temp = 2) and not (str[i] = '|') then edDGroesse.Text := edDGroesse.Text + str[i]
            else if (temp = 3) and not (str[i] = '|') then edDHash.Text := edDHash.Text + str[i]
         end;
         if (edDGroesse.Text = '') then edDGroesse.Text := '0';
         edDGroesse.Text := FloatToStr((StrToFloat(edDGroesse.Text) / 1024) / 1024) + ' MB';

         url := 'http://www.filehash.com/file/' + edDHash.Text;
         try
            fake := IdHTTP1.Get(url);
         except
            fake := '';
            //Application.MessageBox(LngNoDatabank, NIL, 48);
         end;
         if (fake = '') then
         begin
            memoDDateien.Lines.Add(LngNoEntry);
            edDQuellen.Text := LngNoEntry;
            edDVerfgbarkeit.Text := LngNoEntry;
         end
         else
         begin
            i := 1;
            //Verfügbarkeit
            fake := Copy(fake, Pos('Availability:', fake)+17);
            while not (fake[i] = '<') do
            begin
               edDVerfgbarkeit.Text := edDVerfgbarkeit.Text + fake[i];
               inc(i);
            end;
            i := 1;
            //Quellen
            fake := Copy(fake, Pos('Complete Sources:', fake)+21);
            while not (fake[i] = '<') do
            begin
               edDQuellen.Text := edDQuellen.Text + fake[i];
               inc(i);
            end;
            //Inhalt
            fake := Copy(fake, Pos('following names:', fake)+25);
            i := 1;                 //Von...
            j := Pos('</b>', fake); //...bis
            k := -1;
            while (i < j) do
            begin
               inc(k);
               memoDDateien.Lines.Add('');
               while not (fake[i] = '<') do
               begin
                  memoDDateien.Lines.Strings[k] := memoDDateien.Lines.Strings[k] + fake[i];
                  inc(i);
               end;
               i := i+5;
            end;
         end;
         if (edDQuellen.Text = '') then edDQuellen.Text := LngNoEntry;
         if (edDVerfgbarkeit.Text = '') then edDVerfgbarkeit.Text := LngNoEntry;
         if (memoDDateien.Lines.Count = 0) then memoDDateien.Lines.Add(LngNoEntry);
      end
      else Application.MessageBox(LngBadeDonkeyLink, NIL, 48);
   end
   else Application.MessageBox(LngInsertLink, LngHint, 64)
end;

procedure TShareInfo.lboxDateienClick(Sender: TObject);
var i: integer;
begin
   for i := 0 to lboxDateien.Items.Count - 1 do
   if lboxDateien.Selected[i] then
   begin
      edDateiname.Text := lboxDateien.Items.Strings[i];
      edTGroesse.Text := FloatToStr(((sizearray[i])/1024)/1024) + ' MB';
   end;
end;

procedure TShareInfo.Beenden1Click(Sender: TObject);
begin
   Close;
end;

procedure TShareInfo.Torrent1Click(Sender: TObject);
begin
   PageControl1.ActivePageIndex := 0;
   btLadenClick(self);
end;

procedure TShareInfo.eDonkey1Click(Sender: TObject);
begin
   PageControl1.ActivePageIndex := 1;
   btDonkeyClick(self);
end;

procedure TShareInfo.Sig2Dat1Click(Sender: TObject);
begin
   PageControl1.ActivePageIndex := 2;
   btSig2DatClick(self);
end;

procedure TShareInfo.Info1Click(Sender: TObject);
begin
   AboutBox.Visible := True;
   AboutBox.Show;
end;

procedure TShareInfo.UpdatePrfung1Click(Sender: TObject);
begin
   url := 'http://www.chrissyx.com/update.php?siversion=' + AboutBox.edVersion.Caption;
   try
      if IdHTTP1.Get(url) = 'true' then
      begin
    //     IdHTTP1.Head(url);   Sie ist ' + IntToStr(IdHTTP1.Response.ContentLength) + ' gross!'
         case Application.MessageBox(LngNewVersion, LngUpdaten, 36) of
         IDYES:
         ShellExecute(handle, 'open', 'http://www.chrissyx.com/daten/ShareInfo.exe', NIL, NIL, SW_SHOW);
         end;
      end
      else Application.MessageBox(LngNoNewVersion, LngHint, 64);
   except
      //on E: exception do
      Application.MessageBox(LngNoHost, NIL, 48);
   end;
end;

procedure TShareInfo.Optionen1Click(Sender: TObject);
begin
   Optionen.Visible := True;
   Optionen.Show;
end;

procedure TShareInfo.OnShow(Sender: TObject);
begin
   Reg := TRegistry.Create;
   Reg.RootKey := HKEY_LOCAL_MACHINE;
   if Reg.OpenKey('Software\Chrissyx Homepage Progs\ShareInfo', True) then
   try
      Optionen.ComboBox1.ItemIndex := Reg.ReadInteger('Sprache');
      Optionen.cbCanClose.Checked := Reg.ReadBool('CanClose');
      Reg.CloseKey;
      ChangeLanguage(Optionen.ComboBox1.ItemIndex);
   except
      Optionen.ComboBox1.ItemIndex := 0;
      Optionen.cbCanClose.Checked := False;
      Application.MessageBox(LngNoSettingsRead, NIL, 48);
   end
   else Application.MessageBox(LngNoSettingsFound, NIL, 48);
   Reg.Free;
   PCount := ParamCount;
   if (ParamStr(1) <> '') then btLadenClick(self);
   PageControl1.ActivePageIndex := 0;
end;

procedure TShareInfo.OnCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if Optionen.cbCanClose.Checked then
   case Application.MessageBox(LngRealExit, LngQuestion, 36) of
   IDNO: CanClose := False;
   IDYES: CanClose := True;
   end;
end;

procedure TShareInfo.btSig2DatClick(Sender: TObject);
var str :string;
i, temp :integer;
begin
   edSName.Clear;
   edSHash.Clear;
   edSGroesse.Clear;
   if not (edSig2DatPfad.Text = '') then
   begin
      str := edSig2DatPfad.Text;
      if (Pos('sig2dat:///', str) > 0) then
      begin
         temp := 1;
         for i := 18 to Length(str) do
         begin
            if (str[i] = '|') then inc(temp);
            if (temp = 1) and not (str[i] = '|') then edSName.Text := edSName.Text + str[i]
            else if (temp = 2) and not (str[i] = '|') then edSGroesse.Text := edSGroesse.Text + str[i]
            else if (temp = 3) and not (str[i] = '|') then edSHash.Text := edSHash.Text + str[i]
         end;
      edSGroesse.Text := Copy(edSGroesse.Text, 8, Pos('Bytes', edSGroesse.Text));
      edSGroesse.Text := Copy(edSGroesse.Text, 1, Pos('B', edSGroesse.Text)-1);
      edSGroesse.Text := FloatToStr((StrToFloat(edSGroesse.Text) / 1024) / 1024) + ' MB';
      edSHash.Text := Copy(edSHash.Text, 8, Length(edSHash.Text));
      end
      else Application.MessageBox(LngBadSig2DatLink, NIL, 48);
   end
   else Application.MessageBox(LngInsertLink, LngHint, 64);
end;

procedure TShareInfo.Versionshistory1Click(Sender: TObject);
begin
   Versionshistory.Visible := True;
   Versionshistory.Show;
end;

procedure TShareInfo.Spende1Click(Sender: TObject);
begin
   case Application.MessageBox('Dir gefällt das Programm? Du möchtest mich unterstützen? Dann kannst Du mir etwas spenden!', 'Spende?', 68) of
   IDYES: ShellExecute(handle, 'open', 'mailto:chrissyx@t-online.de?subject=SPENDE FÜR SHAREINFO', NIL, NIL, SW_SHOW);
   end;
end;

end.

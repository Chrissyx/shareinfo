unit mShareInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BDecode, Hashes, MessageDigests, ExtCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Contnrs,
  Menus, mAboutBox, ShellAPI, mOptionen, Registry, mSprache;

type
  TShareInfo = class(TForm)
    gbTorrent: TGroupBox;
    Label1: TLabel;
    edTorrentPfad: TEdit;
    btLaden: TButton;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    edTracker: TEdit;
    Label3: TLabel;
    edTName: TEdit;
    memoKommentar: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edTHash: TEdit;
    edDatum: TEdit;
    lboxDateien: TListBox;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edDateiname: TEdit;
    Label11: TLabel;
    edTGroesse: TEdit;
    GroupBox2: TGroupBox;
    edDonkeyPfad: TEdit;
    btDonkey: TButton;
    Label12: TLabel;
    edDName: TEdit;
    Label13: TLabel;
    edDHash: TEdit;
    Label14: TLabel;
    edDGroesse: TEdit;
    Label15: TLabel;
    edDateien: TEdit;
    Label16: TLabel;
    IdHTTP1: TIdHTTP;
    Label17: TLabel;
    edTAnzahl: TEdit;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    Beenden1: TMenuItem;
    ShareInfo1: TMenuItem;
    Hilfe1: TMenuItem;
    Info1: TMenuItem;
    orrent1: TMenuItem;
    eDonkey1: TMenuItem;
    Sig2Dat1: TMenuItem;
    Magnet1: TMenuItem;
    Label18: TLabel;
    edTGGroesse: TEdit;
    UpdatePrfung1: TMenuItem;
    cbTrackerOn: TCheckBox;
    cbTrackerOff: TCheckBox;
    Optionen1: TMenuItem;
    N1: TMenuItem;
    procedure btLadenClick(Sender: TObject);
    procedure btDonkeyClick(Sender: TObject);
    procedure lboxDateienClick(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure orrent1Click(Sender: TObject);
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
   OpenDialog1.FileName := ''; //Hier m�sste eine andere L�sung gefunden werden. Sonst weniger Luxus...
end;

procedure TShareInfo.btDonkeyClick(Sender: TObject);
var str, url, fake: string;
    i, j, temp: integer;
    size: real;
begin
   edDName.Clear;
   edDHash.Clear;
   edDGroesse.Clear;
   edDateien.Clear;
   if not (edDonkeyPfad.Text = '') then
   begin
      str := edDonkeyPfad.Text;
//      if (str[1] + str[2] + str[3] + str[4] + str[5] + str[6] + str[7] = 'ed2k://') then
      if (Pos('ed2k://', str) > 0) then // :)
      begin
         temp := 1;
         for i := 14 to Length(str) do
         begin
            if (str[i] = '|') then inc(temp);
            if (temp = 1) and not (str[i] = '|') then edDName.Text := edDName.Text + str[i]
            else if (temp = 2) and not (str[i] = '|') then edDGroesse.Text := edDGroesse.Text + str[i]
            else if (temp = 3) and not (str[i] = '|') then edDHash.Text := edDHash.Text + str[i]
         end;
         size := StrToFloat (edDGroesse.Text);
         size := (size / 1024) / 1024;
         edDGroesse.Text := FloatToStr(size) + ' MB';

         url := 'http://www.filehash.com/file/' + edDHash.Text;
         try
            fake := IdHTTP1.Get(url);
         except
            fake := '';
            Application.MessageBox(LngNoDatabank, NIL, 48);
         end;
         for i := 1 to Length(fake) do
         begin
            if (fake[i-2] = 'h') and (fake[i-1] = '2') and (fake[i] = '>') then
            begin
               j := i+1;
               while not (fake[j] = '<') or (fake[j] = char(13)) do
               begin
                  edDateien.Text := edDateien.Text + fake[j];
                  inc(j);
               end;
            end
         end;
         if (edDateien.Text = '') then edDateien.Text := LngNoEntry;
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

procedure TShareInfo.orrent1Click(Sender: TObject);
begin
   btLadenClick(self);
end;

procedure TShareInfo.eDonkey1Click(Sender: TObject);
begin
   btDonkeyClick(self);
end;

procedure TShareInfo.Info1Click(Sender: TObject);
begin
   AboutBox.Visible := True;
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
         ShellExecute(handle, 'open', PChar('http://www.chrissyx.com/daten/ShareInfo.exe'), NIL, NIL, SW_SHOW);
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
   if ParamStr(1) <> '' then btLadenClick(self);
end;

procedure TShareInfo.OnCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if Optionen.cbCanClose.Checked then
   case Application.MessageBox(LngRealExit, LngQuestion, 36) of
   IDNO: CanClose := False;
   IDYES: CanClose := True;
   end;
end;

end.
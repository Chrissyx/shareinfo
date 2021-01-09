unit mAboutBox;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ShellAPI;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    edVersion: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbSpeicher1: TLabel;
    lbSpeicher2: TLabel;
    lbSpeicher4: TLabel;
    lbSpeicher5: TLabel;
    lbSpeicher7: TLabel;
    lbSpeicher8: TLabel;
    lbSpeicher3: TLabel;
    lbSpeicher6: TLabel;
    btSpeicher: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btSpeicherClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
  private
    { Private declarations }
    klick: boolean;
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.dfm}

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
   close;
end;

procedure TAboutBox.Label1Click(Sender: TObject);
begin
   ShellExecute(handle, 'open', 'http://www.chrissyx.de.vu/', NIL, NIL, SW_SHOW);
end;

procedure TAboutBox.Label2Click(Sender: TObject);
begin
   ShellExecute(handle, 'open', 'http://www.chrissyx.com/', NIL, NIL, SW_SHOW);
end;

procedure TAboutBox.Label4Click(Sender: TObject);
begin
   ShellExecute(handle, 'open', 'http://www.shareinfo.de.vu/', NIL, NIL, SW_SHOW);
end;

procedure TAboutBox.btSpeicherClick(Sender: TObject);
begin
   if (klick = false) then
   begin
      AboutBox.Width := 500;
      btSpeicher.Caption := 'Speicher <<';
      klick := true;
   end
   else
   begin
      AboutBox.Width := 305;
      btSpeicher.Caption := 'Speicher >>';
      klick := false;
   end;
end;

procedure TAboutBox.FormCreate(Sender: TObject);
var Memory: TMemoryStatus;
begin
   klick := false;
   AboutBox.Width := 305;
   Memory.dwLength := SizeOf(Memory);
   GlobalMemoryStatus(Memory);
   lbSpeicher1.Caption := 'Speicher: ' + IntToStr(Memory.dwTotalPhys div 1048576) + ' MB';
   lbSpeicher2.Caption := 'Freier Speicher: ' + IntToStr(Memory.dwAvailPhys div 1048576) + ' MB';
   lbSpeicher3.Caption := 'Belegter Speicher: ' + IntToStr((Memory.dwTotalPhys - Memory.dwAvailPhys) div 1048576) + ' MB';
   lbspeicher4.Caption := 'Pagefile: ' + IntToStr(Memory.dwTotalPageFile div 1048576) + ' MB';
   lbSpeicher5.Caption := 'Freier Pagefile: ' + IntToStr(Memory.dwAvailPageFile div 1048576) + ' MB';
 //  lbSpeicher6.Caption := 'Belegter Pagefile ' + IntToStr((Memory.dwTotalPhys - Memory.dwAvailPageFile) div 1048576) + ' MB';
   lbSpeicher6.Caption := 'Virtueller: ' + IntToStr(Memory.dwTotalVirtual div 1048576) + ' MB';
   lbSpeicher7.Caption := 'Freier Virueller: ' + IntToStr(Memory.dwAvailVirtual div 1048576) + ' MB';
   lbSpeicher8.Caption := 'Belegter Virtueller: ' + IntToStr((Memory.dwTotalVirtual - Memory.dwAvailVirtual) div 1048576) + ' MB';
end;

end.

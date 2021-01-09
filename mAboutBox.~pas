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
    procedure OKButtonClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
  private
    { Private declarations }
    url: string;
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
   url := 'http://www.chrissyx.de.vu/';
   ShellExecute(handle, 'open', PChar(url), NIL, NIL, SW_SHOW);
end;

procedure TAboutBox.Label2Click(Sender: TObject);
begin
   url := 'http://www.chrissyx.com/';
   ShellExecute(handle, 'open', PChar(url), NIL, NIL, SW_SHOW);
end;

procedure TAboutBox.Label4Click(Sender: TObject);
begin
   url := 'http://www.shareinfo.de.vu/';
   ShellExecute(handle, 'open', PChar(url), NIL, NIL, SW_SHOW);
end;

end.
 

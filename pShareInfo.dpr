program pShareInfo;

uses
  Forms,
  mShareInfo in 'mShareInfo.pas' {ShareInfo},
  BDecode in 'BDecode.pas',
  Hashes in 'Hashes.pas',
  MessageDigests in 'MessageDigests.pas',
  mAboutBox in 'mAboutBox.pas' {AboutBox},
  mOptionen in 'mOptionen.pas' {Optionen},
  mSprache in 'mSprache.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ShareInfo';
  Application.CreateForm(TShareInfo, ShareInfo);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TOptionen, Optionen);
  Application.Run;
end.

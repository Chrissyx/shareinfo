unit mSprache;

interface

procedure ChangeLanguage(index: Integer);

var //Lng Vars
LngNoTracker: string;
LngNoComment: string;
LngNoCreationDate: string;
LngNoFilename: string;
LngFilelength1: PChar;
LngFilelength2: PChar;
LngNoPath1: PChar;
LngNoPath2: PChar;
LngNoInfolength: string;
LngNoInfopart: PChar;
LngNoHash: string;
LngBadTorrent: PChar;
LngNoDatabank: PChar;
LngNoEntry: string;
LngBadeDonkeyLink: PChar;
LngBadSig2DatLink: PChar;
LngInsertLink: PChar;
LngNewVersion: PChar;
LngUpdaten: PChar;
LngNoNewVersion: PChar;
LngHint: PChar;
LngNoHost: PChar;
LngNoSettingsRead: PChar;
LngNoSettingsFound: PChar;
LngRealExit: PChar;
LngQuestion: Pchar;
LngNoSettingsSave: PChar;

implementation

uses mShareInfo, mOptionen, mAboutBox;

procedure ChangeLanguage(index: Integer);
var change: boolean;
begin
   change := False;
   case index of
   0: begin //DEUTSCH / GERMAN / TYSK
         //--------------------------Men�--------------------------//
         ShareInfo.MainMenu1.Items[0].Caption := 'Datei';
         ShareInfo.MainMenu1.Items[0][0].Caption := 'Optionen...';
         ShareInfo.MainMenu1.Items[0][2].Caption := 'Beenden';
         ShareInfo.MainMenu1.Items[2].Caption := 'Hilfe';
         ShareInfo.MainMenu1.Items[2][2].Caption := 'Update Pr�fung';
         //--------------------------Layout--------------------------//
         //ShareInfo
         ShareInfo.Label1.Caption := 'Torrent Datei:';
         ShareInfo.btLaden.Caption := 'Torrent �ffnen...';
         ShareInfo.Label2.Caption := 'Tracker:';
         ShareInfo.cbTrackerOn.Caption := 'On';
         ShareInfo.cbTrackerOff.Caption := 'Off (ggf. Verbindung pr�fen)';
         ShareInfo.Label3.Caption := 'Dateiname:';
         ShareInfo.Label4.Caption := 'Kommentar:';
         ShareInfo.Label6.Caption := 'Datum:';
         ShareInfo.Label18.Caption := 'Gr��e:';
         ShareInfo.Label7.Caption := 'Inhalt:';
         ShareInfo.Label8.Caption := '(Klick f�r';
         ShareInfo.Label9.Caption := 'mehr Infos)';
         ShareInfo.Label10.Caption := 'Dateiname:';
         ShareInfo.Label11.Caption := 'Gr��e:';
         ShareInfo.Label17.Caption := 'Anzahl:';
         ShareInfo.btDonkey.Caption := 'eDonkey Link checken';
         ShareInfo.Label13.Caption := 'Dateiname:';
         ShareInfo.Label15.Caption := 'Gr��e:';
         ShareInfo.Label16.Caption := 'Inhalt:';
         ShareInfo.btSig2Dat.Caption := 'Sig2Dat Link checken';
         ShareInfo.Label22.Caption := 'Dateiname:';
         ShareInfo.Label20.Caption := 'Gr��e';
         ShareInfo.Label23.Caption := 'Inhalt:';
         ShareInfo.Label24.Caption := 'Quellen:';
         ShareInfo.Label25.Caption := 'Verf�gbarkeit:';
         //Optionen
         Optionen.lbSprache.Caption := 'Sprache:';
         Optionen.ComboBox1.Items[0] := 'Deutsch';
         Optionen.ComboBox1.Items[1] := 'Englisch';
         Optionen.ComboBox1.Items[2] := 'Norwegisch';
         Optionen.cbCanClose.Caption := 'Beim Beenden nachfragen?';
         //AboutBox
         Aboutbox.Label4.Caption := 'Unterst�tzt Torrent, eDonkey, Sig2Dat';
         Aboutbox.Label3.Caption := 'ShareInfo nutzt Programmroutinen von BDecode,';
         Aboutbox.Label5.Caption := 'Hashes und MessageDigests.';
         Aboutbox.Label6.Caption := '�bersetzung:';
         Aboutbox.Label7.Caption := 'Deutsch - Chrissyx';
         Aboutbox.Label8.Caption := 'Englisch - Chrissyx';
         Aboutbox.Label9.Caption := 'Norwegisch - Frazzy';         
         //--------------------------Titel--------------------------//
         Optionen.Caption := 'ShareInfo - Optionen';
         AboutBox.Caption := '�ber ShareInfo...';
         //--------------------------Messages--------------------------//
         //ShareInfo         
         LngNoTracker := 'ERROR: Tracker nicht gefunden!';
         LngNoComment := 'ERROR: Komentar nicht gefunden!';
         LngNoCreationDate := 'ERROR: Kein Erstellungsdatum gefunden!';
         LngNoFilename := 'ERROR: Dateiname nicht gefunden!';
         LngFilelength1 := PChar('L�nge der Datei ');
         LngFilelength2 := PChar(' nicht gefunden!');
         LngNoPath1 := PChar('Konnte in Datei ');
         LngNoPath2 := PChar(' kein Pfadsegment finden!');
         LngNoInfolength := 'ERROR: L�nge im Infosegment nicht gefunden!';
         LngNoInfopart := PChar('Konnte Infosegment nicht finden!');
         LngNoHash := 'ERROR: Keine Hash gefunden!';
         LngBadTorrent := PChar('Torrent ist korrupt!');
         LngNoDatabank := PChar('Konnte Online Datenbank nicht abfragen! Bitte Verbindung pr�fen oder sp�ter erneut versuchen!');
         LngNoEntry := 'Kein Eintrag gefunden, ggf. Verbindung pr�fen.';
         LngBadeDonkeyLink := PChar('Ung�ltiger eDonkey Link!');
         LngBadSig2DatLink := PChar('Ung�ltiger Sig2Dat Link!');
         LngInsertLink := PChar('Bitte Link einf�gen!');
         LngNewVersion := PChar('Es ist eine neuere Version verf�gbar!' + char(13) + 'M�chtest Du sie laden?');
         LngUpdaten := PChar('Updaten?');
         LngNoNewVersion := PChar('Es gibt keine neuere Version!');
         LngHint := PChar('Hinweis');
         LngNoHost := PChar('Host nicht erreichbar! Bitte Verbindung pr�fen!');
         LngNoSettingsRead := PChar('Konnte Einstellungen nicht lesen! Standardwerte wurden gesetzt!');
         LngNoSettingsFound := PChar('Konnte Einstellungen nicht finden!');
         LngRealExit := PChar('ShareInfo wirklich beenden?');
         LngQuestion := PChar('Frage');
         //Optionen
         LngNoSettingsSave := PChar('Konnte Einstellungen nicht speichern!');
         change := True;
      end;
   1: begin //ENGLISCH / ENGLISH / ENGELSK
         //--------------------------Menu--------------------------//
         ShareInfo.MainMenu1.Items[0].Caption := 'File';
         ShareInfo.MainMenu1.Items[0][0].Caption := 'Options...';
         ShareInfo.MainMenu1.Items[0][2].Caption := 'Exit';
         ShareInfo.MainMenu1.Items[2].Caption := 'Help';
         ShareInfo.MainMenu1.Items[2][2].Caption := 'Update check';
         //--------------------------Layout--------------------------//
         //ShareInfo
         ShareInfo.Label1.Caption := 'Torrent file:';
         ShareInfo.btLaden.Caption := 'Open Torrent...';
         ShareInfo.Label2.Caption := 'Announce URL:';
         ShareInfo.cbTrackerOn.Caption := 'On';
         ShareInfo.cbTrackerOff.Caption := 'Off (check connection?)';
         ShareInfo.Label3.Caption := 'Filename:';
         ShareInfo.Label4.Caption := 'Comment:';
         ShareInfo.Label6.Caption := 'Date:';
         ShareInfo.Label18.Caption := 'Size:';
         ShareInfo.Label7.Caption := 'Content:';
         ShareInfo.Label8.Caption := '(Click for';
         ShareInfo.Label9.Caption := 'more Info)';
         ShareInfo.Label10.Caption := 'Filename:';
         ShareInfo.Label11.Caption := 'Size:';
         ShareInfo.Label17.Caption := 'Count:';
         ShareInfo.btDonkey.Caption := 'Check eDonkey link';
         ShareInfo.Label13.Caption := 'Filename:';
         ShareInfo.Label15.Caption := 'Size:';
         ShareInfo.Label16.Caption := 'Content:';
         ShareInfo.btSig2Dat.Caption := 'Check Sig2Dat link';
         ShareInfo.Label22.Caption := 'Filename:';
         ShareInfo.Label20.Caption := 'Size:';
         ShareInfo.Label23.Caption := 'Content:';
         ShareInfo.Label24.Caption := 'Sources:';
         ShareInfo.Label25.Caption := 'Availability:';
         //Options
         Optionen.lbSprache.Caption := 'Language:';
         Optionen.ComboBox1.Items[0] := 'German';
         Optionen.ComboBox1.Items[1] := 'English';
         Optionen.ComboBox1.Items[2] := 'Norwegian';
         Optionen.cbCanClose.Caption := 'With exiting ask?';
         //AboutBox
         Aboutbox.Label4.Caption := 'Supports Torrent, eDonkey, Sig2Dat';
         Aboutbox.Label3.Caption := 'ShareInfo uses program routines from BDecode,';
         Aboutbox.Label5.Caption := 'Hashes and MessageDigests.';
         Aboutbox.Label6.Caption := 'Translation:';
         Aboutbox.Label7.Caption := 'German - Chrissyx';
         Aboutbox.Label8.Caption := 'English - Chrissyx';
         Aboutbox.Label9.Caption := 'Norwegian - Frazzy';
         //--------------------------Title--------------------------//
         Optionen.Caption := 'ShareInfo - Options';
         AboutBox.Caption := 'About ShareInfo...';
         //--------------------------Messages--------------------------//
         //ShareInfo
         LngNoTracker := 'ERROR: No tracker found!';
         LngNoComment := 'ERROR: No comment found!';
         LngNoCreationDate := 'ERROR: No creation date found!';
         LngNoFilename := 'ERROR: No filename found!';
         LngFilelength1 := PChar('Filelength of ');
         LngFilelength2 := PChar(' not found!');
         LngNoPath1 := PChar('File ');
         LngNoPath2 := PChar(' contains no path!');
         LngNoInfolength := 'ERROR: No length found in Info part!';
         LngNoInfopart := PChar('No info part found!');
         LngNoHash := 'ERROR: No Hash found!';
         LngBadTorrent := PChar('Torrent is corrupt!');
         LngNoDatabank := PChar('No route to online databank! Please check your connection or try again later!');
         LngNoEntry := 'No Entry found! Check connection?';
         LngBadeDonkeyLink := PChar('No valid eDonkey link!');
         LngBadSig2DatLink := PChar('No valid Sig2Dat link!');
         LngInsertLink := PChar('Please insert link!');
         LngNewVersion := PChar('A new version is available!' + char(13) + 'You want to load it?');
         LngUpdaten := PChar('Update program?');
         LngNoNewVersion := PChar('There is no new version!');
         LngHint := PChar('Hint');
         LngNoHost := PChar('No route to host! Please check your connection!');
         LngNoSettingsRead := PChar('Could not read settings! Using standard settings!');
         LngNoSettingsFound := PChar('Could not locate settings!');
         LngRealExit := PChar('Exit ShareInfo?');
         LngQuestion := PChar('Question');
         //Options
         LngNoSettingsSave := PChar('Could not save settings!');
         change := True;
      end;
   2: begin //NORWEGISCH / NORWEGIAN / NORSK
         //--------------------------Menu--------------------------//
         ShareInfo.MainMenu1.Items[0].Caption := 'Fil';
         ShareInfo.MainMenu1.Items[0][0].Caption := 'Alternativer...';
         ShareInfo.MainMenu1.Items[0][2].Caption := 'Avslutt';
         ShareInfo.MainMenu1.Items[2].Caption := 'Hjelp';
         ShareInfo.MainMenu1.Items[2][2].Caption := 'Sjekk for oppdateringer';
         //--------------------------Layout--------------------------//
         //ShareInfo
         ShareInfo.Label1.Caption := 'Torrent fil:';
         ShareInfo.btLaden.Caption := '�pne Torrent...';
         ShareInfo.Label2.Caption := 'Announce URL:';
         ShareInfo.cbTrackerOn.Caption := 'P�';
         ShareInfo.cbTrackerOff.Caption := 'Av (Sjekk tilkobling?)';
         ShareInfo.Label3.Caption := 'Filnavn:';
         ShareInfo.Label4.Caption := 'Kommentar:';
         ShareInfo.Label6.Caption := 'Dato:';
         ShareInfo.Label18.Caption := 'St�rrelse:';
         ShareInfo.Label7.Caption := 'Innhold:';
         ShareInfo.Label8.Caption := '(Klikk for';
         ShareInfo.Label9.Caption := 'mer Info)';
         ShareInfo.Label10.Caption := 'Filnavn:';
         ShareInfo.Label11.Caption := 'St�rrelse:';
         ShareInfo.Label17.Caption := 'Antall:';
         ShareInfo.btDonkey.Caption := 'Sjekk eDonkey link';
         ShareInfo.Label13.Caption := 'Filnavn:';
         ShareInfo.Label15.Caption := 'St�rrelse:';
         ShareInfo.Label16.Caption := 'Innhold:';
         ShareInfo.btSig2Dat.Caption := 'Sjekk Sig2Dat link';
         ShareInfo.Label22.Caption := 'Filnavn:';
         ShareInfo.Label20.Caption := 'St�rrelse:';
         ShareInfo.Label23.Caption := 'Innhold:';
         ShareInfo.Label24.Caption := 'Sources:'; //TRANSLATE!!!!
         ShareInfo.Label25.Caption := 'Availability:'; //TRANSLATE!!!!
         //Options
         Optionen.lbSprache.Caption := 'Spr�k:';
         Optionen.ComboBox1.Items[0] := 'Tysk';
         Optionen.ComboBox1.Items[1] := 'Engelsk';
         Optionen.ComboBox1.Items[2] := 'Norsk';
         Optionen.cbCanClose.Caption := 'Med avslutnings bedskjed?';
         //AboutBox
         Aboutbox.Label4.Caption := 'St�tter Torrent, eDonkey og Sig2Dat';
         Aboutbox.Label3.Caption := 'ShareInfo bruker program rutiner fra BDecode,';
         Aboutbox.Label5.Caption := 'Hashes og MessageDigests.';
         Aboutbox.Label6.Caption := 'Oversatt av:';
         Aboutbox.Label7.Caption := 'Tysk - Chrissyx';
         Aboutbox.Label8.Caption := 'Engelsk - Chrissyx';
         Aboutbox.Label9.Caption := 'Norsk - Frazzy';
         //--------------------------Title--------------------------//
         Optionen.Caption := 'ShareInfo - Alternativer';
         AboutBox.Caption := 'Om ShareInfo...';
         //--------------------------Messages--------------------------//
         //ShareInfo
         LngNoTracker := 'FEIL: Ingen tracker funnet!';
         LngNoComment := 'FEIL: Ingen kommentar funnet!';
         LngNoCreationDate := 'FEIL: Ingen opprettelse dato funnet!';
         LngNoFilename := 'FEIL: Ingen filnavn funnet!';
         LngFilelength1 := PChar('Fillengde av ');
         LngFilelength2 := PChar(' ikke funnet!');
         LngNoPath1 := PChar('Fil ');
         LngNoPath2 := PChar(' Inneholder ingen bane!');
         LngNoInfolength := 'FEIL: Ingen lengde funnet til info banen!';
         LngNoInfopart := PChar('Ingen info del funnet!');
         LngNoHash := 'FEIL: Ingen Hash funnet!';
         LngBadTorrent := PChar('Torrenten er korrupt!');
         LngNoDatabank := PChar('Ingen bane til databank! Vennligst sjekk din tilkobling, eller pr�v igjen senere!');
         LngNoEntry := 'Ingen adgang funnet! Sjekk din tilkobling?';
         LngBadeDonkeyLink := PChar('Ikke en gyldig eDonkey link!');
         LngBadSig2DatLink := PChar('Ikke en gyldig Sig2Dat link!');
         LngInsertLink := PChar('Vennligst skriv inn link!');
         LngNewVersion := PChar('En ny versjon er tilgjengelig!' + char(13) + 'Vil du laste den ned?');
         LngUpdaten := PChar('Oppdater programm?');
         LngNoNewVersion := PChar('Det er for �yeblikket ingen ny versjon tilgjengelig!');
         LngHint := PChar('Hint');
         LngNoHost := PChar('Ingen bane til vert! Vennligst sjekk din tilkobling!');
         LngNoSettingsRead := PChar('Kunne ikke lese innstillingene! Bruker standard Innstillinger!');
         LngNoSettingsFound := PChar('Kunne ikke finne innstillingene!');
         LngRealExit := PChar('Avslutt ShareInfo?');
         LngQuestion := PChar('Sp�rsm�l');
         //Options
         LngNoSettingsSave := PChar('Kunne ikke lagre innstillingene!');
         change := True;         
      end;
   end;
   if change = False then ChangeLanguage(0);   
end;

end.

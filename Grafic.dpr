program Grafic;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Bilder},
  Windows,
  SysUtils,
  Unit3 in 'Unit3.pas' {Form3},
  Abaut in 'Abaut.pas' {AboutBox},
  Unit4 in 'Unit4.pas' {GraficList: TDataModule},
  Registry,Dialogs;
{$R *.res}



begin
  Application.Initialize;

  //Application.HelpFile:=Unit1.InstallPath+'\HELP.HLP';

  Application.HelpFile := 'Unit1.InstallPath+''\HELP.HLP''';

  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TBilder, Bilder);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TGraficList, GraficList);
  Application.Run;
  

end.

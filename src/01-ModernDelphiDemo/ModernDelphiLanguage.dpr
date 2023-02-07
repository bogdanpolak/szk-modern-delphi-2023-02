program ModernDelphiLanguage;

uses
  Vcl.Forms,
  FormMain in 'FormMain.pas' {FormDemoMain},
  DemoHelper in 'DemoHelper.pas',
  Exercises.Generics in 'Exercises.Generics.pas',
  QueueForm in 'QueueForm.pas' {FormQueue},
  superdate in 'SuperObjects\superdate.pas',
  superobject in 'SuperObjects\superobject.pas',
  supertimezone in 'SuperObjects\supertimezone.pas',
  supertypes in 'SuperObjects\supertypes.pas',
  Exercises.Anonymous in 'Exercises.Anonymous.pas',
  Exercises.Spring4D.Collections in 'Exercises.Spring4D.Collections.pas',
  Exercises.Spring4D.Base in 'Exercises.Spring4D.Base.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormDemoMain, FormDemoMain);
  Application.Run;
end.

unit Unit5; 

// WInFF 1.0 Copyright 2006-2009 Matthew Weatherford
// http://winff.org
// Licensed under the GPL v3 or any later version
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ClipBrd,Buttons, gettext, translations, ExtCtrls;

type

  { TfrmScript }

  TfrmScript = class(TForm)
    btnClip: TButton;
    btnContinue: TButton;
    btnSave: TButton;
    Button1: TButton;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    SaveDialog1: TSaveDialog;
    procedure btnClipClick(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    scriptfilename : string;
  end; 

var
  frmScript: TfrmScript;

Resourcestring
  rsform5='FFmpeg Command Line';
  rsbutton1='OK';
  rsClip='Clipboard';
  rsClip2='Close';
  rsSave='Save';
  rsContinue='Continue';
implementation

uses unit1;

{ TfrmScript }

procedure TfrmScript.FormCreate(Sender: TObject);
begin
TranslateUnitResourceStrings('unit5', PODirectory + 'winff.%s.po', unit1.Lang, unit1.FallbackLang);
  frmScript.Caption:=rsform5;
  button1.Caption:=rsbutton1;
  btnClip.Caption:=rsClip;
  btnSave.Caption:=rsSave;
  btnContinue.Caption:=rsContinue;
  application.processmessages;
  btnSave.Left := btnClip.Left + btnClip.Width + 4;

end;

procedure TfrmScript.btnCloseClick(Sender: TObject);
begin
  frmScript.Close;
end;

procedure TfrmScript.btnClipClick(Sender: TObject);
begin
     Clipboard.AsText:=memo1.text; // can copy just one line, but what if its 2-pass?
     btnClip.Caption := rsClip2;
     application.processmessages;
     sleep(500);
     btnClip.Caption := rsClip;
     application.processmessages;
end;

procedure TfrmScript.btnRunClick(Sender: TObject);
begin
  Memo1.lines.SaveToFile(ScriptFilename);
end;

procedure TfrmScript.btnSaveClick(Sender: TObject);
begin
  If SaveDialog1.execute then
  begin
       memo1.lines.savetofile(SaveDialog1.FileName);

  end;
end;

procedure TfrmScript.FormResize(Sender: TObject);
begin
  if frmScript.Width < 100 then frmScript.width:=100;
  if frmScript.height < 150 then frmScript.height:=150;
  memo1.Height:= frmScript.Height -56;
  memo1.width:= frmScript.width -20;
  // button1 position determined by panels
  // button1.Left:=frmScript.Width div 2 - 36;
  // button1.top:=frmScript.Height-40;
end;

initialization
  {$I unit5.lrs}

end.


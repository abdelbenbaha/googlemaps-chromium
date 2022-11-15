unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uCEFWinControl, uCEFWindowParent,
  uCEFChromiumCore, uCEFChromium,uCEFInterfaces,uCEFTypes;

type
  TfrmEdit = class(TForm)
    grpMaps: TRadioGroup;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    webview: TCEFWindowParent;
    Button1: TButton;
    Button2: TButton;
    Chromium: TChromium;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grpMapsClick(Sender: TObject);
    procedure ChromiumConsoleMessage(Sender: TObject;
      const browser: ICefBrowser; level: Cardinal; const message,
      source: ustring; line: Integer; out Result: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    lat:string;
    lng:string;
  public
    { Public declarations }
  end;

var
  frmEdit: TfrmEdit;

implementation

uses Unit1;

{$R *.dfm}

procedure TfrmEdit.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TfrmEdit.FormShow(Sender: TObject);
var fs:TFileStream;
    html:string;
begin
lat:='';
lng:='';
if FileExists(frmmain.htmlDir+'map.html') then
 with TStringStream.Create('') do
  try
    fs:=TFileStream.Create(frmmain.htmlDir+'map.html',fmOpenRead);
    try
    CopyFrom(fs,fs.Size);
    html:=DataString;
    html:=StringReplace(html,'%API_KEY%',frmmain.edtApi.Text,[]);
    html:=StringReplace(html,'%LAT%',frmmain.edtLat.Text,[]);
    html:=StringReplace(html,'%LNG%',frmmain.edtLong.Text,[]);
    html:=StringReplace(html,'%MAPTYPE%',QuotedStr(mapTypes[grpMaps.Itemindex]),[]);
    Chromium.LoadString(html);
    finally
      fs.Free;
    end;
  finally
   Free;
  end;
end;

procedure TfrmEdit.FormCreate(Sender: TObject);
begin
Chromium.CreateBrowser(webview);
end;

procedure TfrmEdit.grpMapsClick(Sender: TObject);
begin
FormShow(self);
end;

procedure TfrmEdit.ChromiumConsoleMessage(Sender: TObject;
  const browser: ICefBrowser; level: Cardinal; const message,
  source: ustring; line: Integer; out Result: Boolean);
begin
  with TStringList.Create do
   if Pos(',',message)>0 then
    try
    Delimiter:=',';
    DelimitedText:=Copy(message,2,Length(message)-2);
    if count>=2 then
     begin
       lat:=Strings[0];
       lng:=Strings[1];
     end;
    finally
     Free;
    end;
end;

procedure TfrmEdit.Button1Click(Sender: TObject);
begin
  if (lat<>'') and (lng<>'') then
   begin
   frmMain.edtLat.Text:=lat;
   frmMain.edtLong.Text:=lng;
   frmMain.btnLoad.Click;
   close;
   end;
end;

procedure TfrmEdit.FormDestroy(Sender: TObject);
begin
Chromium.CloseAllBrowsers;
end;

end.

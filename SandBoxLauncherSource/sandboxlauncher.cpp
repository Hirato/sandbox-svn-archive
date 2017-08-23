/////////////////////////////////////////////////////////////////////////////
// Name:        sandboxlauncher.cpp
// Purpose:     
// Author:      James Burns
// Modified by: 
// Created:     17/06/2008 23:21:47
// RCS-ID:      
// Copyright:   
// Licence:     
/////////////////////////////////////////////////////////////////////////////

// For compilers that support precompilation, includes "wx/wx.h".
#include "wx/wxprec.h"

#ifdef __BORLANDC__
#pragma hdrstop
#endif

#ifndef WX_PRECOMP
#include "wx/wx.h"
#endif

////@begin includes
////@end includes

#include "sandboxlauncher.h"

////@begin XPM images
////@end XPM images


/*!
 * SandboxLauncher type definition
 */

IMPLEMENT_CLASS( SandboxLauncher, wxFrame )


/*!
 * SandboxLauncher event table definition
 */

BEGIN_EVENT_TABLE( SandboxLauncher, wxFrame )

////@begin SandboxLauncher event table entries
    EVT_BUTTON( ID_BUTTON1, SandboxLauncher::OnButton1Click )

    EVT_BUTTON( ID_BUTTON, SandboxLauncher::OnButtonClick )

    EVT_BUTTON( ID_BUTTON2, SandboxLauncher::OnButton2Click )

////@end SandboxLauncher event table entries

END_EVENT_TABLE()


/*!
 * SandboxLauncher constructors
 */

SandboxLauncher::SandboxLauncher()
{
    Init();
}

SandboxLauncher::SandboxLauncher( wxWindow* parent, wxWindowID id, const wxString& caption, const wxPoint& pos, const wxSize& size, long style )
{
    Init();
    Create( parent, id, caption, pos, size, style );
}


/*!
 * SandboxLauncher creator
 */

bool SandboxLauncher::Create( wxWindow* parent, wxWindowID id, const wxString& caption, const wxPoint& pos, const wxSize& size, long style )
{
////@begin SandboxLauncher creation
    wxFrame::Create( parent, id, caption, pos, size, style );

    CreateControls();
    Centre();
////@end SandboxLauncher creation
    return true;
}


/*!
 * SandboxLauncher destructor
 */

SandboxLauncher::~SandboxLauncher()
{
////@begin SandboxLauncher destruction
////@end SandboxLauncher destruction
}


/*!
 * Member initialisation
 */

void SandboxLauncher::Init()
{
////@begin SandboxLauncher member initialisation
    ComboBox1 = NULL;
    Button1 = NULL;
    ComboBox2 = NULL;
    TextBox5 = NULL;
    ComboBox4 = NULL;
    TextBox1 = NULL;
    ComboBox5 = NULL;
    ComboBox6 = NULL;
    TextBox2 = NULL;
    Button2 = NULL;
    TextBox3 = NULL;
    TextBox4 = NULL;
////@end SandboxLauncher member initialisation
}


/*!
 * Control creation for SandboxLauncher
 */

void SandboxLauncher::CreateControls()
{    
////@begin SandboxLauncher content construction
    SandboxLauncher* itemFrame1 = this;

    wxNotebook* itemNotebook2 = new wxNotebook( itemFrame1, ID_NOTEBOOK, wxDefaultPosition, wxDefaultSize, wxBK_DEFAULT );

    wxPanel* itemPanel3 = new wxPanel( itemNotebook2, ID_PANEL, wxDefaultPosition, wxDefaultSize, wxSUNKEN_BORDER|wxTAB_TRAVERSAL );
    wxFlexGridSizer* itemFlexGridSizer4 = new wxFlexGridSizer(3, 1, 0, 0);
    itemPanel3->SetSizer(itemFlexGridSizer4);

    wxStaticBox* itemStaticBoxSizer5Static = new wxStaticBox(itemPanel3, wxID_ANY, _("Select Display Size"));
    wxStaticBoxSizer* itemStaticBoxSizer5 = new wxStaticBoxSizer(itemStaticBoxSizer5Static, wxHORIZONTAL);
    itemFlexGridSizer4->Add(itemStaticBoxSizer5, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);
    wxFlexGridSizer* itemFlexGridSizer6 = new wxFlexGridSizer(1, 5, 0, 0);
    itemStaticBoxSizer5->Add(itemFlexGridSizer6, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);
    wxArrayString ComboBox1Strings;
    ComboBox1Strings.Add(_("640x480"));
    ComboBox1Strings.Add(_("800x600"));
    ComboBox1Strings.Add(_("1024x768"));
    ComboBox1Strings.Add(_("1280x960"));
    ComboBox1Strings.Add(_("1600x1200"));
    ComboBox1 = new wxComboBox( itemPanel3, ID_COMBOBOX, _("1024x768"), wxDefaultPosition, wxSize(215, -1), ComboBox1Strings, wxCB_READONLY );
    ComboBox1->SetStringSelection(_("1024x768"));
    itemFlexGridSizer6->Add(ComboBox1, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);

    Button1 = new wxButton( itemPanel3, ID_BUTTON1, _("Launch"), wxDefaultPosition, wxDefaultSize, 0 );
    itemFlexGridSizer6->Add(Button1, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);

    wxStaticBox* itemStaticBoxSizer9Static = new wxStaticBox(itemPanel3, wxID_ANY, _("Server"));
    wxStaticBoxSizer* itemStaticBoxSizer9 = new wxStaticBoxSizer(itemStaticBoxSizer9Static, wxHORIZONTAL);
    itemFlexGridSizer4->Add(itemStaticBoxSizer9, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);
    wxFlexGridSizer* itemFlexGridSizer10 = new wxFlexGridSizer(2, 4, 0, 0);
    itemStaticBoxSizer9->Add(itemFlexGridSizer10, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);
    wxStaticBox* itemStaticBoxSizer11Static = new wxStaticBox(itemPanel3, wxID_ANY, _("Players"));
    wxStaticBoxSizer* itemStaticBoxSizer11 = new wxStaticBoxSizer(itemStaticBoxSizer11Static, wxHORIZONTAL);
    itemFlexGridSizer10->Add(itemStaticBoxSizer11, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);
    wxArrayString ComboBox2Strings;
    ComboBox2Strings.Add(_("1"));
    ComboBox2Strings.Add(_("2"));
    ComboBox2Strings.Add(_("3"));
    ComboBox2Strings.Add(_("4"));
    ComboBox2Strings.Add(_("5"));
    ComboBox2Strings.Add(_("6"));
    ComboBox2Strings.Add(_("7"));
    ComboBox2Strings.Add(_("8"));
    ComboBox2Strings.Add(_("9"));
    ComboBox2Strings.Add(_("10"));
    ComboBox2Strings.Add(_("11"));
    ComboBox2Strings.Add(_("12"));
    ComboBox2Strings.Add(_("13"));
    ComboBox2Strings.Add(_("14"));
    ComboBox2Strings.Add(_("15"));
    ComboBox2Strings.Add(_("16"));
    ComboBox2Strings.Add(_("17"));
    ComboBox2Strings.Add(_("18"));
    ComboBox2Strings.Add(_("19"));
    ComboBox2Strings.Add(_("20"));
    ComboBox2Strings.Add(_("21"));
    ComboBox2Strings.Add(_("22"));
    ComboBox2Strings.Add(_("23"));
    ComboBox2Strings.Add(_("24"));
    ComboBox2Strings.Add(_("25"));
    ComboBox2Strings.Add(_("26"));
    ComboBox2Strings.Add(_("27"));
    ComboBox2Strings.Add(_("28"));
    ComboBox2Strings.Add(_("29"));
    ComboBox2Strings.Add(_("30"));
    ComboBox2Strings.Add(_("31"));
    ComboBox2Strings.Add(_("32"));
    ComboBox2 = new wxComboBox( itemPanel3, ID_COMBOBOX1, _("32"), wxDefaultPosition, wxSize(50, -1), ComboBox2Strings, wxCB_READONLY );
    ComboBox2->SetStringSelection(_("32"));
    itemStaticBoxSizer11->Add(ComboBox2, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);

    wxStaticBox* itemStaticBoxSizer13Static = new wxStaticBox(itemPanel3, wxID_ANY, _("Master"));
    wxStaticBoxSizer* itemStaticBoxSizer13 = new wxStaticBoxSizer(itemStaticBoxSizer13Static, wxHORIZONTAL);
    itemFlexGridSizer10->Add(itemStaticBoxSizer13, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);
    TextBox5 = new wxTextCtrl( itemPanel3, ID_TEXTCTRL4, _T(""), wxDefaultPosition, wxSize(35, -1), 0 );
    itemStaticBoxSizer13->Add(TextBox5, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);

    wxStaticBox* itemStaticBoxSizer15Static = new wxStaticBox(itemPanel3, wxID_ANY, _("MMode"));
    wxStaticBoxSizer* itemStaticBoxSizer15 = new wxStaticBoxSizer(itemStaticBoxSizer15Static, wxHORIZONTAL);
    itemFlexGridSizer10->Add(itemStaticBoxSizer15, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);
    wxArrayString ComboBox4Strings;
    ComboBox4Strings.Add(_("Y"));
    ComboBox4Strings.Add(_("N"));
    ComboBox4 = new wxComboBox( itemPanel3, ID_COMBOBOX3, _("N"), wxDefaultPosition, wxSize(45, -1), ComboBox4Strings, wxCB_READONLY );
    ComboBox4->SetStringSelection(_("N"));
    itemStaticBoxSizer15->Add(ComboBox4, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);

    wxStaticBox* itemStaticBoxSizer17Static = new wxStaticBox(itemPanel3, wxID_ANY, _("Server Name"));
    wxStaticBoxSizer* itemStaticBoxSizer17 = new wxStaticBoxSizer(itemStaticBoxSizer17Static, wxHORIZONTAL);
    itemFlexGridSizer10->Add(itemStaticBoxSizer17, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);
    TextBox1 = new wxTextCtrl( itemPanel3, ID_TEXTCTRL, _("Sandbox Server"), wxDefaultPosition, wxSize(70, -1), 0 );
    itemStaticBoxSizer17->Add(TextBox1, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);

    wxStaticBox* itemStaticBoxSizer19Static = new wxStaticBox(itemPanel3, wxID_ANY, _("BandWidth"));
    wxStaticBoxSizer* itemStaticBoxSizer19 = new wxStaticBoxSizer(itemStaticBoxSizer19Static, wxHORIZONTAL);
    itemFlexGridSizer10->Add(itemStaticBoxSizer19, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);
    wxArrayString ComboBox5Strings;
    ComboBox5 = new wxComboBox( itemPanel3, ID_COMBOBOX4, _T(""), wxDefaultPosition, wxSize(50, -1), ComboBox5Strings, wxCB_READONLY );
    itemStaticBoxSizer19->Add(ComboBox5, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);

    wxStaticBox* itemStaticBoxSizer21Static = new wxStaticBox(itemPanel3, wxID_ANY, _("Dedicated"));
    wxStaticBoxSizer* itemStaticBoxSizer21 = new wxStaticBoxSizer(itemStaticBoxSizer21Static, wxHORIZONTAL);
    itemFlexGridSizer10->Add(itemStaticBoxSizer21, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);
    wxArrayString ComboBox6Strings;
    ComboBox6Strings.Add(_("Y"));
    ComboBox6Strings.Add(_("N"));
    ComboBox6 = new wxComboBox( itemPanel3, ID_COMBOBOX5, _("N"), wxDefaultPosition, wxSize(45, -1), ComboBox6Strings, wxCB_READONLY );
    ComboBox6->SetStringSelection(_("N"));
    itemStaticBoxSizer21->Add(ComboBox6, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);

    wxStaticBox* itemStaticBoxSizer23Static = new wxStaticBox(itemPanel3, wxID_ANY, _("Password"));
    wxStaticBoxSizer* itemStaticBoxSizer23 = new wxStaticBoxSizer(itemStaticBoxSizer23Static, wxHORIZONTAL);
    itemFlexGridSizer10->Add(itemStaticBoxSizer23, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);
    TextBox2 = new wxTextCtrl( itemPanel3, ID_TEXTCTRL1, _T(""), wxDefaultPosition, wxSize(40, -1), 0 );
    itemStaticBoxSizer23->Add(TextBox2, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);

    Button2 = new wxButton( itemPanel3, ID_BUTTON, _("Launch"), wxDefaultPosition, wxDefaultSize, 0 );
    itemFlexGridSizer10->Add(Button2, 0, wxALIGN_LEFT|wxALIGN_CENTER_VERTICAL|wxALL, 5);

    wxStaticBox* itemStaticBoxSizer26Static = new wxStaticBox(itemPanel3, wxID_ANY, _("Client"));
    wxStaticBoxSizer* itemStaticBoxSizer26 = new wxStaticBoxSizer(itemStaticBoxSizer26Static, wxHORIZONTAL);
    itemFlexGridSizer4->Add(itemStaticBoxSizer26, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);
    wxFlexGridSizer* itemFlexGridSizer27 = new wxFlexGridSizer(1, 3, 0, 0);
    itemStaticBoxSizer26->Add(itemFlexGridSizer27, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);
    wxStaticBox* itemStaticBoxSizer28Static = new wxStaticBox(itemPanel3, wxID_ANY, _("IP Address"));
    wxStaticBoxSizer* itemStaticBoxSizer28 = new wxStaticBoxSizer(itemStaticBoxSizer28Static, wxHORIZONTAL);
    itemFlexGridSizer27->Add(itemStaticBoxSizer28, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);
    TextBox3 = new wxTextCtrl( itemPanel3, ID_TEXTCTRL2, _("192.168.1.100"), wxDefaultPosition, wxSize(100, -1), 0 );
    itemStaticBoxSizer28->Add(TextBox3, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);

    wxStaticBox* itemStaticBoxSizer30Static = new wxStaticBox(itemPanel3, wxID_ANY, _("Password"));
    wxStaticBoxSizer* itemStaticBoxSizer30 = new wxStaticBoxSizer(itemStaticBoxSizer30Static, wxHORIZONTAL);
    itemFlexGridSizer27->Add(itemStaticBoxSizer30, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);
    TextBox4 = new wxTextCtrl( itemPanel3, ID_TEXTCTRL3, _T(""), wxDefaultPosition, wxSize(65, -1), 0 );
    itemStaticBoxSizer30->Add(TextBox4, 0, wxALIGN_CENTER_VERTICAL|wxALL, 5);

    wxButton* itemButton32 = new wxButton( itemPanel3, ID_BUTTON2, _("Launch"), wxDefaultPosition, wxDefaultSize, 0 );
    itemFlexGridSizer27->Add(itemButton32, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL|wxALL, 5);

    itemNotebook2->AddPage(itemPanel3, _("Sandbox"));

////@end SandboxLauncher content construction
    curWidth = wxSystemSettings::GetMetric(wxSYS_SCREEN_X);
    curHeight = wxSystemSettings::GetMetric(wxSYS_SCREEN_Y);
    wxSprintf(msg,"%dx%d",curWidth,curHeight);
    ComboBox1->Append(msg);
    ComboBox1->SetValue(msg);
    pid = 0;
}


/*!
 * Should we show tooltips?
 */

bool SandboxLauncher::ShowToolTips()
{
    return true;
}

/*!
 * Get bitmap resources
 */

wxBitmap SandboxLauncher::GetBitmapResource( const wxString& name )
{
    // Bitmap retrieval
////@begin SandboxLauncher bitmap retrieval
    wxUnusedVar(name);
    return wxNullBitmap;
////@end SandboxLauncher bitmap retrieval
}

/*!
 * Get icon resources
 */

wxIcon SandboxLauncher::GetIconResource( const wxString& name )
{
    // Icon retrieval
////@begin SandboxLauncher icon retrieval
    wxUnusedVar(name);
    return wxNullIcon;
////@end SandboxLauncher icon retrieval
}

/*!
 * wxEVT_COMMAND_BUTTON_CLICKED event handler for ID_BUTTON1
 */

void SandboxLauncher::OnButton1Click( wxCommandEvent& event )
{
    //wxMessageBox(wxT("blah"));
    //if(!myproc->Exists(pid))
    //{
        if(ComboBox1->GetValue().IsSameAs(wxT("640x480")))
            { finWidth = 640; finHeight = 480; }
        if(ComboBox1->GetValue().IsSameAs(wxT("800x600")))
            { finWidth = 800; finHeight = 600; }
        if(ComboBox1->GetValue().IsSameAs(wxT("1024x768")))
            { finWidth = 1024; finHeight = 768; }
        if(ComboBox1->GetValue().IsSameAs(wxT("1280x960")))
            { finWidth = 1280; finHeight = 960; }
        if(ComboBox1->GetValue().IsSameAs(wxT("1600x1200")))
            { finWidth = 1600; finHeight = 1200; }
        if(ComboBox1->GetValue().IsSameAs(msg))
            { finWidth = curWidth; finHeight = curHeight; }
            
        #ifdef __WIN32__
            wxSprintf(res,wxT("bin\\sandbox.exe -r -w%d -h%d"),finWidth,finHeight);
        #endif
        #ifdef __UNIX__
            wxSprintf(res,wxT(".//bin//sandbox_client -r -w%d -h%d"),finWidth,finHeight);
        #endif
        myproc = myproc->Open(res,wxEXEC_ASYNC);
        pid = myproc->GetPid();
    //}
////@begin wxEVT_COMMAND_BUTTON_CLICKED event handler for ID_BUTTON1 in SandboxLauncher.
    // Before editing this code, remove the block markers.
    event.Skip();
////@end wxEVT_COMMAND_BUTTON_CLICKED event handler for ID_BUTTON1 in SandboxLauncher. 
}

/*!
 * wxEVT_COMMAND_BUTTON_CLICKED event handler for ID_BUTTON
 */

void SandboxLauncher::OnButtonClick( wxCommandEvent& event )
{
    //if(!smyproc->Exists(spid))
    //{
        wxString mystr;
        #ifdef __WIN32__
            mystr.Append(wxT("bin\\sandbox.exe "));
        #endif
        #ifdef __UNIX__
            mystr.Append(wxT(".//bin//sandbox_server "));
        #endif

        if(ComboBox1->GetValue().IsSameAs(wxT("640x480")))
            { finWidth = 640; finHeight = 480; }
        if(ComboBox1->GetValue().IsSameAs(wxT("800x600")))
            { finWidth = 800; finHeight = 600; }
        if(ComboBox1->GetValue().IsSameAs(wxT("1024x768")))
            { finWidth = 1024; finHeight = 768; }
        if(ComboBox1->GetValue().IsSameAs(wxT("1280x960")))
            { finWidth = 1280; finHeight = 960; }
        if(ComboBox1->GetValue().IsSameAs(wxT("1600x1200")))
            { finWidth = 1600; finHeight = 1200; }
        if(ComboBox1->GetValue().IsSameAs(msg))
            { finWidth = curWidth; finHeight = curHeight; }
        
        wxSprintf(res,wxT("-w%d -h%d"),finWidth,finHeight);
        mystr.Append(res);
        mystr.Append(wxT(" "));
        
        if(ComboBox6->GetValue().IsSameAs(wxT("Y")));
            mystr.Append(wxT("-d"));
            
        mystr.Append(wxT(" "));
        mystr.Append(wxT("-c"));
        mystr.Append(ComboBox2->GetValue());
        mystr.Append(wxT(" "));
        if(!TextBox5->GetValue().IsSameAs(wxT("")))
        {
            mystr.Append(wxT("-m"));
            mystr.Append(wxT("\""));
            mystr.Append(TextBox5->GetValue());
            mystr.Append(wxT("\""));
        }
        mystr.Append(wxT(" "));
        if(ComboBox4->GetValue().IsSameAs(wxT("Y")))
            mystr.Append(wxT("-o0"));
        else
            mystr.Append(wxT("-o1"));
        mystr.Append(wxT(" "));
        if(!TextBox1->GetValue().IsSameAs(wxT("")))
        {
            mystr.Append(wxT("-n"));
            mystr.Append(wxT("\""));
            mystr.Append(TextBox1->GetValue());
            mystr.Append(wxT("\""));
        }
        mystr.Append(wxT(" "));
        if(!TextBox2->GetValue().IsSameAs(wxT("")))
        {
            mystr.Append(wxT("-p"));
            mystr.Append(wxT("\""));
            mystr.Append(TextBox2->GetValue());
            mystr.Append(wxT("\""));
        }
        //mystr.Append(ComboBox5->GetValue());
        //mystr.Append(wxT(" "));

        smyproc = smyproc->Open(mystr,wxEXEC_ASYNC);
        spid = smyproc->GetPid();
    //}
    
////@begin wxEVT_COMMAND_BUTTON_CLICKED event handler for ID_BUTTON in SandboxLauncher.
    // Before editing this code, remove the block markers.
    event.Skip();
////@end wxEVT_COMMAND_BUTTON_CLICKED event handler for ID_BUTTON in SandboxLauncher. 
}


/*!
 * wxEVT_COMMAND_BUTTON_CLICKED event handler for ID_BUTTON2
 */

void SandboxLauncher::OnButton2Click( wxCommandEvent& event )
{
    //if(!myproc->Exists(pid))
    //{
        wxString mystr;
        #ifdef __WIN32__
            mystr.Append(wxT("bin\\sandbox.exe -r "));
        #endif
        #ifdef __UNIX__
            mystr.Append(wxT(".//bin//sandbox_client -r "));
        #endif

        if(ComboBox1->GetValue().IsSameAs(wxT("640x480")))
            { finWidth = 640; finHeight = 480; }
        if(ComboBox1->GetValue().IsSameAs(wxT("800x600")))
            { finWidth = 800; finHeight = 600; }
        if(ComboBox1->GetValue().IsSameAs(wxT("1024x768")))
            { finWidth = 1024; finHeight = 768; }
        if(ComboBox1->GetValue().IsSameAs(wxT("1280x960")))
            { finWidth = 1280; finHeight = 960; }
        if(ComboBox1->GetValue().IsSameAs(wxT("1600x1200")))
            { finWidth = 1600; finHeight = 1200; }
        if(ComboBox1->GetValue().IsSameAs(msg))
            { finWidth = curWidth; finHeight = curHeight; }
            
        wxSprintf(res,wxT("-w%d -h%d"),finWidth,finHeight);
        mystr.Append(res);
        
        mystr.Append(wxT(" "));
        mystr.Append(wxT("-x"));
        mystr.Append(wxT("\"sleep 1000 [ connect "));
        mystr.Append(TextBox3->GetValue());
        mystr.Append(wxT(" ] "));
        if(!TextBox4->GetValue().IsSameAs(wxT("")))
        {
            mystr.Append(wxT("[ setmaster "));
            mystr.Append(TextBox4->GetValue());
            mystr.Append(wxT(" ] "));
        }
        mystr.Append(wxT("\""));
        myproc = myproc->Open(mystr,wxEXEC_ASYNC);
        pid = myproc->GetPid();
    //}
////@begin wxEVT_COMMAND_BUTTON_CLICKED event handler for ID_BUTTON2 in SandboxLauncher.
    // Before editing this code, remove the block markers.
    event.Skip();
////@end wxEVT_COMMAND_BUTTON_CLICKED event handler for ID_BUTTON2 in SandboxLauncher. 
}

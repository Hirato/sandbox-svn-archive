/////////////////////////////////////////////////////////////////////////////
// Name:        sandboxlauncher.h
// Purpose:     
// Author:      James Burns
// Modified by: 
// Created:     17/06/2008 23:21:47
// RCS-ID:      
// Copyright:   
// Licence:     
/////////////////////////////////////////////////////////////////////////////

#ifndef _SANDBOXLAUNCHER_H_
#define _SANDBOXLAUNCHER_H_


/*!
 * Includes
 */

////@begin includes
#include "wx/frame.h"
#include "wx/notebook.h"
////@end includes
#include "wx/process.h"

/*!
 * Forward declarations
 */

////@begin forward declarations
////@end forward declarations

/*!
 * Control identifiers
 */

////@begin control identifiers
#define ID_SANDBOXLAUNCHER 10000
#define ID_NOTEBOOK 10001
#define ID_PANEL 10002
#define ID_COMBOBOX 10008
#define ID_BUTTON1 10009
#define ID_COMBOBOX1 10003
#define ID_TEXTCTRL4 10004
#define ID_COMBOBOX3 10005
#define ID_TEXTCTRL 10006
#define ID_COMBOBOX4 10007
#define ID_COMBOBOX5 10010
#define ID_TEXTCTRL1 10011
#define ID_BUTTON 10012
#define ID_TEXTCTRL2 10013
#define ID_TEXTCTRL3 10014
#define ID_BUTTON2 10015
#define SYMBOL_SANDBOXLAUNCHER_STYLE wxCAPTION|wxRESIZE_BORDER|wxSYSTEM_MENU|wxCLOSE_BOX
#define SYMBOL_SANDBOXLAUNCHER_TITLE _("Sandbox Launcher")
#define SYMBOL_SANDBOXLAUNCHER_IDNAME ID_SANDBOXLAUNCHER
#define SYMBOL_SANDBOXLAUNCHER_SIZE wxSize(360, 400)
#define SYMBOL_SANDBOXLAUNCHER_POSITION wxDefaultPosition
////@end control identifiers
#define ID_TIMER1 10100

/*!
 * SandboxLauncher class declaration
 */

class SandboxLauncher: public wxFrame
{    
    DECLARE_CLASS( SandboxLauncher )
    DECLARE_EVENT_TABLE()

public:
    /// Constructors
    SandboxLauncher();
    SandboxLauncher( wxWindow* parent, wxWindowID id = SYMBOL_SANDBOXLAUNCHER_IDNAME, const wxString& caption = SYMBOL_SANDBOXLAUNCHER_TITLE, const wxPoint& pos = SYMBOL_SANDBOXLAUNCHER_POSITION, const wxSize& size = SYMBOL_SANDBOXLAUNCHER_SIZE, long style = SYMBOL_SANDBOXLAUNCHER_STYLE );

    bool Create( wxWindow* parent, wxWindowID id = SYMBOL_SANDBOXLAUNCHER_IDNAME, const wxString& caption = SYMBOL_SANDBOXLAUNCHER_TITLE, const wxPoint& pos = SYMBOL_SANDBOXLAUNCHER_POSITION, const wxSize& size = SYMBOL_SANDBOXLAUNCHER_SIZE, long style = SYMBOL_SANDBOXLAUNCHER_STYLE );

    /// Destructor
    ~SandboxLauncher();

    /// Initialises member variables
    void Init();

    /// Creates the controls and sizers
    void CreateControls();

////@begin SandboxLauncher event handler declarations

    /// wxEVT_COMMAND_BUTTON_CLICKED event handler for ID_BUTTON1
    void OnButton1Click( wxCommandEvent& event );

    /// wxEVT_COMMAND_BUTTON_CLICKED event handler for ID_BUTTON
    void OnButtonClick( wxCommandEvent& event );

    /// wxEVT_COMMAND_BUTTON_CLICKED event handler for ID_BUTTON2
    void OnButton2Click( wxCommandEvent& event );

////@end SandboxLauncher event handler declarations

////@begin SandboxLauncher member function declarations

    /// Retrieves bitmap resources
    wxBitmap GetBitmapResource( const wxString& name );

    /// Retrieves icon resources
    wxIcon GetIconResource( const wxString& name );
////@end SandboxLauncher member function declarations

    /// Should we show tooltips?
    static bool ShowToolTips();

////@begin SandboxLauncher member variables
    wxComboBox* ComboBox1;
    wxButton* Button1;
    wxComboBox* ComboBox2;
    wxTextCtrl* TextBox5;
    wxComboBox* ComboBox4;
    wxTextCtrl* TextBox1;
    wxComboBox* ComboBox5;
    wxComboBox* ComboBox6;
    wxTextCtrl* TextBox2;
    wxButton* Button2;
    wxTextCtrl* TextBox3;
    wxTextCtrl* TextBox4;
////@end SandboxLauncher member variables
    wxSystemSettings Screen;
    char msg[50];
    char res[50];
    int curWidth,curHeight;
    int finWidth, finHeight;
    int pid;
    int spid;
    wxProcess* myproc;
    wxProcess* smyproc;
};

#endif
    // _SANDBOXLAUNCHER_H_

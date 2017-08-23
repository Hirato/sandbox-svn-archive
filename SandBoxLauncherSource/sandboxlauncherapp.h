/////////////////////////////////////////////////////////////////////////////
// Name:        sandboxlauncherapp.h
// Purpose:     
// Author:      James Burns
// Modified by: 
// Created:     17/06/2008 20:22:13
// RCS-ID:      
// Copyright:   
// Licence:     
/////////////////////////////////////////////////////////////////////////////

#ifndef _SANDBOXLAUNCHERAPP_H_
#define _SANDBOXLAUNCHERAPP_H_


/*!
 * Includes
 */

////@begin includes
#include "wx/image.h"
#include "sandboxlauncher.h"
////@end includes

/*!
 * Forward declarations
 */

////@begin forward declarations
////@end forward declarations

/*!
 * Control identifiers
 */

////@begin control identifiers
////@end control identifiers

/*!
 * SandBoxLauncherApp class declaration
 */

class SandBoxLauncherApp: public wxApp
{    
    DECLARE_CLASS( SandBoxLauncherApp )
    DECLARE_EVENT_TABLE()

public:
    /// Constructor
    SandBoxLauncherApp();

    void Init();

    /// Initialises the application
    virtual bool OnInit();

    /// Called on exit
    virtual int OnExit();

////@begin SandBoxLauncherApp event handler declarations

////@end SandBoxLauncherApp event handler declarations

////@begin SandBoxLauncherApp member function declarations

////@end SandBoxLauncherApp member function declarations

////@begin SandBoxLauncherApp member variables
////@end SandBoxLauncherApp member variables
};

/*!
 * Application instance declaration 
 */

////@begin declare app
DECLARE_APP(SandBoxLauncherApp)
////@end declare app

#endif
    // _SANDBOXLAUNCHERAPP_H_

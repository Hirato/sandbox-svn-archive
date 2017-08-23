/////////////////////////////////////////////////////////////////////////////
// Name:        sandboxlauncherapp.cpp
// Purpose:     
// Author:      James Burns
// Modified by: 
// Created:     17/06/2008 20:22:13
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

#include "sandboxlauncherapp.h"

////@begin XPM images
////@end XPM images


/*!
 * Application instance implementation
 */

////@begin implement app
IMPLEMENT_APP( SandBoxLauncherApp )
////@end implement app


/*!
 * SandBoxLauncherApp type definition
 */

IMPLEMENT_CLASS( SandBoxLauncherApp, wxApp )


/*!
 * SandBoxLauncherApp event table definition
 */

BEGIN_EVENT_TABLE( SandBoxLauncherApp, wxApp )

////@begin SandBoxLauncherApp event table entries
////@end SandBoxLauncherApp event table entries

END_EVENT_TABLE()


/*!
 * Constructor for SandBoxLauncherApp
 */

SandBoxLauncherApp::SandBoxLauncherApp()
{
    Init();
}


/*!
 * Member initialisation
 */

void SandBoxLauncherApp::Init()
{
////@begin SandBoxLauncherApp member initialisation
////@end SandBoxLauncherApp member initialisation
}

/*!
 * Initialisation for SandBoxLauncherApp
 */

bool SandBoxLauncherApp::OnInit()
{    
////@begin SandBoxLauncherApp initialisation
	// Remove the comment markers above and below this block
	// to make permanent changes to the code.

#if wxUSE_XPM
	wxImage::AddHandler(new wxXPMHandler);
#endif
#if wxUSE_LIBPNG
	wxImage::AddHandler(new wxPNGHandler);
#endif
#if wxUSE_LIBJPEG
	wxImage::AddHandler(new wxJPEGHandler);
#endif
#if wxUSE_GIF
	wxImage::AddHandler(new wxGIFHandler);
#endif
	SandboxLauncher* mainWindow = new SandboxLauncher( NULL );
	mainWindow->Show(true);
////@end SandBoxLauncherApp initialisation

    return true;
}


/*!
 * Cleanup for SandBoxLauncherApp
 */

int SandBoxLauncherApp::OnExit()
{    
////@begin SandBoxLauncherApp cleanup
	return wxApp::OnExit();
////@end SandBoxLauncherApp cleanup
}


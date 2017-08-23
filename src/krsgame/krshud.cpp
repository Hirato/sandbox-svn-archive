#include "krsgame.h"
#include "engine.h"

namespace game
{
	VARP(metertype, 0, 0, 1);

	void quad(int x, int y, int xs, int ys)
	{
		gle::begin(GL_TRIANGLE_STRIP);
		gle::attribf(x,    y);    gle::attribf(0, 0);
		gle::attribf(x+xs, y);    gle::attribf(1, 0);
		gle::attribf(x,    y+ys); gle::attribf(0, 1);
		gle::attribf(x+xs, y+ys); gle::attribf(1, 1);
		gle::end();
	}

	void gameplayhud(int w, int h)
	{
		float scale = min(w / 1600.0f, h / 1200.0f);
		pushhudmatrix();
		hudmatrix.scale(scale, scale, 1);
		flushhudmatrix();

		gle::defvertex(2);
		gle::deftexcoord0();
		gle::colorf(1, 1, 1);

		float right = w / scale, bottom = h / scale;

		if(thirdperson)
		{
			/*apply meter based on meter type selection*/
			if(metertype == 0)
				settexture("data/krs/hud/meter_km", 3);
			else if(metertype == 1)
				settexture("data/krs/hud/meter_mph", 3);

			quad(right-512, bottom-512, 512, 512);

			/*apply needel to meter*/
			settexture("data/krs/hud/needle", 3);

			const static vec2 coords[4] = {vec2(0, 1), vec2(1, 1), vec2(0, 0), vec2(1, 0)};
			vec points[4] = { vec(-32, -40, 0), vec(32, -40, 0), vec(-32, 216, 0), vec(32, 216, 0)};
			float angle = (player1->vel.magnitude() * 170.0f / 250.0f ) + 60;

			loopi(4) points[i].rotate_around_z(angle * RAD);

			gle::begin(GL_TRIANGLE_STRIP);
			loopi(4)
			{
				gle::attribf(right - 256 + points[i].x, bottom - 256 + points[i].y);
				gle::attrib(coords[i]);
			}
			gle::end();
		}

		pophudmatrix();
	}

	const char *defaultcrosshair(int index)
	{
		return editmode ? "packages/crosshairs/edit" : "packages/crosshairs/empty";
	}

	int selectcrosshair(float &r, float &g, float &b)
	{
		r = b = 0.5;
		g = 1.0f;
		return editmode;
	}
}

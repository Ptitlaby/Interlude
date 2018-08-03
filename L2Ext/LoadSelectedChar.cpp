#include "StdAfx.h"
#include "Packets.h"
#include "SubStack.h"

void CPacketFix::LoadCharSelectedPacket(CUserSocket *pSocket, const char *format, ...)
{
	CPacket packet;
	va_list va;
	va_start(va, format);
/* c */packet.WriteC(va_arg(va, unsigned char));
/* S */packet.WriteS(va_arg(va, PWCHAR));
		UINT charId = va_arg(va, UINT);
/* d */packet.WriteD(charId);
/* S */packet.WriteS(va_arg(va, PWCHAR)); // title
/* d */packet.WriteD(va_arg(va, UINT)); //session
/* d */packet.WriteD(va_arg(va, UINT)); //clan id
/* d */packet.WriteD(va_arg(va, UINT)); // ??
/* d */packet.WriteD(va_arg(va, UINT)); //sex
/* d */packet.WriteD(va_arg(va, UINT)); //race

		UINT baseClass = va_arg(va, UINT);
		if(g_SubStack.IsEnabled())
		{
			UINT charIndex = UINT_MAX;
			for(UINT n=0;n<7;n++)
			{
				if(pSocket->characterDBID[n] == charId)
				{
					charIndex = n;
					break;
				}
			}
			if(charIndex != UINT_MAX && charIndex < 7)
			{
				if(pSocket->pED->baseClass[charIndex] != UINT_MAX)
				{
					baseClass = pSocket->pED->baseClass[charIndex];
				}
			}
		}

/* d */packet.WriteD(baseClass);

/* d */packet.WriteD(va_arg(va, UINT)); // active?
/* d */packet.WriteD(va_arg(va, UINT)); //x
/* d */packet.WriteD(va_arg(va, UINT)); //y
/* d */packet.WriteD(va_arg(va, UINT)); //z

/* f */packet.WriteF(va_arg(va, double)); // cur hp
/* f */packet.WriteF(va_arg(va, double)); // cur mp
/* d */packet.WriteD(va_arg(va, UINT)); //sp
/* d */packet.WriteQ(va_arg(va, UINT)); //exp
/* d */packet.WriteD(va_arg(va, UINT)); //level
/* d */packet.WriteD(va_arg(va, UINT)); //karma
/* d */packet.WriteD(va_arg(va, UINT)); //?

// stats like str,dex
/* d */packet.WriteD(va_arg(va, UINT));
/* d */packet.WriteD(va_arg(va, UINT));
/* d */packet.WriteD(va_arg(va, UINT));
/* d */packet.WriteD(va_arg(va, UINT));
/* d */packet.WriteD(va_arg(va, UINT));
/* d */packet.WriteD(va_arg(va, UINT));

	for (int i = 0; i < 30; i++)
	{
	/* d */packet.WriteD(va_arg(va, UINT));
	}

/* d */packet.WriteD(va_arg(va, UINT)); //?
/* d */packet.WriteD(va_arg(va, UINT)); //?

/* d */UINT nTime = (va_arg(va, UINT));
		packet.WriteD(L2Server::GetL2Time());

/* d */packet.WriteD(va_arg(va, UINT)); //?

/*BuffSize*/ UINT nBuffSize = va_arg(va, UINT);
/*b*/ char *szPrivilege = va_arg(va, char*);
		//packet.WriteD(0);
/* d */packet.WriteD(va_arg(va, UINT));
/* d */packet.WriteD(va_arg(va, UINT));
/* d */packet.WriteD(va_arg(va, UINT));
/* d */packet.WriteD(va_arg(va, UINT));
/* d */packet.WriteD(va_arg(va, UINT));
	va_end(va);
	pSocket->Send("b", packet.GetSize(), packet.GetBuff());
}
#include "StdAfx.h"
#include "AntiDDoS.h"
#include "CursedWeaponSystem.h"
#include "PacketHandler.h"
#include "TvT.h"
#include "SocketLimiter.h"
#include "AutoAnnounce.h"
#include "DnN.h"
#include "VoteSystem.h"
#include "FractionSystem.h"
#include "ObsceneFilter.h"
#include "SchemeBuffer.h"
#include "DuelSystem.h"
#include "Auction.h"
#include "VisualArmor.h"
#include "DB.h"
#include "RaidBossStatus.h"
#include "CastleSiegeManager.h"
#include "PKPvPStatus.h"
#include "DailyPvP.h"
#include "ChatManager.h"
#include "DBNpcMaker.h"
#include "ClanPvPStatus.h"

#pragma optimize("", off)

void CL2Time::Initialize()
{
	g_HookManager.WriteMemoryDWORD(0xA10180, (DWORD)CL2Time::TimerExpired);
}

void CL2Time::TimerExpired(CL2Time* pL2Time, int nID)
{
	VIRTUALIZER_TIGER_WHITE_START;
	guard;

	typedef void (*f)(CL2Time*, int);
	f(0x0064AB70L)(pL2Time, nID);

	unguard;
	VIRTUALIZER_TIGER_WHITE_END;
}


#pragma optimize("", on)

CL2Time::CL2Time()
{
	pInstance = (CL2Time*)0x6F8E3A0;
}

CL2Time::~CL2Time()
{

}

void CL2Time::Init()
{
	typedef void(*f)(CL2Time*);
	f(0x646130L)(pInstance);
}

long int CL2Time::GetTime()
{
	typedef long int (*f)(CL2Time*);
	return f(0x646E90L)(pInstance);
}

bool CL2Time::IsNight()
{
	typedef bool(*f)(CL2Time*);
	return f(0x646DC0L)(pInstance);
}

void CL2Time::SetTime(UINT nTime)
{
	typedef void(*f)(INT64, UINT);
	f(0x646FD0)(0x6F8E3A0, nTime);
}
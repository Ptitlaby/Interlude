#include "StdAfx.h"
#include "Packets.h"
#include "AccountDB.h"
#include "SocketDB.h"

extern INT32 g_AntiBotVersion;

void CPacketFix::CharSelectInfoFix(CUserSocket *pSocket, const char *szFormat, BYTE bOpCode, DWORD dwCharNum, DWORD dwPacketSize, PUCHAR pOldPacket)
{
	if(dwCharNum<=0)
		pSocket->Send(szFormat, bOpCode, dwCharNum, dwPacketSize, pOldPacket);
	else if (pSocket && pOldPacket)
	{
		g_AccountDB.Add(pSocket->accountId, pSocket);

		CPacket OldPacket(pOldPacket);
		CPacket NewPacket;
		for(unsigned int n=0;n<dwCharNum; n++)
		{
			/*S*/ NewPacket.WriteS(OldPacket.ReadS());
				int nCharID = OldPacket.ReadD();
			/*d*/ NewPacket.WriteD(nCharID);
			/*S*/ NewPacket.WriteS(OldPacket.ReadS());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
					UINT baseClass = OldPacket.ReadD();
					pSocket->pED->baseClass[n] = baseClass;
			/*d*/ NewPacket.WriteD(baseClass);	//base class

			/*d*/ NewPacket.WriteD(OldPacket.ReadD());	//active
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());	//x
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());	//y
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());	//z
			/*f*/ NewPacket.WriteF(OldPacket.ReadF());	//cur hp
			/*f*/ NewPacket.WriteF(OldPacket.ReadF());	//cur mp
			/*d*/ NewPacket.WriteD(OldPacket.ReadD()); // sp
			/*Q*/ INT32 nExp = OldPacket.ReadD();
				NewPacket.WriteQ(CL2LevelUP::GetExperience(nExp));
			/*d*/ NewPacket.WriteD(OldPacket.ReadD()); // level

			/*d*/ NewPacket.WriteD(OldPacket.ReadD()); // karma
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD()); // pvp kills

			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());

			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
				int nHairDBID = OldPacket.ReadD();
				int nFaceDBID = OldPacket.ReadD();
			/*d*/ NewPacket.WriteD(nHairDBID); //Hair Slot dbid
			/*d*/ //NewPacket.WriteD(nFaceDBID); //Face Slot dbid

			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			/*d*/ NewPacket.WriteD(OldPacket.ReadD());
			int nHairItemType = OldPacket.ReadD();
			int nFaceItemType = OldPacket.ReadD();
			/*d*/ NewPacket.WriteD(nHairItemType); //Hair Slot type
			/*d*/ //NewPacket.WriteD(nFaceItemType); //Face slot type


			/*d*/ NewPacket.WriteD(OldPacket.ReadD()); // hair
			/*d*/ NewPacket.WriteD(OldPacket.ReadD()); // hair color
			/*d*/ NewPacket.WriteD(OldPacket.ReadD()); // face

			double hp = OldPacket.ReadF();
			/*f*/ NewPacket.WriteF(hp); // hp max
			/*f*/ NewPacket.WriteF(OldPacket.ReadF()); // map max

			/*d*/ NewPacket.WriteD(OldPacket.ReadD()); // delete time

			/*d*/ NewPacket.WriteD(OldPacket.ReadD()); // class id
			/*d*/ NewPacket.WriteD(OldPacket.ReadD()); // last used
			/*c*/ NewPacket.WriteC(OldPacket.ReadC()); // enchant effect

			UINT augmentation = OldPacket.ReadD();
			/*d - new*/ //NewPacket.WriteD(augmentation); //Augmentation ID

			/*d*/ NewPacket.WriteD(nFaceDBID); //Face Slot dbid
			
			/*d*/ NewPacket.WriteD(nFaceItemType); //Face slot type

			int EffectiveMana0 = OldPacket.ReadD();
			int EffectiveMana1 = OldPacket.ReadD();
			int EffectiveMana2 = OldPacket.ReadD();
			int EffectiveMana3 = OldPacket.ReadD();
			//g_Log.Add(CLog::Error, "ef [%d] [%d] [%d] [%d]", EffectiveMana0, EffectiveMana1, EffectiveMana2, EffectiveMana3);
		}
		pSocket->Send(szFormat, bOpCode, dwCharNum, NewPacket.GetSize(), NewPacket.GetBuff());
	}
	
	g_SocketDB.SetStatus(pSocket, CSocketData::CHAR_SELECTION_SCREEN);
}

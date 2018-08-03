#include "stdafx.h"
#include "License.h"

extern TCHAR g_LicenseName[256];

#pragma optimize("", off)

namespace License
{
	CLicense& CLicense::GetInstance()
	{
		static CLicense m_Instance;
		return m_Instance;
	}

	void CLicense::Init()
	{
		VIRTUALIZER_TIGER_BLACK_START;
		m_LicenseName = g_LicenseName;
		//license name
		const WCHAR vang[] = { L'V', L'a', L'n', L'g', 0 };

		//features for the licens - vang
		m_Data[vang].push_back(LicenseExtUse);
		m_Data[vang].push_back(LicenseSkillMaster);
		m_Data[vang].push_back(LicenseInstanceZone);
		m_Data[vang].push_back(LicenseSubStack);
		m_Data[vang].push_back(LicenseChatManager);
		m_Data[vang].push_back(LicenseRebirth);
		m_Data[vang].push_back(LicenseChampionNpc);
		m_Data[vang].push_back(LicenseDBNpcMaker);
		m_Data[vang].push_back(LicenseRecipeManager);
		m_Data[vang].push_back(LicenseHtmlPIN);
		m_Data[vang].push_back(LicensePvPAnnounce);

		VIRTUALIZER_TIGER_BLACK_END;
	}

	void CLicense::SendPostRequest()
	{

	}

	bool CLicense::CanUse(LicenseType licenseType)
	{
		/*
		VIRTUALIZER_TIGER_BLACK_START;
		bool canUse = false;

		map<wstring, vector<LicenseType>>::iterator iter = m_Data.find(m_LicenseName);
		if(iter != m_Data.end())
		{
			vector<LicenseType>& licenses = iter->second;
			for(UINT n=0;n<licenses.size();n++)
			{
				if(licenses[n] == licenseType)
				{
					canUse = true;
					break;
				}
			}
		}

		VIRTUALIZER_TIGER_BLACK_END;

		return canUse;
		*/
		return true;
	}
}
#pragma optimize("", on)

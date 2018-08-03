#include "StdAfx.h"
#include "Item.h"

bool CItem::IsValidItem()
{
	if(this)
	{
        try
		{ 
			if(    (*(LPDWORD)this) == 0xA07CF8 
				|| (*(LPDWORD)this) == 0xA0B368 
				|| (*(LPDWORD)this) == 0xA0A448 
				|| (*(LPDWORD)this) == 0xA09558
				|| (*(LPDWORD)this) == 0xA09CC8
				|| (*(LPDWORD)this) == 0xA08DC8
				|| (*(LPDWORD)this) == 0xA0ABD8 )
			{
				return true;
			}
		}
        catch(...)
		{ 
			/* Invalid pointer */
			/* Preventing Crash ;) */
		}
	}
	return false;
}
CSharedItemData *CItem::GetSharedData()
{
	if(this)
	{
		try
		{
			int nSlotType = this->pSID->nSlotType;
			return this->pSID;
		}
		catch(...)
		{
			return NULL;
		}
	}
	return NULL;
}
bool CItem::IsLifeStone()
{
	if(this)
	{
		try
		{
			if(this->pSID->nItemID >= 8723 && this->pSID->nItemID <= 8762)
				return true;
		}
		catch(...)
		{
			return false;
		}
	}
	return false;
}
CWeapon *CItem::GetWeapon()
{
	if(this)
	{
		try
		{
			if(IsValid(VT_ITEMWEAPON))
			{
				return (CWeapon*)this;
			}
			else
				return NULL;
		}
		catch(...)
		{
			return NULL;
		}
	}
	return NULL;
}

void CItem::Delete()
{
	typedef void (*f)(CItem*);
	f(0x62E180L)(this);
}

void CItem::FindItemSp(CItemSP& itemSp, int itemIndex)
{
	typedef void(*f)(UINT64, CItemSP&, int);
	f(0x4745F0L)(0x0E412130, itemSp, itemIndex);
}

CSPointer<CItem> CItem::FindItemSP(int nItemIndex)
{
	typedef void (*FFindItem)(__int64, CSPointer<CItem>*, int);
	__int64 pItemFactory = 0x0E412130;
	CSPointer<CItem> tmp;
	FFindItem(0x4745F0)(pItemFactory, &tmp, nItemIndex);
	return tmp;
}
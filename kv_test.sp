#include <profiler>

public void OnPluginStart()
{
	RegServerCmd("sm_kv_test", CMD)
}

public Action CMD(int args)
{
	KeyValues kv = new KeyValues("kv")
	Profiler prof = new Profiler()
	prof.Start()
	char sBuffer[64]
	int max = 10000
	int count = 1000
	if(args >= 1)
	{
		GetCmdArg(1, sBuffer, sizeof sBuffer)
		max = StringToInt(sBuffer)
	}
	if(args >= 2)
	{
		GetCmdArg(2, sBuffer, sizeof sBuffer)
		count = StringToInt(sBuffer)
	}
	sBuffer = "section"
	for(int i = 0;i<max;i++)
	{
		IntToString(i, sBuffer[7], sizeof sBuffer-7)
		kv.JumpToKey(sBuffer, true)
		kv.GoBack()
	}
	prof.Stop()
	PrintToServer("%f - Initializing KeyValues file (%i sections)", prof.Time, max)
	prof.Start()
	for(int i = 0;i<count;i++)
	{
		kv.Rewind()
		kv.JumpToKey("section0", false)
	}
	prof.Stop()
	PrintToServer("%f - %i times finding first section", prof.Time, count)
	
	IntToString(max-1, sBuffer[7], sizeof sBuffer-7)
	prof.Start()
	for(int i = 0;i<count;i++)
	{
		kv.Rewind()
		kv.JumpToKey(sBuffer, false)
	}
	prof.Stop()
	PrintToServer("%f - %i times finding last section", prof.Time, count)
	
	IntToString(max/2-1, sBuffer[7], sizeof sBuffer-7)
	prof.Start()
	for(int i = 0;i<count;i++)
	{
		kv.Rewind()
		kv.JumpToKey(sBuffer, false)
	}
	prof.Stop()
	PrintToServer("%f - %i times finding mid section", prof.Time, count)
	
	int id
	kv.JumpToKey("section0", false)
	kv.GetSectionSymbol(id)
	prof.Start()
	for(int i = 0;i<count;i++)
	{
		kv.Rewind()
		kv.JumpToKeySymbol(id)
	}
	prof.Stop()
	PrintToServer("%f - %i times jump first section via symbol", prof.Time, count)
	
	IntToString(max-1, sBuffer[7], sizeof sBuffer-7)
	kv.JumpToKey(sBuffer, false)
	kv.GetSectionSymbol(id)
	prof.Start()
	for(int i = 0;i<count;i++)
	{
		kv.Rewind()
		kv.JumpToKeySymbol(id)
	}
	prof.Stop()
	PrintToServer("%f - %i times jump last section via symbol", prof.Time, count)
	
	IntToString(max/2-1, sBuffer[7], sizeof sBuffer-7)
	kv.JumpToKey(sBuffer, false)
	kv.GetSectionSymbol(id)
	prof.Start()
	for(int i = 0;i<count;i++)
	{
		kv.Rewind()
		kv.JumpToKeySymbol(id)
	}
	prof.Stop()
	PrintToServer("%f - %i times jump mid section via symbol", prof.Time, count)
	kv.Close()
	prof.Close()
	return Plugin_Handled
}
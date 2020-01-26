#include <profiler>

StringMap map 
ArrayList list

public void OnPluginStart()
{
	RegServerCmd("sm_array_stringmap_test", CMD)
}

public Action CMD(int args)
{
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
	PrintToServer("Test: Values - %i, Times - %i", max, count)
	
	map = new StringMap()
	list = new ArrayList(ByteCountToCells(32))
	Profiler prof = new Profiler()
	
	sBuffer = "stringmap"
	prof.Start()
	for(int i = 0;i!=max;i++)
	{
		IntToString(i, sBuffer[9], sizeof sBuffer-9)
		map.SetValue(sBuffer, i)
	}
	prof.Stop()
	PrintToServer("Test Init Map (%i): %f", max, prof.Time)
	prof.Start()
	for(int i = 0;i!=max;i++)
	{
		IntToString(i, sBuffer[9], sizeof sBuffer-9)
		list.PushString(sBuffer)
	}
	prof.Stop()
	PrintToServer("Test Init Array (%i): %f", max, prof.Time)
	
	int buf
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		map.GetValue("stringmap0", buf)
	prof.Stop()
	PrintToServer("Test Map First: %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		list.FindString("stringmap0")
	prof.Stop()
	PrintToServer("Test Array First: %f", prof.Time)
	//----------------------------------------------------
	IntToString(max-1, sBuffer[9], sizeof sBuffer-9)
	prof.Start()
	for(int i = 0;i!=count;i++)
		map.GetValue("stringmap9999", buf)
	prof.Stop()
	PrintToServer("Test Map Last: %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		list.FindString("stringmap9999")
	prof.Stop()
	PrintToServer("Test Array Last: %f", prof.Time)
	//----------------------------------------------------
	IntToString(max/2-1, sBuffer[9], sizeof sBuffer-9)
	prof.Start()
	for(int i = 0;i!=count;i++)
		map.GetValue("stringmap4999", buf)
	prof.Stop()
	PrintToServer("Test Map Mid: %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		list.FindString("stringmap4999")
	prof.Stop()
	PrintToServer("Test Array Mid: %f", prof.Time)
	
	prof.Close()
	list.Close()
	map.Close()
}
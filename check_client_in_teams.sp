#include <profiler>

public void OnPluginStart()
{
	RegServerCmd("sm_check_team", CMD)
}

public Action CMD(int args)
{
	char sBuffer[64]
	int count = 1000
	int value = 2 // ct or t
	if(args >= 1)
	{
		GetCmdArg(1, sBuffer, sizeof sBuffer)
		count = StringToInt(sBuffer)
	}
	if(args >= 2)
	{
		GetCmdArg(2, sBuffer, sizeof sBuffer)
		value = StringToInt(sBuffer)
	}
	bool temp
	PrintToServer("Count - %i", count)
	PrintToServer("Value - %i", value)
	Profiler prof = new Profiler()
	prof.Start()
	for(int i = 0;i!=count;i++)
		temp = (value > 1)
	prof.Stop()
	PrintToServer("Test1 - %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		temp = (value != 1 && value != 0)
	prof.Stop()
	PrintToServer("Test2 - %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		temp = (value == 2 || value == 3)
	prof.Stop()
	PrintToServer("Test3 - %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		temp = (value >> 1)
	prof.Stop()
	PrintToServer("Test4 - %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		temp = (value & 0b10)
	prof.Stop()
	PrintToServer("Test5 - %f", prof.Time)
	
	prof.Start()
	for(int i = 0;i!=count;i++)
		temp = (value >= 2)
	prof.Stop()
	PrintToServer("Test6 - %f", prof.Time)
	
	prof.Close()
	return Plugin_Handled
}
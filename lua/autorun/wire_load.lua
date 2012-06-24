-- $Rev: 1663 $
-- $LastChangedDate: 2009-09-12 03:34:53 -0700 (Sat, 12 Sep 2009) $
-- $LastChangedBy: TomyLobo $

if VERSION < 129 then
	ErrorNoHalt("WireMod: Your GMod is years too old. Load aborted.\n")
	return
end

if SERVER then
	-- this file
	AddCSLuaFile("autorun/wire_load.lua")
	
	-- shared includes
	AddCSLuaFile("wire/wireshared.lua")
	AddCSLuaFile("wire/updatecheck.lua")
	AddCSLuaFile("wire/beam_netvars.lua")
	AddCSLuaFile("wire/wiregates.lua")
	AddCSLuaFile("wire/wiremonitors.lua")
	AddCSLuaFile("wire/gpulib.lua")
	AddCSLuaFile("wire/cpulib.lua")
	AddCSLuaFile("wire/timedpairs.lua")
	
	-- client includes
	AddCSLuaFile("wire/client/cl_wirelib.lua")
	AddCSLuaFile("wire/client/cl_modelplug.lua")
	AddCSLuaFile("wire/client/cl_wire_map_interface.lua")
	AddCSLuaFile("wire/client/wiredermaexts.lua")
	AddCSLuaFile("wire/client/wiremenus.lua")
	AddCSLuaFile("wire/client/texteditor.lua")
	AddCSLuaFile("wire/client/toolscreen.lua")
	AddCSLuaFile("wire/client/wire_expression2_browser.lua")
	AddCSLuaFile("wire/client/wire_expression2_editor.lua")
	AddCSLuaFile("wire/client/e2helper.lua")
	AddCSLuaFile("wire/client/e2descriptions.lua")
	AddCSLuaFile("wire/client/gmod_tool_auto.lua")
	AddCSLuaFile("wire/client/sound_browser.lua")
	AddCSLuaFile("wire/welcome_menu.lua")
	AddCSLuaFile("wire/client/welcome_menu_derma.lua")
	AddCSLuaFile("wire/client/rendertarget_fix.lua")
	
	-- HL-ZASM
	AddCSLuaFile("wire/client/hlzasm/hc_compiler.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_opcodes.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_expression.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_preprocess.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_syntax.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_codetree.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_optimize.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_output.lua")
	AddCSLuaFile("wire/client/hlzasm/hc_tokenizer.lua")

	-- ZVM
	AddCSLuaFile("wire/zvm/zvm_core.lua")
	AddCSLuaFile("wire/zvm/zvm_features.lua")
	AddCSLuaFile("wire/zvm/zvm_opcodes.lua")
	AddCSLuaFile("wire/zvm/zvm_data.lua")

	-- resource files
	for i=1,32 do
		//resource.AddSingleFile("settings/render_targets/WireGPU_RT_"..i..".txt")
	end
	resource.AddSingleFile("materials/expression 2/cog.vtf")
	resource.AddSingleFile("materials/expression 2/cog.vmt")
	resource.AddSingleFile("materials/gui/silkicons/page_white_add.vmt")
	resource.AddSingleFile("materials/gui/silkicons/page_white_add.vtf")
	resource.AddSingleFile("materials/gui/silkicons/page_white_delete.vmt")
	resource.AddSingleFile("materials/gui/silkicons/page_white_delete.vtf")
	resource.AddSingleFile("materials/vgui/spawnmenu/File.vmt")
	resource.AddSingleFile("materials/vgui/spawnmenu/File.vtf")
	resource.AddSingleFile("materials/vgui/spawnmenu/Folder.vmt")
	resource.AddSingleFile("materials/vgui/spawnmenu/Folder.vtf")
	resource.AddSingleFile("materials/vgui/spawnmenu/save.vmt")
	resource.AddSingleFile("materials/vgui/spawnmenu/save.vtf")
	resource.AddSingleFile("materials/wirelogo.vmt")
	resource.AddSingleFile("materials/wirelogo.vtf")
	resource.AddSingleFile("materials/expression 2/cog_world.vmt")
end

-- shared includes
include("wire/wireshared.lua")
include("wire/updatecheck.lua")
include("wire/beam_netvars.lua")
include("wire/wiregates.lua")
include("wire/wiremonitors.lua")
include("wire/gpulib.lua")
include("wire/cpulib.lua")
include("wire/welcome_menu.lua")
include("wire/timedpairs.lua")

-- server includes
if SERVER then
	include("wire/server/wirelib.lua")
	include("wire/server/modelplug.lua")
	include("wire/server/radiolib.lua")
end

-- client includes
if CLIENT then
	include("wire/client/cl_wirelib.lua")
	include("wire/client/cl_modelplug.lua")
	include("wire/client/cl_wire_map_interface.lua")
	include("wire/client/wiredermaexts.lua")
	include("wire/client/wiremenus.lua")
	include("wire/client/toolscreen.lua")
	include("wire/client/texteditor.lua")
	include("wire/client/wire_expression2_browser.lua")
	include("wire/client/wire_expression2_editor.lua")
	include("wire/client/e2helper.lua")
	include("wire/client/e2descriptions.lua")
	include("wire/client/gmod_tool_auto.lua")
	include("wire/client/sound_browser.lua")
	include("wire/client/welcome_menu_derma.lua")
	include("wire/client/rendertarget_fix.lua")
	include("wire/client/hlzasm/hc_compiler.lua")
	
	include("wire/datafiles.lua")
end

-- load uwsvn
if file.Find("wire/uwsvn_load.lua", LUA_PATH)[1] then
	if SERVER then AddCSLuaFile("wire/uwsvn_load.lua" ) end
	include("wire/uwsvn_load.lua")
end

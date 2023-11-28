--
-- Premake5 file for build Curl project.
-- Copyright (c) 2023-present by Danil (Kenny) Dukhovenko, All rights reserved.
--
-- Requirement:
--  - ForceEngine.lua
--  - vcpkg installed with 'vcpkg install curl'
--  - vcpkg should also install followed libraries:
--    - zlib
--
-- NOTE: This is thunk library, only with linkage .lib. All source code contains in
-- vcpkg\packages\curl_x64-windows.
-- Read more in ForceEngine.lua::About __NULL_IMPORT_DESCRIPTOR why i made this dicision.
--

-- Curl C++ Project
project "Curl"
	kind          "StaticLib"
	language      "C++"
	cppdialect    "C++17"
	staticruntime "On"
	targetdir     ("%{ForceDir.BinLib}/" .. BuildDir .. "/%{prj.name}/Lib")
	objdir        ("%{ForceDir.BinLib}/" .. BuildDir .. "/%{prj.name}/Obj")

	files {
		"%{IncludeDir.Curl}/curl/**.h",
		"src/**.cpp"
	}
	
	includedirs {
		"%{IncludeDir.Curl}"
	}

	filter "system:windows"
		systemversion "latest"
	
	filter "system:linux"
		pic "On"
		systemversion "latest"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"
		links ( "%{Library.Dbg.Curl}", "%{Library.Dbg.ZLib}" )

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
		links ( "%{Library.Rel.Curl}", "%{Library.Rel.ZLib}" )
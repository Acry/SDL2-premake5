-- premake5.lua
workspace "SDL2_Test"
   configurations { "Debug", "Release" }

project "SDL2_Test"
   kind "WindowedApp"
   language "C"
   targetdir "bin/%{cfg.buildcfg}"

   files { "**.h", "**.c" }

   filter "configurations:Debug"
      defines { "DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"

      -- linux library cflags and libs
      configuration { "linux", "gmake" }
      buildoptions { 
	      "`pkg-config --cflags sdl2`"
      }
      linkoptions { 
	      "`pkg-config --libs sdl2`",
	      "-lSDL2_image",
	      "-lm"
      }
      -- windows library cflags and libs
--       configuration { "windows" }
--       includedirs { "SDL/include" }
--       libdirs { "../RecastDemo/Contrib/SDL/lib/x86" }
--       debugdir "../RecastDemo/Bin/"
--       links { 
-- 	      "glu32",
-- 	      "opengl32",
-- 	      "SDL2",
-- 	      "SDL2main",
--       }
      -- mac includes and libs
--       configuration "macosx"
--       links {"OpenGL.framework","CoreFoundation.framework","SDL2.framework"}
--       
--       configuration {"macosx", "gmake"}
--       buildoptions {"-F /Library/Frameworks", "-F ~/Library/Frameworks"}
--       linkoptions {"-F /Library/Frameworks", "-F ~/Library/Frameworks"}

--       configuration { "macosx" }
--       kind "ConsoleApp"
--       includedirs { "/Library/Frameworks/SDL2.framework/Headers" }
--       buildoptions { "-Wunused-value -Wshadow -Wreorder -Wsign-compare -Wall" }
--       links { 
-- 	      "SDL2.framework"
--       }
	postbuildcommands {
		-- copy assets
		"{MKDIR} bin/%{cfg.buildcfg}/assets/gfx/",
		"{COPY} assets/gfx/* bin/%{cfg.buildcfg}/assets/gfx"
	}

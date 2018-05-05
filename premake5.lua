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

      
      newaction
      {
	      trigger     = "clean",
	      
	      description = "Clean all build files and output",
	      
	      execute = function ()
		      
		      files_to_delete = 
		      {
			      "Makefile",
			      "*.make"
		      }
		      
		      directories_to_delete = 
		      {
			      "obj",
			      "bin",
		      }
		      
		      for i,v in ipairs( directories_to_delete ) do
			      os.rmdir( v )
		      end
		      
		      if not os.is "windows" then
			      os.execute "find . -name .DS_Store -delete"
			      for i,v in ipairs( files_to_delete ) do
				      os.execute( "rm -f " .. v )
			      end
		      else
			      for i,v in ipairs( files_to_delete ) do
				      os.execute( "del /F /Q  " .. v )
			      end
		      end
		      
	      end
      }
      
	postbuildcommands {
		-- copy assets
		"{MKDIR} bin/%{cfg.buildcfg}/assets/gfx/",
		"{COPY} assets/gfx/* bin/%{cfg.buildcfg}/assets/gfx"
	}
	

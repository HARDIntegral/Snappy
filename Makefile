#	Configuaration
CC := gcc
Extension := .c
OpenGL := "/usr/include/GL"
GLFW := "/usr/include/GLFW"
Libraries := -lm -lglfw

#	C Source Code
Source := Source
Include := Include

#	Build Folder
BuildDir := Build/

#	Build Target
Target := out
Flags := -O2 -g -Wall -Wextra

#	Build
Name := Snappy
Build := $(Name).$(Target)


#	Loading in file locations
Sources := 									\
	$(wildcard $(Source)**/**$(Extension))	\
	$(wildcard $(Source)*$(Extension))

Objects := 													   	\
	$(patsubst $(Source)%$(Extension), $(BuildDir)%.o, $(Sources))


#	Handling automatic dependency tracking
Dependencies := $(patsubst %.o, %.d, $(Objects))
-include $(Dependencies)

DependenciesFlags = -MMD -MF $(@:.o=.d)

#	Run Binary
run:
	@$(BuildDir)./$(Build)

#	Build Executable
build: $(Objects)
	@echo [INFO] Building Snappy [$(Target)] ...
	@$(CC) $^ -o $(BuildDir)$(Build) $(Libraries)
	@echo [INFO] [$(Build)] Created!

$(BuildDir)%.o: $(Source)%$(Extension)
	@echo [CC] $<
	@mkdir -p $(@D)
	@$(CC) -fPIC $< -c -o $@ $(Flags) $(DependenciesFlags)	\
		-I$(Include)										\
		-I$(OpenGL)											\
		-I$(GLFW)

#	Clean the Build Environment
.PHONEY: clean

clean:
	@rm -rf $(BuildDir)

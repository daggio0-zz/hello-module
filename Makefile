
MAKE=sudo make
TARGET_MODULE:=hello-module
INSMOD=sudo insmod
RMMOD=sudo rmmod
KVERSION := $(shell uname -r)

#.PHONY: clean install load unload

# If we are running by kernel building system
ifneq ($(KERNELRELEASE),)
	$(TARGET_MODULE)-objs := main.o
	obj-m := $(TARGET_MODULE).o
# If we running without kernel build system
else
	BUILDSYSTEM_DIR:=/lib/modules/$(KVERSION)/build
	PWD:=$(shell pwd)
all: 
	# run kernel build system to make module
	$(MAKE) -C $(BUILDSYSTEM_DIR) M=$(PWD) modules
clean:
	# run kernel build system to cleanup in current directory
	$(MAKE) -C $(BUILDSYSTEM_DIR) M=$(PWD) clean
install:
	$(MAKE) -C $(BUILDSYSTEM_DIR) M=$(PWD) modules_install -n
load:
	$(INSMOD) ./$(TARGET_MODULE).ko
unload:
	$(RMMOD) ./$(TARGET_MODULE).ko
endif

################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/flows/application/Application.cpp \
../src/flows/application/CBR.cpp \
../src/flows/application/InfiniteBuffer.cpp \
../src/flows/application/M2MEventDriven.cpp \
../src/flows/application/M2MEventDrivenV2.cpp \
../src/flows/application/M2MTimeDriven.cpp \
../src/flows/application/M2MTimeDrivenV2.cpp \
../src/flows/application/TraceBased.cpp \
../src/flows/application/VoIP.cpp \
../src/flows/application/WEB.cpp \
../src/flows/application/application-sink.cpp 

OBJS += \
./src/flows/application/Application.o \
./src/flows/application/CBR.o \
./src/flows/application/InfiniteBuffer.o \
./src/flows/application/M2MEventDriven.o \
./src/flows/application/M2MEventDrivenV2.o \
./src/flows/application/M2MTimeDriven.o \
./src/flows/application/M2MTimeDrivenV2.o \
./src/flows/application/TraceBased.o \
./src/flows/application/VoIP.o \
./src/flows/application/WEB.o \
./src/flows/application/application-sink.o 

CPP_DEPS += \
./src/flows/application/Application.d \
./src/flows/application/CBR.d \
./src/flows/application/InfiniteBuffer.d \
./src/flows/application/M2MEventDriven.d \
./src/flows/application/M2MEventDrivenV2.d \
./src/flows/application/M2MTimeDriven.d \
./src/flows/application/M2MTimeDrivenV2.d \
./src/flows/application/TraceBased.d \
./src/flows/application/VoIP.d \
./src/flows/application/WEB.d \
./src/flows/application/application-sink.d 


# Each subdirectory must supply rules for building sources it contributes
src/flows/application/%.o: ../src/flows/application/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O0 -g3 -w -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '



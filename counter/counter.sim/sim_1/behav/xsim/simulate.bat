@echo off
REM ****************************************************************************
REM Vivado (TM) v2018.2.2 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Wed Oct 17 17:33:32 +0300 2018
REM SW Build 2348494 on Mon Oct  1 18:25:44 MDT 2018
REM
REM Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
call xsim counter_behav -key {Behavioral:sim_1:Functional:counter} -tclbatch counter.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__zad1.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__zad1.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E067 : Short_Integer; pragma Import (Ada, E067, "system__os_lib_E");
   E014 : Short_Integer; pragma Import (Ada, E014, "ada__exceptions_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "system__soft_links_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "system__exception_table_E");
   E033 : Short_Integer; pragma Import (Ada, E033, "ada__containers_E");
   E063 : Short_Integer; pragma Import (Ada, E063, "ada__io_exceptions_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "ada__strings_E");
   E049 : Short_Integer; pragma Import (Ada, E049, "ada__strings__maps_E");
   E053 : Short_Integer; pragma Import (Ada, E053, "ada__strings__maps__constants_E");
   E073 : Short_Integer; pragma Import (Ada, E073, "interfaces__c_E");
   E018 : Short_Integer; pragma Import (Ada, E018, "system__exceptions_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "system__object_reader_E");
   E042 : Short_Integer; pragma Import (Ada, E042, "system__dwarf_lines_E");
   E094 : Short_Integer; pragma Import (Ada, E094, "system__soft_links__initialize_E");
   E032 : Short_Integer; pragma Import (Ada, E032, "system__traceback__symbolic_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "ada__numerics_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "ada__tags_E");
   E148 : Short_Integer; pragma Import (Ada, E148, "ada__streams_E");
   E113 : Short_Integer; pragma Import (Ada, E113, "interfaces__c__strings_E");
   E156 : Short_Integer; pragma Import (Ada, E156, "system__file_control_block_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "system__finalization_root_E");
   E153 : Short_Integer; pragma Import (Ada, E153, "ada__finalization_E");
   E152 : Short_Integer; pragma Import (Ada, E152, "system__file_io_E");
   E128 : Short_Integer; pragma Import (Ada, E128, "system__task_info_E");
   E173 : Short_Integer; pragma Import (Ada, E173, "ada__calendar_E");
   E107 : Short_Integer; pragma Import (Ada, E107, "ada__real_time_E");
   E146 : Short_Integer; pragma Import (Ada, E146, "ada__text_io_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "system__random_seed_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "system__tasking__initialization_E");
   E191 : Short_Integer; pragma Import (Ada, E191, "system__tasking__protected_objects_E");
   E193 : Short_Integer; pragma Import (Ada, E193, "system__tasking__protected_objects__entries_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "system__tasking__queuing_E");
   E201 : Short_Integer; pragma Import (Ada, E201, "system__tasking__stages_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E193 := E193 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F1;
      end;
      E146 := E146 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "ada__text_io__finalize_spec");
      begin
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "system__file_io__finalize_body");
      begin
         E152 := E152 - 1;
         F3;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, True, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, False, False, True, True, False, False, 
           True, False, False, True, True, True, True, False, 
           False, False, False, False, True, True, False, True, 
           True, False, True, True, True, True, False, False, 
           False, False, False, True, False, False, True, False, 
           False, False, False, True, False, False, False, True, 
           True, False, False, True, False, False, False, False, 
           False, True, False, True, False, True, True, True, 
           False, False, True, False, True, True, True, False, 
           True, True, False, True, True, True, True, False, 
           False, False, False, False, False, False, True, True, 
           True, False, False, False),
         Count => (0, 0, 0, 0, 2, 1, 1, 0, 0, 0),
         Unknown => (False, False, False, False, False, False, True, False, False, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E008 := E008 + 1;
      Ada.Containers'Elab_Spec;
      E033 := E033 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E063 := E063 + 1;
      Ada.Strings'Elab_Spec;
      E047 := E047 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E049 := E049 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E053 := E053 + 1;
      Interfaces.C'Elab_Spec;
      E073 := E073 + 1;
      System.Exceptions'Elab_Spec;
      E018 := E018 + 1;
      System.Object_Reader'Elab_Spec;
      E075 := E075 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E042 := E042 + 1;
      System.Os_Lib'Elab_Body;
      E067 := E067 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E094 := E094 + 1;
      E010 := E010 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E032 := E032 + 1;
      E014 := E014 + 1;
      Ada.Numerics'Elab_Spec;
      E005 := E005 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E140 := E140 + 1;
      Ada.Streams'Elab_Spec;
      E148 := E148 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E113 := E113 + 1;
      System.File_Control_Block'Elab_Spec;
      E156 := E156 + 1;
      System.Finalization_Root'Elab_Spec;
      E155 := E155 + 1;
      Ada.Finalization'Elab_Spec;
      E153 := E153 + 1;
      System.File_Io'Elab_Body;
      E152 := E152 + 1;
      System.Task_Info'Elab_Spec;
      E128 := E128 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E173 := E173 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E107 := E107 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E146 := E146 + 1;
      System.Random_Seed'Elab_Body;
      E171 := E171 + 1;
      System.Tasking.Initialization'Elab_Body;
      E183 := E183 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E191 := E191 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E193 := E193 + 1;
      System.Tasking.Queuing'Elab_Body;
      E197 := E197 + 1;
      System.Tasking.Stages'Elab_Body;
      E201 := E201 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_zad1");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   D:\V\PWIR\Lab 06\obj\Zad1.o
   --   -LD:\V\PWIR\Lab 06\obj\
   --   -LD:\V\PWIR\Lab 06\obj\
   --   -LD:/gnat/2020/lib/gcc/x86_64-pc-mingw32/9.3.1/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -Xlinker
   --   --stack=0x200000,0x1000
   --   -mthreads
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;

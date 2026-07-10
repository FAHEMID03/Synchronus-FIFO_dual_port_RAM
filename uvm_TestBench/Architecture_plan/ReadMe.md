**Verification Plan**
Feature	           Verification Method
Reset	             Directed
Write	             Directed + Random
Read	             Directed + Random
Full	             Directed
Empty	             Directed
Simultaneous       Read/Write	Random
Pointer Wrap	     Directed
Data Integrity     Scoreboard
Random Traffic	   CRV
Coverage	         Functional Coverage
Assertions	       SVA

**TestBench Architecture **
                               **  fifo_test
                                      |
                               fifo_virtual_seq
                                      |
                             fifo_virtual_sequencer
                                      |
                              fifo_env
      -------------------------------------------------------
      |                     |                     |
   fifo_agent         fifo_scoreboard       fifo_coverage**
      |
**-------------------------------------------------------------
|              |                 |                           |
Sequencer     Driver          Monitor                  Assertions
      |
 Interface
      |
 FIFO DUT**

** Planing Arechitecture**
                                  fifo_test
                                      │ 
                                fifo_virtual_sequence 
                                      │
                                fifo_virtual_sequencer
                                      │
                              ---------------------- 
                              |                    │   
                              │                    |
                        Write Agent             Read Agent 
                          │                        |
                --------------------             --------------------
               │         │        │                  │      │       │
            Sequencer  Driver   Monitor         Sequencer   Driver  Monitor 
                         │                                    │
                         └──────────┬────────---------------- │ 
                                FIFO Interface
                                     │ 
                                Synchronous FIFO 
                                     │
                      -------------------------- 
                      │                        │ 
                  Scoreboard               Coverage 
                      │
                  Reference Queue
 

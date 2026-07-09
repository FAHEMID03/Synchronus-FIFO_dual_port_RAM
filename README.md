                                           # Synchronus-FIFO_dual_port_RAM
_______________________________________________________________________________________________
A FIFO (First-In, First-Out) or queue is a memory structure commonly used in hardware to transfer data between two circuits operating in different clock domains. Besides clock domain crossing (CDC), FIFOs have many other applications, such as buffering data, rate matching, and temporary storage. A FIFO typically uses a dual-port memory and maintains two pointers: a write pointer and a read pointer, which are used to manage write and read operations, respectively. The following figure shows a generalized block diagram of a FIFO.



**Block Diagram**
                 +------------------------------------------------------+
                    |                      FIFO                            |
                    |                                                      |
                    |   +-------------------------------+                  |
Write Data -------->|   |                               |                  |
Write Enable ------>|   |                               |-------> Read Data
Write Clock ------->|   |      Dual-Port Memory         |<------- Read Clock
                    |   |                               |<------- Read Enable
                    |   |                               |                  |
                    |   +-------------------------------+                  |
                    |           ^                  ^                       |
                    |           |                  |                       |
                    |    Write Pointer      Read Pointer                  |
                    |           |                  |                       |
                    |           +--------+---------+                       |
                    |                    |                                 |
                    |            FIFO Control Logic                        |
                    |                    |                                 |
                    |     +--------------+--------------+                  |
                    |     |                             |                  |
                    |  Full Flag                   Empty Flag              |
                    |  Almost Full                 Almost Empty            |
                    |  Overflow                    Underflow               |
                    +------------------------------------------------------+


                   ** Explain About Each Block**
                   _____________________________________________________________________________________________________________________________

                 **  Write interface**
                   a)Write_data =(wr_data):data to be store in the fifo.
                   b)write_enable= (wr_en): control wether data is written.
                   c)write clock=(wr_clk): clock for the write domain



                   

define SYNC_FIFO_AGENT_SV

class sync_fifo_write_agent extends uvm_agent;

   //--------------------------------------------
   // Factory Registration
   //--------------------------------------------

   `uvm_component_utils(sync_fifo_write_agent)

   //--------------------------------------------
   // Component Handles
   //--------------------------------------------

   sync_fifo_write_sequencer seqr;

   sync_fifo_write_driver    drv;

   sync_fifo_write_monitor   mon;

   //--------------------------------------------
   // Constructor
   //--------------------------------------------

   function new(string name="sync_fifo_write_agent",
                uvm_component parent);

      super.new(name,parent);

   endfunction

   //--------------------------------------------
   // Build Phase
   //--------------------------------------------

   function void build_phase(uvm_phase phase);

      super.build_phase(phase);

      seqr =
      sync_fifo_write_sequencer::
      type_id::create("seqr",this);

      drv =
      sync_fifo_write_driver::
      type_id::create("drv",this);

      mon =
      sync_fifo_write_monitor::
      type_id::create("mon",this);

   endfunction

   //--------------------------------------------
   // Connect Phase
   //--------------------------------------------

   function void connect_phase(uvm_phase phase);

      super.connect_phase(phase);

      drv.seq_item_port.connect(seqr.seq_item_export);

   endfunction

endclass

class sync_fifo_read_agent extends uvm_agent;

   //--------------------------------------------
   // Factory Registration
   //--------------------------------------------

   `uvm_component_utils(sync_fifo_read_agent)

   //--------------------------------------------
   // Component Handles
   //--------------------------------------------

   sync_fifo_read_sequencer seqr;

   sync_fifo_read_driver drv;

   sync_fifo_read_monitor mon;

   //--------------------------------------------
   // Constructor
   //--------------------------------------------

   function new(string name="sync_fifo_read_agent",
                uvm_component parent);

      super.new(name,parent);

   endfunction

   //--------------------------------------------
   // Build Phase
   //--------------------------------------------

   function void build_phase(uvm_phase phase);

      super.build_phase(phase);

      seqr =
      sync_fifo_read_sequencer::
      type_id::create("seqr",this);

      drv =
      sync_fifo_read_driver::
      type_id::create("drv",this);

      mon =
      sync_fifo_read_monitor::
      type_id::create("mon",this);

   endfunction

   //--------------------------------------------
   // Connect Phase
   //--------------------------------------------

   function void connect_phase(uvm_phase phase);

      super.connect_phase(phase);

      drv.seq_item_port.connect
      (
      seqr.seq_item_export
      );

   endfunction

endclass
class sync_fifo_read_agent extends uvm_agent;

   //--------------------------------------------
   // Factory Registration
   //--------------------------------------------

   `uvm_component_utils(sync_fifo_read_agent)

   //--------------------------------------------
   // Component Handles
   //--------------------------------------------

   sync_fifo_read_sequencer seqr;

   sync_fifo_read_driver drv;

   sync_fifo_read_monitor mon;

   //--------------------------------------------
   // Constructor
   //--------------------------------------------

   function new(string name="sync_fifo_read_agent",
                uvm_component parent);

      super.new(name,parent);

   endfunction

   //--------------------------------------------
   // Build Phase
   //--------------------------------------------

   function void build_phase(uvm_phase phase);

      super.build_phase(phase);

      seqr =
      sync_fifo_read_sequencer::
      type_id::create("seqr",this);

      drv =
      sync_fifo_read_driver::
      type_id::create("drv",this);

      mon =
      sync_fifo_read_monitor::
      type_id::create("mon",this);

   endfunction

   //--------------------------------------------
   // Connect Phase
   //--------------------------------------------

   function void connect_phase(uvm_phase phase);

      super.connect_phase(phase);

      drv.seq_item_port.connect
      (
      seqr.seq_item_export
      );

   endfunction

endclass

`endif

`ifndef SYNC_FIFO_ENV_SV
`define SYNC_FIFO_ENV_SV

class sync_fifo_env extends uvm_env;

   //====================================================
   // Factory Registration
   //====================================================
   `uvm_component_utils(sync_fifo_env)

   //====================================================
   // Component Handles
   //====================================================

   sync_fifo_write_agent      wr_agent;

   sync_fifo_read_agent       rd_agent;

   sync_fifo_scoreboard       sb;

   sync_fifo_coverage         cov;

   //====================================================
   // Constructor
   //====================================================

   function new(string name="sync_fifo_env",
                uvm_component parent);

      super.new(name,parent);

   endfunction

   //====================================================
   // Build Phase
   //====================================================

   function void build_phase(uvm_phase phase);

      super.build_phase(phase);

      `uvm_info(get_type_name(),
                "Building FIFO Environment",
                UVM_LOW)

      wr_agent =
      sync_fifo_write_agent::
      type_id::create("wr_agent",this);

      rd_agent =
      sync_fifo_read_agent::
      type_id::create("rd_agent",this);

      sb =
      sync_fifo_scoreboard::
      type_id::create("sb",this);

      cov =
      sync_fifo_coverage::
      type_id::create("cov",this);

   endfunction

   //====================================================
   // Connect Phase
   //====================================================

   function void connect_phase(uvm_phase phase);

      super.connect_phase(phase);

      //--------------------------------------------------
      // Write Monitor -> Scoreboard
      //--------------------------------------------------

      wr_agent.mon.ap.connect(sb.write_imp);

      //--------------------------------------------------
      // Read Monitor -> Scoreboard
      //--------------------------------------------------

      rd_agent.mon.ap.connect(sb.read_imp);

      //--------------------------------------------------
      // Coverage Connection
      //--------------------------------------------------

      wr_agent.mon.ap.connect(cov.analysis_export);

      rd_agent.mon.ap.connect(cov.analysis_export);

   endfunction

endclass

`endif

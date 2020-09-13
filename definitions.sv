package definitions;

  const logic [2:0] kADD = 3'b000;
  const logic [2:0] kXOR = 3'b001;
  const logic [2:0] kSHL = 3'b010;
  const logic [2:0] kSHR = 3'b011;
  const logic [2:0] kSNZ = 3'b100;
  const logic [2:0] kSEZ = 3'b101;

  typedef enum logic[2:0] {
    ADD, XOR, SHL, SHR, SNZ, SEZ} op_mne;

endpackage

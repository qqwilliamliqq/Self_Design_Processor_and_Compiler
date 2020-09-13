All 3 programs worked.
Simply run test bench and you will see the result.
The modifications we've done to the test bench:
1. We updated top level name in test bench. And top_level port names does not match test bench port names, so we extended (.*).
2. In orginal test benvh, pattern in dm1[160] was in lower 5 bits. We changed it to upper 5 bits to match lab 1 instruction.
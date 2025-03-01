# Just releases for testing.

To execute the test: 
  - download the Source code somewhere.
  - reflash the hardware (copy the `.uf2` onto the device, this should be well-known... )  
  - run a Powershell *as Administrator*
    - cd into the project directory and type:
      ```
      powershell -ExecutionPolicy Bypass -File .\scripts\TEST01.ps1
      ```
    

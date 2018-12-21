.. _fluxescrossingboundaries:

Fluxes crossing boundaries
''''''''''''''''''''''''''

NorESM can simulate several biogeochemical cycles. Here is a list of the
fluxes which cross boundaries in the models and how to enable/disable
interactions

+-----------+--------+----------+--------+-------------------------------+
| Component | Source | Receiver |Unit    | How to enable                 |
+===========+========+==========+========+===============================+
| Dust      | CLM    | CAM      |kg/m2/s |Always calculated by CLM.      |
|           |        |          |        |Picked up and used by          |
|           |        |          |        |atmophere. Used differently    |
|	    |	     |	        |        |in different aerosol-packages  |
|	    |        |		|	 |(bulk-aero,MAM, OSLO_AERO)     | 
+-----------+--------+----------+--------+-------------------------------+
| Dust      | CAM    | HAMMOC   |kg/m2/s |Leaves CAM as cam_out%dstwet{n}|
|           |        |          |        |,cam_out%dstdry{n}(n=1-4),     |
|           |        |          |        |picked up by HAMMOC in coupler |
+-----------+--------+----------+--------+-------------------------------+
| DMS       | HAMMOC | CAM      |kg/m2/s |HAMMOC writes DMS to the       |
|           |        |          |        |coupler if one sets            |
|           |        |          |        |"CCSM_BGC=CO2_DMSA" in         |
|           |        |          |        |env_run.xml. Picked up and     |
|           |        |          |        |used by CAM-Oslo if            |
|           |        |          |        |namelist-variable              |
|           |        |          |        |dms_source=='ocean_flux'. Only |
|           |        |          |        |compsets with MICOM%ECO run    |
|           |        |          |        |HAMMOC                         | 
+-----------+--------+----------+--------+-------------------------------+
|CO2        | CLM    | CAM      | ??     |                               |
+-----------+--------+----------+--------+-------------------------------+
|CO2        | HAMMOC | CAM      | ??     |                               | 
+-----------+--------+----------+--------+-------------------------------+
|CH4        | CLM    | CAM      | ??     |                               |
+-----------+--------+----------+--------+-------------------------------+
|isoprenes/ |        |          |        |                               |
|monterpenes| CLM    | CAM      |kg/m2/s |Calculated by MEGAN in CLM by  |
|           |        |          |        |setting "'isoprene = isoprene',|
|           |        |          |        |'monoterp = myrcene + sabinene |
|           |        |          |        |+limonene + carene_3 +         |
|           |        |          |        |ocimene_t_b + pinene_b +       |
|           |        |          |        |pinene_a'" Note that any       | 
|           |        |          |        |additional emission-file for   |
|           |        |          |        |monoterpenes will by ADDED to  |
|           |        |          |        |the MEGAN emissions            | 
+-----------+--------+----------+--------+-------------------------------+
| NO (?)    | CLM    | CAM      |        |                               | 
+-----------+--------+----------+--------+-------------------------------+
| NH3 (?)   | HAMMOC | CAM      |        |                               | 
+-----------+--------+----------+--------+-------------------------------+
| NHx (?)   | CAM    |CLM+HAMMOC|        |                               | 
+-----------+--------+----------+--------+-------------------------------+
| NOx (?)   | CAM    |CLM+HAMMOC|        |                               |
+-----------+--------+----------+--------+-------------------------------+

[0.000000] Reading FastQ file spodar.pe.qc.fq.gz;
[0.071316] 18014 sequences found
[0.071323] Done
[0.071686] Reading FastQ file spodar.se.qc.fq.gz;
[0.072935] 262 sequences found
[0.072938] Done
[0.196991] Reading read set file spodar.velvet.19.d/Sequences;
[0.200201] 18276 sequences found
[0.215029] Done
[0.215036] 18276 sequences in total.
[0.215755] Writing into roadmap file spodar.velvet.19.d/Roadmaps...
[0.221818] Inputting sequences...
[0.221933] Inputting sequence 0 / 18276
[0.542785]  === Sequences loaded in 0.320984 s
[0.547154] Done inputting sequences
[0.547161] Destroying splay table
[0.552051] Splay table destroyed
[0.000000] Reading roadmap file spodar.velvet.19.d/Roadmaps
[0.010260] 18276 roadmaps read
[0.010654] Creating insertion markers
[0.011039] Ordering insertion markers
[0.011783] Counting preNodes
[0.012030] 5895 preNodes counted, creating them now
[0.031891] Adjusting marker info...
[0.031989] Connecting preNodes
[0.032966] Cleaning up memory
[0.032968] Done creating preGraph
[0.032969] Concatenation...
[0.034823] Renumbering preNodes
[0.034825] Initial preNode count 5895
[0.034930] Destroyed 3272 preNodes
[0.034931] Concatenation over!
[0.034931] Clipping short tips off preGraph
[0.035390] Concatenation...
[0.035555] Renumbering preNodes
[0.035555] Initial preNode count 2623
[0.035628] Destroyed 291 preNodes
[0.035629] Concatenation over!
[0.035629] 191 tips cut off
[0.035629] 2332 nodes left
[0.036167] Writing into pregraph file spodar.velvet.19.d/PreGraph...
[0.056093] Reading read set file spodar.velvet.19.d/Sequences;
[0.059101] 18276 sequences found
[0.073505] Done
[0.079291] Reading pre-graph file spodar.velvet.19.d/PreGraph
[0.079523] Graph has 2332 nodes and 18276 sequences
[0.087659] Scanning pre-graph file spodar.velvet.19.d/PreGraph for k-mers
[0.090385] 233047 kmers found
[0.104905] Sorting kmer occurence table ... 
[0.176438] Sorting done.
[0.176445] Computing acceleration table... 
[0.199351] Computing offsets... 
[0.200946] Ghost Threading through reads 0 / 18276
[0.368703]  === Ghost-Threaded in 0.167770 s
[0.368710] Threading through reads 0 / 18276
[0.542687]  === Threaded in 0.173980 s
[0.543359] Correcting graph with cutoff 0.200000
[0.543501] Determining eligible starting points
[0.544451] Done listing starting nodes
[0.544452] Initializing todo lists
[0.544522] Done with initilization
[0.544522] Activating arc lookup table
[0.544577] Done activating arc lookup table
[0.547659] Concatenation...
[0.547699] Renumbering nodes
[0.547699] Initial node count 2332
[0.547730] Removed 49 null nodes
[0.547731] Concatenation over!
[0.547731] Clipping short tips off graph, drastic
[0.548100] Concatenation...
[0.548163] Renumbering nodes
[0.548163] Initial node count 2283
[0.548200] Removed 117 null nodes
[0.548201] Concatenation over!
[0.548201] 2166 nodes left
[0.548949] Writing into graph file spodar.velvet.19.d/Graph2...
[0.586794] Measuring median coverage depth...
[0.587398] Median coverage depth = 1.114094
[0.588408] Removing contigs with coverage < 0.557047...
[0.588466] Concatenation...
[0.588515] Renumbering nodes
[0.588515] Initial node count 2166
[0.588519] Removed 0 null nodes
[0.588520] Concatenation over!
[0.588562] Concatenation...
[0.588596] Renumbering nodes
[0.588596] Initial node count 2166
[0.588599] Removed 0 null nodes
[0.588599] Concatenation over!
[0.588602] Clipping short tips off graph, drastic
[0.588691] Concatenation...
[0.588724] Renumbering nodes
[0.588725] Initial node count 2166
[0.588727] Removed 0 null nodes
[0.588728] Concatenation over!
[0.588728] 2166 nodes left
[0.588730] Read coherency...
[0.588750] Identifying unique nodes
[0.588789] Done, 1531 unique nodes counted
[0.588789] Trimming read tips
[0.588851] Renumbering nodes
[0.588851] Initial node count 2166
[0.588854] Removed 0 null nodes
[0.588855] Confronted to 0 multiple hits and 0 null over 0
[0.588855] Read coherency over!
[0.588987] Starting pebble resolution...
[0.589106] Computing read to node mapping array sizes
[0.589313] Computing read to node mappings
[0.589527] Estimating library insert lengths...
[0.589692] Paired-end library 1 has length: 79, sample standard deviation: 60
[0.589693] Done
[0.589699] Computing direct node to node mappings
[0.589828] Scaffolding node 0
[0.590309]  === Nodes Scaffolded in 0.000610 s
[0.590430] Preparing to correct graph with cutoff 0.200000
[0.591343] Cleaning memory
[0.591363] Deactivating local correction settings
[0.591378] Pebble done.
[0.591379] Starting pebble resolution...
[0.591487] Computing read to node mapping array sizes
[0.591670] Computing read to node mappings
[0.591908] Estimating library insert lengths...
[0.592072] Paired-end library 1 has length: 79, sample standard deviation: 60
[0.592074] Done
[0.592077] Computing direct node to node mappings
[0.592206] Scaffolding node 0
[0.592668]  === Nodes Scaffolded in 0.000591 s
[0.592804] Preparing to correct graph with cutoff 0.200000
[0.593715] Cleaning memory
[0.593717] Deactivating local correction settings
[0.593731] Pebble done.
[0.593731] Concatenation...
[0.593767] Renumbering nodes
[0.593768] Initial node count 2166
[0.593771] Removed 0 null nodes
[0.593783] Concatenation over!
[0.593784] Removing reference contigs with coverage < 0.557047...
[0.593856] Concatenation...
[0.593890] Renumbering nodes
[0.593890] Initial node count 2166
[0.593893] Removed 0 null nodes
[0.593902] Concatenation over!
[0.594808] Writing contigs into spodar.velvet.19.d/contigs.fa...
[0.621517] Writing into stats file spodar.velvet.19.d/stats.txt...
[0.631470] Writing into graph file spodar.velvet.19.d/LastGraph...
[0.668660] Estimated Coverage = 1.114094
[0.668674] Estimated Coverage cutoff = 0.557047
Final graph has 2166 nodes and n50 of 144, max 297, total 231585, using 3609/18276 reads
[0.000000] Reading FastQ file spodar.pe.qc.fq.gz;
[0.068840] 18014 sequences found
[0.068844] Done
[0.069214] Reading FastQ file spodar.se.qc.fq.gz;
[0.070398] 262 sequences found
[0.070400] Done
[0.156796] Reading read set file spodar.velvet.21.d/Sequences;
[0.159841] 18276 sequences found
[0.174533] Done
[0.174540] 18276 sequences in total.
[0.175449] Writing into roadmap file spodar.velvet.21.d/Roadmaps...
[0.181492] Inputting sequences...
[0.181606] Inputting sequence 0 / 18276
[0.484589]  === Sequences loaded in 0.303113 s
[0.488977] Done inputting sequences
[0.488986] Destroying splay table
[0.494046] Splay table destroyed
[0.000000] Reading roadmap file spodar.velvet.21.d/Roadmaps
[0.009908] 18276 roadmaps read
[0.010239] Creating insertion markers
[0.010566] Ordering insertion markers
[0.010987] Counting preNodes
[0.011209] 5141 preNodes counted, creating them now
[0.030651] Adjusting marker info...
[0.030742] Connecting preNodes
[0.031590] Cleaning up memory
[0.031592] Done creating preGraph
[0.031593] Concatenation...
[0.033255] Renumbering preNodes
[0.033257] Initial preNode count 5141
[0.033335] Destroyed 2996 preNodes
[0.033336] Concatenation over!
[0.033336] Clipping short tips off preGraph
[0.033770] Concatenation...
[0.033881] Renumbering preNodes
[0.033882] Initial preNode count 2145
[0.033933] Destroyed 184 preNodes
[0.033934] Concatenation over!
[0.033934] 130 tips cut off
[0.033935] 1961 nodes left
[0.034523] Writing into pregraph file spodar.velvet.21.d/PreGraph...
[0.052382] Reading read set file spodar.velvet.21.d/Sequences;
[0.055710] 18276 sequences found
[0.070546] Done
[0.076549] Reading pre-graph file spodar.velvet.21.d/PreGraph
[0.076761] Graph has 1961 nodes and 18276 sequences
[0.084061] Scanning pre-graph file spodar.velvet.21.d/PreGraph for k-mers
[0.086788] 205707 kmers found
[0.100099] Sorting kmer occurence table ... 
[0.159138] Sorting done.
[0.159144] Computing acceleration table... 
[0.179004] Computing offsets... 
[0.180343] Ghost Threading through reads 0 / 18276
[0.352117]  === Ghost-Threaded in 0.171788 s
[0.352123] Threading through reads 0 / 18276
[0.519189]  === Threaded in 0.167069 s
[0.519796] Correcting graph with cutoff 0.200000
[0.519919] Determining eligible starting points
[0.520656] Done listing starting nodes
[0.520657] Initializing todo lists
[0.520708] Done with initilization
[0.520709] Activating arc lookup table
[0.520752] Done activating arc lookup table
[0.522385] Concatenation...
[0.522416] Renumbering nodes
[0.522417] Initial node count 1961
[0.522442] Removed 25 null nodes
[0.522443] Concatenation over!
[0.522443] Clipping short tips off graph, drastic
[0.522775] Concatenation...
[0.522825] Renumbering nodes
[0.522825] Initial node count 1936
[0.522852] Removed 126 null nodes
[0.522853] Concatenation over!
[0.522853] 1810 nodes left
[0.523616] Writing into graph file spodar.velvet.21.d/Graph2...
[0.555239] Measuring median coverage depth...
[0.555699] Median coverage depth = 1.125000
[0.556610] Removing contigs with coverage < 0.562500...
[0.556651] Concatenation...
[0.556677] Renumbering nodes
[0.556678] Initial node count 1810
[0.556681] Removed 0 null nodes
[0.556681] Concatenation over!
[0.556716] Concatenation...
[0.556747] Renumbering nodes
[0.556748] Initial node count 1810
[0.556750] Removed 0 null nodes
[0.556751] Concatenation over!
[0.556753] Clipping short tips off graph, drastic
[0.556830] Concatenation...
[0.556855] Renumbering nodes
[0.556856] Initial node count 1810
[0.556859] Removed 0 null nodes
[0.556860] Concatenation over!
[0.556860] 1810 nodes left
[0.556861] Read coherency...
[0.556876] Identifying unique nodes
[0.556908] Done, 1346 unique nodes counted
[0.556909] Trimming read tips
[0.556959] Renumbering nodes
[0.556959] Initial node count 1810
[0.556962] Removed 0 null nodes
[0.556962] Confronted to 0 multiple hits and 0 null over 0
[0.556963] Read coherency over!
[0.557093] Starting pebble resolution...
[0.557195] Computing read to node mapping array sizes
[0.557350] Computing read to node mappings
[0.557515] Estimating library insert lengths...
[0.557675] Paired-end library 1 has length: 79, sample standard deviation: 59
[0.557676] Done
[0.557680] Computing direct node to node mappings
[0.557787] Scaffolding node 0
[0.557985]  === Nodes Scaffolded in 0.000305 s
[0.558068] Preparing to correct graph with cutoff 0.200000
[0.558508] Cleaning memory
[0.558519] Deactivating local correction settings
[0.558533] Pebble done.
[0.558533] Starting pebble resolution...
[0.558635] Computing read to node mapping array sizes
[0.558804] Computing read to node mappings
[0.558972] Estimating library insert lengths...
[0.559133] Paired-end library 1 has length: 79, sample standard deviation: 59
[0.559134] Done
[0.559141] Computing direct node to node mappings
[0.559256] Scaffolding node 0
[0.559455]  === Nodes Scaffolded in 0.000314 s
[0.559544] Preparing to correct graph with cutoff 0.200000
[0.560024] Cleaning memory
[0.560026] Deactivating local correction settings
[0.560042] Pebble done.
[0.560043] Concatenation...
[0.560073] Renumbering nodes
[0.560074] Initial node count 1810
[0.560078] Removed 0 null nodes
[0.560085] Concatenation over!
[0.560086] Removing reference contigs with coverage < 0.562500...
[0.560146] Concatenation...
[0.560172] Renumbering nodes
[0.560173] Initial node count 1810
[0.560175] Removed 0 null nodes
[0.560183] Concatenation over!
[0.561471] Writing contigs into spodar.velvet.21.d/contigs.fa...
[0.614714] Writing into stats file spodar.velvet.21.d/stats.txt...
[0.622680] Writing into graph file spodar.velvet.21.d/LastGraph...
[0.654622] Estimated Coverage = 1.125000
[0.654633] Estimated Coverage cutoff = 0.562500
Final graph has 1810 nodes and n50 of 141, max 289, total 204091, using 3237/18276 reads
[0.000000] Reading FastQ file spodar.pe.qc.fq.gz;
[0.068701] 18014 sequences found
[0.068705] Done
[0.068992] Reading FastQ file spodar.se.qc.fq.gz;
[0.070198] 262 sequences found
[0.070200] Done
[0.156599] Reading read set file spodar.velvet.23.d/Sequences;
[0.159640] 18276 sequences found
[0.174119] Done
[0.174125] 18276 sequences in total.
[0.175154] Writing into roadmap file spodar.velvet.23.d/Roadmaps...
[0.181263] Inputting sequences...
[0.181370] Inputting sequence 0 / 18276
[0.476836]  === Sequences loaded in 0.295588 s
[0.480939] Done inputting sequences
[0.480947] Destroying splay table
[0.486331] Splay table destroyed
[0.000000] Reading roadmap file spodar.velvet.23.d/Roadmaps
[0.009726] 18276 roadmaps read
[0.009969] Creating insertion markers
[0.010276] Ordering insertion markers
[0.010630] Counting preNodes
[0.010836] 4504 preNodes counted, creating them now
[0.030083] Adjusting marker info...
[0.030160] Connecting preNodes
[0.030942] Cleaning up memory
[0.030944] Done creating preGraph
[0.030945] Concatenation...
[0.032448] Renumbering preNodes
[0.032449] Initial preNode count 4504
[0.032503] Destroyed 2762 preNodes
[0.032503] Concatenation over!
[0.032504] Clipping short tips off preGraph
[0.032842] Concatenation...
[0.032927] Renumbering preNodes
[0.032927] Initial preNode count 1742
[0.032959] Destroyed 165 preNodes
[0.032960] Concatenation over!
[0.032960] 115 tips cut off
[0.032961] 1577 nodes left
[0.033688] Writing into pregraph file spodar.velvet.23.d/PreGraph...
[0.049480] Reading read set file spodar.velvet.23.d/Sequences;
[0.052492] 18276 sequences found
[0.067219] Done
[0.073275] Reading pre-graph file spodar.velvet.23.d/PreGraph
[0.073472] Graph has 1577 nodes and 18276 sequences
[0.080116] Scanning pre-graph file spodar.velvet.23.d/PreGraph for k-mers
[0.082598] 176273 kmers found
[0.094449] Sorting kmer occurence table ... 
[0.144170] Sorting done.
[0.144174] Computing acceleration table... 
[0.163475] Computing offsets... 
[0.164620] Ghost Threading through reads 0 / 18276
[0.329685]  === Ghost-Threaded in 0.165077 s
[0.329691] Threading through reads 0 / 18276
[0.497377]  === Threaded in 0.167688 s
[0.498067] Correcting graph with cutoff 0.200000
[0.498176] Determining eligible starting points
[0.498741] Done listing starting nodes
[0.498742] Initializing todo lists
[0.498777] Done with initilization
[0.498777] Activating arc lookup table
[0.498804] Done activating arc lookup table
[0.500213] Concatenation...
[0.500237] Renumbering nodes
[0.500242] Initial node count 1577
[0.500264] Removed 10 null nodes
[0.500264] Concatenation over!
[0.500265] Clipping short tips off graph, drastic
[0.500474] Concatenation...
[0.500516] Renumbering nodes
[0.500517] Initial node count 1567
[0.500538] Removed 92 null nodes
[0.500538] Concatenation over!
[0.500539] 1475 nodes left
[0.501625] Writing into graph file spodar.velvet.23.d/Graph2...
[0.547590] Measuring median coverage depth...
[0.547996] Median coverage depth = 1.153285
[0.549261] Removing contigs with coverage < 0.576642...
[0.549311] Concatenation...
[0.549337] Renumbering nodes
[0.549338] Initial node count 1475
[0.549341] Removed 0 null nodes
[0.549342] Concatenation over!
[0.549370] Concatenation...
[0.549388] Renumbering nodes
[0.549389] Initial node count 1475
[0.549391] Removed 0 null nodes
[0.549391] Concatenation over!
[0.549394] Clipping short tips off graph, drastic
[0.549460] Concatenation...
[0.549478] Renumbering nodes
[0.549479] Initial node count 1475
[0.549481] Removed 0 null nodes
[0.549481] Concatenation over!
[0.549481] 1475 nodes left
[0.549483] Read coherency...
[0.549494] Identifying unique nodes
[0.549520] Done, 1156 unique nodes counted
[0.549520] Trimming read tips
[0.549559] Renumbering nodes
[0.549559] Initial node count 1475
[0.549561] Removed 0 null nodes
[0.549562] Confronted to 0 multiple hits and 0 null over 0
[0.549562] Read coherency over!
[0.549693] Starting pebble resolution...
[0.549804] Computing read to node mapping array sizes
[0.549956] Computing read to node mappings
[0.550091] Estimating library insert lengths...
[0.550253] Paired-end library 1 has length: 79, sample standard deviation: 58
[0.550255] Done
[0.550258] Computing direct node to node mappings
[0.550354] Scaffolding node 0
[0.550458]  === Nodes Scaffolded in 0.000198 s
[0.550523] Preparing to correct graph with cutoff 0.200000
[0.551236] Cleaning memory
[0.551258] Deactivating local correction settings
[0.551270] Pebble done.
[0.551271] Starting pebble resolution...
[0.551370] Computing read to node mapping array sizes
[0.551505] Computing read to node mappings
[0.551638] Estimating library insert lengths...
[0.551795] Paired-end library 1 has length: 79, sample standard deviation: 58
[0.551796] Done
[0.551798] Computing direct node to node mappings
[0.552306] Scaffolding node 0
[0.552825]  === Nodes Scaffolded in 0.001027 s
[0.552893] Preparing to correct graph with cutoff 0.200000
[0.553611] Cleaning memory
[0.553614] Deactivating local correction settings
[0.553624] Pebble done.
[0.553625] Concatenation...
[0.553646] Renumbering nodes
[0.553646] Initial node count 1475
[0.553649] Removed 0 null nodes
[0.553655] Concatenation over!
[0.553655] Removing reference contigs with coverage < 0.576642...
[0.553705] Concatenation...
[0.553724] Renumbering nodes
[0.553724] Initial node count 1475
[0.553726] Removed 0 null nodes
[0.553731] Concatenation over!
[0.554678] Writing contigs into spodar.velvet.23.d/contigs.fa...
[0.575179] Writing into stats file spodar.velvet.23.d/stats.txt...
[0.582212] Writing into graph file spodar.velvet.23.d/LastGraph...
[0.609723] Estimated Coverage = 1.153285
[0.609733] Estimated Coverage cutoff = 0.576642
Final graph has 1475 nodes and n50 of 138, max 262, total 174938, using 2882/18276 reads
[0.000000] Reading FastQ file spodar.pe.qc.fq.gz;
[0.069149] 18014 sequences found
[0.069154] Done
[0.069412] Reading FastQ file spodar.se.qc.fq.gz;
[0.074879] 262 sequences found
[0.074887] Done
[0.161155] Reading read set file spodar.velvet.25.d/Sequences;
[0.164750] 18276 sequences found
[0.179885] Done
[0.179890] 18276 sequences in total.
[0.180871] Writing into roadmap file spodar.velvet.25.d/Roadmaps...
[0.186863] Inputting sequences...
[0.186973] Inputting sequence 0 / 18276
[0.470925]  === Sequences loaded in 0.284076 s
[0.475283] Done inputting sequences
[0.475299] Destroying splay table
[0.481794] Splay table destroyed
[0.000000] Reading roadmap file spodar.velvet.25.d/Roadmaps
[0.010160] 18276 roadmaps read
[0.010622] Creating insertion markers
[0.010952] Ordering insertion markers
[0.011298] Counting preNodes
[0.011497] 4077 preNodes counted, creating them now
[0.031043] Adjusting marker info...
[0.031106] Connecting preNodes
[0.031816] Cleaning up memory
[0.031818] Done creating preGraph
[0.031819] Concatenation...
[0.033172] Renumbering preNodes
[0.033173] Initial preNode count 4077
[0.033217] Destroyed 2540 preNodes
[0.033218] Concatenation over!
[0.033218] Clipping short tips off preGraph
[0.033509] Concatenation...
[0.033581] Renumbering preNodes
[0.033581] Initial preNode count 1537
[0.033606] Destroyed 161 preNodes
[0.033606] Concatenation over!
[0.033606] 115 tips cut off
[0.033607] 1376 nodes left
[0.035874] Writing into pregraph file spodar.velvet.25.d/PreGraph...
[0.084994] Reading read set file spodar.velvet.25.d/Sequences;
[0.088150] 18276 sequences found
[0.103502] Done
[0.109597] Reading pre-graph file spodar.velvet.25.d/PreGraph
[0.109774] Graph has 1376 nodes and 18276 sequences
[0.115366] Scanning pre-graph file spodar.velvet.25.d/PreGraph for k-mers
[0.116936] 155234 kmers found
[0.126719] Sorting kmer occurence table ... 
[0.170690] Sorting done.
[0.170696] Computing acceleration table... 
[0.190059] Computing offsets... 
[0.191073] Ghost Threading through reads 0 / 18276
[0.350031]  === Ghost-Threaded in 0.158969 s
[0.350037] Threading through reads 0 / 18276
[0.511768]  === Threaded in 0.161733 s
[0.512126] Correcting graph with cutoff 0.200000
[0.512226] Determining eligible starting points
[0.512693] Done listing starting nodes
[0.512694] Initializing todo lists
[0.512722] Done with initilization
[0.512722] Activating arc lookup table
[0.512744] Done activating arc lookup table
[0.514016] Concatenation...
[0.514035] Renumbering nodes
[0.514036] Initial node count 1376
[0.514050] Removed 13 null nodes
[0.514051] Concatenation over!
[0.514051] Clipping short tips off graph, drastic
[0.514234] Concatenation...
[0.514270] Renumbering nodes
[0.514270] Initial node count 1363
[0.514288] Removed 63 null nodes
[0.514288] Concatenation over!
[0.514288] 1300 nodes left
[0.514918] Writing into graph file spodar.velvet.25.d/Graph2...
[0.542520] Measuring median coverage depth...
[0.542853] Median coverage depth = 1.166667
[0.544242] Removing contigs with coverage < 0.583333...
[0.544272] Concatenation...
[0.544289] Renumbering nodes
[0.544289] Initial node count 1300
[0.544292] Removed 0 null nodes
[0.544292] Concatenation over!
[0.544317] Concatenation...
[0.544333] Renumbering nodes
[0.544333] Initial node count 1300
[0.544335] Removed 0 null nodes
[0.544336] Concatenation over!
[0.544338] Clipping short tips off graph, drastic
[0.544396] Concatenation...
[0.544411] Renumbering nodes
[0.544412] Initial node count 1300
[0.544413] Removed 0 null nodes
[0.544414] Concatenation over!
[0.544414] 1300 nodes left
[0.544415] Read coherency...
[0.544425] Identifying unique nodes
[0.544447] Done, 1030 unique nodes counted
[0.544448] Trimming read tips
[0.544481] Renumbering nodes
[0.544482] Initial node count 1300
[0.544484] Removed 0 null nodes
[0.544484] Confronted to 0 multiple hits and 0 null over 0
[0.544485] Read coherency over!
[0.544614] Starting pebble resolution...
[0.544718] Computing read to node mapping array sizes
[0.544842] Computing read to node mappings
[0.544965] Estimating library insert lengths...
[0.545122] Paired-end library 1 has length: 74, sample standard deviation: 53
[0.545124] Done
[0.545127] Computing direct node to node mappings
[0.545208] Scaffolding node 0
[0.545299]  === Nodes Scaffolded in 0.000171 s
[0.545356] Preparing to correct graph with cutoff 0.200000
[0.545628] Cleaning memory
[0.545636] Deactivating local correction settings
[0.545646] Pebble done.
[0.545646] Starting pebble resolution...
[0.545739] Computing read to node mapping array sizes
[0.545864] Computing read to node mappings
[0.545981] Estimating library insert lengths...
[0.546134] Paired-end library 1 has length: 74, sample standard deviation: 53
[0.546135] Done
[0.546137] Computing direct node to node mappings
[0.546212] Scaffolding node 0
[0.546299]  === Nodes Scaffolded in 0.000162 s
[0.546352] Preparing to correct graph with cutoff 0.200000
[0.546597] Cleaning memory
[0.546598] Deactivating local correction settings
[0.546607] Pebble done.
[0.546607] Concatenation...
[0.546624] Renumbering nodes
[0.546624] Initial node count 1300
[0.546626] Removed 0 null nodes
[0.546631] Concatenation over!
[0.546631] Removing reference contigs with coverage < 0.583333...
[0.546675] Concatenation...
[0.546690] Renumbering nodes
[0.546691] Initial node count 1300
[0.546693] Removed 0 null nodes
[0.546697] Concatenation over!
[0.547794] Writing contigs into spodar.velvet.25.d/contigs.fa...
[0.566725] Writing into stats file spodar.velvet.25.d/stats.txt...
[0.573248] Writing into graph file spodar.velvet.25.d/LastGraph...
[0.597693] Estimated Coverage = 1.166667
[0.597705] Estimated Coverage cutoff = 0.583333
Final graph has 1300 nodes and n50 of 134, max 260, total 153918, using 2623/18276 reads
[0.000000] Reading FastQ file spodar.pe.qc.fq.gz;
[0.069561] 18014 sequences found
[0.069566] Done
[0.069913] Reading FastQ file spodar.se.qc.fq.gz;
[0.071160] 262 sequences found
[0.071163] Done
[0.187822] Reading read set file spodar.velvet.27.d/Sequences;
[0.190910] 18276 sequences found
[0.205686] Done
[0.205693] 18276 sequences in total.
[0.207714] Writing into roadmap file spodar.velvet.27.d/Roadmaps...
[0.214059] Inputting sequences...
[0.214272] Inputting sequence 0 / 18276
[0.497810]  === Sequences loaded in 0.283786 s
[0.503359] Done inputting sequences
[0.503363] Destroying splay table
[0.508173] Splay table destroyed
[0.000001] Reading roadmap file spodar.velvet.27.d/Roadmaps
[0.015913] 18276 roadmaps read
[0.016227] Creating insertion markers
[0.016524] Ordering insertion markers
[0.016855] Counting preNodes
[0.017048] 3784 preNodes counted, creating them now
[0.036749] Adjusting marker info...
[0.036819] Connecting preNodes
[0.037541] Cleaning up memory
[0.037544] Done creating preGraph
[0.037544] Concatenation...
[0.038807] Renumbering preNodes
[0.038809] Initial preNode count 3784
[0.038849] Destroyed 2370 preNodes
[0.038850] Concatenation over!
[0.038851] Clipping short tips off preGraph
[0.039116] Concatenation...
[0.039179] Renumbering preNodes
[0.039180] Initial preNode count 1414
[0.039201] Destroyed 163 preNodes
[0.039201] Concatenation over!
[0.039202] 124 tips cut off
[0.039202] 1251 nodes left
[0.040151] Writing into pregraph file spodar.velvet.27.d/PreGraph...
[0.053853] Reading read set file spodar.velvet.27.d/Sequences;
[0.056950] 18276 sequences found
[0.071983] Done
[0.077689] Reading pre-graph file spodar.velvet.27.d/PreGraph
[0.077822] Graph has 1251 nodes and 18276 sequences
[0.083236] Scanning pre-graph file spodar.velvet.27.d/PreGraph for k-mers
[0.084699] 139539 kmers found
[0.094594] Sorting kmer occurence table ... 
[0.134504] Sorting done.
[0.134511] Computing acceleration table... 
[0.155476] Computing offsets... 
[0.156409] Ghost Threading through reads 0 / 18276
[0.310648]  === Ghost-Threaded in 0.154251 s
[0.310654] Threading through reads 0 / 18276
[0.461054]  === Threaded in 0.150402 s
[0.461747] Correcting graph with cutoff 0.200000
[0.461853] Determining eligible starting points
[0.462274] Done listing starting nodes
[0.462275] Initializing todo lists
[0.462303] Done with initilization
[0.462304] Activating arc lookup table
[0.462326] Done activating arc lookup table
[0.463241] Concatenation...
[0.463258] Renumbering nodes
[0.463259] Initial node count 1251
[0.463273] Removed 13 null nodes
[0.463273] Concatenation over!
[0.463274] Clipping short tips off graph, drastic
[0.463659] Concatenation...
[0.463690] Renumbering nodes
[0.463690] Initial node count 1238
[0.463705] Removed 71 null nodes
[0.463705] Concatenation over!
[0.463705] 1167 nodes left
[0.464488] Writing into graph file spodar.velvet.27.d/Graph2...
[0.486613] Measuring median coverage depth...
[0.486915] Median coverage depth = 1.171875
[0.487820] Removing contigs with coverage < 0.585938...
[0.487850] Concatenation...
[0.487865] Renumbering nodes
[0.487865] Initial node count 1167
[0.487868] Removed 0 null nodes
[0.487869] Concatenation over!
[0.487891] Concatenation...
[0.487905] Renumbering nodes
[0.487905] Initial node count 1167
[0.487907] Removed 0 null nodes
[0.487907] Concatenation over!
[0.487909] Clipping short tips off graph, drastic
[0.487962] Concatenation...
[0.487976] Renumbering nodes
[0.487976] Initial node count 1167
[0.487978] Removed 0 null nodes
[0.487978] Concatenation over!
[0.487978] 1167 nodes left
[0.487980] Read coherency...
[0.487987] Identifying unique nodes
[0.488007] Done, 951 unique nodes counted
[0.488008] Trimming read tips
[0.488037] Renumbering nodes
[0.488038] Initial node count 1167
[0.488039] Removed 0 null nodes
[0.488040] Confronted to 0 multiple hits and 0 null over 0
[0.488040] Read coherency over!
[0.488170] Starting pebble resolution...
[0.488275] Computing read to node mapping array sizes
[0.488405] Computing read to node mappings
[0.488512] Estimating library insert lengths...
[0.488665] Paired-end library 1 has length: 74, sample standard deviation: 48
[0.488666] Done
[0.488669] Computing direct node to node mappings
[0.488736] Scaffolding node 0
[0.488805]  === Nodes Scaffolded in 0.000136 s
[0.488856] Preparing to correct graph with cutoff 0.200000
[0.489471] Cleaning memory
[0.489642] Deactivating local correction settings
[0.489651] Pebble done.
[0.489652] Starting pebble resolution...
[0.489743] Computing read to node mapping array sizes
[0.489852] Computing read to node mappings
[0.489956] Estimating library insert lengths...
[0.490107] Paired-end library 1 has length: 74, sample standard deviation: 48
[0.490108] Done
[0.490110] Computing direct node to node mappings
[0.490173] Scaffolding node 0
[0.490250]  === Nodes Scaffolded in 0.000140 s
[0.490297] Preparing to correct graph with cutoff 0.200000
[0.490512] Cleaning memory
[0.490514] Deactivating local correction settings
[0.490522] Pebble done.
[0.490522] Concatenation...
[0.490536] Renumbering nodes
[0.490537] Initial node count 1167
[0.490539] Removed 0 null nodes
[0.490543] Concatenation over!
[0.490543] Removing reference contigs with coverage < 0.585938...
[0.490582] Concatenation...
[0.490596] Renumbering nodes
[0.490596] Initial node count 1167
[0.490598] Removed 0 null nodes
[0.490602] Concatenation over!
[0.491822] Writing contigs into spodar.velvet.27.d/contigs.fa...
[0.510034] Writing into stats file spodar.velvet.27.d/stats.txt...
[0.532183] Writing into graph file spodar.velvet.27.d/LastGraph...
[0.553697] Estimated Coverage = 1.171875
[0.553704] Estimated Coverage cutoff = 0.585938
Final graph has 1167 nodes and n50 of 131, max 245, total 138118, using 2418/18276 reads
[0.000001] Reading FastQ file spodar.pe.qc.fq.gz;
[0.068585] 18014 sequences found
[0.068590] Done
[0.068909] Reading FastQ file spodar.se.qc.fq.gz;
[0.070134] 262 sequences found
[0.070136] Done
[0.155414] Reading read set file spodar.velvet.29.d/Sequences;
[0.158550] 18276 sequences found
[0.173627] Done
[0.173633] 18276 sequences in total.
[0.174420] Writing into roadmap file spodar.velvet.29.d/Roadmaps...
[0.181142] Inputting sequences...
[0.181265] Inputting sequence 0 / 18276
[0.457340]  === Sequences loaded in 0.276215 s
[0.461253] Done inputting sequences
[0.461256] Destroying splay table
[0.466022] Splay table destroyed
[0.000001] Reading roadmap file spodar.velvet.29.d/Roadmaps
[0.009639] 18276 roadmaps read
[0.010014] Creating insertion markers
[0.010316] Ordering insertion markers
[0.010644] Counting preNodes
[0.010833] 3530 preNodes counted, creating them now
[0.031030] Adjusting marker info...
[0.031089] Connecting preNodes
[0.031764] Cleaning up memory
[0.031767] Done creating preGraph
[0.031767] Concatenation...
[0.032932] Renumbering preNodes
[0.032933] Initial preNode count 3530
[0.032969] Destroyed 2210 preNodes
[0.032969] Concatenation over!
[0.032970] Clipping short tips off preGraph
[0.033220] Concatenation...
[0.033278] Renumbering preNodes
[0.033279] Initial preNode count 1320
[0.033298] Destroyed 172 preNodes
[0.033299] Concatenation over!
[0.033299] 133 tips cut off
[0.033299] 1148 nodes left
[0.033780] Writing into pregraph file spodar.velvet.29.d/PreGraph...
[0.045732] Reading read set file spodar.velvet.29.d/Sequences;
[0.048795] 18276 sequences found
[0.064283] Done
[0.070381] Reading pre-graph file spodar.velvet.29.d/PreGraph
[0.070538] Graph has 1148 nodes and 18276 sequences
[0.075719] Scanning pre-graph file spodar.velvet.29.d/PreGraph for k-mers
[0.077069] 126267 kmers found
[0.086239] Sorting kmer occurence table ... 
[0.120960] Sorting done.
[0.120963] Computing acceleration table... 
[0.139456] Computing offsets... 
[0.140283] Ghost Threading through reads 0 / 18276
[0.286918]  === Ghost-Threaded in 0.146645 s
[0.286926] Threading through reads 0 / 18276
[0.444539]  === Threaded in 0.157616 s
[0.445145] Correcting graph with cutoff 0.200000
[0.445248] Determining eligible starting points
[0.445636] Done listing starting nodes
[0.445637] Initializing todo lists
[0.445658] Done with initilization
[0.445659] Activating arc lookup table
[0.445677] Done activating arc lookup table
[0.445918] Concatenation...
[0.445934] Renumbering nodes
[0.445934] Initial node count 1148
[0.445942] Removed 3 null nodes
[0.445943] Concatenation over!
[0.445943] Clipping short tips off graph, drastic
[0.446250] Concatenation...
[0.446275] Renumbering nodes
[0.446275] Initial node count 1145
[0.446288] Removed 69 null nodes
[0.446289] Concatenation over!
[0.446289] 1076 nodes left
[0.447074] Writing into graph file spodar.velvet.29.d/Graph2...
[0.466918] Measuring median coverage depth...
[0.467199] Median coverage depth = 1.177419
[0.467968] Removing contigs with coverage < 0.588710...
[0.467996] Concatenation...
[0.468011] Renumbering nodes
[0.468012] Initial node count 1076
[0.468014] Removed 0 null nodes
[0.468015] Concatenation over!
[0.468036] Concatenation...
[0.468048] Renumbering nodes
[0.468048] Initial node count 1076
[0.468050] Removed 0 null nodes
[0.468050] Concatenation over!
[0.468053] Clipping short tips off graph, drastic
[0.468103] Concatenation...
[0.468115] Renumbering nodes
[0.468115] Initial node count 1076
[0.468117] Removed 0 null nodes
[0.468117] Concatenation over!
[0.468118] 1076 nodes left
[0.468119] Read coherency...
[0.468126] Identifying unique nodes
[0.468144] Done, 883 unique nodes counted
[0.468145] Trimming read tips
[0.468172] Renumbering nodes
[0.468172] Initial node count 1076
[0.468174] Removed 0 null nodes
[0.468174] Confronted to 0 multiple hits and 0 null over 0
[0.468175] Read coherency over!
[0.468310] Starting pebble resolution...
[0.468415] Computing read to node mapping array sizes
[0.468533] Computing read to node mappings
[0.468632] Estimating library insert lengths...
[0.468784] Paired-end library 1 has length: 85, sample standard deviation: 46
[0.468785] Done
[0.468788] Computing direct node to node mappings
[0.468852] Scaffolding node 0
[0.468918]  === Nodes Scaffolded in 0.000130 s
[0.468965] Preparing to correct graph with cutoff 0.200000
[0.469574] Cleaning memory
[0.469748] Deactivating local correction settings
[0.469757] Pebble done.
[0.469758] Starting pebble resolution...
[0.469848] Computing read to node mapping array sizes
[0.469952] Computing read to node mappings
[0.470047] Estimating library insert lengths...
[0.470197] Paired-end library 1 has length: 85, sample standard deviation: 46
[0.470198] Done
[0.470200] Computing direct node to node mappings
[0.470265] Scaffolding node 0
[0.470329]  === Nodes Scaffolded in 0.000129 s
[0.470372] Preparing to correct graph with cutoff 0.200000
[0.470565] Cleaning memory
[0.470567] Deactivating local correction settings
[0.470574] Pebble done.
[0.470574] Concatenation...
[0.470587] Renumbering nodes
[0.470588] Initial node count 1076
[0.470590] Removed 0 null nodes
[0.470593] Concatenation over!
[0.470594] Removing reference contigs with coverage < 0.588710...
[0.470629] Concatenation...
[0.470641] Renumbering nodes
[0.470642] Initial node count 1076
[0.470643] Removed 0 null nodes
[0.470647] Concatenation over!
[0.471451] Writing contigs into spodar.velvet.29.d/contigs.fa...
[0.487168] Writing into stats file spodar.velvet.29.d/stats.txt...
[0.492769] Writing into graph file spodar.velvet.29.d/LastGraph...
[0.512537] Estimated Coverage = 1.177419
[0.512546] Estimated Coverage cutoff = 0.588710
Final graph has 1076 nodes and n50 of 127, max 243, total 124663, using 2233/18276 reads
[0.000001] Reading FastQ file spodar.pe.qc.fq.gz;
[0.068823] 18014 sequences found
[0.068827] Done
[0.069166] Reading FastQ file spodar.se.qc.fq.gz;
[0.070356] 262 sequences found
[0.070358] Done
[0.156276] Reading read set file spodar.velvet.31.d/Sequences;
[0.159273] 18276 sequences found
[0.173030] Done
[0.173032] 18276 sequences in total.
[0.173730] Writing into roadmap file spodar.velvet.31.d/Roadmaps...
[0.179738] Inputting sequences...
[0.179837] Inputting sequence 0 / 18276
[0.575052]  === Sequences loaded in 0.395320 s
[0.579072] Done inputting sequences
[0.579079] Destroying splay table
[0.585438] Splay table destroyed
[0.000000] Reading roadmap file spodar.velvet.31.d/Roadmaps
[0.013909] 18276 roadmaps read
[0.018482] Creating insertion markers
[0.018786] Ordering insertion markers
[0.019106] Counting preNodes
[0.019290] 3268 preNodes counted, creating them now
[0.039918] Adjusting marker info...
[0.039962] Connecting preNodes
[0.040594] Cleaning up memory
[0.040595] Done creating preGraph
[0.040596] Concatenation...
[0.041667] Renumbering preNodes
[0.041667] Initial preNode count 3268
[0.041699] Destroyed 2059 preNodes
[0.041699] Concatenation over!
[0.041700] Clipping short tips off preGraph
[0.041925] Concatenation...
[0.041973] Renumbering preNodes
[0.041973] Initial preNode count 1209
[0.041989] Destroyed 166 preNodes
[0.041989] Concatenation over!
[0.041989] 134 tips cut off
[0.041990] 1043 nodes left
[0.044040] Writing into pregraph file spodar.velvet.31.d/PreGraph...
[0.055641] Reading read set file spodar.velvet.31.d/Sequences;
[0.058553] 18276 sequences found
[0.073175] Done
[0.078984] Reading pre-graph file spodar.velvet.31.d/PreGraph
[0.079099] Graph has 1043 nodes and 18276 sequences
[0.083828] Scanning pre-graph file spodar.velvet.31.d/PreGraph for k-mers
[0.085458] 114024 kmers found
[0.093666] Sorting kmer occurence table ... 
[0.125866] Sorting done.
[0.125877] Computing acceleration table... 
[0.147452] Computing offsets... 
[0.148227] Ghost Threading through reads 0 / 18276
[0.274986]  === Ghost-Threaded in 0.126772 s
[0.274993] Threading through reads 0 / 18276
[0.425969]  === Threaded in 0.150978 s
[0.426667] Correcting graph with cutoff 0.200000
[0.426746] Determining eligible starting points
[0.427087] Done listing starting nodes
[0.427088] Initializing todo lists
[0.427106] Done with initilization
[0.427106] Activating arc lookup table
[0.427122] Done activating arc lookup table
[0.427967] Concatenation...
[0.427980] Renumbering nodes
[0.427981] Initial node count 1043
[0.427989] Removed 3 null nodes
[0.427990] Concatenation over!
[0.427990] Clipping short tips off graph, drastic
[0.428178] Concatenation...
[0.428197] Renumbering nodes
[0.428197] Initial node count 1040
[0.428208] Removed 46 null nodes
[0.428208] Concatenation over!
[0.428209] 994 nodes left
[0.473225] Writing into graph file spodar.velvet.31.d/Graph2...
[0.491800] Measuring median coverage depth...
[0.492061] Median coverage depth = 1.183333
[0.492927] Removing contigs with coverage < 0.591667...
[0.492964] Concatenation...
[0.492981] Renumbering nodes
[0.492982] Initial node count 994
[0.492984] Removed 0 null nodes
[0.492985] Concatenation over!
[0.493004] Concatenation...
[0.493016] Renumbering nodes
[0.493016] Initial node count 994
[0.493017] Removed 0 null nodes
[0.493018] Concatenation over!
[0.493021] Clipping short tips off graph, drastic
[0.493068] Concatenation...
[0.493080] Renumbering nodes
[0.493080] Initial node count 994
[0.493082] Removed 0 null nodes
[0.493082] Concatenation over!
[0.493082] 994 nodes left
[0.493084] Read coherency...
[0.493090] Identifying unique nodes
[0.493108] Done, 832 unique nodes counted
[0.493108] Trimming read tips
[0.493133] Renumbering nodes
[0.493134] Initial node count 994
[0.493135] Removed 0 null nodes
[0.493136] Confronted to 0 multiple hits and 0 null over 0
[0.493136] Read coherency over!
[0.493276] Starting pebble resolution...
[0.493445] Computing read to node mapping array sizes
[0.493614] Computing read to node mappings
[0.493709] Estimating library insert lengths...
[0.493862] Paired-end library 1 has length: 71, sample standard deviation: 43
[0.493863] Done
[0.493870] Computing direct node to node mappings
[0.493948] Scaffolding node 0
[0.494032]  === Nodes Scaffolded in 0.000161 s
[0.494082] Preparing to correct graph with cutoff 0.200000
[0.494985] Cleaning memory
[0.495167] Deactivating local correction settings
[0.495178] Pebble done.
[0.495178] Starting pebble resolution...
[0.495271] Computing read to node mapping array sizes
[0.495375] Computing read to node mappings
[0.495469] Estimating library insert lengths...
[0.495618] Paired-end library 1 has length: 71, sample standard deviation: 43
[0.495619] Done
[0.495620] Computing direct node to node mappings
[0.495675] Scaffolding node 0
[0.495737]  === Nodes Scaffolded in 0.000116 s
[0.495776] Preparing to correct graph with cutoff 0.200000
[0.495961] Cleaning memory
[0.495962] Deactivating local correction settings
[0.495969] Pebble done.
[0.495969] Concatenation...
[0.495982] Renumbering nodes
[0.495982] Initial node count 994
[0.495984] Removed 0 null nodes
[0.495987] Concatenation over!
[0.495988] Removing reference contigs with coverage < 0.591667...
[0.496021] Concatenation...
[0.496032] Renumbering nodes
[0.496033] Initial node count 994
[0.496034] Removed 0 null nodes
[0.496037] Concatenation over!
[0.496888] Writing contigs into spodar.velvet.31.d/contigs.fa...
[0.511614] Writing into stats file spodar.velvet.31.d/stats.txt...
[0.516912] Writing into graph file spodar.velvet.31.d/LastGraph...
[0.534846] Estimated Coverage = 1.183333
[0.534857] Estimated Coverage cutoff = 0.591667
Final graph has 994 nodes and n50 of 124, max 241, total 112778, using 2076/18276 reads
[0.000000] Reading FastQ file spodar.pe.qc.fq.gz;
[0.068538] 18014 sequences found
[0.068542] Done
[0.068872] Reading FastQ file spodar.se.qc.fq.gz;
[0.070177] 262 sequences found
[0.070180] Done
[0.155331] Reading read set file spodar.velvet.33.d/Sequences;
[0.158722] 18276 sequences found
[0.174911] Done
[0.174917] 18276 sequences in total.
[0.176803] Writing into roadmap file spodar.velvet.33.d/Roadmaps...
[0.183093] Inputting sequences...
[0.183211] Inputting sequence 0 / 18276
[0.457201]  === Sequences loaded in 0.274122 s
[0.461288] Done inputting sequences
[0.461292] Destroying splay table
[0.465857] Splay table destroyed
[0.000000] Reading roadmap file spodar.velvet.33.d/Roadmaps
[0.009321] 18276 roadmaps read
[0.009549] Creating insertion markers
[0.009836] Ordering insertion markers
[0.010146] Counting preNodes
[0.010325] 3060 preNodes counted, creating them now
[0.031768] Adjusting marker info...
[0.031824] Connecting preNodes
[0.032490] Cleaning up memory
[0.032492] Done creating preGraph
[0.032494] Concatenation...
[0.033539] Renumbering preNodes
[0.033540] Initial preNode count 3060
[0.033569] Destroyed 1924 preNodes
[0.033570] Concatenation over!
[0.033571] Clipping short tips off preGraph
[0.033782] Concatenation...
[0.033823] Renumbering preNodes
[0.033824] Initial preNode count 1136
[0.033838] Destroyed 172 preNodes
[0.033838] Concatenation over!
[0.033838] 146 tips cut off
[0.033839] 964 nodes left
[0.034497] Writing into pregraph file spodar.velvet.33.d/PreGraph...
[0.045383] Reading read set file spodar.velvet.33.d/Sequences;
[0.048788] 18276 sequences found
[0.064508] Done
[0.070435] Reading pre-graph file spodar.velvet.33.d/PreGraph
[0.070567] Graph has 964 nodes and 18276 sequences
[0.074741] Scanning pre-graph file spodar.velvet.33.d/PreGraph for k-mers
[0.075840] 103249 kmers found
[0.083724] Sorting kmer occurence table ... 
[0.112883] Sorting done.
[0.112889] Computing acceleration table... 
[0.131444] Computing offsets... 
[0.132130] Ghost Threading through reads 0 / 18276
[0.264929]  === Ghost-Threaded in 0.132809 s
[0.264937] Threading through reads 0 / 18276
[0.401670]  === Threaded in 0.136735 s
[0.402179] Correcting graph with cutoff 0.200000
[0.402254] Determining eligible starting points
[0.402567] Done listing starting nodes
[0.402567] Initializing todo lists
[0.402584] Done with initilization
[0.402584] Activating arc lookup table
[0.402598] Done activating arc lookup table
[0.402917] Concatenation...
[0.402929] Renumbering nodes
[0.402930] Initial node count 964
[0.402932] Removed 0 null nodes
[0.402934] Concatenation over!
[0.402935] Clipping short tips off graph, drastic
[0.403153] Concatenation...
[0.403170] Renumbering nodes
[0.403171] Initial node count 964
[0.403180] Removed 42 null nodes
[0.403181] Concatenation over!
[0.403181] 922 nodes left
[0.403807] Writing into graph file spodar.velvet.33.d/Graph2...
[0.420912] Measuring median coverage depth...
[0.421166] Median coverage depth = 1.179487
[0.422005] Removing contigs with coverage < 0.589744...
[0.422035] Concatenation...
[0.422048] Renumbering nodes
[0.422049] Initial node count 922
[0.422051] Removed 0 null nodes
[0.422052] Concatenation over!
[0.422070] Concatenation...
[0.422080] Renumbering nodes
[0.422080] Initial node count 922
[0.422082] Removed 0 null nodes
[0.422082] Concatenation over!
[0.422084] Clipping short tips off graph, drastic
[0.422128] Concatenation...
[0.422138] Renumbering nodes
[0.422138] Initial node count 922
[0.422140] Removed 0 null nodes
[0.422140] Concatenation over!
[0.422141] 922 nodes left
[0.422142] Read coherency...
[0.422148] Identifying unique nodes
[0.422164] Done, 777 unique nodes counted
[0.422164] Trimming read tips
[0.422187] Renumbering nodes
[0.422187] Initial node count 922
[0.422189] Removed 0 null nodes
[0.422189] Confronted to 0 multiple hits and 0 null over 0
[0.422190] Read coherency over!
[0.422320] Starting pebble resolution...
[0.422426] Computing read to node mapping array sizes
[0.422544] Computing read to node mappings
[0.422629] Estimating library insert lengths...
[0.422777] Paired-end library 1 has length: 70, sample standard deviation: 50
[0.422779] Done
[0.422782] Computing direct node to node mappings
[0.422830] Scaffolding node 0
[0.422889]  === Nodes Scaffolded in 0.000107 s
[0.422931] Preparing to correct graph with cutoff 0.200000
[0.423549] Cleaning memory
[0.423727] Deactivating local correction settings
[0.423736] Pebble done.
[0.423737] Starting pebble resolution...
[0.423830] Computing read to node mapping array sizes
[0.423927] Computing read to node mappings
[0.424009] Estimating library insert lengths...
[0.424156] Paired-end library 1 has length: 70, sample standard deviation: 50
[0.424161] Done
[0.424163] Computing direct node to node mappings
[0.424207] Scaffolding node 0
[0.424262]  === Nodes Scaffolded in 0.000098 s
[0.424300] Preparing to correct graph with cutoff 0.200000
[0.424474] Cleaning memory
[0.424476] Deactivating local correction settings
[0.424482] Pebble done.
[0.424483] Concatenation...
[0.424494] Renumbering nodes
[0.424494] Initial node count 922
[0.424496] Removed 0 null nodes
[0.424499] Concatenation over!
[0.424500] Removing reference contigs with coverage < 0.589744...
[0.424530] Concatenation...
[0.424541] Renumbering nodes
[0.424541] Initial node count 922
[0.424542] Removed 0 null nodes
[0.424545] Concatenation over!
[0.425246] Writing contigs into spodar.velvet.33.d/contigs.fa...
[0.439603] Writing into stats file spodar.velvet.33.d/stats.txt...
[0.444365] Writing into graph file spodar.velvet.33.d/LastGraph...
[0.460931] Estimated Coverage = 1.179487
[0.460940] Estimated Coverage cutoff = 0.589744
Final graph has 922 nodes and n50 of 120, max 239, total 102168, using 1924/18276 reads
[0.000000] Reading FastQ file spodar.pe.qc.fq.gz;
[0.069444] 18014 sequences found
[0.069448] Done
[0.069863] Reading FastQ file spodar.se.qc.fq.gz;
[0.071034] 262 sequences found
[0.071036] Done
[0.155925] Reading read set file spodar.velvet.35.d/Sequences;
[0.158970] 18276 sequences found
[0.174208] Done
[0.174215] 18276 sequences in total.
[0.204145] Writing into roadmap file spodar.velvet.35.d/Roadmaps...
[0.210317] Inputting sequences...
[0.210430] Inputting sequence 0 / 18276
[0.475971]  === Sequences loaded in 0.265668 s
[0.479945] Done inputting sequences
[0.479949] Destroying splay table
[0.484234] Splay table destroyed
[0.000001] Reading roadmap file spodar.velvet.35.d/Roadmaps
[0.009069] 18276 roadmaps read
[0.009244] Creating insertion markers
[0.009531] Ordering insertion markers
[0.009837] Counting preNodes
[0.010014] 2892 preNodes counted, creating them now
[0.030814] Adjusting marker info...
[0.030848] Connecting preNodes
[0.031449] Cleaning up memory
[0.031450] Done creating preGraph
[0.031451] Concatenation...
[0.032381] Renumbering preNodes
[0.032382] Initial preNode count 2892
[0.032408] Destroyed 1809 preNodes
[0.032408] Concatenation over!
[0.032408] Clipping short tips off preGraph
[0.032597] Concatenation...
[0.032629] Renumbering preNodes
[0.032630] Initial preNode count 1083
[0.032643] Destroyed 262 preNodes
[0.032643] Concatenation over!
[0.032644] 243 tips cut off
[0.032644] 821 nodes left
[0.033290] Writing into pregraph file spodar.velvet.35.d/PreGraph...
[0.042435] Reading read set file spodar.velvet.35.d/Sequences;
[0.045103] 18276 sequences found
[0.060144] Done
[0.066192] Reading pre-graph file spodar.velvet.35.d/PreGraph
[0.066325] Graph has 821 nodes and 18276 sequences
[0.070142] Scanning pre-graph file spodar.velvet.35.d/PreGraph for k-mers
[0.071137] 88492 kmers found
[0.077801] Sorting kmer occurence table ... 
[0.102293] Sorting done.
[0.102301] Computing acceleration table... 
[0.121131] Computing offsets... 
[0.121743] Ghost Threading through reads 0 / 18276
[0.256802]  === Ghost-Threaded in 0.135072 s
[0.256807] Threading through reads 0 / 18276
[0.397866]  === Threaded in 0.141061 s
[0.398396] Correcting graph with cutoff 0.200000
[0.398473] Determining eligible starting points
[0.398739] Done listing starting nodes
[0.398739] Initializing todo lists
[0.398753] Done with initilization
[0.398754] Activating arc lookup table
[0.398765] Done activating arc lookup table
[0.399036] Concatenation...
[0.399047] Renumbering nodes
[0.399048] Initial node count 821
[0.399050] Removed 0 null nodes
[0.399052] Concatenation over!
[0.399053] Clipping short tips off graph, drastic
[0.399202] Concatenation...
[0.399219] Renumbering nodes
[0.399220] Initial node count 821
[0.399228] Removed 39 null nodes
[0.399229] Concatenation over!
[0.399229] 782 nodes left
[0.399959] Writing into graph file spodar.velvet.35.d/Graph2...
[0.415124] Measuring median coverage depth...
[0.415334] Median coverage depth = 1.165217
[0.416702] Removing contigs with coverage < 0.582609...
[0.416725] Concatenation...
[0.416736] Renumbering nodes
[0.416737] Initial node count 782
[0.416739] Removed 0 null nodes
[0.416740] Concatenation over!
[0.416755] Concatenation...
[0.416763] Renumbering nodes
[0.416764] Initial node count 782
[0.416765] Removed 0 null nodes
[0.416765] Concatenation over!
[0.416767] Clipping short tips off graph, drastic
[0.416804] Concatenation...
[0.416812] Renumbering nodes
[0.416813] Initial node count 782
[0.416814] Removed 0 null nodes
[0.416814] Concatenation over!
[0.416815] 782 nodes left
[0.416816] Read coherency...
[0.416821] Identifying unique nodes
[0.416834] Done, 690 unique nodes counted
[0.416835] Trimming read tips
[0.416854] Renumbering nodes
[0.416854] Initial node count 782
[0.416855] Removed 0 null nodes
[0.416856] Confronted to 0 multiple hits and 0 null over 0
[0.416856] Read coherency over!
[0.416986] Starting pebble resolution...
[0.417085] Computing read to node mapping array sizes
[0.417182] Computing read to node mappings
[0.417266] Estimating library insert lengths...
[0.417412] Paired-end library 1 has length: 93, sample standard deviation: 48
[0.417414] Done
[0.417416] Computing direct node to node mappings
[0.417466] Scaffolding node 0
[0.417503]  === Nodes Scaffolded in 0.000086 s
[0.417538] Preparing to correct graph with cutoff 0.200000
[0.418102] Cleaning memory
[0.418287] Deactivating local correction settings
[0.418295] Pebble done.
[0.418296] Starting pebble resolution...
[0.418385] Computing read to node mapping array sizes
[0.418466] Computing read to node mappings
[0.418535] Estimating library insert lengths...
[0.418680] Paired-end library 1 has length: 93, sample standard deviation: 48
[0.418684] Done
[0.418685] Computing direct node to node mappings
[0.418729] Scaffolding node 0
[0.418765]  === Nodes Scaffolded in 0.000080 s
[0.418796] Preparing to correct graph with cutoff 0.200000
[0.418942] Cleaning memory
[0.418943] Deactivating local correction settings
[0.418949] Pebble done.
[0.418950] Concatenation...
[0.418959] Renumbering nodes
[0.418959] Initial node count 782
[0.418961] Removed 0 null nodes
[0.418963] Concatenation over!
[0.418964] Removing reference contigs with coverage < 0.582609...
[0.418990] Concatenation...
[0.418998] Renumbering nodes
[0.418999] Initial node count 782
[0.419000] Removed 0 null nodes
[0.419003] Concatenation over!
[0.420128] Writing contigs into spodar.velvet.35.d/contigs.fa...
[0.433077] Writing into stats file spodar.velvet.35.d/stats.txt...
[0.438212] Writing into graph file spodar.velvet.35.d/LastGraph...
[0.452448] Estimated Coverage = 1.165217
[0.452455] Estimated Coverage cutoff = 0.582609
Final graph has 782 nodes and n50 of 118, max 231, total 87418, using 1639/18276 reads
[0.000000] Reading FastQ file spodar.pe.qc.fq.gz;
[0.069873] 18014 sequences found
[0.069877] Done
[0.070137] Reading FastQ file spodar.se.qc.fq.gz;
[0.071340] 262 sequences found
[0.071342] Done
[0.156255] Reading read set file spodar.velvet.37.d/Sequences;
[0.159511] 18276 sequences found
[0.174536] Done
[0.174543] 18276 sequences in total.
[0.175138] Writing into roadmap file spodar.velvet.37.d/Roadmaps...
[0.181200] Inputting sequences...
[0.181277] Inputting sequence 0 / 18276
[0.441414]  === Sequences loaded in 0.260224 s
[0.445635] Done inputting sequences
[0.445641] Destroying splay table
[0.449997] Splay table destroyed
[0.000000] Reading roadmap file spodar.velvet.37.d/Roadmaps
[0.009734] 18276 roadmaps read
[0.010008] Creating insertion markers
[0.010301] Ordering insertion markers
[0.010609] Counting preNodes
[0.010783] 2723 preNodes counted, creating them now
[0.032053] Adjusting marker info...
[0.032104] Connecting preNodes
[0.032690] Cleaning up memory
[0.032692] Done creating preGraph
[0.032692] Concatenation...
[0.033571] Renumbering preNodes
[0.033571] Initial preNode count 2723
[0.033597] Destroyed 1701 preNodes
[0.033597] Concatenation over!
[0.033598] Clipping short tips off preGraph
[0.033772] Concatenation...
[0.033802] Renumbering preNodes
[0.033803] Initial preNode count 1022
[0.033815] Destroyed 276 preNodes
[0.033815] Concatenation over!
[0.033816] 260 tips cut off
[0.033816] 746 nodes left
[0.034306] Writing into pregraph file spodar.velvet.37.d/PreGraph...
[0.042714] Reading read set file spodar.velvet.37.d/Sequences;
[0.045549] 18276 sequences found
[0.059135] Done
[0.064758] Reading pre-graph file spodar.velvet.37.d/PreGraph
[0.064851] Graph has 746 nodes and 18276 sequences
[0.068235] Scanning pre-graph file spodar.velvet.37.d/PreGraph for k-mers
[0.069104] 79036 kmers found
[0.074719] Sorting kmer occurence table ... 
[0.096112] Sorting done.
[0.096115] Computing acceleration table... 
[0.113990] Computing offsets... 
[0.114522] Ghost Threading through reads 0 / 18276
[0.236452]  === Ghost-Threaded in 0.121939 s
[0.236457] Threading through reads 0 / 18276
[0.367879]  === Threaded in 0.131424 s
[0.368287] Correcting graph with cutoff 0.200000
[0.368362] Determining eligible starting points
[0.368605] Done listing starting nodes
[0.368606] Initializing todo lists
[0.368619] Done with initilization
[0.368619] Activating arc lookup table
[0.368630] Done activating arc lookup table
[0.368905] Concatenation...
[0.368916] Renumbering nodes
[0.368916] Initial node count 746
[0.368919] Removed 0 null nodes
[0.368922] Concatenation over!
[0.368922] Clipping short tips off graph, drastic
[0.369061] Concatenation...
[0.369070] Renumbering nodes
[0.369070] Initial node count 746
[0.369078] Removed 34 null nodes
[0.369079] Concatenation over!
[0.369079] 712 nodes left
[0.369881] Writing into graph file spodar.velvet.37.d/Graph2...
[0.384230] Measuring median coverage depth...
[0.384438] Median coverage depth = 1.161017
[0.385583] Removing contigs with coverage < 0.580508...
[0.385609] Concatenation...
[0.385620] Renumbering nodes
[0.385620] Initial node count 712
[0.385623] Removed 0 null nodes
[0.385624] Concatenation over!
[0.385637] Concatenation...
[0.385645] Renumbering nodes
[0.385645] Initial node count 712
[0.385646] Removed 0 null nodes
[0.385647] Concatenation over!
[0.385649] Clipping short tips off graph, drastic
[0.385683] Concatenation...
[0.385691] Renumbering nodes
[0.385691] Initial node count 712
[0.385692] Removed 0 null nodes
[0.385693] Concatenation over!
[0.385693] 712 nodes left
[0.385695] Read coherency...
[0.385699] Identifying unique nodes
[0.385711] Done, 643 unique nodes counted
[0.385712] Trimming read tips
[0.385729] Renumbering nodes
[0.385729] Initial node count 712
[0.385730] Removed 0 null nodes
[0.385731] Confronted to 0 multiple hits and 0 null over 0
[0.385731] Read coherency over!
[0.385866] Starting pebble resolution...
[0.385971] Computing read to node mapping array sizes
[0.386068] Computing read to node mappings
[0.386133] Estimating library insert lengths...
[0.386278] Paired-end library 1 has length: 93, sample standard deviation: 48
[0.386280] Done
[0.386282] Computing direct node to node mappings
[0.386333] Scaffolding node 0
[0.386368]  === Nodes Scaffolded in 0.000085 s
[0.386400] Preparing to correct graph with cutoff 0.200000
[0.386957] Cleaning memory
[0.387130] Deactivating local correction settings
[0.387137] Pebble done.
[0.387138] Starting pebble resolution...
[0.387226] Computing read to node mapping array sizes
[0.387303] Computing read to node mappings
[0.387366] Estimating library insert lengths...
[0.387510] Paired-end library 1 has length: 93, sample standard deviation: 48
[0.387513] Done
[0.387514] Computing direct node to node mappings
[0.387555] Scaffolding node 0
[0.387590]  === Nodes Scaffolded in 0.000074 s
[0.387617] Preparing to correct graph with cutoff 0.200000
[0.387757] Cleaning memory
[0.387758] Deactivating local correction settings
[0.387764] Pebble done.
[0.387764] Concatenation...
[0.387773] Renumbering nodes
[0.387773] Initial node count 712
[0.387775] Removed 0 null nodes
[0.387777] Concatenation over!
[0.387778] Removing reference contigs with coverage < 0.580508...
[0.387802] Concatenation...
[0.387810] Renumbering nodes
[0.387810] Initial node count 712
[0.387812] Removed 0 null nodes
[0.387814] Concatenation over!
[0.388836] Writing contigs into spodar.velvet.37.d/contigs.fa...
[0.400827] Writing into stats file spodar.velvet.37.d/stats.txt...
[0.405505] Writing into graph file spodar.velvet.37.d/LastGraph...
[0.418130] Estimated Coverage = 1.161017
[0.418140] Estimated Coverage cutoff = 0.580508
Final graph has 712 nodes and n50 of 115, max 229, total 78072, using 1494/18276 reads
[0.000000] Reading FastQ file spodar.pe.qc.fq.gz;
[0.069792] 18014 sequences found
[0.069797] Done
[0.070032] Reading FastQ file spodar.se.qc.fq.gz;
[0.071229] 262 sequences found
[0.071231] Done
[0.155047] Reading read set file spodar.velvet.39.d/Sequences;
[0.158012] 18276 sequences found
[0.172018] Done
[0.172023] 18276 sequences in total.
[0.172848] Writing into roadmap file spodar.velvet.39.d/Roadmaps...
[0.178665] Inputting sequences...
[0.178771] Inputting sequence 0 / 18276
[0.429509]  === Sequences loaded in 0.250852 s
[0.433626] Done inputting sequences
[0.433633] Destroying splay table
[0.437876] Splay table destroyed
[0.000000] Reading roadmap file spodar.velvet.39.d/Roadmaps
[0.009604] 18276 roadmaps read
[0.009961] Creating insertion markers
[0.010264] Ordering insertion markers
[0.010572] Counting preNodes
[0.010751] 2560 preNodes counted, creating them now
[0.032988] Adjusting marker info...
[0.033043] Connecting preNodes
[0.033632] Cleaning up memory
[0.033635] Done creating preGraph
[0.033635] Concatenation...
[0.034459] Renumbering preNodes
[0.034460] Initial preNode count 2560
[0.034486] Destroyed 1586 preNodes
[0.034486] Concatenation over!
[0.034487] Clipping short tips off preGraph
[0.034652] Concatenation...
[0.034683] Renumbering preNodes
[0.034683] Initial preNode count 974
[0.034695] Destroyed 316 preNodes
[0.034695] Concatenation over!
[0.034695] 300 tips cut off
[0.034696] 658 nodes left
[0.035390] Writing into pregraph file spodar.velvet.39.d/PreGraph...
[0.043655] Reading read set file spodar.velvet.39.d/Sequences;
[0.046771] 18276 sequences found
[0.062136] Done
[0.068422] Reading pre-graph file spodar.velvet.39.d/PreGraph
[0.068521] Graph has 658 nodes and 18276 sequences
[0.071737] Scanning pre-graph file spodar.velvet.39.d/PreGraph for k-mers
[0.072925] 68437 kmers found
[0.077922] Sorting kmer occurence table ... 
[0.095550] Sorting done.
[0.095557] Computing acceleration table... 
[0.113242] Computing offsets... 
[0.113817] Ghost Threading through reads 0 / 18276
[0.241202]  === Ghost-Threaded in 0.127394 s
[0.241209] Threading through reads 0 / 18276
[0.362913]  === Threaded in 0.121707 s
[0.363290] Correcting graph with cutoff 0.200000
[0.363357] Determining eligible starting points
[0.363570] Done listing starting nodes
[0.363570] Initializing todo lists
[0.363582] Done with initilization
[0.363582] Activating arc lookup table
[0.363592] Done activating arc lookup table
[0.363695] Concatenation...
[0.363703] Renumbering nodes
[0.363704] Initial node count 658
[0.363706] Removed 0 null nodes
[0.363708] Concatenation over!
[0.363709] Clipping short tips off graph, drastic
[0.363805] Concatenation...
[0.363821] Renumbering nodes
[0.363821] Initial node count 658
[0.363828] Removed 30 null nodes
[0.363829] Concatenation over!
[0.363829] 628 nodes left
[0.364592] Writing into graph file spodar.velvet.39.d/Graph2...
[0.376451] Measuring median coverage depth...
[0.376615] Median coverage depth = 1.155963
[0.377522] Removing contigs with coverage < 0.577982...
[0.377543] Concatenation...
[0.377552] Renumbering nodes
[0.377552] Initial node count 628
[0.377555] Removed 0 null nodes
[0.377555] Concatenation over!
[0.377568] Concatenation...
[0.377575] Renumbering nodes
[0.377575] Initial node count 628
[0.377576] Removed 0 null nodes
[0.377576] Concatenation over!
[0.377579] Clipping short tips off graph, drastic
[0.377608] Concatenation...
[0.377615] Renumbering nodes
[0.377615] Initial node count 628
[0.377616] Removed 0 null nodes
[0.377617] Concatenation over!
[0.377617] 628 nodes left
[0.377619] Read coherency...
[0.377622] Identifying unique nodes
[0.377634] Done, 590 unique nodes counted
[0.377634] Trimming read tips
[0.377649] Renumbering nodes
[0.377649] Initial node count 628
[0.377650] Removed 0 null nodes
[0.377651] Confronted to 0 multiple hits and 0 null over 0
[0.377652] Read coherency over!
[0.377787] Starting pebble resolution...
[0.377886] Computing read to node mapping array sizes
[0.377972] Computing read to node mappings
[0.378031] Estimating library insert lengths...
[0.378174] Paired-end library 1 has length: 60, sample standard deviation: 62
[0.378176] Done
[0.378177] Computing direct node to node mappings
[0.378221] Scaffolding node 0
[0.378253]  === Nodes Scaffolded in 0.000074 s
[0.378282] Preparing to correct graph with cutoff 0.200000
[0.378814] Cleaning memory
[0.378986] Deactivating local correction settings
[0.378993] Pebble done.
[0.378993] Starting pebble resolution...
[0.379079] Computing read to node mapping array sizes
[0.379149] Computing read to node mappings
[0.379205] Estimating library insert lengths...
[0.379347] Paired-end library 1 has length: 60, sample standard deviation: 62
[0.379351] Done
[0.379352] Computing direct node to node mappings
[0.379390] Scaffolding node 0
[0.379421]  === Nodes Scaffolded in 0.000069 s
[0.379445] Preparing to correct graph with cutoff 0.200000
[0.379569] Cleaning memory
[0.379571] Deactivating local correction settings
[0.379575] Pebble done.
[0.379576] Concatenation...
[0.379583] Renumbering nodes
[0.379583] Initial node count 628
[0.379585] Removed 0 null nodes
[0.379587] Concatenation over!
[0.379587] Removing reference contigs with coverage < 0.577982...
[0.379609] Concatenation...
[0.379616] Renumbering nodes
[0.379616] Initial node count 628
[0.379617] Removed 0 null nodes
[0.379619] Concatenation over!
[0.380386] Writing contigs into spodar.velvet.39.d/contigs.fa...
[0.390508] Writing into stats file spodar.velvet.39.d/stats.txt...
[0.394485] Writing into graph file spodar.velvet.39.d/LastGraph...
[0.405628] Estimated Coverage = 1.155963
[0.405637] Estimated Coverage cutoff = 0.577982
Final graph has 628 nodes and n50 of 111, max 227, total 67566, using 1317/18276 reads
[0.000001] Reading FastQ file spodar.pe.qc.fq.gz;
[0.069641] 18014 sequences found
[0.069645] Done
[0.069913] Reading FastQ file spodar.se.qc.fq.gz;
[0.071087] 262 sequences found
[0.071089] Done
[0.164019] Reading read set file spodar.velvet.41.d/Sequences;
[0.167192] 18276 sequences found
[0.181694] Done
[0.181700] 18276 sequences in total.
[0.182568] Writing into roadmap file spodar.velvet.41.d/Roadmaps...
[0.188790] Inputting sequences...
[0.188910] Inputting sequence 0 / 18276
[0.434467]  === Sequences loaded in 0.245694 s
[0.455571] Done inputting sequences
[0.455578] Destroying splay table
[0.459686] Splay table destroyed
[0.000000] Reading roadmap file spodar.velvet.41.d/Roadmaps
[0.009170] 18276 roadmaps read
[0.009417] Creating insertion markers
[0.009703] Ordering insertion markers
[0.010006] Counting preNodes
[0.010176] 2424 preNodes counted, creating them now
[0.032647] Adjusting marker info...
[0.032698] Connecting preNodes
[0.033250] Cleaning up memory
[0.033251] Done creating preGraph
[0.033252] Concatenation...
[0.034018] Renumbering preNodes
[0.034019] Initial preNode count 2424
[0.034041] Destroyed 1491 preNodes
[0.034042] Concatenation over!
[0.034042] Clipping short tips off preGraph
[0.034193] Concatenation...
[0.034219] Renumbering preNodes
[0.034220] Initial preNode count 933
[0.034230] Destroyed 369 preNodes
[0.034231] Concatenation over!
[0.034231] 354 tips cut off
[0.034232] 564 nodes left
[0.034996] Writing into pregraph file spodar.velvet.41.d/PreGraph...
[0.041787] Reading read set file spodar.velvet.41.d/Sequences;
[0.044626] 18276 sequences found
[0.058248] Done
[0.063799] Reading pre-graph file spodar.velvet.41.d/PreGraph
[0.063853] Graph has 564 nodes and 18276 sequences
[0.066404] Scanning pre-graph file spodar.velvet.41.d/PreGraph for k-mers
[0.067065] 58135 kmers found
[0.071127] Sorting kmer occurence table ... 
[0.085848] Sorting done.
[0.085854] Computing acceleration table... 
[0.103493] Computing offsets... 
[0.103907] Ghost Threading through reads 0 / 18276
[0.223385]  === Ghost-Threaded in 0.119487 s
[0.223390] Threading through reads 0 / 18276
[0.327848]  === Threaded in 0.104460 s
[0.328237] Correcting graph with cutoff 0.200000
[0.328302] Determining eligible starting points
[0.328484] Done listing starting nodes
[0.328484] Initializing todo lists
[0.328494] Done with initilization
[0.328495] Activating arc lookup table
[0.328503] Done activating arc lookup table
[0.328594] Concatenation...
[0.328602] Renumbering nodes
[0.328602] Initial node count 564
[0.328604] Removed 0 null nodes
[0.328605] Concatenation over!
[0.328607] Clipping short tips off graph, drastic
[0.328661] Concatenation...
[0.328675] Renumbering nodes
[0.328675] Initial node count 564
[0.328681] Removed 24 null nodes
[0.328682] Concatenation over!
[0.328682] 540 nodes left
[0.329434] Writing into graph file spodar.velvet.41.d/Graph2...
[0.339629] Measuring median coverage depth...
[0.339766] Median coverage depth = 1.140187
[0.340407] Removing contigs with coverage < 0.570093...
[0.340424] Concatenation...
[0.340432] Renumbering nodes
[0.340433] Initial node count 540
[0.340435] Removed 0 null nodes
[0.340435] Concatenation over!
[0.340446] Concatenation...
[0.340452] Renumbering nodes
[0.340452] Initial node count 540
[0.340453] Removed 0 null nodes
[0.340453] Concatenation over!
[0.340455] Clipping short tips off graph, drastic
[0.340481] Concatenation...
[0.340487] Renumbering nodes
[0.340487] Initial node count 540
[0.340488] Removed 0 null nodes
[0.340488] Concatenation over!
[0.340488] 540 nodes left
[0.340490] Read coherency...
[0.340493] Identifying unique nodes
[0.340502] Done, 529 unique nodes counted
[0.340503] Trimming read tips
[0.340515] Renumbering nodes
[0.340515] Initial node count 540
[0.340516] Removed 0 null nodes
[0.340517] Confronted to 0 multiple hits and 0 null over 0
[0.340518] Read coherency over!
[0.340648] Starting pebble resolution...
[0.340744] Computing read to node mapping array sizes
[0.340824] Computing read to node mappings
[0.340875] Estimating library insert lengths...
[0.341017] Paired-end library 1 has length: 152, sample standard deviation: 72
[0.341018] Done
[0.341020] Computing direct node to node mappings
[0.341059] Scaffolding node 0
[0.341087]  === Nodes Scaffolded in 0.000066 s
[0.341111] Preparing to correct graph with cutoff 0.200000
[0.341641] Cleaning memory
[0.341823] Deactivating local correction settings
[0.341829] Pebble done.
[0.341830] Starting pebble resolution...
[0.341918] Computing read to node mapping array sizes
[0.341984] Computing read to node mappings
[0.342033] Estimating library insert lengths...
[0.342174] Paired-end library 1 has length: 152, sample standard deviation: 72
[0.342178] Done
[0.342179] Computing direct node to node mappings
[0.342214] Scaffolding node 0
[0.342242]  === Nodes Scaffolded in 0.000062 s
[0.342263] Preparing to correct graph with cutoff 0.200000
[0.342379] Cleaning memory
[0.342381] Deactivating local correction settings
[0.342385] Pebble done.
[0.342386] Concatenation...
[0.342393] Renumbering nodes
[0.342393] Initial node count 540
[0.342395] Removed 0 null nodes
[0.342397] Concatenation over!
[0.342397] Removing reference contigs with coverage < 0.570093...
[0.342416] Concatenation...
[0.342422] Renumbering nodes
[0.342422] Initial node count 540
[0.342423] Removed 0 null nodes
[0.342425] Concatenation over!
[0.343124] Writing contigs into spodar.velvet.41.d/contigs.fa...
[0.352127] Writing into stats file spodar.velvet.41.d/stats.txt...
[0.355742] Writing into graph file spodar.velvet.41.d/LastGraph...
[0.366027] Estimated Coverage = 1.140187
[0.366039] Estimated Coverage cutoff = 0.570093
Final graph has 540 nodes and n50 of 109, max 225, total 57452, using 1130/18276 reads
[0.000001] Reading FastQ file spodar.pe.qc.fq.gz;
[0.069087] 18014 sequences found
[0.069092] Done
[0.069463] Reading FastQ file spodar.se.qc.fq.gz;
[0.070668] 262 sequences found
[0.070670] Done
[0.156480] Reading read set file spodar.velvet.43.d/Sequences;
[0.159710] 18276 sequences found
[0.174948] Done
[0.174955] 18276 sequences in total.
[0.175842] Writing into roadmap file spodar.velvet.43.d/Roadmaps...
[0.181850] Inputting sequences...
[0.181962] Inputting sequence 0 / 18276
[0.425989]  === Sequences loaded in 0.244154 s
[0.430119] Done inputting sequences
[0.430124] Destroying splay table
[0.434059] Splay table destroyed
[0.000001] Reading roadmap file spodar.velvet.43.d/Roadmaps
[0.009079] 18276 roadmaps read
[0.009283] Creating insertion markers
[0.009557] Ordering insertion markers
[0.009853] Counting preNodes
[0.010023] 2255 preNodes counted, creating them now
[0.032653] Adjusting marker info...
[0.032684] Connecting preNodes
[0.033208] Cleaning up memory
[0.033209] Done creating preGraph
[0.033210] Concatenation...
[0.033910] Renumbering preNodes
[0.033910] Initial preNode count 2255
[0.033930] Destroyed 1374 preNodes
[0.033931] Concatenation over!
[0.033931] Clipping short tips off preGraph
[0.034122] Concatenation...
[0.034141] Renumbering preNodes
[0.034141] Initial preNode count 881
[0.034150] Destroyed 422 preNodes
[0.034150] Concatenation over!
[0.034150] 418 tips cut off
[0.034151] 459 nodes left
[0.034859] Writing into pregraph file spodar.velvet.43.d/PreGraph...
[0.041901] Reading read set file spodar.velvet.43.d/Sequences;
[0.044491] 18276 sequences found
[0.058102] Done
[0.064650] Reading pre-graph file spodar.velvet.43.d/PreGraph
[0.064757] Graph has 459 nodes and 18276 sequences
[0.067153] Scanning pre-graph file spodar.velvet.43.d/PreGraph for k-mers
[0.067722] 47006 kmers found
[0.071319] Sorting kmer occurence table ... 
[0.083330] Sorting done.
[0.083337] Computing acceleration table... 
[0.101004] Computing offsets... 
[0.101270] Ghost Threading through reads 0 / 18276
[0.222330]  === Ghost-Threaded in 0.121070 s
[0.222338] Threading through reads 0 / 18276
[0.342893]  === Threaded in 0.120557 s
[0.343264] Correcting graph with cutoff 0.200000
[0.343320] Determining eligible starting points
[0.343464] Done listing starting nodes
[0.343464] Initializing todo lists
[0.343472] Done with initilization
[0.343472] Activating arc lookup table
[0.343478] Done activating arc lookup table
[0.343551] Concatenation...
[0.343557] Renumbering nodes
[0.343557] Initial node count 459
[0.343558] Removed 0 null nodes
[0.343560] Concatenation over!
[0.343562] Clipping short tips off graph, drastic
[0.343609] Concatenation...
[0.343615] Renumbering nodes
[0.343615] Initial node count 459
[0.343620] Removed 12 null nodes
[0.343620] Concatenation over!
[0.343621] 447 nodes left
[0.344392] Writing into graph file spodar.velvet.43.d/Graph2...
[0.353040] Measuring median coverage depth...
[0.353150] Median coverage depth = 1.123810
[0.354143] Removing contigs with coverage < 0.561905...
[0.354161] Concatenation...
[0.354167] Renumbering nodes
[0.354168] Initial node count 447
[0.354170] Removed 0 null nodes
[0.354171] Concatenation over!
[0.354180] Concatenation...
[0.354185] Renumbering nodes
[0.354185] Initial node count 447
[0.354186] Removed 0 null nodes
[0.354186] Concatenation over!
[0.354188] Clipping short tips off graph, drastic
[0.354209] Concatenation...
[0.354214] Renumbering nodes
[0.354214] Initial node count 447
[0.354215] Removed 0 null nodes
[0.354216] Concatenation over!
[0.354216] 447 nodes left
[0.354218] Read coherency...
[0.354220] Identifying unique nodes
[0.354228] Done, 438 unique nodes counted
[0.354229] Trimming read tips
[0.354239] Renumbering nodes
[0.354240] Initial node count 447
[0.354240] Removed 0 null nodes
[0.354241] Confronted to 0 multiple hits and 0 null over 0
[0.354242] Read coherency over!
[0.354371] Starting pebble resolution...
[0.354465] Computing read to node mapping array sizes
[0.354535] Computing read to node mappings
[0.354584] Estimating library insert lengths...
[0.354725] Paired-end library 1 has length: 153, sample standard deviation: 1
[0.354726] Done
[0.354727] Computing direct node to node mappings
[0.354755] Scaffolding node 0
[0.354779]  === Nodes Scaffolded in 0.000051 s
[0.354800] Preparing to correct graph with cutoff 0.200000
[0.354901] Cleaning memory
[0.354907] Deactivating local correction settings
[0.354913] Pebble done.
[0.354913] Starting pebble resolution...
[0.354998] Computing read to node mapping array sizes
[0.355054] Computing read to node mappings
[0.355094] Estimating library insert lengths...
[0.355233] Paired-end library 1 has length: 153, sample standard deviation: 1
[0.355237] Done
[0.355237] Computing direct node to node mappings
[0.355261] Scaffolding node 0
[0.355283]  === Nodes Scaffolded in 0.000045 s
[0.355300] Preparing to correct graph with cutoff 0.200000
[0.355400] Cleaning memory
[0.355401] Deactivating local correction settings
[0.355405] Pebble done.
[0.355406] Concatenation...
[0.355411] Renumbering nodes
[0.355411] Initial node count 447
[0.355412] Removed 0 null nodes
[0.355414] Concatenation over!
[0.355414] Removing reference contigs with coverage < 0.561905...
[0.355430] Concatenation...
[0.355435] Renumbering nodes
[0.355435] Initial node count 447
[0.355436] Removed 0 null nodes
[0.355438] Concatenation over!
[0.356348] Writing contigs into spodar.velvet.43.d/contigs.fa...
[0.364388] Writing into stats file spodar.velvet.43.d/stats.txt...
[0.367677] Writing into graph file spodar.velvet.43.d/LastGraph...
[0.376026] Estimated Coverage = 1.123810
[0.376035] Estimated Coverage cutoff = 0.561905
Final graph has 447 nodes and n50 of 106, max 191, total 46627, using 923/18276 reads
[0.000000] Reading FastQ file spodar.pe.qc.fq.gz;
[0.068640] 18014 sequences found
[0.068644] Done
[0.069366] Reading FastQ file spodar.se.qc.fq.gz;
[0.070635] 262 sequences found
[0.070638] Done
[0.168481] Reading read set file spodar.velvet.45.d/Sequences;
[0.171576] 18276 sequences found
[0.186003] Done
[0.186008] 18276 sequences in total.
[0.186634] Writing into roadmap file spodar.velvet.45.d/Roadmaps...
[0.192574] Inputting sequences...
[0.192648] Inputting sequence 0 / 18276
[0.432081]  === Sequences loaded in 0.239517 s
[0.436248] Done inputting sequences
[0.436252] Destroying splay table
[0.440092] Splay table destroyed
[0.000000] Reading roadmap file spodar.velvet.45.d/Roadmaps
[0.008983] 18276 roadmaps read
[0.009226] Creating insertion markers
[0.009503] Ordering insertion markers
[0.009795] Counting preNodes
[0.009960] 2131 preNodes counted, creating them now
[0.033406] Adjusting marker info...
[0.033472] Connecting preNodes
[0.034030] Cleaning up memory
[0.034032] Done creating preGraph
[0.034033] Concatenation...
[0.034706] Renumbering preNodes
[0.034708] Initial preNode count 2131
[0.034731] Destroyed 1297 preNodes
[0.034732] Concatenation over!
[0.034732] Clipping short tips off preGraph
[0.034901] Concatenation...
[0.034917] Renumbering preNodes
[0.034918] Initial preNode count 834
[0.034926] Destroyed 478 preNodes
[0.034926] Concatenation over!
[0.034927] 475 tips cut off
[0.034927] 356 nodes left
[0.035654] Writing into pregraph file spodar.velvet.45.d/PreGraph...
[0.040944] Reading read set file spodar.velvet.45.d/Sequences;
[0.044486] 18276 sequences found
[0.060019] Done
[0.066127] Reading pre-graph file spodar.velvet.45.d/PreGraph
[0.066206] Graph has 356 nodes and 18276 sequences
[0.068096] Scanning pre-graph file spodar.velvet.45.d/PreGraph for k-mers
[0.068529] 36353 kmers found
[0.071336] Sorting kmer occurence table ... 
[0.079342] Sorting done.
[0.079347] Computing acceleration table... 
[0.097011] Computing offsets... 
[0.097221] Ghost Threading through reads 0 / 18276
[0.207121]  === Ghost-Threaded in 0.109909 s
[0.207128] Threading through reads 0 / 18276
[0.327075]  === Threaded in 0.119948 s
[0.327487] Correcting graph with cutoff 0.200000
[0.327532] Determining eligible starting points
[0.327639] Done listing starting nodes
[0.327639] Initializing todo lists
[0.327645] Done with initilization
[0.327646] Activating arc lookup table
[0.327650] Done activating arc lookup table
[0.327700] Concatenation...
[0.327705] Renumbering nodes
[0.327705] Initial node count 356
[0.327707] Removed 0 null nodes
[0.327709] Concatenation over!
[0.327710] Clipping short tips off graph, drastic
[0.327745] Concatenation...
[0.327749] Renumbering nodes
[0.327749] Initial node count 356
[0.327753] Removed 8 null nodes
[0.327753] Concatenation over!
[0.327753] 348 nodes left
[0.329238] Writing into graph file spodar.velvet.45.d/Graph2...
[0.336199] Measuring median coverage depth...
[0.336278] Median coverage depth = 1.096154
[0.337096] Removing contigs with coverage < 0.548077...
[0.337109] Concatenation...
[0.337113] Renumbering nodes
[0.337114] Initial node count 348
[0.337115] Removed 0 null nodes
[0.337115] Concatenation over!
[0.337122] Concatenation...
[0.337126] Renumbering nodes
[0.337126] Initial node count 348
[0.337127] Removed 0 null nodes
[0.337128] Concatenation over!
[0.337129] Clipping short tips off graph, drastic
[0.337146] Concatenation...
[0.337150] Renumbering nodes
[0.337150] Initial node count 348
[0.337151] Removed 0 null nodes
[0.337151] Concatenation over!
[0.337151] 348 nodes left
[0.337152] Read coherency...
[0.337155] Identifying unique nodes
[0.337162] Done, 340 unique nodes counted
[0.337162] Trimming read tips
[0.337171] Renumbering nodes
[0.337171] Initial node count 348
[0.337172] Removed 0 null nodes
[0.337172] Confronted to 0 multiple hits and 0 null over 0
[0.337173] Read coherency over!
[0.337302] Starting pebble resolution...
[0.337397] Computing read to node mapping array sizes
[0.337456] Computing read to node mappings
[0.337494] Estimating library insert lengths...
[0.337633] Paired-end library 1 has length: 155, sample standard deviation: 2
[0.337635] Done
[0.337636] Computing direct node to node mappings
[0.337658] Scaffolding node 0
[0.337677]  === Nodes Scaffolded in 0.000040 s
[0.337693] Preparing to correct graph with cutoff 0.200000
[0.337774] Cleaning memory
[0.337780] Deactivating local correction settings
[0.337785] Pebble done.
[0.337785] Starting pebble resolution...
[0.337868] Computing read to node mapping array sizes
[0.337917] Computing read to node mappings
[0.337949] Estimating library insert lengths...
[0.338087] Paired-end library 1 has length: 155, sample standard deviation: 2
[0.338090] Done
[0.338091] Computing direct node to node mappings
[0.338111] Scaffolding node 0
[0.338128]  === Nodes Scaffolded in 0.000036 s
[0.338142] Preparing to correct graph with cutoff 0.200000
[0.338218] Cleaning memory
[0.338219] Deactivating local correction settings
[0.338223] Pebble done.
[0.338224] Concatenation...
[0.338228] Renumbering nodes
[0.338228] Initial node count 348
[0.338229] Removed 0 null nodes
[0.338230] Concatenation over!
[0.338231] Removing reference contigs with coverage < 0.548077...
[0.338243] Concatenation...
[0.338247] Renumbering nodes
[0.338248] Initial node count 348
[0.338248] Removed 0 null nodes
[0.338250] Concatenation over!
[0.339030] Writing contigs into spodar.velvet.45.d/contigs.fa...
[0.345463] Writing into stats file spodar.velvet.45.d/stats.txt...
[0.348880] Writing into graph file spodar.velvet.45.d/LastGraph...
[0.356927] Estimated Coverage = 1.096154
[0.356931] Estimated Coverage cutoff = 0.548077
Final graph has 348 nodes and n50 of 105, max 189, total 36086, using 719/18276 reads
[0.000000] Reading FastQ file spodar.pe.qc.fq.gz;
[0.069292] 18014 sequences found
[0.069296] Done
[0.069641] Reading FastQ file spodar.se.qc.fq.gz;
[0.070861] 262 sequences found
[0.070864] Done
[0.156606] Reading read set file spodar.velvet.47.d/Sequences;
[0.159721] 18276 sequences found
[0.174403] Done
[0.174409] 18276 sequences in total.
[0.175295] Writing into roadmap file spodar.velvet.47.d/Roadmaps...
[0.181380] Inputting sequences...
[0.181494] Inputting sequence 0 / 18276
[0.401020]  === Sequences loaded in 0.219656 s
[0.405022] Done inputting sequences
[0.405026] Destroying splay table
[0.408478] Splay table destroyed
[0.000000] Reading roadmap file spodar.velvet.47.d/Roadmaps
[0.009477] 18276 roadmaps read
[0.009810] Creating insertion markers
[0.010096] Ordering insertion markers
[0.010392] Counting preNodes
[0.010554] 1991 preNodes counted, creating them now
[0.034691] Adjusting marker info...
[0.034736] Connecting preNodes
[0.035257] Cleaning up memory
[0.035260] Done creating preGraph
[0.035260] Concatenation...
[0.035871] Renumbering preNodes
[0.035872] Initial preNode count 1991
[0.035891] Destroyed 1208 preNodes
[0.035892] Concatenation over!
[0.035893] Clipping short tips off preGraph
[0.036026] Concatenation...
[0.036036] Renumbering preNodes
[0.036036] Initial preNode count 783
[0.036042] Destroyed 553 preNodes
[0.036042] Concatenation over!
[0.036043] 552 tips cut off
[0.036043] 230 nodes left
[0.036668] Writing into pregraph file spodar.velvet.47.d/PreGraph...
[0.040266] Reading read set file spodar.velvet.47.d/Sequences;
[0.043041] 18276 sequences found
[0.057791] Done
[0.063761] Reading pre-graph file spodar.velvet.47.d/PreGraph
[0.063821] Graph has 230 nodes and 18276 sequences
[0.065247] Scanning pre-graph file spodar.velvet.47.d/PreGraph for k-mers
[0.065580] 23812 kmers found
[0.067746] Sorting kmer occurence table ... 
[0.072944] Sorting done.
[0.072949] Computing acceleration table... 
[0.093213] Computing offsets... 
[0.093361] Ghost Threading through reads 0 / 18276
[0.186221]  === Ghost-Threaded in 0.092869 s
[0.186229] Threading through reads 0 / 18276
[0.301375]  === Threaded in 0.115148 s
[0.301807] Correcting graph with cutoff 0.200000
[0.301852] Determining eligible starting points
[0.301926] Done listing starting nodes
[0.301927] Initializing todo lists
[0.301931] Done with initilization
[0.301932] Activating arc lookup table
[0.301935] Done activating arc lookup table
[0.301969] Concatenation...
[0.301972] Renumbering nodes
[0.301973] Initial node count 230
[0.301974] Removed 0 null nodes
[0.301976] Concatenation over!
[0.301978] Clipping short tips off graph, drastic
[0.302000] Concatenation...
[0.302003] Renumbering nodes
[0.302003] Initial node count 230
[0.302005] Removed 2 null nodes
[0.302005] Concatenation over!
[0.302006] 228 nodes left
[0.302830] Writing into graph file spodar.velvet.47.d/Graph2...
[0.307984] Measuring median coverage depth...
[0.308039] Median coverage depth = 1.071429
[0.308852] Removing contigs with coverage < 0.535714...
[0.308864] Concatenation...
[0.308868] Renumbering nodes
[0.308869] Initial node count 228
[0.308871] Removed 0 null nodes
[0.308871] Concatenation over!
[0.308876] Concatenation...
[0.308879] Renumbering nodes
[0.308879] Initial node count 228
[0.308880] Removed 0 null nodes
[0.308880] Concatenation over!
[0.308882] Clipping short tips off graph, drastic
[0.308893] Concatenation...
[0.308896] Renumbering nodes
[0.308896] Initial node count 228
[0.308897] Removed 0 null nodes
[0.308897] Concatenation over!
[0.308897] 228 nodes left
[0.308899] Read coherency...
[0.308908] Identifying unique nodes
[0.308912] Done, 223 unique nodes counted
[0.308913] Trimming read tips
[0.308918] Renumbering nodes
[0.308918] Initial node count 228
[0.308919] Removed 0 null nodes
[0.308920] Confronted to 0 multiple hits and 0 null over 0
[0.308920] Read coherency over!
[0.309051] Starting pebble resolution...
[0.309147] Computing read to node mapping array sizes
[0.309201] Computing read to node mappings
[0.309225] Estimating library insert lengths...
[0.309363] Paired-end library 1 has length: 155, sample standard deviation: 2
[0.309364] Done
[0.309366] Computing direct node to node mappings
[0.309382] Scaffolding node 0
[0.309395]  === Nodes Scaffolded in 0.000029 s
[0.309407] Preparing to correct graph with cutoff 0.200000
[0.309475] Cleaning memory
[0.309481] Deactivating local correction settings
[0.309485] Pebble done.
[0.309485] Starting pebble resolution...
[0.309568] Computing read to node mapping array sizes
[0.309607] Computing read to node mappings
[0.309629] Estimating library insert lengths...
[0.309765] Paired-end library 1 has length: 155, sample standard deviation: 2
[0.309768] Done
[0.309769] Computing direct node to node mappings
[0.309783] Scaffolding node 0
[0.309795]  === Nodes Scaffolded in 0.000025 s
[0.309804] Preparing to correct graph with cutoff 0.200000
[0.309861] Cleaning memory
[0.309862] Deactivating local correction settings
[0.309866] Pebble done.
[0.309866] Concatenation...
[0.309869] Renumbering nodes
[0.309869] Initial node count 228
[0.309870] Removed 0 null nodes
[0.309871] Concatenation over!
[0.309872] Removing reference contigs with coverage < 0.535714...
[0.309881] Concatenation...
[0.309884] Renumbering nodes
[0.309884] Initial node count 228
[0.309884] Removed 0 null nodes
[0.309885] Concatenation over!
[0.310643] Writing contigs into spodar.velvet.47.d/contigs.fa...
[0.315720] Writing into stats file spodar.velvet.47.d/stats.txt...
[0.318283] Writing into graph file spodar.velvet.47.d/LastGraph...
[0.322986] Estimated Coverage = 1.071429
[0.322995] Estimated Coverage cutoff = 0.535714
Final graph has 228 nodes and n50 of 104, max 187, total 23753, using 476/18276 reads
[0.000000] Reading FastQ file spodar.pe.qc.fq.gz;
[0.068625] 18014 sequences found
[0.068635] Done
[0.070405] Reading FastQ file spodar.se.qc.fq.gz;
[0.071767] 262 sequences found
[0.071772] Done
[0.158942] Reading read set file spodar.velvet.49.d/Sequences;
[0.161903] 18276 sequences found
[0.176133] Done
[0.176137] 18276 sequences in total.
[0.177118] Writing into roadmap file spodar.velvet.49.d/Roadmaps...
[0.183177] Inputting sequences...
[0.183285] Inputting sequence 0 / 18276
[0.406812]  === Sequences loaded in 0.223649 s
[0.413354] Done inputting sequences
[0.413357] Destroying splay table
[0.416869] Splay table destroyed
[0.000000] Reading roadmap file spodar.velvet.49.d/Roadmaps
[0.009601] 18276 roadmaps read
[0.009951] Creating insertion markers
[0.010247] Ordering insertion markers
[0.010543] Counting preNodes
[0.010705] 1841 preNodes counted, creating them now
[0.035528] Adjusting marker info...
[0.035575] Connecting preNodes
[0.036090] Cleaning up memory
[0.036092] Done creating preGraph
[0.036093] Concatenation...
[0.036660] Renumbering preNodes
[0.036661] Initial preNode count 1841
[0.036679] Destroyed 1108 preNodes
[0.036680] Concatenation over!
[0.036680] Clipping short tips off preGraph
[0.036789] Concatenation...
[0.036797] Renumbering preNodes
[0.036797] Initial preNode count 733
[0.036801] Destroyed 607 preNodes
[0.036801] Concatenation over!
[0.036802] 606 tips cut off
[0.036802] 126 nodes left
[0.037549] Writing into pregraph file spodar.velvet.49.d/PreGraph...
[0.040407] Reading read set file spodar.velvet.49.d/Sequences;
[0.043405] 18276 sequences found
[0.057813] Done
[0.063659] Reading pre-graph file spodar.velvet.49.d/PreGraph
[0.063707] Graph has 126 nodes and 18276 sequences
[0.064740] Scanning pre-graph file spodar.velvet.49.d/PreGraph for k-mers
[0.064911] 12829 kmers found
[0.066413] Sorting kmer occurence table ... 
[0.069081] Sorting done.
[0.069085] Computing acceleration table... 
[0.086721] Computing offsets... 
[0.086881] Ghost Threading through reads 0 / 18276
[0.192650]  === Ghost-Threaded in 0.105781 s
[0.192658] Threading through reads 0 / 18276
[0.298899]  === Threaded in 0.106242 s
[0.299313] Correcting graph with cutoff 0.200000
[0.299350] Determining eligible starting points
[0.299388] Done listing starting nodes
[0.299388] Initializing todo lists
[0.299391] Done with initilization
[0.299392] Activating arc lookup table
[0.299394] Done activating arc lookup table
[0.299414] Concatenation...
[0.299416] Renumbering nodes
[0.299417] Initial node count 126
[0.299418] Removed 0 null nodes
[0.299420] Concatenation over!
[0.299421] Clipping short tips off graph, drastic
[0.299434] Concatenation...
[0.299436] Renumbering nodes
[0.299436] Initial node count 126
[0.299437] Removed 2 null nodes
[0.299438] Concatenation over!
[0.299438] 124 nodes left
[0.300426] Writing into graph file spodar.velvet.49.d/Graph2...
[0.304242] Measuring median coverage depth...
[0.304270] Median coverage depth = 1.046053
[0.305230] Removing contigs with coverage < 0.523026...
[0.305239] Concatenation...
[0.305242] Renumbering nodes
[0.305243] Initial node count 124
[0.305245] Removed 0 null nodes
[0.305245] Concatenation over!
[0.305248] Concatenation...
[0.305250] Renumbering nodes
[0.305250] Initial node count 124
[0.305250] Removed 0 null nodes
[0.305251] Concatenation over!
[0.305253] Clipping short tips off graph, drastic
[0.305259] Concatenation...
[0.305261] Renumbering nodes
[0.305261] Initial node count 124
[0.305262] Removed 0 null nodes
[0.305262] Concatenation over!
[0.305262] 124 nodes left
[0.305264] Read coherency...
[0.305265] Identifying unique nodes
[0.305267] Done, 120 unique nodes counted
[0.305268] Trimming read tips
[0.305271] Renumbering nodes
[0.305271] Initial node count 124
[0.305272] Removed 0 null nodes
[0.305273] Confronted to 0 multiple hits and 0 null over 0
[0.305273] Read coherency over!
[0.305403] Starting pebble resolution...
[0.305497] Computing read to node mapping array sizes
[0.305540] Computing read to node mappings
[0.305558] Estimating library insert lengths...
[0.305694] Paired-end library 1 has length: 152, sample standard deviation: 1
[0.305695] Done
[0.305696] Computing direct node to node mappings
[0.305708] Scaffolding node 0
[0.305716]  === Nodes Scaffolded in 0.000019 s
[0.305724] Preparing to correct graph with cutoff 0.200000
[0.305772] Cleaning memory
[0.305779] Deactivating local correction settings
[0.305783] Pebble done.
[0.305783] Starting pebble resolution...
[0.305870] Computing read to node mapping array sizes
[0.305901] Computing read to node mappings
[0.305915] Estimating library insert lengths...
[0.306050] Paired-end library 1 has length: 152, sample standard deviation: 1
[0.306054] Done
[0.306055] Computing direct node to node mappings
[0.306063] Scaffolding node 0
[0.306070]  === Nodes Scaffolded in 0.000015 s
[0.306076] Preparing to correct graph with cutoff 0.200000
[0.306114] Cleaning memory
[0.306115] Deactivating local correction settings
[0.306118] Pebble done.
[0.306118] Concatenation...
[0.306120] Renumbering nodes
[0.306120] Initial node count 124
[0.306121] Removed 0 null nodes
[0.306122] Concatenation over!
[0.306122] Removing reference contigs with coverage < 0.523026...
[0.306127] Concatenation...
[0.306129] Renumbering nodes
[0.306129] Initial node count 124
[0.306130] Removed 0 null nodes
[0.306131] Concatenation over!
[0.307146] Writing contigs into spodar.velvet.49.d/contigs.fa...
[0.310866] Writing into stats file spodar.velvet.49.d/stats.txt...
[0.313153] Writing into graph file spodar.velvet.49.d/LastGraph...
[0.316088] Estimated Coverage = 1.046053
[0.316096] Estimated Coverage cutoff = 0.523026
Final graph has 124 nodes and n50 of 102, max 162, total 12770, using 259/18276 reads
[0.000000] Reading FastQ file spodar.pe.qc.fq.gz;
[0.068509] 18014 sequences found
[0.068514] Done
[0.068915] Reading FastQ file spodar.se.qc.fq.gz;
[0.070246] 262 sequences found
[0.070248] Done
[0.181291] Reading read set file spodar.velvet.51.d/Sequences;
[0.184483] 18276 sequences found
[0.198991] Done
[0.198995] 18276 sequences in total.
[0.199633] Writing into roadmap file spodar.velvet.51.d/Roadmaps...
[0.205564] Inputting sequences...
[0.205684] Inputting sequence 0 / 18276
[0.495034]  === Sequences loaded in 0.289481 s
[0.499407] Done inputting sequences
[0.499410] Destroying splay table
[0.504281] Splay table destroyed
[0.000000] Reading roadmap file spodar.velvet.51.d/Roadmaps
[0.009308] 18276 roadmaps read
[0.009717] Creating insertion markers
[0.009987] Ordering insertion markers
[0.010277] Counting preNodes
[0.010436] 1712 preNodes counted, creating them now
[0.035311] Adjusting marker info...
[0.035335] Connecting preNodes
[0.035811] Cleaning up memory
[0.035813] Done creating preGraph
[0.035813] Concatenation...
[0.036330] Renumbering preNodes
[0.036331] Initial preNode count 1712
[0.036346] Destroyed 1020 preNodes
[0.036347] Concatenation over!
[0.036347] Clipping short tips off preGraph
[0.036406] Concatenation...
[0.036414] Renumbering preNodes
[0.036414] Initial preNode count 692
[0.036417] Destroyed 680 preNodes
[0.036417] Concatenation over!
[0.036417] 672 tips cut off
[0.036418] 12 nodes left
[0.037115] Writing into pregraph file spodar.velvet.51.d/PreGraph...
[0.039242] Reading read set file spodar.velvet.51.d/Sequences;
[0.041961] 18276 sequences found
[0.055568] Done
[0.061144] Reading pre-graph file spodar.velvet.51.d/PreGraph
[0.061156] Graph has 12 nodes and 18276 sequences
[0.061528] Scanning pre-graph file spodar.velvet.51.d/PreGraph for k-mers
[0.061947] 797 kmers found
[0.062702] Sorting kmer occurence table ... 
[0.062971] Sorting done.
[0.062972] Computing acceleration table... 
[0.079578] Computing offsets... 
[0.079595] Ghost Threading through reads 0 / 18276
[0.150662]  === Ghost-Threaded in 0.071072 s
[0.150667] Threading through reads 0 / 18276
[0.219785]  === Threaded in 0.069120 s
[0.220148] Correcting graph with cutoff 0.200000
[0.220177] Determining eligible starting points
[0.220184] Done listing starting nodes
[0.220184] Initializing todo lists
[0.220186] Done with initilization
[0.220186] Activating arc lookup table
[0.220187] Done activating arc lookup table
[0.220194] Concatenation...
[0.220195] Renumbering nodes
[0.220196] Initial node count 12
[0.220197] Removed 0 null nodes
[0.220199] Concatenation over!
[0.220200] Clipping short tips off graph, drastic
[0.220203] Concatenation...
[0.220204] Renumbering nodes
[0.220204] Initial node count 12
[0.220205] Removed 5 null nodes
[0.220205] Concatenation over!
[0.220205] 7 nodes left
[0.221086] Writing into graph file spodar.velvet.51.d/Graph2...
[0.223284] Measuring median coverage depth...
[0.223289] Median coverage depth = 1.330435
[0.224299] Removing contigs with coverage < 0.665217...
[0.224306] Concatenation...
[0.224307] Renumbering nodes
[0.224307] Initial node count 7
[0.224308] Removed 0 null nodes
[0.224309] Concatenation over!
[0.224309] Concatenation...
[0.224310] Renumbering nodes
[0.224310] Initial node count 7
[0.224310] Removed 0 null nodes
[0.224311] Concatenation over!
[0.224312] Clipping short tips off graph, drastic
[0.224313] Concatenation...
[0.224314] Renumbering nodes
[0.224314] Initial node count 7
[0.224314] Removed 0 null nodes
[0.224315] Concatenation over!
[0.224315] 7 nodes left
[0.224316] Read coherency...
[0.224316] Identifying unique nodes
[0.224317] Done, 5 unique nodes counted
[0.224317] Trimming read tips
[0.224318] Renumbering nodes
[0.224318] Initial node count 7
[0.224319] Removed 0 null nodes
[0.224319] Confronted to 0 multiple hits and 0 null over 0
[0.224320] Read coherency over!
[0.224454] Starting pebble resolution...
[0.224540] Computing read to node mapping array sizes
[0.224574] Computing read to node mappings
[0.224580] Estimating library insert lengths...
[0.224714] Done
[0.224715] Computing direct node to node mappings
[0.224722] Scaffolding node 0
[0.224725]  === Nodes Scaffolded in 0.000010 s
[0.224729] Preparing to correct graph with cutoff 0.200000
[0.224751] Cleaning memory
[0.224756] Deactivating local correction settings
[0.224759] Pebble done.
[0.224760] Starting pebble resolution...
[0.224841] Computing read to node mapping array sizes
[0.224863] Computing read to node mappings
[0.224867] Estimating library insert lengths...
[0.225000] Done
[0.225000] Computing direct node to node mappings
[0.225003] Scaffolding node 0
[0.225005]  === Nodes Scaffolded in 0.000003 s
[0.225006] Preparing to correct graph with cutoff 0.200000
[0.225024] Cleaning memory
[0.225025] Deactivating local correction settings
[0.225028] Pebble done.
[0.225028] Concatenation...
[0.225029] Renumbering nodes
[0.225029] Initial node count 7
[0.225030] Removed 0 null nodes
[0.225030] Concatenation over!
[0.225031] Removing reference contigs with coverage < 0.665217...
[0.225032] Concatenation...
[0.225032] Renumbering nodes
[0.225033] Initial node count 7
[0.225033] Removed 0 null nodes
[0.225033] Concatenation over!
[0.225792] Writing contigs into spodar.velvet.51.d/contigs.fa...
[0.227563] Writing into stats file spodar.velvet.51.d/stats.txt...
[0.229028] Writing into graph file spodar.velvet.51.d/LastGraph...
[0.229796] Estimated Coverage = 1.330435
[0.229800] Estimated Coverage cutoff = 0.665217
Final graph has 7 nodes and n50 of 115, max 129, total 627, using 15/18276 reads

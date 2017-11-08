F: nom plante                                                                            
         NO:                                                         codeplante          soj
         O: monocot ou dicot                               2                             
                   M1: monocotyledone                      0                             
                   M2: dicotyledone                        0                             
                                                                     codemonocot         2
F: d�veloppement                                                                         
         NO:                                                         tdmin                 5.00000
         NO:                                                         tdmax                25.00000
         O: temp�rature pilote                             2                             
                   M1: air                                 4                             
                   M2: culture                             7                             
                                                                     codetemp            1
                   O: �chelle.de.temps                     2
                   M11: �chelle.journali�re                0 
                   M12: �chelle.horaire                    0 
                                                                     codegdh             1
                   M2:                                               coeflevamf          1.0
                   M2:                                               coefamflax          1.0
                   M2:                                               coeflaxsen          1.0
                   M2:                                               coefsenlan          1.0
                   M2:                                               coeflevdrp          1.0
                   M2:                                               coefdrpmat          1.0
                   M2:                                               coefflodrp          1.0
         O: plante photop�riodique                         2                             
                   M1: oui                                 2                             
                   M2: non                                 0                             
                                                                     codephot            1
                   M1:                                               phobase             18.0
                   M1:                                               phosat              15.00000
         O: effet retard stress                            2                             
                   M1: oui                                 1                             
                   M2: non                                 0                             
                                                                     coderetflo          2
                   M1:                                               stressdev           0.2
         O: besoins en froid                              3
                   M1: non                                0 
                   M2: vernalisation(herbac�es)           4 
                   M3: dormance(ligneux)                  9
                                                                     codebfroid          1
                   M2:                                               jvcmini             7.0
                   M2:                                               julvernal           274
                   M2:                                               tfroid              6.5
                   M2:                                               ampfroid            10.0
                   O: calcul.dormance                     3
                             M31: for�age                 1
                             M32: Richardson              0
                             M33: Bidabe                  2 
                                                                     codedormance        3
                             M31:                                    ifindorm            70
                             M33:                                    q10                 3.0
                             M33:                                    idebdorm            300
                   M3:                                               stdordebour         100.0
F: d�but de v�g�tation                                                                                 
         O: annuelle ou p�renne                            2
                   M1: annuelle                            15 
                   M2: p�renne                             0 
                                                                     codeperenne         1
                   O: germination.ou.d�marrage             2                             
                            M11: oui                       2                             
                            M12: non                       0                             
                                                                     codegermin          1
                            M11:                                     tgmin               5.00000
                            M11:                                     stpltger            40.00000
                   O: croissance.plantule                  2                             
                            M21: croissance.hypocotyle     5                             
                            M22: plantation                2                             
                                                                     codehypo            1
                            M21:                                     belong              0.01150
                            M21:                                     celong              4.57000
                            M21:                                     elmax               5.00000
                            M21:                                     nlevlim1            10
                            M21:                                     nlevlim2            50
                            M22:                                     laiplantule         0.00000
                            M22:                                     nbfeuilplant        0
F: feuillage
         NO:                                                         plastochrone        70.0
         NO:                                                         bdens               7.00000
         NO:                                                         laicomp             0.3
         NO:                                                         hautbase            0.00000
         NO:                                                         hautmax             0.8
         O: fonction foliaire                             2
                   M1: LAI                                20 
                   M2: taux.de.recouvrement               4
                                                                     codelaitr           1
                   M1:                                               vlaimax             2.2
                   M1:                                               pentlaimax          5.5
                   M1:                                               udlaimax            3.0
                   M1:                                               durvieI             0.8
                   M1:                                               tcmin               5
                   M1:                                               tcmax               45.00000
                   M1:                                               ratiosen            0.8
                   M1:                                               abscission          0.2
                   M1:                                               parazofmorte        13.0
                   M1:                                               innturgmin          -0.8
                   O: option.calcul.LAI                   2
                             M11: LAInet.direct           2 
                             M12: LAInet=LAIbrut-senes    4
                                                                     codlainet           2
                             M11:                                    dlaimax             9.0e-4
                             M11:                                    tustressmin         0.7
                             M12:                                    dlaimaxbrut         9.0e-4
                             M12:                                    durviesupmax        0.4
                             M12:                                    innsen              0.35
                             M12:                                    rapsenturg          0.5
                   M2:                                               tauxrecouvmax       1.0
                   M2:                                               tauxrecouvkmax      1.0
                   M2:                                               pentrecouv          4.5
                   M2:                                               infrecouv           0.85
F: interception du rayonnement                                                           
         O: interception du rayonnement                    2                             
                   M1: loi.de.Beer                         1                             
                   M2: transferts                          6                             
                                                                     codetransrad        1
                   M1:                                               extin               .50000
                   M2:                                               ktrou                  .00000
                   M2:                                               forme                 0
                   M2:                                               rapforme               .00000
                   M2:                                               adfol               1.0
                   M2:                                               dfolbas             5.0
                   M2:                                               dfolhaut            5.0
F: croissance en biomasse                                                                
         O: seuils de temp�ratures                         2                             
                   M1: idem.LAI                            0                             
                   M2: diff�rents.LAI                      2                             
                                                                     codtefcroi          1
                   M2:                                               temin                 5.00000
                   M2:                                               temax                45.00000
         NO:                                                         teopt                28.00000
         NO:                                                         teoptbis             32.00000
         NO:                                                         efcroijuv             1.25
         NO:                                                         efcroiveg             3.0
         NO:                                                         efcroirepro           3.5000
         NO:                                                         remobres              0.2
         NO:                                                         coefmshaut             .00000
F: repartition entre organes
         NO:                                                         slamax              300
         NO:                                                         slamin              200
         NO:                                                         tigefeuil           1.0
         NO:                                                         envfruit            0.20
         NO:                                                         sea                 50.0
F: croissance et rendement                                                              
         O: type  de croissance                            2                             
                   M1: d�termin�e                          11                            
                   M2: ind�termin�e                        16                             
                                                                     codeindetermin      1
                   M1:                                               nbjgrains           20
                   M1:                                               cgrain              0.05
                   M1:                                               cgrainv0            0
                   M1:                                               nbgrmin             0
                   O: unit�.IR                             2                             
                             M11: jours                    2                             
                             M12: degr�.jours              1                             
                                                                     codeir              1
                             M11:                                    vitircarb           .01500
                             M11:                                    irmax               .50000
                             M12:                                    vitircarbT          .00070
                   M2:                                               nboite              10
                   M2:                                               allocamx            .60000
                   M2:                                               afpf                .40000
                   M2:                                               bfpf                4.32000
                   M2:                                               sdrpnou             300.0
                   M2:                                               spfrmin             0.75
                   M2:                                               spfrmax             1.0
                   M2:                                               splaimin            0.2
                   M2:                                               splaimax            1.0
                   O: nombre.inflorescences               2
                             M21: impos�                  1 
                             M22: fonction.�tat.trophique 2
                                                                     codcalinflo         2
                             M21:                                    nbinflo             2.0
                             M22:                                    inflomax            5.0
                             M22:                                    pentinflores        0.8
         O: contrainte thermique remplissage               2                             
                   M1: oui                                 2                             
                   M2: non                                 0                             
                                                                     codetremp           1
                   M1:                                               tminremp            5.0
                   M1:                                               tmaxremp            30.0
         NO:                                                         vitpropsucre        0.0
         NO:                                                         vitprophuile        0.0000
         NO:                                                         vitirazo            0.025
F: racines                                                                               
         NO:                                                         sensanox            0.0
         NO:                                                         stoprac             sen
         NO:                                                         sensrsec            0.5
         NO:                                                         contrdamax          0.3
         O: temp�rature pilote                             2                             
                   M1: culture                             0                             
                   M2: sol.(seuil.TGMIN)                   0                             
                                                                     codetemprac         1
         O: densit� racinaire                              2                             
                   M1: profil.optimal.type                 3                             
                   M2: densit�.vraie                       4                             
                                                                     coderacine          2
                   M1:                                               zlabour             30
                   M1:                                               zpente              85
                   M1:                                               zprlim              150
                   M2:                                               draclong            100.00
                   M2:                                               debsenrac           800.00
                   M2:                                               lvfront             5e-2
                   M2:                                               longsperac          6e-3
F: gel
         NO:                                                         tletale             -5.0
         NO:                                                         tdebgel             0.0
         O: gel plantule ou lev�e                         2                                           
                   M1: non                                0 
                   M2: oui                                3
                                                                     codgellev           2
                   M2:                                               nbfgellev           3
                   M2:                                               tgellev10           -1.0
                   M2:                                               tgellev90           -4.0
         O: gel feuillage phase juv�nile (jusqu'� AMF)    2                                           
                   M1: non                                0 
                   M2: oui                                2
                                                                     codgeljuv           2
                   M2:                                               tgeljuv10           -1.0
                   M2:                                               tgeljuv90           -4.0
         O: gel feuillage phase adulte                    2                                           
                   M1: non                                0 
                   M2: oui                                2
                                                                     codgelveg           2
                   M2:                                               tgelveg10           -1.0
                   M2:                                               tgelveg90           -4.0
         O: gel fleurs/fruits (� partir de FLO)           2                                           
                   M1: non                                0 
                   M2: oui                                2
                                                                     codgelflo           2
                   M2:                                               tgelflo10           0
                   M2:                                               tgelflo90           -1
F: eau                                                                                   
         NO:                                                         psisto               15.00000
         NO:                                                         psiturg               4.00000
         NO:                                                         h2ofeuilverte       0.90
         NO:                                                         h2ofeuiljaune       0.15
         NO:                                                         h2otigestruc        0.60
         NO:                                                         h2oreserve          0.70
         NO:                                                         h2ofrvert           0.40
         NO:                                                         stdrpdes            500.0
         NO:                                                         deshydbase          0.008
         NO:                                                         tempdeshyd          0.005
         O: besoins en eau                                 2                             
                   M1: coefficient.cultural                1                             
                   M2: mod�le.r�sistif                     1                             
                                                                     codebeso            1
                   M1:                                               kmax                  1.30000
                   M2:                                               rsmin               250.
         O: interception de la pluie                       2                             
                   M1: oui                                 3                             
                   M2: non                                 0                             
                                                                     codeintercept       2
                   M1:                                               mouillabil             .00000
                   M1:                                               stemflowmax            .00000
                   M1:                                               kstemflow              .00000
F: azote                                                                                 
         NO:                                                         Vmax1                  .00180
         NO:                                                         Kmabs1               50.00
         NO:                                                         Vmax2                  .05000
         NO:                                                         Kmabs2               25000.00
         NO:                                                         adil                  5.35000
         NO:                                                         bdil                   .44000
         NO:                                                         adilmax               8.50000
         NO:                                                         bdilmax                .44000
         NO:                                                         masecNmax             1.54000
         NO:                                                         INNmin                 .300
         NO:                                                         inngrain1             1.5
         NO:                                                         inngrain2             1.5
         O: legumineuse                                    2                             
                   M1: non                                 0                             
                   M2: oui                                 18                             
                                                                     codelegume          2
                   O: fixation.symbiotique                 2
                             M11: azote.critique           0 
                             M12: activite.nodosite        13
                                                                     codesymbiose        2
                             M12:                                    stlevdno            150.0
                             M12:                                    stdnofno            500.0
                             M12:                                    stfnofvino          300.0
                             M12:                                    vitno               0.003
                             M12:                                    profnod             40.0
                             M12:                                    concNnodseuil       13.0e-1
                             M12:                                    concNrac0           1.2
                             M12:                                    concNrac100         0.4
                             M12:                                    hunod               1.5
                             M12:                                    tempnod1            0.0
                             M12:                                    tempnod2            30.0
                             M12:                                    tempnod3            36.0
                             M12:                                    tempnod4            50.0
         O: effet azote sur nb fruits                      2                             
                   M1: non                                 0                             
                   M2: oui(inns)                           0                             
                                                                     codazofruit         1
F: vari�tal                                                                              
         TV: les diff�rentes vari�t�s                      2
                   M01: Vari�t�.00                         22 
                   M02: Vari�t�.I                          22 
                                                                     codevar             Variete.00
                   M01:                                              stlevamf            100
                   M01:                                              stamflax            450
                   M01:                                              stlevdrp            500
                   M01:                                              pgrainmaxi          0.225
                   M01:                                              adens               -0.5
                   M01:                                              croirac             0.15
                   M01:                                              stflodrp            0
                   M01:                                              durvieF             200
                   O:  codebfroid                          1
                             M012:                                   jvc                 0
                   O:  codephot                            1
                             M011:                                   sensiphot           0
                   O:  codlainet                           2
                             M011:                                   stlaxsen            260
                             M011:                                   stsenlan            160.
                   O:  codeindetermin                      4
                             M011:                                   nbgrmax             2200
                             M011:                                   stdrpmat            510
                             M012:                                   afruitpot           .00000
                             M012:                                   dureefruit          .00000
                   O:  codelegume                          1
                             M012:                                   fixmax              6.0
                                                                     codevar             Variete.I
                   M02:                                              stlevamf            90
                   M02:                                              stamflax            530
                   M02:                                              stlevdrp            800
                   M02:                                              pgrainmaxi          .225
                   M02:                                              adens               -.50000
                   M02:                                              croirac             .15000
                   M02:                                              stflodrp            0
                   M02:                                              durvieF             200
                   O:  codebfroid                          1
                             M022:                                   jvc                 0
                   O:  codephot                            1
                             M021:                                   sensiphot           0
                   O:  codlainet                           2
                             M021:                                   stlaxsen            260.
                             M021:                                   stsenlan            160.
                   O:  codeindetermin                      4
                             M021:                                   nbgrmax             2200
                             M021:                                   stdrpmat            520
                             M022:                                   afruitpot           .00000
                             M022:                                   dureefruit          .00000
                   O:  codelegume                          1
                             M022:                                   fixmax              6.0

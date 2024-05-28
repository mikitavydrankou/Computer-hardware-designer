% Definicje komponentow komputera

% Fakty o procesorach: 'nazwa', 'gniazdo', 'watty'
processor('intel_core_i7', 'lga2011', 80).
processor('intel_core_i9', 'lga1200', 120).
processor('amd_ryzen_5', 'am4', 60).
processor('amd_ryzen_7', 'am4', 100).
processor('amd_ryzen_9', 'am4', 140).
processor('intel_core_i5', 'lga1200', 65).
processor('intel_pentium', 'lga1200', 50).
processor('amd_ryzen_3', 'am4', 50).
processor('intel_core_i3', 'lga1200', 50).
processor('intel_celeron', 'lga1200', 35).


% Fakty o plytach glownych: 'nazwa', 'gniazdo', 'typ_pamieci', 'zlacze_dysku'
motherboard('asus_rog', 'lga1200', 'ddr4', 'sata3', 'atx').
motherboard('msi_meg', 'lga2011', 'ddr4', 'sata3', 'atx').
motherboard('gigabyte_aorus', 'am4', 'ddr4', 'sata3', 'matx').
motherboard('asrock_steel_legend', 'am4', 'ddr4', 'sata3', 'atx').
motherboard('asrock_pro4', 'am4', 'ddr4', 'sata3', 'matx').
motherboard('asus_strix', 'lga1151', 'ddr4', 'sata3', 'atx').
motherboard('msi_bazooka', 'am4', 'ddr4', 'sata3', 'matx').


% Fakty o kartach graficznych: 'nazwa', 'dlugosc_mm', 'watty'
graphics_card('nvidia_rtx_3080', 250, 300).
graphics_card('amd_rx_6800_xt', 250, 300).
graphics_card('nvidia_gtx_1660_super', 200, 180).
graphics_card('nvidia_rtx_3090', 300, 350).
graphics_card('amd_rx_6900_xt', 270, 330).
graphics_card('nvidia_gtx_1650', 180, 150).
graphics_card('nvidia_gtx_1660_ti', 220, 250).
graphics_card('amd_rx_6700_xt', 250, 280).
graphics_card('nvidia_rtx_3060', 230, 200).


% Fakty o pamieci RAM: 'nazwa', 'typ_pamieci'
ram('corsair', 'ddr4').
ram('g.skill', 'ddr4').
ram('crucial', 'ddr4').
ram('kingston', 'ddr4').
ram('team_group', 'ddr4').
ram('hyperx', 'ddr4').
ram('patriot', 'ddr4').
ram('adata', 'ddr4').
ram('crucial_ballistix', 'ddr4').

% Fakty o dyskach twardych: 'nazwa', 'zlacze_dysku'
hard_drive('samsung', 'm2').
hard_drive('seagate', 'sata3').
hard_drive('western_digital', 'sata3').
hard_drive('crucial', 'sata3').
hard_drive('adata', 'm2').
hard_drive('kingston', 'sata3').
hard_drive('wd_black', 'sata3').
hard_drive('crucial', 'm2').
hard_drive('seagate_firecuda', 'sata3').


% Fakty o chlodzeniach procesora: 'nazwa', 'gniazdo', 'wysokosc'
processor_cooler('noctua', 'lga2011', 200).
processor_cooler('cooler_master', 'lga1200', 150).
processor_cooler('be_quiet', 'am4', 200).
processor_cooler('nzxt', 'lga1200', 160).
processor_cooler('thermalright', 'am4', 180).
processor_cooler('scythe', 'lga2011', 190).
processor_cooler('arctic', 'lga1200', 160).
processor_cooler('cryorig', 'am4', 180).
processor_cooler('deepcool', 'lga2011', 190).

% Fakty o obudowach komputerowych: 'nazwa', 'wysokosc_chlodzenia', 'dlugosc_karty'
case('fractal_design', 350, 280, 'atx').
case('nzxt', 300, 300, 'atx').
case('corsair_275R_airflow', 250, 400, 'atx').
case('phanteks_eclipse_P300A', 350, 320, 'matx').
case('cooler_master_mastercase_H500', 300, 400, 'atx').
case('lian_li_lancool_II_mesh', 250, 380, 'atx').
case('nzxt_H510', 350, 320, 'atx').
case('cooler_master_masterbox_MB511', 300, 400, 'atx').
case('fractal_design_meshify_C', 250, 380, 'atx').

% Fakty o zasilaczach: 'nazwa', 'watty'
power_supply('aerocool', 700).
power_supply('seasonic', 1000).
power_supply('chieftec', 500).
power_supply('evga', 850).
power_supply('corsair', 750).
power_supply('thermaltake', 650).
power_supply('be quiet!', 650).
power_supply('silverstone', 550).
power_supply('thermaltake', 750).

% Predykat sprawdzajacy kompatybilnosc komponentow
compatible_components(Processor, Motherboard, GraphicsCard, RAM, HardDrive, Cooler, Case, Power) :-
    compatible_processor(Processor, Motherboard),
    compatible_cooler(Processor, Cooler),
    compatible_case(Cooler, Case),
    compatible_ram(Motherboard, RAM),
    compatible_hard_drive(Motherboard, HardDrive),
    compatible_graphics_card(Case, GraphicsCard),
    compatible_power(Processor, GraphicsCard, Power),
    compatible_motherboard_case(Motherboard, Case).

% Predykat sprawdzajacy kompatybilnosc zasilacza z procesorem i karta graficzna
compatible_motherboard_case(Motherboard, Case) :-
    motherboard(Motherboard, _, _, _, MotherboardFormFactor),
    case(Case, _, _, CaseFormFactor),
    (
        (MotherboardFormFactor = CaseFormFactor) ;
        (MotherboardFormFactor = 'matx', CaseFormFactor = 'atx')
        ),
    Motherboard \= '',
    Case \= ''.


% Predykat sprawdzajacy kompatybilnosc zasilacza z procesorem i karta graficzna
compatible_power(Processor, GraphicsCard, PowerSupply) :-
    processor(_, _, ProcessorWatts),
    graphics_card(_, _, GraphicsCardWatts),
    TotalWattsNeeded is ProcessorWatts + GraphicsCardWatts,
    power_supply(PowerSupply, PowerSupplyWatts),
    TotalWattsNeeded =< PowerSupplyWatts,
    Processor \= '',
    GraphicsCard \= '',
    PowerSupply \= ''.

% Predykaty sprawdzajace kompatybilnosc poszczegolnych komponentow

% Sprawdzenie kompatybilnosci procesora z plyta glowna pod wzgledem gniazda
compatible_processor(Processor, Motherboard) :-
    processor(Processor, Socket, _),
    motherboard(Motherboard, Socket, _, _, _).

% Sprawdzenie kompatybilnosci chlodzenia z procesorem pod wzgledem gniazda
compatible_cooler(Processor, Cooler) :-
    processor(Processor, Socket, _),
    processor_cooler(Cooler, Socket, _),
    Processor \= '',
    Cooler \= ''.

% Sprawdzenie kompatybilnosci obudowy z chlodzeniem pod wzgledem wysokosci
compatible_case(Cooler, Case) :-
    processor_cooler(Cooler, _, CoolerHeight),
    case(Case, CaseHeight, _, _),
    CoolerHeight =< CaseHeight,
    Cooler \= '',
    Case \= ''.

% Sprawdzenie kompatybilnosci pamieci RAM z plyta glowna pod wzgledem typu
compatible_ram(Motherboard, RAM) :-
    motherboard(_, _, MemoryType, _, _),
    ram(RAM, MemoryType),
    Motherboard \= '',
    RAM \= ''.

% Sprawdzenie kompatybilnosci dysku twardego z plyta glowna pod wzgledem zlacza
compatible_hard_drive(Motherboard, HardDrive) :-
    motherboard(_, _, _, DriveSocket, _),
    hard_drive(HardDrive, DriveSocket),
    Motherboard \= '',
    HardDrive \= ''.

% Sprawdzenie kompatybilnosci karty graficznej z obudowa pod wzgledem dlugosci
compatible_graphics_card(Case, GraphicsCard) :-
    case(Case, _, CaseLength, _),
    graphics_card(GraphicsCard, CardLength, _),
    CardLength =< CaseLength,
    Case \= '',
    GraphicsCard \= ''.

% Glowna funkcja programu
main :-
    choose_case(Case),
    choose_motherboard(Case, Motherboard),
    choose_graphics_card(Case, GraphicsCard),
    choose_processor(Motherboard, Processor),
    choose_ram(Motherboard, RAM),
    choose_cooler(Processor, Cooler, Case),
    choose_power_supply(Processor, GraphicsCard, PowerSupply),
    choose_hard_drive(Motherboard, HardDrive),
    print_selection(Case, Motherboard, GraphicsCard, Processor, RAM, Cooler, PowerSupply, HardDrive).

choose_case(Case) :-
    write('Wybierz obudowe: '), nl,
    findall(C, case(C, _, _, _), Cases),
    print_list(Cases),
    read(Index),
    nth1(Index, Cases, Case),
    write('Wybrales obudowe: '), write(Case), nl.

choose_motherboard(Case, Motherboard) :-
    write('Wybierz plyte glowna: '), nl,
    findall(M, (motherboard(M, _, _, _, _), compatible_motherboard_case(M, Case)), Motherboards),
    print_list(Motherboards),
    read(Index),
    nth1(Index, Motherboards, Motherboard),
    write('Wybrales plyte glowna: '), write(Motherboard), nl.

choose_graphics_card(Case, GraphicsCard) :-
    write('Wybierz karte graficzna: '), nl,
    findall(G, (graphics_card(G, _, _), compatible_graphics_card(Case, G)), GraphicsCards),
    print_list(GraphicsCards),
    read(Index),
    nth1(Index, GraphicsCards, GraphicsCard),
    write('Wybrales karte graficzna: '), write(GraphicsCard), nl.

choose_processor(Motherboard, Processor) :-
    write('Wybierz procesor: '), nl,
    findall(P, compatible_processor(P, Motherboard), Processors),
    print_list(Processors),
    read(Index),
    nth1(Index, Processors, Processor),
    write('Wybrales procesor: '), write(Processor), nl.

choose_ram(Motherboard, RAM) :-
    write('Wybierz pamiec RAM: '), nl,
    setof(R, compatible_ram(Motherboard, R), RAMs),
    print_list(RAMs),
    read(Index),
    nth1(Index, RAMs, RAM),
    write('Wybrales pamiec RAM: '), write(RAM), nl.

choose_cooler(Processor, Cooler, Case) :-
    write('Wybierz chlodzenie: '), nl,
    findall(C, (processor_cooler(C, _, _), compatible_cooler(Processor, C), compatible_case(C, Case)), Coolers),
    print_list(Coolers),
    read(Index),
    nth1(Index, Coolers, Cooler),
    write('Wybrales chlodzenie: '), write(Cooler), nl.

choose_power_supply(Processor, GraphicsCard, PowerSupply) :-
    write('Wybierz zasilacz: '), nl,
    setof(P, compatible_power(Processor, GraphicsCard, P), PowerSupplies),
    print_list(PowerSupplies),
    read(Index),
    nth1(Index, PowerSupplies, PowerSupply),
    write('Wybrales zasilacz: '), write(PowerSupply), nl.

choose_hard_drive(Motherboard, HardDrive) :-
    write('Wybierz dysk twardy: '), nl,
    setof(H, compatible_hard_drive(Motherboard, H), HardDrives),
    print_list(HardDrives),
    read(Index),
    nth1(Index, HardDrives, HardDrive),
    write('Wybrales dysk twardy: '), write(HardDrive), nl.

print_list(List) :-
    print_list(List, 1).

print_list([], _).
print_list([Head|Tail], Index) :-
    write(Index), write('. '), write(Head), nl,
    NewIndex is Index + 1,
    print_list(Tail, NewIndex).

print_selection(Case, Motherboard, GraphicsCard, Processor, RAM, Cooler, PowerSupply, HardDrive) :-
    write('Wybrales nastepujace komponenty:'), nl,
    write('Obudowa: '), write(Case), nl,
    write('Plyta glowna: '), write(Motherboard), nl,
    write('Karta graficzna: '), write(GraphicsCard), nl,
    write('Procesor: '), write(Processor), nl,
    write('Pamiec RAM: '), write(RAM), nl,
    write('Chlodzenie: '), write(Cooler), nl,
    write('Zasilacz: '), write(PowerSupply), nl,
    write('Dysk twardy: '), write(HardDrive), nl,
    compatible_components(Processor, Motherboard, GraphicsCard, RAM, HardDrive, Cooler, Case, PowerSupply).

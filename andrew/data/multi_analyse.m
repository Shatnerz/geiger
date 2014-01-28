function[chis] = multi_analyse (m)
    [chis(1,1),chis(1,2)] = analyse_geiger_test('geiger10ms.data',m);
    [chis(2,1),chis(2,2)] = analyse_geiger_test('geiger50ms.data',m);
    [chis(3,1),chis(3,2)] = analyse_geiger_test('geiger100ms.data',m);
    [chis(4,1),chis(4,2)] = analyse_geiger_test('geiger500ms.data',m);
    [chis(5,1),chis(5,2)] = analyse_geiger_test('geiger1000ms.data',m);
    [chis(6,1),chis(6,2)] = analyse_geiger_test('geiger1500ms.data',m);
    [chis(7,1),chis(7,2)]= analyse_geiger_test('geiger2000ms.data',m);

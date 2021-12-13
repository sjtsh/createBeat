import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'EntityService/Beat.dart';
import 'Methods/multithreading.dart';
import 'OutletEntity.dart';

List<Outlet> allOutlets = [];
int threadCount = 10;

List<Beat> selectedBeats = [];

List<String> headers = [
  "Zone",
  "Region",
  "Territory",
  "Beats Name",
  "Beats ERP ID",
  "Distributor",
  "Outlet ERP ID",
  "Outlets Name",
  "Latitude",
  "Longitude",
  "Owners Name",
  "Owners Number",
  "Formatted Address",
  "Address",
  "SubCity",
  "Market",
  "City",
  "State",
  "Image"
];

List<LatLng> starvaCoordinates = [
  [85.337996, 27.650136],
  [85.337989, 27.650106],
  [85.337981, 27.650104],
  [85.337972, 27.650102],
  [85.337964, 27.650101],
  [85.337966, 27.650094],
  [85.33798, 27.650106],
  [85.337966, 27.650123],
  [85.337972, 27.650126],
  [85.337992, 27.650126],
  [85.337986, 27.650124],
  [85.337988, 27.650119],
  [85.337989, 27.650117],
  [85.33799, 27.650116],
  [85.337991, 27.650114],
  [85.337989, 27.650114],
  [85.337928, 27.650033],
  [85.337911, 27.649996],
  [85.337867, 27.649941],
  [85.33785, 27.649911],
  [85.337835, 27.649881],
  [85.337831, 27.649871],
  [85.337807, 27.649836],
  [85.337789, 27.649812],
  [85.337762, 27.649782],
  [85.33775, 27.649715],
  [85.337745, 27.64967],
  [85.337726, 27.649626],
  [85.337708, 27.649593],
  [85.337692, 27.649571],
  [85.337686, 27.649564],
  [85.33768, 27.649556],
  [85.337672, 27.649545],
  [85.337665, 27.649541],
  [85.337659, 27.649537],
  [85.337653, 27.649533],
  [85.337646, 27.649529],
  [85.33764, 27.649525],
  [85.337633, 27.64952],
  [85.337627, 27.649516],
  [85.33762, 27.649512],
  [85.337614, 27.649508],
  [85.337607, 27.649504],
  [85.337601, 27.6495],
  [85.337595, 27.649496],
  [85.337588, 27.649492],
  [85.337567, 27.649465],
  [85.337548, 27.649436],
  [85.337535, 27.649409],
  [85.33752, 27.64938],
  [85.337505, 27.649342],
  [85.337491, 27.649296],
  [85.337478, 27.649247],
  [85.337462, 27.649209],
  [85.337432, 27.649169],
  [85.337413, 27.649119],
  [85.337395, 27.64907],
  [85.337379, 27.649013],
  [85.337369, 27.648956],
  [85.337369, 27.648908],
  [85.337374, 27.648872],
  [85.337369, 27.648823],
  [85.33736, 27.648771],
  [85.337342, 27.648723],
  [85.337316, 27.648676],
  [85.337293, 27.648641],
  [85.337272, 27.648618],
  [85.337248, 27.648591],
  [85.337219, 27.648561],
  [85.337191, 27.648527],
  [85.337165, 27.648498],
  [85.337161, 27.648474],
  [85.33717, 27.648466],
  [85.337171, 27.648454],
  [85.337171, 27.648442],
  [85.337172, 27.64843],
  [85.337172, 27.648418],
  [85.33718, 27.64838],
  [85.337191, 27.648339],
  [85.337198, 27.648296],
  [85.337197, 27.648243],
  [85.337191, 27.648182],
  [85.33719, 27.648126],
  [85.337197, 27.648076],
  [85.337204, 27.64803],
  [85.337203, 27.647992],
  [85.3372, 27.647937],
  [85.337187, 27.64788],
  [85.337173, 27.64784],
  [85.337158, 27.6478],
  [85.337149, 27.647786],
  [85.33713, 27.647762],
  [85.337116, 27.647737],
  [85.337111, 27.647706],
  [85.337108, 27.647699],
  [85.33708, 27.647675],
  [85.337067, 27.64767],
  [85.337048, 27.647671],
  [85.337035, 27.647674],
  [85.337014, 27.647663],
  [85.337003, 27.647656],
  [85.336991, 27.647648],
  [85.336957, 27.647628],
  [85.336944, 27.647622],
  [85.3369, 27.647605],
  [85.336858, 27.647594],
  [85.336816, 27.647584],
  [85.336785, 27.647577],
  [85.336754, 27.647573],
  [85.336718, 27.647572],
  [85.33671, 27.64757],
  [85.336681, 27.647555],
  [85.336674, 27.647547],
  [85.336663, 27.647514],
  [85.336658, 27.647477],
  [85.336657, 27.647443],
  [85.336662, 27.647415],
  [85.336669, 27.647386],
  [85.336684, 27.64733],
  [85.336686, 27.647296],
  [85.336683, 27.647268],
  [85.336677, 27.647234],
  [85.336675, 27.647223],
  [85.336668, 27.647189],
  [85.336667, 27.64718],
  [85.336663, 27.647168],
  [85.336652, 27.647148],
  [85.336638, 27.647114],
  [85.336634, 27.647102],
  [85.336644, 27.647053],
  [85.336655, 27.647025],
  [85.33667, 27.646993],
  [85.336683, 27.646954],
  [85.336697, 27.64687],
  [85.336701, 27.646797],
  [85.336697, 27.64676],
  [85.336694, 27.646748],
  [85.336689, 27.646715],
  [85.336687, 27.646704],
  [85.336684, 27.646671],
  [85.336683, 27.646659],
  [85.336686, 27.646618],
  [85.336688, 27.646602],
  [85.336699, 27.646553],
  [85.336715, 27.646509],
  [85.336728, 27.646456],
  [85.336733, 27.646424],
  [85.33676, 27.646338],
  [85.336794, 27.646297],
  [85.336817, 27.646272],
  [85.33683, 27.646257],
  [85.336837, 27.646249],
  [85.336858, 27.646216],
  [85.336874, 27.646188],
  [85.33688, 27.646172],
  [85.336967, 27.645888],
  [85.336986, 27.645826],
  [85.337017, 27.64571],
  [85.337043, 27.645613],
  [85.337077, 27.645523],
  [85.337118, 27.645436],
  [85.337151, 27.645361],
  [85.33718, 27.645291],
  [85.337206, 27.64523],
  [85.337228, 27.645171],
  [85.337253, 27.645102],
  [85.337283, 27.645026],
  [85.337311, 27.64496],
  [85.337339, 27.644902],
  [85.337366, 27.644844],
  [85.33739, 27.644779],
  [85.337412, 27.644714],
  [85.337438, 27.644646],
  [85.337467, 27.644576],
  [85.337496, 27.644508],
  [85.337522, 27.64444],
  [85.33755, 27.64438],
  [85.337572, 27.644328],
  [85.33759, 27.644283],
  [85.337603, 27.644248],
  [85.337615, 27.644219],
  [85.337627, 27.644173],
  [85.337634, 27.644151],
  [85.337646, 27.644105],
  [85.337657, 27.644065],
  [85.337674, 27.644026],
  [85.337721, 27.64399],
  [85.337744, 27.643956],
  [85.337752, 27.64394],
  [85.337768, 27.643901],
  [85.337796, 27.643824],
  [85.337807, 27.643788],
  [85.337822, 27.643754],
  [85.337869, 27.643621],
  [85.337905, 27.643577],
  [85.337923, 27.643545],
  [85.337938, 27.643477],
  [85.33796, 27.643444],
  [85.337981, 27.643414],
  [85.338003, 27.643367],
  [85.338008, 27.643335],
  [85.338008, 27.643271],
  [85.338011, 27.643232],
  [85.338058, 27.643138],
  [85.338079, 27.643079],
  [85.338099, 27.643032],
  [85.338122, 27.642973],
  [85.338138, 27.642909],
  [85.338151, 27.642846],
  [85.338166, 27.642791],
  [85.338187, 27.642741],
  [85.338199, 27.642695],
  [85.338207, 27.642666],
  [85.338234, 27.642649],
  [85.338274, 27.642627],
  [85.338296, 27.642575],
  [85.338321, 27.64245],
  [85.33833, 27.642415],
  [85.33834, 27.642388],
  [85.338361, 27.642332],
  [85.338385, 27.642288],
  [85.338421, 27.642209],
  [85.33846, 27.642127],
  [85.338488, 27.642068],
  [85.338517, 27.642007],
  [85.338543, 27.641943],
  [85.338569, 27.641884],
  [85.338596, 27.641829],
  [85.338622, 27.641776],
  [85.338646, 27.641726],
  [85.338668, 27.64168],
  [85.338686, 27.641631],
  [85.338706, 27.641577],
  [85.338728, 27.641525],
  [85.338742, 27.641493],
  [85.338761, 27.641447],
  [85.338777, 27.641393],
  [85.338791, 27.641338],
  [85.338802, 27.641283],
  [85.33881, 27.641241],
  [85.338845, 27.641164],
  [85.338882, 27.641076],
  [85.338899, 27.641034],
  [85.338923, 27.640982],
  [85.338951, 27.640925],
  [85.338982, 27.640868],
  [85.339011, 27.64081],
  [85.339035, 27.640751],
  [85.339058, 27.640691],
  [85.339081, 27.640634],
  [85.3391, 27.640573],
  [85.339109, 27.640502],
  [85.339125, 27.640431],
  [85.339148, 27.64036],
  [85.339176, 27.640293],
  [85.339202, 27.640233],
  [85.339228, 27.640174],
  [85.339252, 27.640116],
  [85.339273, 27.640053],
  [85.339298, 27.639989],
  [85.339326, 27.639934],
  [85.339349, 27.639888],
  [85.339375, 27.639832],
  [85.339401, 27.639777],
  [85.339428, 27.639722],
  [85.33945, 27.639666],
  [85.339476, 27.639619],
  [85.339498, 27.63958],
  [85.339527, 27.639515],
  [85.33956, 27.639455],
  [85.339591, 27.639396],
  [85.339621, 27.639348],
  [85.339646, 27.639308],
  [85.339668, 27.639256],
  [85.33969, 27.639194],
  [85.339717, 27.639136],
  [85.339749, 27.639078],
  [85.339791, 27.639038],
  [85.339815, 27.639005],
  [85.339841, 27.638955],
  [85.339874, 27.638893],
  [85.339905, 27.638838],
  [85.339929, 27.63881],
  [85.339959, 27.638766],
  [85.339987, 27.638713],
  [85.340009, 27.638658],
  [85.340028, 27.638611],
  [85.340052, 27.638561],
  [85.340082, 27.638504],
  [85.340109, 27.63845],
  [85.340135, 27.638387],
  [85.340161, 27.638325],
  [85.340186, 27.638261],
  [85.340214, 27.638195],
  [85.340239, 27.638134],
  [85.34027, 27.638073],
  [85.340303, 27.638014],
  [85.340339, 27.637952],
  [85.340366, 27.6379],
  [85.340378, 27.637868],
  [85.340396, 27.637822],
  [85.340415, 27.637784],
  [85.340435, 27.637763],
  [85.340453, 27.637738],
  [85.340468, 27.637729],
  [85.34048, 27.637727],
  [85.340492, 27.637724],
  [85.340523, 27.637732],
  [85.340555, 27.637734],
  [85.34061, 27.637738],
  [85.34068, 27.637737],
  [85.340861, 27.637723],
  [85.34092, 27.637726],
  [85.340957, 27.637735],
  [85.340998, 27.637736],
  [85.341047, 27.637728],
  [85.341117, 27.637713],
  [85.341197, 27.637695],
  [85.341261, 27.637676],
  [85.341308, 27.637665],
  [85.34139, 27.637653],
  [85.341469, 27.637652],
  [85.341533, 27.637648],
  [85.341565, 27.63764],
  [85.341596, 27.637613],
  [85.34161, 27.637576],
  [85.341624, 27.637534],
  [85.341632, 27.637513],
  [85.341649, 27.637477],
  [85.341663, 27.637442],
  [85.341676, 27.637407],
  [85.341686, 27.63736],
  [85.341694, 27.637314],
  [85.341705, 27.637265],
  [85.341716, 27.637216],
  [85.341726, 27.637167],
  [85.341734, 27.637123],
  [85.341745, 27.63706],
  [85.3418, 27.636911],
  [85.341817, 27.636838],
  [85.341834, 27.636798],
  [85.341844, 27.636763],
  [85.341861, 27.636723],
  [85.341881, 27.636684],
  [85.341914, 27.63662],
  [85.341948, 27.63656],
  [85.34197, 27.636523],
  [85.341989, 27.636489],
  [85.342024, 27.636497],
  [85.342063, 27.636419],
  [85.342079, 27.636373],
  [85.342098, 27.636327],
  [85.342119, 27.636286],
  [85.342191, 27.636158],
  [85.342211, 27.636112],
  [85.342224, 27.636073],
  [85.342251, 27.636025],
  [85.342262, 27.635991],
  [85.342297, 27.635947],
  [85.342344, 27.635879],
  [85.342374, 27.63584],
  [85.342419, 27.635755],
  [85.342439, 27.635714],
  [85.342456, 27.635673],
  [85.342469, 27.635639],
  [85.342491, 27.635581],
  [85.342513, 27.635534],
  [85.342532, 27.635493],
  [85.342565, 27.635433],
  [85.342586, 27.635387],
  [85.342599, 27.635352],
  [85.342603, 27.635342],
  [85.34261, 27.635313],
  [85.342622, 27.635281],
  [85.342624, 27.635266],
  [85.342629, 27.635249],
  [85.342633, 27.635231],
  [85.342638, 27.635215],
  [85.342645, 27.63519],
  [85.342649, 27.635177],
  [85.342654, 27.635164],
  [85.342674, 27.635134],
  [85.342695, 27.635101],
  [85.342703, 27.635091],
  [85.342722, 27.635055],
  [85.342728, 27.63504],
  [85.34274, 27.635014],
  [85.342752, 27.634996],
  [85.342772, 27.634957],
  [85.342792, 27.634913],
  [85.342807, 27.634888],
  [85.342825, 27.634857],
  [85.342863, 27.634797],
  [85.342897, 27.63473],
  [85.342912, 27.634698],
  [85.342928, 27.634667],
  [85.342962, 27.634606],
  [85.342997, 27.63454],
  [85.343013, 27.634506],
  [85.343032, 27.634466],
  [85.34307, 27.634387],
  [85.343096, 27.634335],
  [85.343124, 27.63428],
  [85.343142, 27.634202],
  [85.343155, 27.634138],
  [85.34317, 27.634086],
  [85.343188, 27.634045],
  [85.343211, 27.634017],
  [85.343228, 27.63399],
  [85.343267, 27.633947],
  [85.343293, 27.633908],
  [85.343326, 27.633854],
  [85.343366, 27.633802],
  [85.3434, 27.633744],
  [85.343425, 27.633681],
  [85.343449, 27.633616],
  [85.34348, 27.633554],
  [85.343514, 27.633495],
  [85.343542, 27.633438],
  [85.343568, 27.633378],
  [85.343594, 27.633309],
  [85.343624, 27.633232],
  [85.343657, 27.633152],
  [85.343692, 27.633081],
  [85.343725, 27.63301],
  [85.343757, 27.632945],
  [85.34379, 27.632893],
  [85.343814, 27.632845],
  [85.343835, 27.632793],
  [85.343867, 27.632745],
  [85.343896, 27.63269],
  [85.343914, 27.632626],
  [85.343935, 27.632562],
  [85.343965, 27.632497],
  [85.34399, 27.632435],
  [85.344016, 27.632372],
  [85.344049, 27.632305],
  [85.344074, 27.632243],
  [85.344096, 27.632177],
  [85.344117, 27.63212],
  [85.344145, 27.63206],
  [85.34417, 27.631999],
  [85.344194, 27.631938],
  [85.344227, 27.631877],
  [85.344265, 27.631817],
  [85.344294, 27.631755],
  [85.344319, 27.631691],
  [85.34435, 27.631625],
  [85.344378, 27.631566],
  [85.344404, 27.631507],
  [85.344428, 27.631449],
  [85.344454, 27.631387],
  [85.344483, 27.631323],
  [85.34451, 27.631259],
  [85.34453, 27.631201],
  [85.344548, 27.631144],
  [85.344574, 27.631086],
  [85.3446, 27.631027],
  [85.34463, 27.630967],
  [85.344663, 27.630901],
  [85.344694, 27.630837],
  [85.344722, 27.630772],
  [85.344753, 27.630711],
  [85.344787, 27.63066],
  [85.344813, 27.630613],
  [85.344836, 27.630568],
  [85.344858, 27.630523],
  [85.344882, 27.630482],
  [85.344901, 27.630443],
  [85.344917, 27.63041],
  [85.34493, 27.630379],
  [85.344947, 27.630346],
  [85.344965, 27.630307],
  [85.34499, 27.630275],
  [85.344998, 27.630198],
  [85.345009, 27.630162],
  [85.345039, 27.630132],
  [85.345065, 27.630088],
  [85.345084, 27.63004],
  [85.345106, 27.629988],
  [85.34513, 27.629936],
  [85.345157, 27.62988],
  [85.345188, 27.629821],
  [85.345224, 27.629762],
  [85.345257, 27.629702],
  [85.345282, 27.629643],
  [85.345318, 27.629579],
  [85.34535, 27.629517],
  [85.345385, 27.629451],
  [85.345416, 27.629384],
  [85.34544, 27.629317],
  [85.345451, 27.629258],
  [85.345461, 27.629205],
  [85.34548, 27.629154],
  [85.345506, 27.629103],
  [85.345537, 27.629049],
  [85.345568, 27.628996],
  [85.345601, 27.628945],
  [85.345629, 27.628897],
  [85.345652, 27.628848],
  [85.345676, 27.628797],
  [85.345703, 27.628744],
  [85.345729, 27.628693],
  [85.345755, 27.628643],
  [85.345781, 27.62859],
  [85.345807, 27.628536],
  [85.345838, 27.628481],
  [85.345868, 27.628428],
  [85.345896, 27.628379],
  [85.345922, 27.628325],
  [85.345952, 27.628269],
  [85.34598, 27.628214],
  [85.346006, 27.628165],
  [85.34603, 27.628112],
  [85.34606, 27.628045],
  [85.346097, 27.627968],
  [85.346133, 27.627889],
  [85.346172, 27.627809],
  [85.346211, 27.62773],
  [85.346248, 27.627655],
  [85.346283, 27.627578],
  [85.346315, 27.6275],
  [85.346345, 27.62743],
  [85.346374, 27.627372],
  [85.346404, 27.627323],
  [85.346429, 27.627274],
  [85.346456, 27.627234],
  [85.346476, 27.62719],
  [85.346501, 27.627147],
  [85.346523, 27.627099],
  [85.346555, 27.627047],
  [85.346593, 27.626998],
  [85.346624, 27.626952],
  [85.346649, 27.626909],
  [85.346675, 27.626864],
  [85.346694, 27.62682],
  [85.346718, 27.626778],
  [85.346743, 27.626728],
  [85.346771, 27.626677],
  [85.346803, 27.626626],
  [85.34684, 27.626573],
  [85.34688, 27.626517],
  [85.346918, 27.62646],
  [85.346956, 27.626406],
  [85.34699, 27.626355],
  [85.347027, 27.626309],
  [85.347057, 27.626263],
  [85.347086, 27.62622],
  [85.347112, 27.62618],
  [85.347135, 27.62615],
  [85.347155, 27.626122],
  [85.347175, 27.626089],
  [85.347199, 27.626063],
  [85.347224, 27.626029],
  [85.347249, 27.625988],
  [85.347274, 27.625944],
  [85.347302, 27.6259],
  [85.347324, 27.625866],
  [85.347342, 27.625833],
  [85.347366, 27.625796],
  [85.347388, 27.625764],
  [85.347412, 27.625731],
  [85.347436, 27.625694],
  [85.347455, 27.62566],
  [85.347478, 27.625625],
  [85.347496, 27.625594],
  [85.347519, 27.625564],
  [85.347548, 27.625532],
  [85.347576, 27.625498],
  [85.347605, 27.625465],
  [85.347635, 27.625429],
  [85.347662, 27.625399],
  [85.347693, 27.625371],
  [85.347703, 27.625362],
  [85.347723, 27.625335],
  [85.347729, 27.625326],
  [85.347747, 27.625294],
  [85.347753, 27.625284],
  [85.34777, 27.625249],
  [85.347775, 27.625237],
  [85.347793, 27.625203],
  [85.347797, 27.625192],
  [85.347804, 27.625162],
  [85.347807, 27.625153],
  [85.347813, 27.625137],
  [85.347821, 27.625123],
  [85.347831, 27.625097],
  [85.347834, 27.625087],
  [85.347838, 27.625072],
  [85.347843, 27.625066],
  [85.347846, 27.625063],
  [85.347845, 27.62506],
  [85.347853, 27.625056],
  [85.347716, 27.625112],
  [85.347692, 27.625058],
  [85.347717, 27.625006],
  [85.347736, 27.624993],
  [85.347744, 27.624979],
  [85.347752, 27.624968],
  [85.347754, 27.624964],
  [85.347756, 27.624961],
  [85.347759, 27.624958],
  [85.347759, 27.624955],
  [85.347758, 27.62495],
  [85.347754, 27.624953],
  [85.347751, 27.624957],
  [85.34775, 27.624956],
  [85.347753, 27.624952],
  [85.347758, 27.624948],
  [85.347763, 27.624939],
  [85.347771, 27.624929],
  [85.347779, 27.624918],
  [85.347784, 27.624911],
  [85.347786, 27.624907],
  [85.347785, 27.624908],
  [85.347784, 27.624911],
  [85.347781, 27.624913],
  [85.347779, 27.624914],
  [85.347776, 27.624915],
  [85.347776, 27.624916],
  [85.347775, 27.624917],
  [85.347775, 27.624917],
  [85.347775, 27.624917],
  [85.347775, 27.624917],
  [85.347776, 27.624918],
  [85.347804, 27.624947],
  [85.347809, 27.624951],
  [85.347812, 27.624955],
  [85.347811, 27.624959],
  [85.347807, 27.624964],
  [85.347803, 27.624966],
  [85.347801, 27.624968],
  [85.347799, 27.624968],
  [85.347798, 27.624968],
  [85.347798, 27.624968],
  [85.347797, 27.624968],
  [85.347797, 27.624968],
  [85.347796, 27.624969],
  [85.347796, 27.624969],
  [85.347795, 27.624969],
  [85.347795, 27.624968],
  [85.347793, 27.624999],
  [85.347793, 27.625006],
  [85.347792, 27.625008],
  [85.347792, 27.625012],
  [85.347793, 27.625016],
  [85.347795, 27.625022],
  [85.347797, 27.625028],
  [85.347799, 27.625031],
  [85.3478, 27.625034],
  [85.347801, 27.625037],
  [85.347799, 27.625031],
  [85.347799, 27.625028],
  [85.3478, 27.625026],
].map((e) => LatLng(e[1], e[0])).toList();

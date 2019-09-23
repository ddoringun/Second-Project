<%@page import="bean.ChartDTO"%><%@page import="bean.ChartDAO"%><%@page import="java.io.Console"%><%@page import="bean.MusicDTO"%><%@page import="java.util.ArrayList"%><%@page import="bean.MusicDAO"%><%@page import="org.jsoup.Jsoup"%><%@page import="org.jsoup.nodes.Document"%><%@page import="org.jsoup.nodes.Element"%><%@page import="org.jsoup.select.Elements"%><%@page import="java.io.IOException"%><%@ page language="java" contentType="text/html; charset=UTF8"
	pageEncoding="UTF8"%><%
		ChartDAO dao = new ChartDAO();
		ChartDTO dto = new ChartDTO();
		Document doc = null;
		String song ="89095473;88965638;89126699;88915147;89059621;88261335;87928158;88965633;88947057;89119858;88727092;88773173;89091983;88987356;89149183;89117145;89143933;89147220;89058209;88978973;89091924;88707240;89011319;88824340;88965627;88686378;88709300;88965632;88501296;87840106;88890308;89150406;89148820;88732246;89064462;88965631;88504833;88511064;88607738;88336380;89059750;88281290;89149101;88510820;88728543;88740321;88933143;88074702;87506735;88674285;87752744;88732247;86380457;86941521;88510821;88707238;87998685;88909978;88773174;88948788;88725289;88951935;89126695;88323996;89143093;88559277;88562939;88194599;82779996;86925465;88773175;86432095;87512697;88352905;88316432;88773178;88353506;88611219;89101027;86868163;87271938;88697586;88286541;88914149;88244288;87315030;88098432;87034188;88728375;87101034;88421579;87683188;88355491;88468830;88295011;87957296;85433670;88419409;87628996;88353726;86496239;88689633;86978532;88965635;88678985;88040624;88542731;85803478;88557156;88773176;88564550;86083393;88965628;87463712;87579522;89059697;88417558;88363609;88703035;88776558;87360263;88773177;88914905;87240368;88251225;87699632;84861691;87526820;85448749;86468828;88234302;88971182;88391129;88684311;88690398;89126578;87470580;86868102;89096273;86978777;88293633;88253990;88470489;87101441;88149389;87444264;88280580;87993384;89021253;87893782;88162019;87115262;87413975;88732249;82689882;87931536;87538960;88646493;87403636;88295436;89147965;88928855;86311323;88040625;89126573;88573751;87235670;88671402;87440992;88528811;88953188;88062821;87647017;88736570;88350489;89041088;88773172;88729142;86455936;89143226;87663449;87298263;18082664;88401806;86594795;89056956;89148578;87946017;87730738;88048450;88336403;88701549;87466348;87270282;88740322;85902355;89117146;85887585;87101804;88914060;";
		String[] value = song.split(";");
		//200곡의 각 번호 / 장르, 재생횟수 탐색시 사용 / 수시로 업데이트
		//0번이 200위 / 199번이 1위

		String url1 = "https://www.genie.co.kr/detail/songInfo?xgnm=";
		dao.delete();

		String title = null;
		String genre = null;
		int count = 0;
		String time = null;

		int n = 0;
		for (int i = 0; i < 200; i++) { //1위부터 200위까지 반복
			String url = url1 + String.valueOf(value[199 - i]); // 각 노래 상세페이지
			doc = Jsoup.connect(url).get();

			for (Element el : doc.select("div.info-zone h2.name")) { // title 가져옴
				title = el.text();
				break;
			}

			n = 0;
			for (Element el : doc.select("div.info-zone li span.value")) { // 재생시간 가져올 것 !!!
				if (n < 3) {
					n++;
				} else {
					String xx = el.text();
					time =xx.replaceAll("\\:", "");
					break;
				}
			}

			n = 0;
			for (Element el : doc.select("div.info-zone li span.value")) { // genre 가져옴
				if (n < 2) {
					n++;
				} else {
					genre = el.text();
					break;
				}
			}
			
			n = 0;
			for (Element el : doc.select("div.total p")) { // 재생횟수 가져옴
				if (n < 1) {
					n++;
				} else {
					String xx = el.text();
					count = Integer.parseInt(xx.replaceAll("\\,", "")); // 천단위 콤마 없애고 숫자로 만듦
					break;
				}
			}
			dao.update(title, time, genre, count);
		}

		ArrayList<ChartDTO> list = dao.selectAll();

		ArrayList temp = null;
		ChartDTO dto1 = new ChartDTO();
		int[] popCount = new int[2];
		int[] genreCount = new int[8];
		
		for (int i = 0; i < 2; i++) {
			temp = dao.pop(i);
			popCount[i]=temp.size();
		} // 가요와 팝 각각의 노래수 배열
		
		for (int i = 0; i < 8; i++) {
			temp = dao.genre(i);
			genreCount[i]=temp.size();
		} // 8개 장르별 노래수 배열
	%><%=popCount[0]%>,<%=popCount[1]%>,<%=genreCount[0]%>,<%=genreCount[1]%>,<%=genreCount[2]%>,<%=genreCount[3]%>,<%=genreCount[4]%>,<%=genreCount[5]%>,<%=genreCount[6]%>,<%=genreCount[7]%>
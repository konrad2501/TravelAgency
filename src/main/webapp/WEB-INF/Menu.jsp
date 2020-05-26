<%--
  Created by IntelliJ IDEA.
  User: konradmichalski
  Date: 20/05/2020
  Time: 15:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script src="webjars/jquery/2.2.4/jquery.min.js"></script>
    <script type="text/javascript"></script>
    <title>Menu</title>
</head>
<body>

<style>
    body {
        text-align: center;
        margin-top:20px;
        padding:0;
        width: 100%;
        height: 100%;
        background-color: paleturquoise;
    }
 .left {
     height:100%;
     width: 33%;
     float:left;
}
 .center {
     height:100%;
     width: 33%;
     float:left;
     background-color: azure;
    }

 .right {
     height:100%;
     width: 33%;
     float:right;
 }

    h1 {
        color:orange;
    }

    img {
        margin:10px;
        border-radius: 10px;

    }
</style>

<div class="menu">
    <div class="left">
    <c:if test="${logged}">
        <table>
            <h1>Hiszpania</h1>
            <c:forEach var="tour" items="${Spain}">
                <tr>
                    <td>
                        <input type="button" id="${tour.city}" value="Rezerwuj" onclick="tourClick(this, ${tour.price})"/>
                    </td>
                    <td>
                        <input type="button" id="${tour.city}" value=">Informacje<" onclick="wczytaj(this)">
                    </td>
                    <td>
                        <input type="button" id="${tour.city}" value=">Termin<" name = "${tour.departure} ${tour.arrival}"
                               onclick="info(this, ${tour.days}, ${tour.price})">
                    </td>
                    <td>
                            ${tour.city} - ${tour.price} zł/os.
                    </td>
                </tr>
            </c:forEach>
        </table>
        <hr>
        <table>
            <h1>Włochy</h1>
            <c:forEach var="tour" items="${Italy}">
                <tr>
                    <td>
                        <input type="button" id="${tour.city}" value="Rezerwuj" onclick="tourClick(this, ${tour.price})"/>
                    </td>
                    <td>
                            <input type="button" id="${tour.city}" value=">Informacje<" onclick="wczytaj(this)">
                    </td>
                    <td>
                        <input type="button" id="${tour.city}" value=">Termin<" name = "${tour.departure} ${tour.arrival}"
                               onclick="info(this, ${tour.days}, ${tour.price})">
                    </td>
                    <td>
                            ${tour.city} - ${tour.price} zł/os.
                    </td>
                </tr>
            </c:forEach>
        </table>
        <hr>
        <table>
            <h1>Turcja</h1>
            <c:forEach var="tour" items="${Turkey}">
                <tr>
                    <td>
                        <input type="button" id="${tour.city}" value="Rezerwuj" onclick="tourClick(this, ${tour.price})"/>
                    </td>
                    <td>
                        <input type="button" id="${tour.city}" value=">Informacje<" onclick="wczytaj(this)">
                    </td>
                    <td>
                    <input type="button" id="${tour.city}" value=">Termin<" name = "${tour.departure} ${tour.arrival}"
                           onclick="info(this, ${tour.days}, ${tour.price})">
                    </td>
                    <td>
                            ${tour.city} - ${tour.price} zł/os.
                    </td>
                </tr>
            </c:forEach>
        </table>
        <hr>
        <table>
            <h1>Portugalia</h1>
            <c:forEach var="tour" items="${Portugal}">
                <tr>
                    <td>
                        <input type="button" id="${tour.city}" value="Rezerwuj" onclick="tourClick(this, ${tour.price})"/>
                    </td>
                    <td>
                        <input type="button" id="${tour.city}" value=">Informacje<" onclick="wczytaj(this)">
                    </td>
                    <td>
                        <input type="button" id="${tour.city}" value=">Termin<" name = "${tour.departure} ${tour.arrival}"
                               onclick="info(this, ${tour.days}, ${tour.price})">
                    </td>
                    <td>
                            ${tour.city} - ${tour.price} zł/os.
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
    <c:if test="${!logged}">
        <c:redirect url="/Login"/>
    </c:if>
    </div>
    <div class="center">
        <div id="text" style="margin: 10px;">
            Lubisz mieć zaplanowane wakacje od początku do końca, cenisz sobie wygodę i bezpieczeństwo? Zarezerwuj swój urlop u nas! Z przyjemnością pomożemy Ci przebrnąć przez gęstą dżunglę ofert wycieczek objazdowych, wczasów wypoczynkowych all inclusive, egzotycznych wakacji, last minute i odpowiedzieć na pytanie gdzie pojechać na wakacje? Dużym plusem podróżowania z nami jest fakt, że możesz całkowicie się zrelaksować i nie musisz się niczym martwić.
        </div>
        <br>
        <img id="display1" width="80%" height="20%" src="https://www.szkolneblogi.pl/static/media/users/private/kasjer_sko/slonce_sko_thumb.png">
        <br>
        <img id="display2" width="80%" height="20%" src='https://skonto.net.pl/wp-content/uploads/2018/01/kokos2-500x350.png'>
        <br>
        <img id="display3" width="80%" height="20%" src="https://f4fcdn.eu/wp-content/uploads/2018/05/norweg_jp_wallet.jpg">
    </div>
    <div class="right">
<h3>Rachunek:</h3>
<form method="post">
    <div class="order">
        <div id="order">
        </div>
        <label id="total"></label>
        <br><br><br>
        <a href="OrderConfirm" type="submit" id="finished" onclick="finishOrder()">Zamawiam!</a>
    </div>
</form>
    </div>
</div>
</body>
</html>
<script>
    var totalCost = 0;
    var tours = [];
    var count = 0 ;
    function tourClick(button, price)
    {
        if ( count < 10 ) {
            var city = button.id;
            totalCost += price;
            var order = document.getElementById("order");
            var node = document.createElement('div');
            node.innerHTML = '<label>' + city + '</label>' + ' : ' + price + ' zł';
            order.appendChild(node);
            document.getElementById("total").innerText = "\nKoszt zamówienia: " + totalCost + "zł ";
            tours.push(city);
            count += 1;
        }
    }

    function info(button, days, price)
    {
        var city=button.id;
        var price = price;
        var days = days;
        var text = button.name;
        var textSplit = text.split(" ");
        var dep = textSplit[0];
        var arr = textSplit[1];

        if(city == "Barcelona") { faq(city,days,price,dep,arr); }
        if(city == "Madryt") { faq(city,days,price,dep,arr); }
        if(city == "Majorka") { faq(city,days,price,dep,arr); }
        if(city == "Sewilla") { faq(city,days,price,dep,arr); }
        if(city == "Rzym") { faq(city,days,price,dep,arr); }
        if(city == "Wenecja") { faq(city,days,price,dep,arr); }
        if(city == "Mediolan") { faq(city,days,price,dep,arr); }
        if(city == "Florencja") { faq(city,days,price,dep,arr); }
        if(city == "Stambuł") { faq(city,days,price,dep,arr); }
        if(city == "Kapadocja") { faq(city,days,price,dep,arr); }
        if(city == "Pamukkale") { faq(city,days,price,dep,arr); }
        if(city == "Antalya") { faq(city,days,price,dep,arr); }
        if(city == "Lizbona") { faq(city,days,price,dep,arr); }
        if(city == "Porto") { faq(city,days,price,dep,arr); }
        if(city == "Madera") { faq(city,days,price,dep,arr); }
        if(city == "Sintra") { faq(city,days,price,dep,arr); }
        document.getElementById('display1').src='https://cdn.galleries.smcloud.net/t/galleries/gf-Qnfd-f8zD-G8Dr_nowy-paszport-2018-jak-wyglada-i-od-kiedy-obowiazuje-664x442-nocrop.jpg';
        document.getElementById('display2').src='https://sciezkimojegoswiata.com/wp-content/uploads/2018/10/lot-bilet.png';
        document.getElementById('display3').src='https://ocdn.eu/pulscms-transforms/1/m13k9kpTURBXy9lZTY2YTNlYTc3M2U5NTUxYzA0OTA0ZDEzZjAwMmU0Yy5qcGeTlQMAfM0PoM0IypMFzQMUzQG8kwmmYzc0YmEzBoGhMAE/dreamliner-lot-u.jpg';
    }

    function faq(city,days,price,dep,arr) {
        document.getElementById("text").innerText = "\nMiasto: " + city + "\nLiczba dni: " + days + "\nCena za osobę: " + price + "\nData wylotu: " + dep + "\nData przylotu: " + arr;
    }

    function wczytaj(button)
    {
        var city=button.id;
        if(city == "Barcelona") {
            document.getElementById("text").innerText = "Barcelona to duże miasto, drugie największe po Madrycie w Hiszpanii. Jest stolicą wspólnoty autonomicznej Katalonii. Położona jest nad Morzem Śródziemnym, mniej więcej w środku linii brzegowej Katalonii, wciśnięta pomiędzy morze i góry Serra de Collserola.";
            document.getElementById('display1').src='https://i.content4travel.com/cms/img/u/kraj/1/hiszpania_0.jpg?version=191128-04';
            document.getElementById('display2').src='https://static.deon.pl/storage/image/core_files/2018/12/15/74993948206f3482cd3f8aeb66af82d3/jpg/deon/articles-thumb-xlarge-breakpoint-default/hiszpania-rekordowo-niska-liczba-katolikow.jpg';
            document.getElementById('display3').src='https://static.300gospodarka.pl/media/2020/04/shutterstock_712467547-e1586254554395.jpg';
        }
        if(city == "Madryt") {
            document.getElementById("text").innerText = "Madryt jest stolicą Hiszpanii. Leży w centralnej części kraju nad rzeką Manzanares u podnóża Wyżyny Kastylijskiej, na wysokości 646 m n.p.m. Zajmuje powierzchnię 607 km². Liczba ludności miasta wynosi 3,2 mln. Jest on ponadto stolicą regionu administracyjnego o tej samej nazwie";
            document.getElementById('display1').src='https://hispanico.pl/wp-content/uploads/2016/02/palac-krolewski-madryt-hiszpania-palacio-real.jpg';
            document.getElementById('display2').src='https://gdziewyjechac.pl/wp-content/uploads/2013/11/Madryt-plaza-mayor.jpg';
            document.getElementById('display3').src='https://www.tpcoe.gov.pl/dokumenty/zalaczniki/10/10-2919.jpg';
        }
        if(city == "Majorka")
        {
            document.getElementById("text").innerText = "Majorka – największa w archipelagu Balearów wyspa hiszpańska na Morzu Śródziemnym o długości około 100 km i powierzchni 3640 km². Zamieszkuje ją 859 289 mieszkańców. Głównym miastem i stolicą wyspy jest Palma de Mallorca. Wyspa jest zbudowana głównie z wapieni mezozoicznych.";
            document.getElementById('display1').src='https://ocs-pl.oktawave.com/v1/AUTH_8cbbf711-053c-4ce9-974a-cdf33454ce7e/blog-tui-pl/2019/01/Minorka.jpg';
            document.getElementById('display2').src='https://i.wpimg.pl/O/644x430/d.wpimg.pl/366670358--2040432002/majorka.jpg';
            document.getElementById('display3').src='https://www.national-geographic.pl/media/cache/default_view/uploads/media/default/0013/58/majorka-to-nie-tylko-plaza-i-drink-jak-poznac-jej-tajemnice.jpeg';
        }
        if(city == "Sewilla")
        {
            document.getElementById("text").innerText = "Sewilla to artystyczna, kulturalna i finansowa stolica południowej Hiszpanii, to formalnie stolica Andaluzji. To duże miasto – zamieszkane przez ponad 700 tys. mieszkańców, a obszar metropolitalny liczy prawie 1,5 mln mieszkańców. Sewilla jest czwartym z największych miast kraju.";
            document.getElementById('display1').src='https://hispanico.pl/wp-content/uploads/2016/01/park-marii-luizy-sewilla-andaluzja-hiszpania.jpg';
            document.getElementById('display2').src='https://f4fcdn.eu/wp-content/uploads/2018/09/Sewilla2000ST.jpg';
            document.getElementById('display3').src='https://lubiehiszpanie.pl/wp-content/uploads/2018/07/Sewilla-Hiszpania.jpg';
        }
        if(city == "Rzym")
        {
            document.getElementById("text").innerText = "Rzym – stolica i największe miasto Włoch, położone w środkowej części kraju nad rzeką Tyber i Morzem Śródziemnym. ... Rzym jest również stolicą regionu administracyjno-historycznego Lacjum (Lazio).";
            document.getElementById('display1').src='https://dzienniknaukowy.pl/assets/media/colloseumwp.jpg';
            document.getElementById('display2').src='https://www.kierunekwlochy.pl/wp-content/uploads/2017/10/piazza-navona-rzym.jpg';
            document.getElementById('display3').src='https://lazurowyprzewodnik.pl/wp-content/uploads/2019/10/Rzym1.jpg';
        }
        if(city == "Wenecja")
        {
            document.getElementById("text").innerText = "Wenecja. Wenecja to miasto na wodzie i 100 wyspach, które każdego roku rozpala zmysły milionów turystów. Kojarzy się z romantyzmem i karnawałową zabawą, a jej symbolem są sunące kanałami gondole, mosty, Plac św. Marka z Bazyliką i Pałacem Dożów.";
            document.getElementById('display1').src='https://www.forum-ekonomiczne.pl/wp-content/uploads/2019/06/Wenecja.jpg';
            document.getElementById('display2').src='https://www.radiozet.pl/var/radiozet/storage/images/podroze/wlochy.-zaskakujacy-efekt-kwarantanny.-wyjatkowo-przejrzyste-kanaly-w-wenecji/9569140-9-pol-PL/Wlochy-przejmuje-natura.-Zaskakujacy-efekt-kwarantanny-we-Wloszech_article_horizontal_ld_json.jpg';
            document.getElementById('display3').src='https://ocdn.eu/pulscms-transforms/1/7eQk9kqTURBXy9iOTRkZDM2NDkzZGMxNDc1Mzk5MGU4ZWQ4ZjdlMzYyMS5qcGVnk5UDAHbNDtjNCFmTBc0DFM0BvJMJpmJkZTcyZAaBoTAB/wenecja.jpg';
        }
        if(city == "Mediolan")
        {
            document.getElementById("text").innerText = "Mediolan – miasto i gmina w północnych Włoszech, stolica prowincji Mediolan i regionu Lombardia. Położone na północno-zachodnim skraju Niziny Padańskiej pomiędzy rzekami Ticino, Adda, Pad i Alpami.";
            document.getElementById('display1').src='https://ocdn.eu/pulscms-transforms/1/rE4k9kqTURBXy84Y2I0YmIzZWNlZTY2ZGM1MzhlM2M4ZDRlMTViNTc5Ni5qcGVnkpUCzQPAAMLDlQIAzQPAwsOBoTAF';
            document.getElementById('display2').src='https://podroze.smcloud.net/t/photos/t/143681/katedra-w-mediolanie_1123839.jpg';
            document.getElementById('display3').src='https://zamieszkali.pl/wp-content/uploads/2019/08/milan-705880_1280.jpg';
        }
        if(city == "Florencja")
        {
            document.getElementById("text").innerText = "Florencja jest stolicą regionu Toskania i prowincji Florencja. Otoczona wzgórzami, leży nad rzeką Arno, która przepływa przez miasto, historyczne centrum jest na prawym brzegu. Florencja była ważnym miejscem w historii regionu, Włoch, a również i świata.";
            document.getElementById('display1').src='https://podroze.smcloud.net/t/photos/t/139285/florencja-widok-na-katedre-santa-maria-del-fiore_1021758.jpg';
            document.getElementById('display2').src='https://i.wpimg.pl/O/644x429/d.wpimg.pl/1954392146-553915913/florencja.jpeg';
            document.getElementById('display3').src='https://www.kierunekwlochy.pl/wp-content/uploads/2017/12/florencja-55.jpg';
        }
        if(city == "Stambuł")
        {
            document.getElementById("text").innerText = "Stambuł to jedno z dwóch miast położonych na styku dwóch kontynentów (drugim jest rosyjski Magnitogorsk). Miasto znajduje się po obu stronach cieśniny Bosfor, pomiędzy Morzem Marmara, a Morzem Czarnym. ... Dzięki bogatej historii miasto zachwyca cudownymi zabytkami oraz pięknie zdobionymi meczetami.";
            document.getElementById('display1').src='https://f4fcdn.eu/wp-content/uploads/2020/04/shutterstock_589266878.jpg';
            document.getElementById('display2').src='https://mlecznepodroze.pl/wp-content/uploads/2019/05/stambul-meczet-mewy-ladne-Depositphotos_167240380_xl-2015-1500x1007px.jpg';
            document.getElementById('display3').src='https://ocdn.eu/images/pulscms/ZGE7MDA_/b17c6c6f9b237a769bb22ca37ef8bb17.jpeg';
        }
        if(city == "Kapadocja")
        {
            document.getElementById("text").innerText = "Kapadocja to dzieło wciąż nieskończone - wiatr i deszcze nieustannie zmieniają kształt wulkanicznych skał. Najbardziej urozmaicone krajobrazy z fantastycznymi formami skalnymi znajdziemy w trójkącie wyznaczonym przez miasta Avanos, Ürgüp i Nevsehir. Turcja Kapadocja. Kapadocja to także kraina balonów.";
            document.getElementById('display1').src='https://fly.pl/cdn/photo/582/343/169524/sypr/fascynujca-kapadocja-turcja-wyc-objazdowe-0.jpg';
            document.getElementById('display2').src='https://metintour.pl/images/atrakcja/2/1488764484_b28fdd996881439c79254de897b2be23.jpg';
            document.getElementById('display3').src='https://gfx.radiozet.pl/var/radiozet/storage/images/podroze-radia-zet/kapadocja-w-krainie-basniowych-krajobrazow-turcji/432507-4-pol-PL/Kapadocja-w-krainie-basniowych-krajobrazow_article.jpg';
        }
        if(city == "Pamukkale")
        {
            document.getElementById("text").innerText = "Pamukkale (tur. Bawełniany zamek lub Bawełniana twierdza) – turecka miejscowość położona w dolinie Cürüksu (w starożytności zwanej Doliną Lycos), około 18 km od Denizli. Słynie z wapiennych osadów powstałych na zboczu góry Cökelez. ... W związku z tym władze tureckie nakazały zamknięcie hoteli, a następnie ich rozebranie.";
            document.getElementById('display1').src='https://www.arcymistrz.pl/wp-content/uploads/2019/09/Pamukkale.jpg';
            document.getElementById('display2').src='https://gfx.chillizet.pl/var/chillizet/storage/images/styl-zycia/podroze/pamukkale-bawelniany-zamek-w-turcji-niezwykla-atrakcja-turystyczna-21982/2386717-1-pol-PL/To-miejsce-wyglada-jak-stworzone-przez-grafikow-a-istnieje-naprawde!-Gdzie-sie-znajduje_article.jpg';
            document.getElementById('display3').src='https://www.osmol.pl/wp-content/uploads/2013/02/Pamukkale-Turcja-1500x800.jpg';
        }
        if(city == "Antalya")
        {
            document.getElementById("text").innerText = "Antalya to miasto, którego trudno nie polubić. Zachwycali się nim autorzy antyczni, nowożytni podróżnicy zwiedzający Imperium Osmańskie, w superlatywach wyrażał się o nim także sam Ojciec Turków czyli pierwszy prezydent Republiki Tureckiej, Mustafa Kemal Atatürk. Z jednej strony jest to obecnie licząca sobie przeszło milion mieszkańców metropolia, a z drugiej - coraz popularniejszy kurort turystyczny, z pięknymi plażami i luksusowymi hotelami.";
            document.getElementById('display1').src='https://q-cf.bstatic.com/images/hotel/max1024x768/231/231324425.jpg';
            document.getElementById('display2').src='https://i.content4travel.com/cms/img/u/kraj/1/antalya_0.jpg?version=191214-08';
            document.getElementById('display3').src='https://jawagabunda.pl/wp-content/uploads/2017/10/turcja16-min-696x461.jpg';
        }
        if(city == "Lizbona")
        {
            document.getElementById("text").innerText = "Lizbona jest stolicą Portugalii i największym miastem kraju. W jej granicach administracyjnych mieszka ok. 565 tys. ... Z lewym brzegiem rzeki łączą miasto dwa mosty – 25 Kwietnia oraz Vasco da Gama, oba to wspaniałe przykłady sztuki inżynierskiej, ale także po prostu ładne obiekty.";
            document.getElementById('display1').src='https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Lisbon_%2837019885565%29.jpg/1200px-Lisbon_%2837019885565%29.jpg';
            document.getElementById('display2').src='https://duze-podroze.pl/wp-content/uploads/2018/03/lizbona-blog.jpg';
            document.getElementById('display3').src='https://i.wpimg.pl/O/644x430/d.wpimg.pl/1083424592-763335619/01_lizbona_portugalia_sean_pavone_shutterstock2.jpg';
        }
        if(city == "Porto")
        {
            document.getElementById("text").innerText = "Porto to miasto, które posiada wyjątkową atmosferę i które można odkrywać w nieskończoność. ... Porto (znane także jako Oporto) leży u ujścia rzeki Douro (hisz. Duero), nad Oceanem Atlantyckim. Za czasów Wizygotów miasto było siedzibą biskupów.";
            document.getElementById('display1').src='https://upload.wikimedia.org/wikipedia/commons/5/55/O_Porto_%28visto_da_Ponte_Dom_Luis_I%29.jpg';
            document.getElementById('display2').src='https://duze-podroze.pl/wp-content/uploads/2014/01/IMGP8642.jpg';
            document.getElementById('display3').src='https://duze-podroze.pl/wp-content/uploads/2015/08/porto-widok.jpg';
        }
        if(city == "Madera")
        {
            document.getElementById("text").innerText = "Madera jest jedną z wysp archipelagu na Oceanie Atlantyckim, terytorialnie należącą do Portugalii. Nazywana jest „Perłą Atlantyku” i wyspą wiecznej wiosny ze względu na panujący na niej łagodny klimat typu śródziemnomorskiego, ze średnią roczną temperaturą 22 stopni w ciągu dnia.";
            document.getElementById('display1').src='https://f4fcdn.eu/wp-content/uploads/2020/03/shutterstock_1068574526-2.jpg';
            document.getElementById('display2').src='https://travelover.pl/wp-content/uploads/2018/07/IMG_2525-e1531673048780-1080x732.jpg';
            document.getElementById('display3').src='https://podroze.smcloud.net/t/image/t/134386/madera_335093.jpg';
        }
        if(city == "Sintra")
        {
            document.getElementById("text").innerText = "Sintra to wspaniałe portugalskie miasteczko, położone wśród wzgórz Serra de Sintra. Rozrzucone między tymi wyściełanymi sosnowymi lasami pagórkami, kryją się ekstrawaganckie pałace, wystawne rezydencje i ruiny starożytnego zamku.";
            document.getElementById('display1').src='https://www.evitravel.pl/wp-content/uploads/2018/11/Lizbona_Sintra_0065a-750x410.jpg';
            document.getElementById('display2').src='https://duze-podroze.pl/wp-content/uploads/2015/07/sintra-pena-palac-1360x816.jpg';
            document.getElementById('display3').src='https://www.goforworld.com/wp-content/uploads/2017/09/studnia.jpg';
        }
    }

    function finishOrder() {
        $.ajax({
            url: "Menu",
            type: 'POST',
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json"
            },
            data: JSON.stringify(tours),
        }).done(function (result) {
        });
    }

</script>
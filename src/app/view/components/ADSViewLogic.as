package app.view.components {
    import com.vk.MainVKBanner;
    import com.vk.MainVKBannerEvent;
    import com.vk.vo.BannersPanelVO;

    import core.view.components.ViewLogic;

    import flash.events.Event;

    public class ADSViewLogic extends ViewLogic {

        public function init(flashVars:Object):void {

            var ad_unit_id:String = "65049"; // укажите тут свой id
            var block:MainVKBanner = new MainVKBanner(ad_unit_id); // создание баннера и присвоение ему id
            block.x = 0;
            block.y = 450;
            content.addChild(block); // добавление баннера на сцену

            var params:BannersPanelVO = new BannersPanelVO(); // создание класса параметров баннера
            // изменение стандартных параметров:
            params.demo = '0'; // 1 - показывает тестовые баннеры

            // вертикальный (AD_TYPE_VERTICAL) или горизонтальный (AD_TYPE_HORIZONTAL) блок баннеров
            params.ad_type = BannersPanelVO.AD_TYPE_HORIZONTAL;
            // Вертикальный (AD_UNIT_TYPE_VERTICAL) или горизонтальный (AD_UNIT_TYPE_HORIZONTAL) баннер внутри блока баннеров
            params.ad_unit_type = BannersPanelVO.AD_UNIT_TYPE_HORIZONTAL;
            params.title_color = '#FFFFFF'; // цвет заголовка
            params.desc_color = '#FFFFFF'; // цвет описания
            params.domain_color = '#FFFFFF'; // цвет ссылки
            params.bg_color = '#000000'; // цвет фона
            params.bg_alpha = 1; // прозрачность фона (0 - прозрачно, 1 - непрозрачно)

            // размер шрифта. FONT_SMALL, FONT_MEDIUM или FONT_BIG
            params.font_size = BannersPanelVO.FONT_MEDIUM;
            params.lines_color = '#FFFFFF'; // цвет разделителей
            params.link_color = '#FFFFFF'; // цвет надписи "Реклама ВКонтакте"
            params.ads_count = 4; // количество выдаваемых баннеров
            params.ad_width = 600; // максимальная ширина блока
            params.ad_height = 130; // максимальная ширина блока
            block.initBanner(flashVars, params); // инициализация баннера

            block.addEventListener(MainVKBannerEvent.LOAD_COMPLETE, this.banner_onLoad);
            block.addEventListener(MainVKBannerEvent.LOAD_IS_EMPTY, this.banner_onAdsEmpty);
            block.addEventListener(MainVKBannerEvent.LOAD_ERROR, this.banner_onError);
        }

        private function banner_onLoad(e:Event):void {

            // прячете альтернативную рекламу, в случае, если она показана
            trace('Main.banner_onLoad :');
        }

        private function banner_onAdsEmpty(e:Event):void {

            // показываете альтернативную рекламу
            trace('Main.banner_onAdsEmpty :');
        }

        private function banner_onError(e:Event):void {

            var event:MainVKBannerEvent = e as MainVKBannerEvent;
            trace('Main.banner_onError :', event.errorMessage, event.errorCode);
        }
    }
}

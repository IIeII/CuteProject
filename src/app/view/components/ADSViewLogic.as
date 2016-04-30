package app.view.components {
    import com.vk.MainVKBanner;
    import com.vk.MainVKBannerEvent;
    import com.vk.vo.BannersPanelVO;

    import core.view.components.ViewLogic;

    import flash.events.Event;

    public class ADSViewLogic extends ViewLogic {

        public function init(flashVars:Object):void {

            var ad_unit_id:String = "65049"; // ������� ��� ���� id
            var block:MainVKBanner = new MainVKBanner(ad_unit_id); // �������� ������� � ���������� ��� id
            block.x = 0;
            block.y = 450;
            content.addChild(block); // ���������� ������� �� �����

            var params:BannersPanelVO = new BannersPanelVO(); // �������� ������ ���������� �������
            // ��������� ����������� ����������:
            params.demo = '0'; // 1 - ���������� �������� �������

            // ������������ (AD_TYPE_VERTICAL) ��� �������������� (AD_TYPE_HORIZONTAL) ���� ��������
            params.ad_type = BannersPanelVO.AD_TYPE_HORIZONTAL;
            // ������������ (AD_UNIT_TYPE_VERTICAL) ��� �������������� (AD_UNIT_TYPE_HORIZONTAL) ������ ������ ����� ��������
            params.ad_unit_type = BannersPanelVO.AD_UNIT_TYPE_HORIZONTAL;
            params.title_color = '#FFFFFF'; // ���� ���������
            params.desc_color = '#FFFFFF'; // ���� ��������
            params.domain_color = '#FFFFFF'; // ���� ������
            params.bg_color = '#000000'; // ���� ����
            params.bg_alpha = 1; // ������������ ���� (0 - ���������, 1 - �����������)

            // ������ ������. FONT_SMALL, FONT_MEDIUM ��� FONT_BIG
            params.font_size = BannersPanelVO.FONT_MEDIUM;
            params.lines_color = '#FFFFFF'; // ���� ������������
            params.link_color = '#FFFFFF'; // ���� ������� "������� ���������"
            params.ads_count = 4; // ���������� ���������� ��������
            params.ad_width = 600; // ������������ ������ �����
            params.ad_height = 130; // ������������ ������ �����
            block.initBanner(flashVars, params); // ������������� �������

            block.addEventListener(MainVKBannerEvent.LOAD_COMPLETE, this.banner_onLoad);
            block.addEventListener(MainVKBannerEvent.LOAD_IS_EMPTY, this.banner_onAdsEmpty);
            block.addEventListener(MainVKBannerEvent.LOAD_ERROR, this.banner_onError);
        }

        private function banner_onLoad(e:Event):void {

            // ������� �������������� �������, � ������, ���� ��� ��������
            trace('Main.banner_onLoad :');
        }

        private function banner_onAdsEmpty(e:Event):void {

            // ����������� �������������� �������
            trace('Main.banner_onAdsEmpty :');
        }

        private function banner_onError(e:Event):void {

            var event:MainVKBannerEvent = e as MainVKBannerEvent;
            trace('Main.banner_onError :', event.errorMessage, event.errorCode);
        }
    }
}

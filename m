Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A052AA372
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgKGIOv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:51 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKGIOv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736890; x=1636272890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ah0+1mEnJdX05Q2mVPorPQhcLW5wBEGXXNi04bnk03g=;
  b=erbEhKUZuhNnxcALIHqNYaH8/th/3eoH8yHrE04w8VTjO0lvhyqrQ+ZZ
   XJToDacwc4NumFUN/8D2I10CcfvwFowjPnPOphDns3X1M55b4k53YxsYN
   8diPsts/3W9Vlrtfq8AcdaKqXN9f6v/f+0NaSqjMja4RyGF35MOK4C+Kz
   wu+MU3229MaU8QNYSP1/gC3lfw0V+8T75LfOXbAXQQeNwVkr316RtcyJw
   5oVrKkIWJovZ51zccZoeK7ltKxhQs30PyJnNHhSW/1R4C+ei129VoThpb
   gGvCsRgyp2T5idpc5Tx5s1d3Ou8RXOBrU0a4dUmU1a5PnAGs6m3cXtIiH
   A==;
IronPort-SDR: IFysDHtVX2jf16l8p13e+9+dIPAk+iItYcov09T6w4lLZ6Ju50Ewez81sOHIQPN1sNwaSYcgrK
 pyRkyntS/4c+7Nmtqwjvr8sI5uEkvGznAWI02NK10BOKAkS/5XutwOTFRmEzQmzAXyn9W0cfBF
 QtaN+HOIOsSWNe6u3HXkA0InnnusrPQ5ODcTjwc9L+joR1+VsKRCNoqtz1n8gBmIDHI7+5jJKs
 Q+wm1WVKaylhMqUNwnwaN+vW3GzGs6upIlal16hwgmFKHMz9FE65UtHefaWx6g01x1a4rTXzSa
 pF0=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564377"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:50 +0800
IronPort-SDR: P/sH90I0KIO2A9hcbGtFc5JHamLFGVXmQipofegbBQbvTwXlu36pmbbq/ZHIYWVINlqU5Z7v2Q
 SAo0EL1tEIKuUmFuggLIEU7Bc3Wx7qQAlbCTJU4ykb7RAdPsboHJVOCDt+21D1UVArtRJsND7J
 i3M1pwf8exiLuhbxKMJdPNmVBsNBMMZVuQBDXZ/Qat/MPMAFmn5NLeNKQbLLaNoSwK4rmUWInc
 DPZ6uniB7IS8KQ0w3awAHu49kNkk3dVWD4xAi6sxDDypd0w1hy912oOlw5n8s79WNvIame98mW
 Mocm6oL9DmzmraYvFwK3DRDx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:41 -0800
IronPort-SDR: tCjB9lyCTe615202gVJFGQD2Y1XtiyOayZe8caLQvPWA5qCK2cJsOQjBAV+Wsi0GvUv4r7vhmG
 SPV1z3bYORy+DveiSCH9wrzxwQIBzgmN08HeP9OxANTgZQmwqqO53jsrT8+P+dYIvI+SfglE1/
 xD4scmp5HEwA98e3HKCYS5E9BjH3hLhT+KvW4IaAOFJ5ObdvKk1u5QHnov7/bjiKf80JCD+yrd
 ZEMVDU+97kwgqPUh5eDk9o54PFRbXzdnhR4cgHQ6qXMRqnQzIn6N4rxzBABsB3xqoTTDGUpLeM
 tOI=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:48 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 10/32] riscv: Fix sifive serial driver
Date:   Sat,  7 Nov 2020 17:13:58 +0900
Message-Id: <20201107081420.60325-11-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Setup the port uartclk in sifive_serial_probe() so that the base baud
rate is correctly printed during device probe instead of always showing
"0".  I.e. the probe message is changed from

38000000.serial: ttySIF0 at MMIO 0x38000000 (irq = 1,
base_baud = 0) is a SiFive UART v0

to the correct:

38000000.serial: ttySIF0 at MMIO 0x38000000 (irq = 1,
base_baud = 115200) is a SiFive UART v0

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/tty/serial/sifive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 13eadcb8aec4..214bf3086c68 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -999,6 +999,7 @@ static int sifive_serial_probe(struct platform_device *pdev)
 	/* Set up clock divider */
 	ssp->clkin_rate = clk_get_rate(ssp->clk);
 	ssp->baud_rate = SIFIVE_DEFAULT_BAUD_RATE;
+	ssp->port.uartclk = ssp->baud_rate * 16;
 	__ssp_update_div(ssp);
 
 	platform_set_drvdata(pdev, ssp);
-- 
2.28.0


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C40924DE70
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 19:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgHURad (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 13:30:33 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38792 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgHUQOL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Aug 2020 12:14:11 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200821161407euoutp022660269d2689a8caf8c5ae40b1380929~tVJZE_yMH0659906599euoutp02K
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200821161407euoutp022660269d2689a8caf8c5ae40b1380929~tVJZE_yMH0659906599euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598026447;
        bh=axDL6sluj5xlo96GTCxVwhlUTt8MkkA+5p9ugSmGU9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eseW2q+qu3KPVliloXQxVSu0+cdcikfPMSPh8dMH+W30dXcsqDVlZa1RTidaG07tB
         nkxFJvITH/gUJfvUemmaJmcwopxeyXIDrtjM9GsCb3xek8TstixrWgirGy6P4WcoGj
         FY4GefsgBw95JnkmKEAHXS6LXZGuRbDUB7lr/4Dk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200821161406eucas1p1b4e6d827233652edce283502ebebb13b~tVJYw8rW-0799907999eucas1p1e;
        Fri, 21 Aug 2020 16:14:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 55.D9.06456.EC2FF3F5; Fri, 21
        Aug 2020 17:14:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200821161406eucas1p2be3221183a855afd0213f8ce58bd8942~tVJYXQO7A1578115781eucas1p2k;
        Fri, 21 Aug 2020 16:14:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200821161406eusmtrp1362332e2149498732b1d6ae5059a9c1f~tVJYWjVmN1179011790eusmtrp15;
        Fri, 21 Aug 2020 16:14:06 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-d4-5f3ff2cef0c9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.A9.06017.EC2FF3F5; Fri, 21
        Aug 2020 17:14:06 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200821161406eusmtip26e6c03e133428d45de6e68d8da2bb565~tVJYJPEpw2051720517eusmtip2m;
        Fri, 21 Aug 2020 16:14:06 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 4/9] spi: spi-s3c64xx: Rename S3C64XX_SPI_SLAVE_* to
 S3C64XX_SPI_CS_*
Date:   Fri, 21 Aug 2020 18:13:56 +0200
Message-Id: <20200821161401.11307-5-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821161401.11307-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7rnPtnHG3w4Y2Cx+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV8bWp9vYCtaLVrxaeYylgfG5
        YBcjJ4eEgInE94332LoYuTiEBFYwSvw4NoMVwvnCKPF08XUWCOczo8SzRX+Zuxg5wFoeL+aB
        iC9nlJj74jRU+3NGif3nTrGAzGUTcJToX3oCbJSIwAQmiYfn3rCBJJgFSiV6dh4Cs4UFoiSa
        pl1nB7FZBFQl3j2YzwSygVfAWmLGK0+I++Ql2pdvByvnFLCROH6piRXE5hUQlDg58wnYLn4B
        LYk1TddZIMbLSzRvnc0MsldC4BK7xO39a9kgBrlIfOjdyQphC0u8Or6FHcKWkTg9uYcF4rN6
        icmTzCB6exglts35wQJRYy1x59wvNpAaZgFNifW79CHCjhInd++FBgqfxI23ghAn8ElM2jYd
        Kswr0dEmBFGtIrGufw/UQCmJ3lcrGCcwKs1C8swsJA/MQti1gJF5FaN4amlxbnpqsWFearle
        cWJucWleul5yfu4mRmA6Ov3v+KcdjF8vJR1iFOBgVOLh/XHIPl6INbGsuDL3EKMEB7OSCK/T
        2dNxQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTA6/lm+
        Nzm64D1PqI6guOBk/pMK04xWGgr9u9w0KX7ZodSPc6ev0bQOnuSyWCr30hVLBrEWZ2ulqqTt
        uskuBVWTth1hOLvk/OO9Bx0dAjrPLn6/gjttfdx21Ry5ad/7RQ0SC/8/e9zWuTbCYM4kJ/v2
        DZvOihW0sa92O3TCpJh18eEdJ002LXyrxFKckWioxVxUnAgAJ6Z1oEMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7rnPtnHGzzfK2ix+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsbWp9vYCtaLVrxaeYylgfG5YBcjB4eEgInE48U8XYxcHEIC
        Sxklpu7rZoWIS0msnJvexcgJZApL/LnWxQZR85RRou/qXhaQBJuAo0T/0hOsIAkRgRlMEk9u
        TGYFSTALlEtcmvWcHcQWFoiQaJw7H8xmEVCVePdgPhPIAl4Ba4kZrzwhFshLtC/fzgZicwrY
        SBy/1AQ2RgioZNviy2C7eAUEJU7OfMIC0sosoC6xfp4QSJhfQEtiTdN1Foit8hLNW2czT2AU
        moWkYxZCxywkVQsYmVcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExt62Yz+37GDsehd8iFGA
        g1GJh/fHIft4IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccXleakFh9iNAX6ciKzlGhy
        PjAt5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYEw6dmZHzKF1
        uYzfLuWkXrXgYro0TYfr1IOEHeev3jNx6Nm1s0x+wdTVLktaJvKb5CZ/WWFoZtmkcW4r10kX
        7RnaZp+8ldOVVSe47loTOO/VidCfBb0tM69E/hH4sSp6a3RH/zGTgwzP32xW9nEX8We5ubJk
        Zn/1xZmffvwU8dE4/bXAUNWm31aJpTgj0VCLuag4EQB/sswZ0wIAAA==
X-CMS-MailID: 20200821161406eucas1p2be3221183a855afd0213f8ce58bd8942
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200821161406eucas1p2be3221183a855afd0213f8ce58bd8942
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200821161406eucas1p2be3221183a855afd0213f8ce58bd8942
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <CGME20200821161406eucas1p2be3221183a855afd0213f8ce58bd8942@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Rename S3C64XX_SPI_SLAVE_* to S3C64XX_SPI_CS_* to match documentation.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 3364d362ed21..433b9d77b914 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -29,7 +29,7 @@
 #define S3C64XX_SPI_CH_CFG		0x00
 #define S3C64XX_SPI_CLK_CFG		0x04
 #define S3C64XX_SPI_MODE_CFG		0x08
-#define S3C64XX_SPI_SLAVE_SEL		0x0C
+#define S3C64XX_SPI_CS_REG		0x0C
 #define S3C64XX_SPI_INT_EN		0x10
 #define S3C64XX_SPI_STATUS		0x14
 #define S3C64XX_SPI_TX_DATA		0x18
@@ -64,9 +64,9 @@
 #define S3C64XX_SPI_MODE_TXDMA_ON		(1<<1)
 #define S3C64XX_SPI_MODE_4BURST			(1<<0)
 
-#define S3C64XX_SPI_SLAVE_AUTO			(1<<1)
-#define S3C64XX_SPI_SLAVE_SIG_INACT		(1<<0)
-#define S3C64XX_SPI_SLAVE_NSC_CNT_2		(2<<4)
+#define S3C64XX_SPI_CS_NSC_CNT_2		(2<<4)
+#define S3C64XX_SPI_CS_AUTO			(1<<1)
+#define S3C64XX_SPI_CS_SIG_INACT		(1<<0)
 
 #define S3C64XX_SPI_INT_TRAILING_EN		(1<<6)
 #define S3C64XX_SPI_INT_RX_OVERRUN_EN		(1<<5)
@@ -319,18 +319,18 @@ static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
 
 	if (enable) {
 		if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO)) {
-			writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+			writel(0, sdd->regs + S3C64XX_SPI_CS_REG);
 		} else {
-			u32 ssel = readl(sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+			u32 ssel = readl(sdd->regs + S3C64XX_SPI_CS_REG);
 
-			ssel |= (S3C64XX_SPI_SLAVE_AUTO |
-						S3C64XX_SPI_SLAVE_NSC_CNT_2);
-			writel(ssel, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+			ssel |= (S3C64XX_SPI_CS_AUTO |
+						S3C64XX_SPI_CS_NSC_CNT_2);
+			writel(ssel, sdd->regs + S3C64XX_SPI_CS_REG);
 		}
 	} else {
 		if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
-			writel(S3C64XX_SPI_SLAVE_SIG_INACT,
-			       sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+			writel(S3C64XX_SPI_CS_SIG_INACT,
+			       sdd->regs + S3C64XX_SPI_CS_REG);
 	}
 }
 
@@ -951,9 +951,9 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
 	sdd->cur_speed = 0;
 
 	if (sci->no_cs)
-		writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+		writel(0, sdd->regs + S3C64XX_SPI_CS_REG);
 	else if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
-		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+		writel(S3C64XX_SPI_CS_SIG_INACT, sdd->regs + S3C64XX_SPI_CS_REG);
 
 	/* Disable Interrupts - we use Polling if not DMA mode */
 	writel(0, regs + S3C64XX_SPI_INT_EN);
-- 
2.26.2


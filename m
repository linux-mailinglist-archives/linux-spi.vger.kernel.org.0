Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D938D55C40E
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 14:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiF0Gtp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 02:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiF0Gtm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 02:49:42 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7329DF61
        for <linux-spi@vger.kernel.org>; Sun, 26 Jun 2022 23:49:38 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220627064933epoutp04f6273d0b374165b862e26280bb9dfc8a~8Z4Kq88xl2051020510epoutp04N
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 06:49:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220627064933epoutp04f6273d0b374165b862e26280bb9dfc8a~8Z4Kq88xl2051020510epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656312573;
        bh=8zllR9hyJ8dKnQ6gq7P0sG117iOyo/OTY/EOHg1rNjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQE2AZtz8GZ2F9HFL9en4a1Re25RJM6/bKaOgyNIW8FW0iX6Hu7s9t1H/TmzOgDt1
         JLhZr8ct4vezYioMRyY5LITLRcV1MkU1Jnmunz89DQx5C2F1aSigBUJJm0NdhNUNRT
         yXwgANrREcrWPC5SZztAnm73HdZUfbus+V++T0oM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220627064932epcas2p4c2e3bdc39c17b362b5e8a11965b76391~8Z4Js1BvZ0616106161epcas2p41;
        Mon, 27 Jun 2022 06:49:32 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LWdcr368Sz4x9Pw; Mon, 27 Jun
        2022 06:49:32 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.FF.09650.CF259B26; Mon, 27 Jun 2022 15:49:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220627064931epcas2p19407c5c3da3319cfb55dcb2c6d517256~8Z4I1-5Yi1673416734epcas2p1X;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220627064931epsmtrp2c026b9dc08fe93b205048abcc9b81026~8Z4I1PsG82152221522epsmtrp2c;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-2f-62b952fceccc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.E5.08802.BF259B26; Mon, 27 Jun 2022 15:49:31 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220627064931epsmtip2affe897662142e83b378f306a93aa11e~8Z4Iphwwh3217532175epsmtip29;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
From:   Chanho Park <chanho61.park@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 5/5] spi: s3c64xx: add spi port configuration for Exynos
 Auto v9 SoC
Date:   Mon, 27 Jun 2022 15:47:07 +0900
Message-Id: <20220627064707.138883-6-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627064707.138883-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmqe6foJ1JBrMvC1s8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xvEP29gKVvNUXPvXxNLAOJWri5GTQ0LAROLQ
        hGusILaQwA5GiVftShD2J0aJGf/Uuxi5gOzPjBKNV/pYYRp2PZvHDJHYxSjx5OFcdgjnI6PE
        vz3L2EGq2AR0JbY8f8UIkhARuMkoMf1sHxOIwyxwg1Fi74z1jCBVwgJhEo1rnjKB2CwCqhLz
        D95jA7F5Bewl2ht3sEPsk5fYML+XGcTmFHCQWPT0ChNEjaDEyZlPWEBsZqCa5q2zwW6SEOjl
        kFhybypUs4vEj9cTmCFsYYlXx7dAxaUkPr/bywZhF0ssnfWJCaK5gVHi8rZfUAljiVnP2oEu
        5QDaoCmxfpc+iCkhoCxx5BbUXj6JjsN/2SHCvBIdbUIQjeoSB7ZPZ4GwZSW653yGBp2HxIGF
        7UyQ0JrMKNGyopttAqPCLCTvzELyziyExQsYmVcxiqUWFOempxYbFRjBozg5P3cTIzi5arnt
        YJzy9oPeIUYmDsZDjBIczEoivK+vb00S4k1JrKxKLcqPLyrNSS0+xGgKDOyJzFKiyfnA9J5X
        Em9oYmlgYmZmaG5kamCuJM7rlbIhUUggPbEkNTs1tSC1CKaPiYNTqoFp2xPV2ICAgANeWrLa
        efXPoro9U+8p/LV5kH5o2jVtmZiD5txCv2boJTgrTTAq8f27oopTfb1BUZbVwe5+0ZLmTLMa
        V/l/LrcnMrmpRYitcwlV8bCKXh6wNIVRtKTjxoKcFYK3p84p3HpV9FXc/EuM3h9iVO2+TzE9
        6iSuJWvU/1O2JU5sh4T0N+4nS6Z9OlzN7J1qEPUtP8b+0eX7py4e0H7quO+es/YMUaaES183
        n72y3kncOtOmzCdmEmv/9+v3EqtiWrTD+nz9r+94GL3ivmjRfKZdceIvdnzqlJCU9W7+ZGTv
        /ChIcd66H2YLzrbN/3asSsaumu11+Va/RQ/apl0VWrr2cm+N7r2PG5VYijMSDbWYi4oTAWYo
        81Y3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvO7voJ1JBlOXGFk8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj+IdtbAWreSqu/Wti
        aWCcytXFyMkhIWAisevZPOYuRi4OIYEdjBJnb95ngUjISjx7t4MdwhaWuN9yhBWi6D2jxMdp
        r5lBEmwCuhJbnr9iBEmICNxmlPjbuI0NxGEWuMMo8Wj5HiaQKmGBEIlHXdNZQWwWAVWJ+Qfv
        sYHYvAL2Eu2NMCvkJTbM7wWbyingILHo6RWgXg6gdfYSzw9UQpQLSpyc+QTsOmag8uats5kn
        MArMQpKahSS1gJFpFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcBxoae1g3LPqg94h
        RiYOxkOMEhzMSiK8r69vTRLiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampB
        ahFMlomDU6qBKTLKa73U21lnPP4I9+/bcvT3lxP5HBadZXx57rq8743LBeewBMR4fa5/dv6K
        FcuK6NtPmsNWxIpwxC8Xm3Hwc+kn7rP1BqcVFh5QfJ/G+SakknPJ59TdYVrCbk6TP4TVCpla
        OBZc137WNEXrprHD5TDHs96LP8/i9552lvF40X2mLSqrFrmqLzLVK969Knz6nPmCWY8TdVTl
        CmYdbogu9Y8U+VHL0jPtRGFS46HHDQ/u/dpncSPefc3O2tUW162Dqj28151dZHD16o+d7BsL
        7pxczPe+kPnzn0PNbMsbcvvXmeTyODjafHu3b9empFIXxej/q6vmHs+yiHjJk7nsnEv/RjuV
        wA1Jdb+6m++fVmIpzkg01GIuKk4EACdAOxnyAgAA
X-CMS-MailID: 20220627064931epcas2p19407c5c3da3319cfb55dcb2c6d517256
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627064931epcas2p19407c5c3da3319cfb55dcb2c6d517256
References: <20220627064707.138883-1-chanho61.park@samsung.com>
        <CGME20220627064931epcas2p19407c5c3da3319cfb55dcb2c6d517256@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add exynosautov9 spi port configuration. It supports up to 12 spis and
has DIV_4 as the default internal clock divider. The spi also has
an internal loopback mode to run a loopback test.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index dd5fc8570bce..67b1fecf6fc6 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1447,6 +1447,19 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
+static struct s3c64xx_spi_port_config exynosautov9_spi_port_config = {
+	.fifo_lvl_mask	= { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff, 0x7f,
+			    0x7f, 0x7f, 0x7f, 0x7f},
+	.rx_lvl_offset	= 15,
+	.tx_st_done	= 25,
+	.high_speed	= true,
+	.clk_from_cmu	= true,
+	.clk_ioclk	= true,
+	.clk_div	= 4,
+	.has_loopback	= true,
+	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
+};
+
 static struct s3c64xx_spi_port_config fsd_spi_port_config = {
 	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
 	.rx_lvl_offset	= 15,
@@ -1487,6 +1500,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "samsung,exynos5433-spi",
 			.data = (void *)&exynos5433_spi_port_config,
 	},
+	{ .compatible = "samsung,exynosautov9-spi",
+			.data = (void *)&exynosautov9_spi_port_config,
+	},
 	{ .compatible = "tesla,fsd-spi",
 			.data = (void *)&fsd_spi_port_config,
 	},
-- 
2.36.1


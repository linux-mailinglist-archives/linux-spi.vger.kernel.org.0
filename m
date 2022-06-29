Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEC055FD51
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 12:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiF2KZi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 06:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiF2KZg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 06:25:36 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185C532EDA
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 03:25:35 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220629102530epoutp04e915e63b7479618d4b16772b7b631371~9EHRpUko82853928539epoutp04c
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 10:25:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220629102530epoutp04e915e63b7479618d4b16772b7b631371~9EHRpUko82853928539epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656498330;
        bh=9p8V/gY+iug/K+J+Ot/jtAqyH7lehPxJWBa8D1Hwqes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+XUT4G55SDHUcErD9m6GLabegPDpIGzNbejU11Esx8BQoIEIc8bb1o7iAG50Ibml
         L12p7m3al0kWJeHz833j6CVs/o5YtEhH9jAD4BPK6J6wdWXdFQ0si2JWAXbRkGMFoR
         2HNSbewuc+7Tgumy/v2kVwBBOuAz7BDhpyJVw6Z8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220629102529epcas2p307fe118a6c9eae3a747c3a3f6e0670b3~9EHQwlIof2740927409epcas2p3L;
        Wed, 29 Jun 2022 10:25:29 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LXyK45rlNz4x9Pv; Wed, 29 Jun
        2022 10:25:28 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.5F.09666.8982CB26; Wed, 29 Jun 2022 19:25:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220629102527epcas2p42e99f44d529d215623bd0e12a082d1dd~9EHPez7tV0590505905epcas2p4x;
        Wed, 29 Jun 2022 10:25:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220629102527epsmtrp2fcd44219b50f2317ce71393bf023223b~9EHPd3j7E0374603746epsmtrp2k;
        Wed, 29 Jun 2022 10:25:27 +0000 (GMT)
X-AuditID: b6c32a45-45bff700000025c2-79-62bc2898bf0e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.D6.08905.7982CB26; Wed, 29 Jun 2022 19:25:27 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220629102527epsmtip1fff8c16f6a2b2db49c0b525a828e845f~9EHPON5Hb2596825968epsmtip1j;
        Wed, 29 Jun 2022 10:25:27 +0000 (GMT)
From:   Chanho Park <chanho61.park@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 2/4] spi: s3c64xx: support custom value of internal clock
 divider
Date:   Wed, 29 Jun 2022 19:23:02 +0900
Message-Id: <20220629102304.65712-3-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629102304.65712-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmue4MjT1JBg/WaVs8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2RuOnw6wFf7Qr1l3rZGxg7FfuYuTkkBAwkZi+
        /gpTFyMXh5DADkaJTT2vmCGcT4wS/bf/QGW+MUo8OX2SDabl15pFbBCJvYwSHY2rWUESQgIf
        gfo/aIPYbAK6Eluev2IEKRIRuMkoMf1sH9goZoEbjBJ7Z6xnBKkSFgiTePDyGpjNIqAqMf/d
        YvYuRg4OXgE7ibunIiG2yUtsmN/LDGJzCthLvL0CsYxXQFDi5MwnLCA2M1BN89bZYHdLCEzk
        kOicvJsFZI6EgIvE7u5MiDnCEq+Ob2GHsKUkPr/bC/VNscTSWZ+YIHobGCUub/sFlTCWmPWs
        nRFkDrOApsT6XfoQI5UljtyCWssn0XH4LztEmFeio00IolFd4sD26SwQtqxE95zPrBC2h8S8
        e7OhATqJUeLEuudsExgVZiH5ZhaSb2YhLF7AyLyKUSy1oDg3PbXYqMAQHsPJ+bmbGMGpVct1
        B+Pktx/0DjEycTAeYpTgYFYS4V14ZmeSEG9KYmVValF+fFFpTmrxIUZTYFBPZJYSTc4HJve8
        knhDE0sDEzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1M+U5nOFa2LrAJX1A5
        8XQue0Iah86UPc8Lv3qx7PXbeuZdb+2MHvF+0VfPPrt9dY7yrnNO5r8cNWH1970ORyubtT54
        3T1SWiiku+rnwjnqWRk/9tV09SXPuXhS81dZuLzX2yMPXipt+RzXaJhzMNNloX34j2Wits+N
        Cs0unXuSO+uFRNJZJ7F50oZLJ101OBXjmxp4oiHXTyF6k5b4nCrhqSFVSrU28jm/V4n8evVy
        9+czf7N2uEv1rA3e47ZTc+m+P5KxfEILD9zOURH8VTvX7fHsxhm1G2ccbFwwR+Ou7h7LglLb
        jgVXK5h261wMYJvzRJg/7Rivwyy25UYBNdo5qbskNrzf7vPMqFXC6FebEktxRqKhFnNRcSIA
        KdXyaDYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnO50jT1JBnd/qFo8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSuj8dNh1oI/2hXrrnUy
        NjD2K3cxcnJICJhI/FqziK2LkYtDSGA3o8TXt49ZIRKyEs/e7WCHsIUl7rccAYsLCbxnlOh6
        XA5iswnoSmx5/ooRpFlE4DajxN/GbWCTmAXuMEo8Wr6HCaRKWCBE4vG8FYwgNouAqsT8d4uB
        pnJw8ArYSdw9FQmxQF5iw/xeZhCbU8Be4u2V1VDL7CSWXN/JAmLzCghKnJz5BMxmBqpv3jqb
        eQKjwCwkqVlIUgsYmVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHgZbmDsbtqz7o
        HWJk4mA8xCjBwawkwrvwzM4kId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqem
        FqQWwWSZODilGpjOrJs7S7e7alafpIz3+a8d9TtMLm/c3pj8fG+JnlfT5DQnZsHJ9+z/cliq
        LUh4Uv56acmpBr3r9VOdjPNn3n7b3ba54tUf0W4ed0fz/esmf6jffIGLo0k2dbv7voMXbpZP
        y6473+s235DpaPWbGfXXpjWsuf/RPOdd0Aynkx7+DlLOO15Flv7Nnz1f0L5gzj0GzfV2OY9W
        tsdurNx5T9Ul0HNvjLhlsGe870WhsKmCHbyPjsvw8O6Ij2/52l7pFR7+bPav3X+rLpSItM9/
        rnNL7UYnv8Nqvagsj6ce37bdlQnZvUqIRbU6wSN35TyXyOZ17tu0T62Q+HLKYx/T3UCuddv+
        fNm8yGrqTn6xIxOVWIozEg21mIuKEwEc/WB78QIAAA==
X-CMS-MailID: 20220629102527epcas2p42e99f44d529d215623bd0e12a082d1dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220629102527epcas2p42e99f44d529d215623bd0e12a082d1dd
References: <20220629102304.65712-1-chanho61.park@samsung.com>
        <CGME20220629102527epcas2p42e99f44d529d215623bd0e12a082d1dd@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Modern exynos SoCs such as Exynos Auto v9 have different internal clock
divider, for example "4". To support this internal value, this adds
clk_div of the s3c64xx_spi_port_config and assign "2" as the default
value to existing s3c64xx_spi_port_config.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 0c917cf891ca..ff565e57736b 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -131,6 +131,7 @@ struct s3c64xx_spi_dma_data {
  * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
  * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
  * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
+ * @clk_div: Internal clock divider
  * @quirks: Bitmask of known quirks
  * @high_speed: True, if the controller supports HIGH_SPEED_EN bit.
  * @clk_from_cmu: True, if the controller does not include a clock mux and
@@ -148,6 +149,7 @@ struct s3c64xx_spi_port_config {
 	int	rx_lvl_offset;
 	int	tx_st_done;
 	int	quirks;
+	int	clk_div;
 	bool	high_speed;
 	bool	clk_from_cmu;
 	bool	clk_ioclk;
@@ -620,6 +622,7 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	void __iomem *regs = sdd->regs;
 	int ret;
 	u32 val;
+	int div = sdd->port_conf->clk_div;
 
 	/* Disable Clock */
 	if (!sdd->port_conf->clk_from_cmu) {
@@ -668,16 +671,15 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
 	if (sdd->port_conf->clk_from_cmu) {
-		/* The src_clk clock is divided internally by 2 */
-		ret = clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
+		ret = clk_set_rate(sdd->src_clk, sdd->cur_speed * div);
 		if (ret)
 			return ret;
-		sdd->cur_speed = clk_get_rate(sdd->src_clk) / 2;
+		sdd->cur_speed = clk_get_rate(sdd->src_clk) / div;
 	} else {
 		/* Configure Clock */
 		val = readl(regs + S3C64XX_SPI_CLK_CFG);
 		val &= ~S3C64XX_SPI_PSR_MASK;
-		val |= ((clk_get_rate(sdd->src_clk) / sdd->cur_speed / 2 - 1)
+		val |= ((clk_get_rate(sdd->src_clk) / sdd->cur_speed / div - 1)
 				& S3C64XX_SPI_PSR_MASK);
 		writel(val, regs + S3C64XX_SPI_CLK_CFG);
 
@@ -871,6 +873,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
 	struct s3c64xx_spi_driver_data *sdd;
 	int err;
+	int div;
 
 	sdd = spi_master_get_devdata(spi->master);
 	if (spi->dev.of_node) {
@@ -889,22 +892,24 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 
 	pm_runtime_get_sync(&sdd->pdev->dev);
 
+	div = sdd->port_conf->clk_div;
+
 	/* Check if we can provide the requested rate */
 	if (!sdd->port_conf->clk_from_cmu) {
 		u32 psr, speed;
 
 		/* Max possible */
-		speed = clk_get_rate(sdd->src_clk) / 2 / (0 + 1);
+		speed = clk_get_rate(sdd->src_clk) / div / (0 + 1);
 
 		if (spi->max_speed_hz > speed)
 			spi->max_speed_hz = speed;
 
-		psr = clk_get_rate(sdd->src_clk) / 2 / spi->max_speed_hz - 1;
+		psr = clk_get_rate(sdd->src_clk) / div / spi->max_speed_hz - 1;
 		psr &= S3C64XX_SPI_PSR_MASK;
 		if (psr == S3C64XX_SPI_PSR_MASK)
 			psr--;
 
-		speed = clk_get_rate(sdd->src_clk) / 2 / (psr + 1);
+		speed = clk_get_rate(sdd->src_clk) / div / (psr + 1);
 		if (spi->max_speed_hz < speed) {
 			if (psr+1 < S3C64XX_SPI_PSR_MASK) {
 				psr++;
@@ -914,7 +919,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 			}
 		}
 
-		speed = clk_get_rate(sdd->src_clk) / 2 / (psr + 1);
+		speed = clk_get_rate(sdd->src_clk) / div / (psr + 1);
 		if (spi->max_speed_hz >= speed) {
 			spi->max_speed_hz = speed;
 		} else {
@@ -1396,6 +1401,7 @@ static const struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
 	.fifo_lvl_mask	= { 0x7f },
 	.rx_lvl_offset	= 13,
 	.tx_st_done	= 21,
+	.clk_div	= 2,
 	.high_speed	= true,
 };
 
@@ -1403,12 +1409,14 @@ static const struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
 	.fifo_lvl_mask	= { 0x7f, 0x7F },
 	.rx_lvl_offset	= 13,
 	.tx_st_done	= 21,
+	.clk_div	= 2,
 };
 
 static const struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7F },
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
+	.clk_div	= 2,
 	.high_speed	= true,
 };
 
@@ -1416,6 +1424,7 @@ static const struct s3c64xx_spi_port_config exynos4_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F },
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
+	.clk_div	= 2,
 	.high_speed	= true,
 	.clk_from_cmu	= true,
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
@@ -1425,6 +1434,7 @@ static const struct s3c64xx_spi_port_config exynos7_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F, 0x7F, 0x7F, 0x1ff},
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
+	.clk_div	= 2,
 	.high_speed	= true,
 	.clk_from_cmu	= true,
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
@@ -1434,6 +1444,7 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff},
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
+	.clk_div	= 2,
 	.high_speed	= true,
 	.clk_from_cmu	= true,
 	.clk_ioclk	= true,
@@ -1444,6 +1455,7 @@ static const struct s3c64xx_spi_port_config fsd_spi_port_config = {
 	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
+	.clk_div	= 2,
 	.high_speed	= true,
 	.clk_from_cmu	= true,
 	.clk_ioclk	= false,
-- 
2.36.1


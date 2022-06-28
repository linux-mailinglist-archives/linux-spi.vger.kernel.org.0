Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F7455C56D
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 14:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbiF1Eor (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jun 2022 00:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244291AbiF1Eop (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jun 2022 00:44:45 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1637E65EF
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 21:44:44 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220628044434epoutp03d7bf0a808b609c14eb7e4513d588fd8a~8r0UfRmg81281812818epoutp033
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 04:44:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220628044434epoutp03d7bf0a808b609c14eb7e4513d588fd8a~8r0UfRmg81281812818epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656391474;
        bh=J5mUbOnlge67Kp3ch61lExaYuS3HiESE8Qq3FyYrjjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJzvd26VB8cwAfM/1aLPuVO2I2vLlqRcLDW+ybp3GpZC5T6DIKVRalScWP+WEGGVX
         tFkp/Xz1LVycWUBW9qTxLxQwOcV+c/O7AmS8NaApxwQl/yhfMTrR5f7ddT730XEnQ0
         GCGW/5KjLetj0xiQ4SbFvUx70qH6cGysr7yF6fiY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220628044433epcas2p30ccf54c11ea8cd1ea6085f1d9c5b0a6a~8r0TzojP71830818308epcas2p39;
        Tue, 28 Jun 2022 04:44:33 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LXBp91p9fz4x9Pw; Tue, 28 Jun
        2022 04:44:33 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.D6.09666.1378AB26; Tue, 28 Jun 2022 13:44:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220628044432epcas2p11e6f927321c30cf5557dbd41d749ef28~8r0TANA1p1424614246epcas2p1l;
        Tue, 28 Jun 2022 04:44:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220628044432epsmtrp2e1a72a51fe0de0497151a6a437be01e5~8r0S_iJrx2084220842epsmtrp23;
        Tue, 28 Jun 2022 04:44:32 +0000 (GMT)
X-AuditID: b6c32a45-471ff700000025c2-89-62ba87319e7d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.70.08905.0378AB26; Tue, 28 Jun 2022 13:44:32 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220628044432epsmtip1f70fcd8482e010ed119cdb03a9eef5af~8r0SvnclO2875028750epsmtip1d;
        Tue, 28 Jun 2022 04:44:32 +0000 (GMT)
From:   Chanho Park <chanho61.park@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 2/4] spi: s3c64xx: support custom value of internal clock
 divider
Date:   Tue, 28 Jun 2022 13:42:20 +0900
Message-Id: <20220628044222.152794-3-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628044222.152794-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmha5h+64kgw1zeSwezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWi74XD5kt9r7eym6x6fE1VosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
        YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
        JafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y8mzDpaCRToVj551szYwrlHuYuTkkBAwkWjY
        uouxi5GLQ0hgB6PE1ds7mSCcT4wSt06sYYNwvjFKXLuxiRmm5cL5p8wQib2MEu++LYZq+cgo
        Mf9eIyNIFZuArsSW56/ABosI3GSUmH62D6yKWeAGo8TeGeuBMhwcwgJhEpNfuII0sAioSqzo
        +skOYvMK2EscutIKtU5eYsP8XjCbU8BBYsHt7YwQNYISJ2c+YQGxmYFqmrfOBjtJQqCXQ2LO
        +f1QzS4Sffd6WCFsYYlXx7ewQ9hSEp/f7WWDsIslls76xATR3MAocXnbL6iEscSsZ+1ghzIL
        aEqs36UPYkoIKEscuQW1l0+i4/Bfdogwr0RHmxBEo7rEge3TWSBsWYnuOZ+hLvCQmHJ8Bwsk
        sCYzSvSvm8k8gVFhFpJ3ZiF5ZxbC4gWMzKsYxVILinPTU4uNCgzhcZycn7uJEZxetVx3ME5+
        +0HvECMTB+MhRgkOZiUR3oVndiYJ8aYkVlalFuXHF5XmpBYfYjQFBvZEZinR5Hxggs8riTc0
        sTQwMTMzNDcyNTBXEuf1StmQKCSQnliSmp2aWpBaBNPHxMEp1cBkyiZ83e/wNMVVE5x8zvVW
        m34y6FVVXnmy9a1bYYpya6v2/RnB4lPL5pXsqLb60b7xQbvYvalTTx+dG+b2cPJZt1udx9tX
        qfEX8e+puPvJ3md+6NTrSn7Zc501Tk3pNNW8sse799JJfsd/z7WmtC+yFPGQkY6/n+Czoc1o
        VemTh3VrLsz8Mj9vkWT0o1cyxq/cUwt3fl0b5Z68u3jLug7OBRf5GVkeccnInri3fIfGlp0s
        F+ep1h/xrrvzqWC3WJKjhI5Jqvk8WwsR33865UXrTgeY3y1m9/vBI5Y664q3mCDb94d+YkJe
        Jc7bGV70fGgumf/bf/2WBJfv2V+XLn00szk9PfXP+xcHHDcqzDqvxFKckWioxVxUnAgALoR2
        7jgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnK5B+64kgyvf1CwezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWi74XD5kt9r7eym6x6fE1VosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJWx5FkHS8EinYpHz7pZ
        GxjXKHcxcnJICJhIXDj/lLmLkYtDSGA3o8S671NZIRKyEs/e7WCHsIUl7rccYYUoes8osWvF
        C7AEm4CuxJbnrxhBEiICtxkl/jZuYwNxmAXuMEo8Wr6HCaRKWCBEYvXsCSwgNouAqsSKrp9g
        3bwC9hKHrrQyQ6yQl9gwvxfM5hRwkFhwezsjiC0EVLN+51pWiHpBiZMzn4DNYQaqb946m3kC
        o8AsJKlZSFILGJlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER4KW5g7G7as+6B1i
        ZOJgPMQowcGsJMK78MzOJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphak
        FsFkmTg4pRqYzneU+2evntRgX+N87Cxn1oJIvb2JewXf/Pra7jJV7sI/C+3VAb558rFHDdyW
        7nwmEuYvYdK/gFdzunRcROcpC5fJwa9WL1DblTed8TJ70CKWY+79JQLrjP9++HguVHanrvaS
        1SrrlE/6avnx+U5n9c/2eeKT8S/h8MzT4nOfbZoe4GE1z2tnoYjS8f9P+HM9XOvOvPvlEx5f
        uF01VUl5xm4xG5P3O/evnJjwkv170uJT7+8kRoWdbb0wfdqklIQz2227PlWdbS0vDn4dtmib
        kWFIr0Tt97M71tiq+23fs2dR6H5Hrzelj77tlnPjlHM54PmHW27ys4P3Z2YarNo0keet1zL+
        a5unCpq6q1xYrMRSnJFoqMVcVJwIAHbzTMzzAgAA
X-CMS-MailID: 20220628044432epcas2p11e6f927321c30cf5557dbd41d749ef28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220628044432epcas2p11e6f927321c30cf5557dbd41d749ef28
References: <20220628044222.152794-1-chanho61.park@samsung.com>
        <CGME20220628044432epcas2p11e6f927321c30cf5557dbd41d749ef28@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Modern exynos SoCs such as Exynos Auto v9 has different internal clock
divider, for example "4". To support this internal value, this adds
clk_div of the s3c64xx_spi_port_config and assign "2" as the default
value to existing s3c64xx_spi_port_config.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b3c50c7665fc..51a0e830441b 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -131,6 +131,7 @@ struct s3c64xx_spi_dma_data {
  * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
  * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
  * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
+ * @clk_div: Internal clock divider, if not specified, use 2 as the default.
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
+	u32 div = sdd->port_conf->clk_div;
 
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
+	u32 div = 2;
 
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
@@ -1444,6 +1455,7 @@ static struct s3c64xx_spi_port_config fsd_spi_port_config = {
 	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
+	.clk_div	= 2,
 	.high_speed	= true,
 	.clk_from_cmu	= true,
 	.clk_ioclk	= false,
-- 
2.36.1


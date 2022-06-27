Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D57E55D324
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiF0Gts (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 02:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiF0Gtq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 02:49:46 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3AA10AD
        for <linux-spi@vger.kernel.org>; Sun, 26 Jun 2022 23:49:45 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220627064933epoutp022a016388226657e7466f55dfc841cc86~8Z4J6yegn1610116101epoutp02f
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 06:49:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220627064933epoutp022a016388226657e7466f55dfc841cc86~8Z4J6yegn1610116101epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656312573;
        bh=5z+x19IHjXLCqg8eCmD1MyhqL/USWu8oisWwN3c0QFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSoed4f22FjsqZRRb4U8uboNsJf+lBXd7+tFG47/Z5JsDb9HWwEWCExiskTlAjTco
         uIyu0g7xclQAc2V6vKtfk4vldlxD75gxcTwLpd5HMPBHOnwiwmNBJAO2A52YN24xk+
         n7ZuIY8p5ZbdlHdI4bI6WnKg8UUsoyP0uayvPs4o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220627064932epcas2p3dfef94079bcfe8f811f1d59bbb31397b~8Z4JcLJCS2915129151epcas2p34;
        Mon, 27 Jun 2022 06:49:32 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LWdcr1LRYz4x9Q7; Mon, 27 Jun
        2022 06:49:32 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.EC.09662.CF259B26; Mon, 27 Jun 2022 15:49:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220627064931epcas2p2e1dc352f41895b294d7945c2239de362~8Z4IsbvYj2456724567epcas2p2Q;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220627064931epsmtrp210b758ea1309d2dbf70f564305f8f3e8~8Z4IrhnDS2166021660epsmtrp2B;
        Mon, 27 Jun 2022 06:49:31 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-99-62b952fce882
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.89.08905.BF259B26; Mon, 27 Jun 2022 15:49:31 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220627064931epsmtip25afe0f913e703d45bb6699095eceaf3c~8Z4Ie5LNL3090630906epsmtip2g;
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
Subject: [PATCH 3/5] spi: s3c64xx: support custom value of internal clock
 divider
Date:   Mon, 27 Jun 2022 15:47:05 +0900
Message-Id: <20220627064707.138883-4-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627064707.138883-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmme6foJ1JBp9XsVk8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xtPX4QV75Su2TJjI2MA4T7KLkYNDQsBEYtW6
        qC5GLg4hgR2MEg9bXjBBOJ+AnLtzmSGcb4wSd1+tY+xi5ATr2L3oHCtEYi+jRN/Di1AtHxkl
        Nv/uZQKpYhPQldjy/BUjSEJE4CajxPSzfWBVzAI3GCX2zlgPNktYIFhi14OZ7CA2i4CqxPWJ
        G8G6eQXsJfZvecgMsU9eYsP8XjCbU8BBYtHTK1A1ghInZz5hAbGZgWqat84GO1ZCoJdDYsdX
        mGYXiZ+nXkLZwhKvjm9hh7ClJD6/28sGYRdLLJ31iQmiuYFR4vK2X1AJY4lZz9oZQeHELKAp
        sX6XPiTIlCWO3ILayyfRcfgvO0SYV6KjTQiiUV3iwPbpLBC2rET3nM+sELaHxJb1r6FhOplR
        YtfFnewTGBVmIXlnFpJ3ZiEsXsDIvIpRLLWgODc9tdiowAQexcn5uZsYwclVy2MH4+y3H/QO
        MTJxMB5ilOBgVhLhfX19a5IQb0piZVVqUX58UWlOavEhRlNgYE9klhJNzgem97ySeEMTSwMT
        MzNDcyNTA3MlcV6vlA2JQgLpiSWp2ampBalFMH1MHJxSDUzacZemOLmyPivaGsUbE8H4NbjI
        fhPv/KQPSy2Wrg9v4Zl9z3RxmtaU3NtmPDoyd1/s3KhzK3Fpb+P85ImGNxskj2t7PLphtGsP
        I8cqz6372I4V2Fgs9f0o3KF/4sbk5W+eH93HO/HGHJuM56rbjtl+aN7hzVoicf2zmESXuZoF
        y6xnex49M1qyxWnSgsr/i5dyNv42nCbKut90drKJkXThE1mrHp7NnM522Qte2uQ8ZftSaRc9
        K379o/St9bO9732sWDltepJ64uHOHQtrQoK8Sv/vdDz56KH9/5UROvszTdJ0u4+3LTlzpklQ
        eOrVlden71DqvLXyygMjiVe6/Ps+T1mZkWLU71fIYfJo7vtvSizFGYmGWsxFxYkAGPbMVzcE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSvO7voJ1JBof3qVs8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj6evwgr3yFVsmTGRs
        YJwn2cXIySEhYCKxe9E51i5GLg4hgd2MEptOdrNCJGQlnr3bwQ5hC0vcbzkCVfSeUWLZo1uM
        IAk2AV2JLc9fMYIkRARuM0r8bdzGBuIwC9xhlHi0fA8TSJWwQKBEy+ITbCA2i4CqxPWJG8Hi
        vAL2Evu3PGSGWCEvsWF+L5jNKeAgsejpFaAaDqB19hLPD1RClAtKnJz5hAXEZgYqb946m3kC
        o8AsJKlZSFILGJlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER4GW5g7G7as+6B1i
        ZOJgPMQowcGsJML7+vrWJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphak
        FsFkmTg4pRqYGLum9kudKe3IeXpi/uxf8/c/2D/zZIh2+OwlMQanr/9cfkh6ZfDVEwmneSRD
        TnuzT915Z9rxU2xuos9nV8T/e9JgXidc/lGZofx+1ISTCyMlLn6fqGh48JqMTeQD/o7lc8yk
        u+quteu8fbc/SLCkinlxs/Aen+9u0YlBDEX7provyd5U/9On/aT9jSdOIbwZi3a/V79VdjqR
        aWnNwmZG81pPk+vxqs2H4owSo+YuKO4JbctcUbdJQq9sj4mUgs/WJ84sdnJufKejnh8reLDb
        NHzqkjO/zs+bu+HyrvWv2mOUrra+vzXzu3x51vwaj/dvDnDUbzGPqMziV+78yVXfnvFuoZ3h
        M5v5iau+h3+zUmIpzkg01GIuKk4EALVjHIHxAgAA
X-CMS-MailID: 20220627064931epcas2p2e1dc352f41895b294d7945c2239de362
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627064931epcas2p2e1dc352f41895b294d7945c2239de362
References: <20220627064707.138883-1-chanho61.park@samsung.com>
        <CGME20220627064931epcas2p2e1dc352f41895b294d7945c2239de362@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Modern exynos SoCs such as Exynos Auto v9 has different internal clock
divider, for example "4". To support this internal value, this adds
clk_div of the s3c64xx_spi_port_config and use it if it is specified.
Otherwise, use "2" which is the previous default value.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index e17c74c0d7de..dd5fc8570bce 100644
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
+	u32 div = sdd->port_conf->clk_div ? sdd->port_conf->clk_div : 2;
 
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
@@ -889,22 +892,26 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 
 	pm_runtime_get_sync(&sdd->pdev->dev);
 
+	/* Use clk_div value if it is specified, otherwise use 2 as default */
+	if (sdd->port_conf->clk_div)
+		div = sdd->port_conf->clk_div;
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
@@ -914,7 +921,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 			}
 		}
 
-		speed = clk_get_rate(sdd->src_clk) / 2 / (psr + 1);
+		speed = clk_get_rate(sdd->src_clk) / div / (psr + 1);
 		if (spi->max_speed_hz >= speed) {
 			spi->max_speed_hz = speed;
 		} else {
-- 
2.36.1


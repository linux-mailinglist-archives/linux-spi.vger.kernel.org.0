Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E8255FD52
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 12:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiF2KZg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 06:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiF2KZe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 06:25:34 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB1E3BBE6
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 03:25:31 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220629102529epoutp012e3dc097d9d27657de0ac94cad13d13e~9EHRb2tM90829408294epoutp01K
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 10:25:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220629102529epoutp012e3dc097d9d27657de0ac94cad13d13e~9EHRb2tM90829408294epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656498329;
        bh=cAEW5DLT+rYmdqbRLPAbLST8Ew6HY1jTaugv3W8tTeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKPuhsNA+X8GmB2qpOIVkwyui7OrQycrZU27P3CT9QzK7Q/M+jZWDifroy3KEluhq
         oVSksE/8cIxCFLn0j4Mz30PeYygcjiu3hsjlt7FlBYlWPtG6WKwTsZE3ymKvQDoaNj
         IogWroBem70htXbb30s2yN55h+tqHeximqoNt87k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220629102528epcas2p45d87863f402a93e4584b550300225050~9EHQl6drQ0841508415epcas2p4U;
        Wed, 29 Jun 2022 10:25:28 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LXyK44Lnzz4x9Pr; Wed, 29 Jun
        2022 10:25:28 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.36.09642.8982CB26; Wed, 29 Jun 2022 19:25:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220629102527epcas2p19e967e3647084cbfad1bff0b9390b4ad~9EHPlGR0v2705927059epcas2p1s;
        Wed, 29 Jun 2022 10:25:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220629102527epsmtrp176ab46399948dfd958d86e6c844b87a6~9EHPhqxFc0392803928epsmtrp1X;
        Wed, 29 Jun 2022 10:25:27 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-d0-62bc289830dc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.D6.08905.7982CB26; Wed, 29 Jun 2022 19:25:27 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220629102527epsmtip1319246b7935d580b80ddc633f2a4d368~9EHPY1KrL2691826918epsmtip1S;
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
Subject: [PATCH v3 4/4] spi: s3c64xx: add spi port configuration for Exynos
 Auto v9 SoC
Date:   Wed, 29 Jun 2022 19:23:04 +0900
Message-Id: <20220629102304.65712-5-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629102304.65712-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmme4MjT1JBuemy1k8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xrYbb5kLrvFXXF/7naWB8R9PFyMnh4SAicTM
        k/OZQGwhgR2MErMv53cxcgHZnxglls+7xAzhfGOU+DdpGjtMR/OuqewQHXsZJT58yYIo+sgo
        8XHqd7BRbAK6Eluev2IESYgI3GSUmH62jwnEYRa4wSixd8Z6RpAqYYFIiRk/TzGD2CwCqkBF
        98HivAJ2Env2XGaCWCcvsWF+L1gNp4C9xNsrq1khagQlTs58wgJiMwPVNG+dDXarhMBEDomf
        H7cDORxAjovE4RZJiDnCEq+Ob4F6QUriZX8blF0ssXTWJyaI3gZGicvbfrFBJIwlZj1rZwSZ
        wyygKbF+lz7ESGWJI7eg1vJJdBz+yw4R5pXoaBOCaFSXOLB9OguELSvRPeczK4TtIdGz7SE0
        RCcxSnyb/5R9AqPCLCTfzELyzSyExQsYmVcxiqUWFOempxYbFRjDYzg5P3cTIzi1arnvYJzx
        9oPeIUYmDsZDjBIczEoivAvP7EwS4k1JrKxKLcqPLyrNSS0+xGgKDOuJzFKiyfnA5J5XEm9o
        YmlgYmZmaG5kamCuJM7rlbIhUUggPbEkNTs1tSC1CKaPiYNTqoGpXL08+XbEyruZc04xXvyS
        ce/TL9WIad5rrjeqZTctvnzz1sFrh2T7avIauzweRsps0Ton9dTs7P85FtePB9Q8Xe0+f9/x
        HUpqt4+be2uZ524qOBkR11G5WSi5d8Ul4RsR07xuOkv/E7paZJmYsXX9DL5tW4zn8GUVdezq
        C7v47PDxNUUZc0PDS56lOnKuXNZys/mD+M77H+17c58Erf9zX/3E3/gzX84X5K45vOLinLVy
        qzblHT3VzM5ywHPLm+x4AZF3DP7bHggLvGCNOj5dfuIH2TCv4k2/HjYvmxgdytCxRObBaj3z
        qysE956fdM59hUjp5Y1vyw9nnv38oS9szddzlQrng+Vq3YplPwWaHFNiKc5INNRiLipOBADV
        B5q4NgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnO50jT1JBvseG1g8mLeNzWLxj+dM
        FlMfPmGzuLxf22L+kXOsFn0vHjJb7H29ld1i0+NrrBYzzu9jsmj8eJPdonXvEXYHbo/rSz4x
        e2xa1cnmcefaHjaPzUvqPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStj2423zAXX+Cuur/3O
        0sD4j6eLkZNDQsBEonnXVPYuRi4OIYHdjBIdnY9YIBKyEs/e7WCHsIUl7rccYYUoes8osWzj
        CSaQBJuArsSW568YQRIiArcZJf42bmMDcZgF7jBKPFq+B6xKWCBc4tisc2BjWQRUJaafvc8I
        YvMK2Ens2XOZCWKFvMSG+b3MIDangL3E2yurWUFsIaCaJdd3skDUC0qcnPkEzGYGqm/eOpt5
        AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeCluYOxu2rPugd
        YmTiYDzEKMHBrCTCu/DMziQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YW
        pBbBZJk4OKUamOYtV6++HH/aLSzu4Nbnrb/qwoSOpB9U+TrZorX4hJTkgsptzWvEqv3jP3P7
        yDIJ1vhklS49Ly888eijx3/902dE8712f//wa/nEi+VZEr3LfB8p/1Tv6dCTMXm8YfObLXrb
        N6+5EFK0fFGO7Hkp8wyem2sETh5eOl9OdZKz+hIp1yT2Wfu/n9uewup0e3PwyrUHg7/qPfix
        aU/9olv6WllNNz0zN/FPVJvh1lIrEnA779PH+4FzPl9KzGnbvFVfvXEG9/26oONCLf8f7E84
        au4joKXpMv1hoOhPmXjn0s0WX7lEJmzdnLT8q5HZjZpr6w6khVw7epHfY0/StIUmUyTqrtnq
        Jj0yiVuTX9t8oFKJpTgj0VCLuag4EQA/gJk28wIAAA==
X-CMS-MailID: 20220629102527epcas2p19e967e3647084cbfad1bff0b9390b4ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220629102527epcas2p19e967e3647084cbfad1bff0b9390b4ad
References: <20220629102304.65712-1-chanho61.park@samsung.com>
        <CGME20220629102527epcas2p19e967e3647084cbfad1bff0b9390b4ad@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add exynosautov9 spi port configuration. It supports up to 12 spis so
MAX_SPI_PORTS should be increased from 6 to 12.
It has DIV_4 as the default internal clock divider and an internal
loopback mode to run a loopback test.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andi Shyti <andi@etezian.org>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ff565e57736b..7f346866614a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -18,7 +18,7 @@
 
 #include <linux/platform_data/spi-s3c64xx.h>
 
-#define MAX_SPI_PORTS		6
+#define MAX_SPI_PORTS		12
 #define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
 #define AUTOSUSPEND_TIMEOUT	2000
@@ -1451,6 +1451,19 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
+static const struct s3c64xx_spi_port_config exynosautov9_spi_port_config = {
+	.fifo_lvl_mask	= { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff, 0x7f,
+			    0x7f, 0x7f, 0x7f, 0x7f},
+	.rx_lvl_offset	= 15,
+	.tx_st_done	= 25,
+	.clk_div	= 4,
+	.high_speed	= true,
+	.clk_from_cmu	= true,
+	.clk_ioclk	= true,
+	.has_loopback	= true,
+	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
+};
+
 static const struct s3c64xx_spi_port_config fsd_spi_port_config = {
 	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
 	.rx_lvl_offset	= 15,
@@ -1492,6 +1505,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
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


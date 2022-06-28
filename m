Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE6A55C696
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 14:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244335AbiF1Eop (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jun 2022 00:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244297AbiF1Eom (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jun 2022 00:44:42 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAE99FC8
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 21:44:39 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220628044434epoutp04e0d173bd74647c19abca9fabd56d5a84~8r0UvRy7T1493314933epoutp04R
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 04:44:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220628044434epoutp04e0d173bd74647c19abca9fabd56d5a84~8r0UvRy7T1493314933epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656391474;
        bh=WdzNcCBUUsRhvuN8WI9tNEWHB08Feb81bArEwJFsRw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eHy6WIqcKYpVqhh6xwfxBhC7moi7+dFviDBmpF+feEln8LGl/sTGyAf6DTwiqFAqK
         eNPmMlcGmO51ydCZRKFrz8oO4/9ae48NSXJfA6Y7PM3w48ji2PmMiVngRxWYJzPU7z
         ilPNhPRUxzQLSHfAQdPGVoXFh0YFK2zsbN4/KoTE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220628044433epcas2p347141f45fa7e761965ad99e82ff15d03~8r0UFRGun1827118271epcas2p3e;
        Tue, 28 Jun 2022 04:44:33 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LXBp94SJzz4x9Q7; Tue, 28 Jun
        2022 04:44:33 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.D6.09666.1378AB26; Tue, 28 Jun 2022 13:44:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220628044432epcas2p2e2b4c0d52f11c0bf543c537e819224bc~8r0TLfgjV0047300473epcas2p2P;
        Tue, 28 Jun 2022 04:44:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220628044432epsmtrp139f0304b5aca10b4e6ce04e43c2d3544~8r0TKqKE02149721497epsmtrp18;
        Tue, 28 Jun 2022 04:44:32 +0000 (GMT)
X-AuditID: b6c32a45-45bff700000025c2-8a-62ba8731fb31
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.70.08905.0378AB26; Tue, 28 Jun 2022 13:44:32 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220628044432epsmtip18800ee082a259ae04efbd064ce9e58d9~8r0S8wBq_2875128751epsmtip1a;
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
Subject: [PATCH v2 4/4] spi: s3c64xx: add spi port configuration for Exynos
 Auto v9 SoC
Date:   Tue, 28 Jun 2022 13:42:22 +0900
Message-Id: <20220628044222.152794-5-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628044222.152794-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmha5h+64kgytzRSwezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWi74XD5kt9r7eym6x6fE1VosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
        YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
        JafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE74+zNDvaCh3wVP+6eYGpgnMLTxcjJISFgIrGj
        +RpLFyMXh5DADkaJnS8usEI4nxglThxdwwpSJSTwjVHi0vxkmI69J98xQRTtZZTYPq8dquMj
        o8TVEwvYQKrYBHQltjx/xQiSEBG4ySgx/WwfWAuzwA1Gib0z1jOCVAkLREq0fbrCAmKzCKhK
        LO9dD9bNK2AvcfHuMRaIffISG+b3MoPYnAIOEgtub2eEqBGUODnzCVgNM1BN89bZzCALJAQm
        ckhcbp/IBNHsInHk8ypmCFtY4tXxLewQtpTEy/42KLtYYumsT0wQzQ2MEpe3/WKDSBhLzHrW
        DrSNA2iDpsT6XfogpoSAssSRW1B7+SQ6Dv9lhwjzSnS0CUE0qksc2D4d6nxZie45n1khbA+J
        xq4PTJAgncwo8W5rzARGhVlIvpmF5JtZCHsXMDKvYhRLLSjOTU8tNiowhEdxcn7uJkZwctVy
        3cE4+e0HvUOMTByMhxglOJiVRHgXntmZJMSbklhZlVqUH19UmpNafIjRFBjWE5mlRJPzgek9
        ryTe0MTSwMTMzNDcyNTAXEmc1ytlQ6KQQHpiSWp2ampBahFMHxMHp1QD096VksXfLorfTDoT
        Ur2Xp8z7dpbKF5mv/lqcV5XLf5W9n/fwtq6yUCrfPa/48kOm04sffXU81btt7m3JZ37JwZMY
        I3RWa24ISVpTrit2UHmV3NG0R88slrmz91ecdb+jfKr3pMiH+AyJtxeu3jDuFp7z8GYji42l
        qtHS6qP6O5aVXjuR3G7K8mDlq8lX+Srm/9ZVDJ76z8P2Z968FVOdCo8WL3ifJP9Ea9vfC2mP
        rFOFN68JzhTbPa3izJtLL9IeqWSEnZjQ2NndVxCduWt+YMnsLU6/DvvMNjG+818hrf/stLbK
        afKzF9U8OJ+aLVO4brt5pfXZyMQui58bPR3VLnHduvzvAKfvuWdpVsnFNkosxRmJhlrMRcWJ
        AIal9Nk3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnK5B+64kgwUrTCwezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWi74XD5kt9r7eym6x6fE1VosZ5/cxWTR+vMlu0br3CLsDt8f1JZ+Y
        PTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJVx9mYHe8FDvoofd08w
        NTBO4eli5OSQEDCR2HvyHVMXIxeHkMBuRonfV76xQyRkJZ692wFlC0vcbznCClH0nlHi3eEm
        VpAEm4CuxJbnrxhBEiICtxkl/jZuYwNxmAXuMEo8Wr6HCaRKWCBcYtajhWCjWARUJZb3rmcD
        sXkF7CUu3j3GArFCXmLD/F5mEJtTwEFiwe3tjCC2EFDN+p1rWSHqBSVOznwCVs8MVN+8dTbz
        BEaBWUhSs5CkFjAyrWKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4ELc0djNtXfdA7
        xMjEwXiIUYKDWUmEd+GZnUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0t
        SC2CyTJxcEo1MF14bvR0f630Vf0z63b6/P6dlFu1+5vikm3HjgfemP/qpkHU+43tO5dlM+ke
        ay64dmzbzDlPaq2V/2x6eD04+X3C0yWfNRxP3XB/5fH26PU4weVPCnp2qSoLNXldV//J9mPS
        rontQUIxoSuP9X0Uf7Htg5/o/cmLv+SbaTj2M/7YwXk/tUmLvVj24Efp2Yl12YbSV583eYgU
        fNhYdOTdL7e1Jmsn786bot6WndV2o/9j69SeWcsjPCT4mC8fvP9pUmWgFcNal9cHfd+o2juz
        5Bjee3hn1x8BlaIFU6NqX9kXezvezDh6cgXbE+k9Z1hua1neb3eu++B89ltuxfWG2hd6VzYt
        Fmqs6gueorQ+/OskJZbijERDLeai4kQARnCwRfMCAAA=
X-CMS-MailID: 20220628044432epcas2p2e2b4c0d52f11c0bf543c537e819224bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220628044432epcas2p2e2b4c0d52f11c0bf543c537e819224bc
References: <20220628044222.152794-1-chanho61.park@samsung.com>
        <CGME20220628044432epcas2p2e2b4c0d52f11c0bf543c537e819224bc@epcas2p2.samsung.com>
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

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 51a0e830441b..0c9e19889809 100644
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
 static struct s3c64xx_spi_port_config fsd_spi_port_config = {
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


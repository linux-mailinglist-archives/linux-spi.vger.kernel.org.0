Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD20281252
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbgJBMXF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 08:23:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55009 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387896AbgJBMW6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 08:22:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201002122253euoutp012884f73d00e2d6c3af6afeaf903af93e~6LFf5TCP00521105211euoutp012
        for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2020 12:22:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201002122253euoutp012884f73d00e2d6c3af6afeaf903af93e~6LFf5TCP00521105211euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601641373;
        bh=lnOCU+ZnfcGa1dstHG1WG9yIqVu2Mdkx10tT0KaNnpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKOypmBvgLJlYbEvhNzaEGoy9gnoDrpQY5cU60geFeJ7PNInPxj4vKPpGmorP5QRg
         dj4oNH9UcLP+6wsNIiFs1lydru7tjHU1wKkeQ0ZkfVZEsPT3XCi4ZH8OBfpDPYrnM+
         bM8HjcfrEWcIZLBWUqKsVXqxUz8BjG/0orjgff/4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201002122253eucas1p214e6d4f5215839e45b3a4ac32c2b14b4~6LFfa84_M0641106411eucas1p29;
        Fri,  2 Oct 2020 12:22:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DD.EB.05997.D9B177F5; Fri,  2
        Oct 2020 13:22:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201002122252eucas1p16b24cee16354763e4925f21cf52c6a4d~6LFfHHVGI1198111981eucas1p18;
        Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201002122252eusmtrp228731ca900ff8f631f224d19dafcabb9~6LFfGgYJh0225802258eusmtrp2J;
        Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-53-5f771b9d13c9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 60.C0.06017.C9B177F5; Fri,  2
        Oct 2020 13:22:52 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201002122252eusmtip2db7b6c2791ad3b5dbfa6114a0e0c8a6d~6LFe7Z9Hb1486314863eusmtip2k;
        Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?Bart=C5=82omiej=20=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v3 5/9] spi: spi-s3c64xx: Rename S3C64XX_SPI_SLAVE_* to
 S3C64XX_SPI_CS_*
Date:   Fri,  2 Oct 2020 14:22:39 +0200
Message-Id: <20201002122243.26849-6-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002122243.26849-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djP87pzpcvjDabfELJY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKaL+3mrVg
        vWjFtlNbWBoYnwt2MXJySAiYSPy5fo+pi5GLQ0hgBaPE2S2NjBDOF0aJbW/vs0E4nxkl/i9Z
        yQzTsvbgRBaIxHJGiQfb21khnOeMEiu/P2ICqWITcJToX3oCLCEisJ1JYuLn82AtzAJHGSU2
        P7jKAlIlLBAl8WXiDzYQm0VAVeJ9w3FGEJtXwFridssXRoh98hLty7eD1XAK2EicXLSNDaJG
        UOLkzCdgc/gFtCTWNF0Hs5mB6pu3zmYGWSYh8Ihd4tGa1VCHu0ic3bSfFcIWlnh1fAs7hC0j
        8X/nfKCzOYDseonJk8wgenuAITDnBwtEjbXEnXO/2EBqmAU0Jdbv0ocod5RYdlkWwuSTuPFW
        EOICPolJ26YzQ4R5JTrahCBmqEis698DNU9KovfVCsYJjEqzkPwyC8n9sxBWLWBkXsUonlpa
        nJueWmyUl1quV5yYW1yal66XnJ+7iRGYpk7/O/5lB+OuP0mHGAU4GJV4eAUOlMYLsSaWFVfm
        HmKU4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKXsUIC6YklqdmpqQWpRTBZ
        Jg5OqQbGiY05n/4wR2nl/vhwQTa7UtC6Tqhw6fn+F190qxKmsUg1hEsG3L5/8eO0fz/UdunN
        MM/av1JbfZ9JkZBBQbx3ubv6HqVtfjPzzpxw4332TmyB8bYFmS+lm/Xv2hXMfu28T9TpM2eI
        M5NIcvD3p5pzj1zaJ2tyg6XkhM/tyzbml3b6JnreipRVYinOSDTUYi4qTgQAIFTpMU8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7pzpMvjDS7cs7BY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLaL+3mrVgvWjFtlNbWBoYnwt2MXJySAiY
        SKw9OJGli5GLQ0hgKaNE3+cVzF2MHEAJKYmVc9MhaoQl/lzrYoOoecoo8bT/MQtIgk3AUaJ/
        6QlWkISIwH4miUsX7oNNYhY4zChxed06JpAqYYEIicdfGsE6WARUJd43HGcEsXkFrCVut3xh
        hFghL9G+fDsbiM0pYCNxctE2MFsIqKb141xWiHpBiZMzn7CAXMcsoC6xfp4QSJhfQEtiTdN1
        sPHMQGOat85mnsAoNAtJxyyEjllIqhYwMq9iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjMpt
        x35u2cHY9S74EKMAB6MSD6/AgdJ4IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccXleak
        Fh9iNAV6cyKzlGhyPjBh5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi
        4JRqYFzAJbi4Z1vFU/NfHK9Epib4v1khs2XfOj3XqlZjn7zg7bFL96YdedpvI7BxxWIvvv3q
        t6Q/RkhJrQuea8M1Z8eFKZVrjl4XDOPvZVI2U/jW5Lw6V6FWo++N/6WX7Dp5Qr8/XNoxe07G
        +7AJ7cFcVx493qJ7+a/FzNpU7+vhc/Vfrtx6n+fAtzlKLMUZiYZazEXFiQDzltGT4AIAAA==
X-CMS-MailID: 20201002122252eucas1p16b24cee16354763e4925f21cf52c6a4d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201002122252eucas1p16b24cee16354763e4925f21cf52c6a4d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201002122252eucas1p16b24cee16354763e4925f21cf52c6a4d
References: <20201002122243.26849-1-l.stelmach@samsung.com>
        <CGME20201002122252eucas1p16b24cee16354763e4925f21cf52c6a4d@eucas1p1.samsung.com>
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
index 86b6125b24a6..13b53f9a5c3e 100644
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
@@ -332,18 +332,18 @@ static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
 
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
 
@@ -982,9 +982,9 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
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


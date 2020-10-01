Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1914528028D
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 17:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbgJAPWv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 11:22:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41190 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732661AbgJAPWv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 11:22:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201001152249euoutp02e319e1b9c84509e670bcdfa164e8fdc0~555Td1_C02406724067euoutp02P
        for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2020 15:22:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201001152249euoutp02e319e1b9c84509e670bcdfa164e8fdc0~555Td1_C02406724067euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601565769;
        bh=F7lc4bNVQrq/uJ6QtYI8r7CnZWm8NNaS58UeBeaW5GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TdEjeD3jrkSZkfjNzkdjaShGnyI65qnBJaZ0hWpwfeT8c3KaqxrD8XkTsE23waNKP
         GGZSRcYnT5SHDWwaMv1pLILCWBkLNtyAWSW/WC47a5U0cfYLLNAW9/uo/gMkEd22co
         D7RZCNFXWNzoVHG0pDPQVIDjSpMfyvdsYLysAi7w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201001152248eucas1p26c9e10839bf9cae4f295f353ee4f7c6c~555TIEhlr1941319413eucas1p2E;
        Thu,  1 Oct 2020 15:22:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5D.EC.06318.844F57F5; Thu,  1
        Oct 2020 16:22:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201001152248eucas1p10219600aaa0df6e030d2493b2aefbe92~555SpEBmC1729617296eucas1p1i;
        Thu,  1 Oct 2020 15:22:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201001152248eusmtrp116d2e24d4c7abc58e47a58a225c1c159~555Sofy2m2671526715eusmtrp1l;
        Thu,  1 Oct 2020 15:22:48 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-9f-5f75f448a878
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F5.D5.06017.844F57F5; Thu,  1
        Oct 2020 16:22:48 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201001152247eusmtip28e692c3e7a775c4fbd1a34263ac75ea4~555SbCl7k0513205132eusmtip2U;
        Thu,  1 Oct 2020 15:22:47 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 RESEND 5/9] spi: spi-s3c64xx: Rename S3C64XX_SPI_SLAVE_*
 to S3C64XX_SPI_CS_*
Date:   Thu,  1 Oct 2020 17:21:44 +0200
Message-Id: <20201001152148.29747-6-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001152148.29747-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7oeX0rjDY4vUbVY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DK+LxnE2PB
        etGK9ctvsDUwPhfsYuTkkBAwkVj68QlrFyMXh5DACkaJ8/dvskM4XxglJn58wAbhfGaU+PVq
        HTNMy7lF06ASyxklzm5fwwLhPGeUON18mh2kik3AUaJ/6QmwwSIC25kkJn4+zwKSYBYolejZ
        eQionYNDWCBR4ulVPxCTRUBVYs0eQ5AKXgFriQkfLrFBLJOXaF++HczmFLCRODfxMBtEjaDE
        yZlPwCbyC2hJrGm6DjVdXqJ562yoQ++xS/S3eICMlxBwkWj9VgMRFpZ4dXwLO4QtI3F6cg8L
        REm9xORJZiAHSwj0MEpsm/ODBaLGWuLOuV9gBzMLaEqs36UPEXaUeNu2hRWilU/ixltBiAP4
        JCZtm84MEeaV6GgTgqhWkVjXvwdqoJRE76sVjBMYlWYheWUWkvNnIexawMi8ilE8tbQ4Nz21
        2DgvtVyvODG3uDQvXS85P3cTIzA9nf53/OsOxn1/kg4xCnAwKvHwZhwqjRdiTSwrrsw9xCjB
        wawkwut09nScEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxS
        DYwzbcuurdeSDpDgjiqZzKJ6PUbNirv3nPSKTeXhX01WON8sqJ+RVtR/rUHqXkBu8/6/q/eF
        PXTdFxRWkL7swoNnk5reW3nMiWN5Zx+U0nZJ+U3uFY1d7+Pb31ZsmzvB7oTN2gWbHE+qzvfZ
        4fTjOnetzaunAZ833D76PbzzjFmS7t4p9c3VDUFKLMUZiYZazEXFiQABsswWSwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7oeX0rjDS6cZrFY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL+LxnE2PBetGK9ctvsDUwPhfsYuTkkBAw
        kTi3aBpbFyMXh5DAUkaJjasamLsYOYASUhIr56ZD1AhL/LnWBVXzlFFi+YR9jCAJNgFHif6l
        J1hBEiIC+5kkLl24zwKSYBYol7g06zk7iC0sEC/x8Pk3dpChLAKqEmv2GIKEeQWsJSZ8uMQG
        sUBeon35djCbU8BG4tzEw2C2kECuxO7dR9kg6gUlTs58wgIyhllAXWL9PCGQML+AlsSaputQ
        W+UlmrfOZp7AKDQLSccshI5ZSKoWMDKvYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzIbcd+
        btnB2PUu+BCjAAejEg+vwIHSeCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYf
        YjQF+nIis5Rocj4wWeSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCU
        amCM7Vnazc629Tq/XO21R1vvWOX9v3xsq8pans0FWi1qK/s8qi7VLXMTDy/81PXcpNo+e8+G
        zEcPf2zd47w8pVT+6y+Wd/wLjf6/Tfj59sG25q1dZRt6WJp8nuhvEO3ODYkMXbZHMz/2njPL
        5E2HeeLWy6b6TV+9qc9y/e6O2Sfrd+jKeM0RPH9IiaU4I9FQi7moOBEA9MK/p94CAAA=
X-CMS-MailID: 20201001152248eucas1p10219600aaa0df6e030d2493b2aefbe92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201001152248eucas1p10219600aaa0df6e030d2493b2aefbe92
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201001152248eucas1p10219600aaa0df6e030d2493b2aefbe92
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <20201001152148.29747-1-l.stelmach@samsung.com>
        <CGME20201001152248eucas1p10219600aaa0df6e030d2493b2aefbe92@eucas1p1.samsung.com>
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
index 5be6f2484e86..adc5593ca2ca 100644
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


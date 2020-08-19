Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39625249E20
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHSMf1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:35:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60714 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgHSMch (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:32:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200819123228euoutp020d3380d620f1cdc92a88d08083380b48~sq1S1jV9t1342313423euoutp02i
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 12:32:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200819123228euoutp020d3380d620f1cdc92a88d08083380b48~sq1S1jV9t1342313423euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597840348;
        bh=7RCmfy2p+tT9CWqfwKdINiZGD57fYFdZKszRWdqclLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqYUErkiTZY2d+t92e7yUG95Qsc8HY7v+J//txDKQAAQ4gyadLxW4WvOo3EuAcUhZ
         RKAf4n58Y0Zztggu3oEaLCs5qWg80i1e3ZZ8vuKER4ZjtKv/fqyBpy6ECTiszd9CmA
         jV/+2sf3owItngX1EjRCvSDfp+ICU+ZN294l2d1M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200819123227eucas1p2b5d318b29d9265a27126b4d221e9ed2c~sq1SagGCA2428624286eucas1p2K;
        Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 97.3B.06456.BDB1D3F5; Wed, 19
        Aug 2020 13:32:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200819123227eucas1p1f56cc06dc6c368abf2d3952ba04f37e2~sq1SESBNx1242912429eucas1p12;
        Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200819123227eusmtrp1bec799b243d3a44abacec1d81b1dccd6~sq1SDl9801680116801eusmtrp19;
        Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-af-5f3d1bdb9d64
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.63.06017.BDB1D3F5; Wed, 19
        Aug 2020 13:32:27 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819123227eusmtip2311306ee4d46a3cabcc7dae369dde216~sq1R1pO6Z0167401674eusmtip2W;
        Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH 4/8] spi: spi-s3c64xx: Rename S3C64XX_SPI_SLAVE_* to
 S3C64XX_SPI_CS_*
Date:   Wed, 19 Aug 2020 14:32:04 +0200
Message-Id: <20200819123208.12337-5-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819123208.12337-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7q3pW3jDRY8UrRY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yO3B7XF/y
        idlj06pONo/NS+o9+rasYvT4vEkugDWKyyYlNSezLLVI3y6BK2PLtyamgt8iFbPnNbE3MO4Q
        7GLk5JAQMJF4+HUPYxcjF4eQwApGiadN09kgnC+MErdW/GYBqRIS+Mwo0f88BKZjy+9TrBBF
        yxklpl2+wQZR9JxR4lhXPYjNJuAo0b/0BFiRiMAEJomH596AFTELlEr07DwEZgsLhEs0r1nP
        BGKzCKhK7D58EizOK2At0bfhCjPENnmJ9uXbweKcAjYSD39NgaoRlDg58wnYdfwCWhJrmq6z
        QMyXl2jeOpsZZLGEwDl2ibnvN7JDDHKRmH+hjQ3CFpZ4dXwLVFxG4vTkHqBmDiC7XmLyJDOI
        3h5GiW1zfrBA1FhL3Dn3iw2khllAU2L9Ln2IsKPEvFlLmCFa+SRuvBWEOIFPYtK26VBhXomO
        NiGIahWJdf17oAZKSfS+WsE4gVFpFpJnZiF5YBbCrgWMzKsYxVNLi3PTU4sN81LL9YoTc4tL
        89L1kvNzNzEC09Hpf8c/7WD8einpEKMAB6MSD2/FOet4IdbEsuLK3EOMEhzMSiK8TmdPxwnx
        piRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXA2P/hX2Drk7+f
        ZA85Gy//vM2V4ZByzNrYyfO2FebeSHqRskBd7kOuYkLsMwbLLx8LGZy3dJzM/ibQa7ZrqqnX
        8Y1huRs38T0L2ma/vbRk93a95sjjK+fFbNj36Kp/acOr2Ruk/A6yz/UqsS29xjjNtilIZHb6
        5tOrr+94u4j7Q498/+J7PltStJVYijMSDbWYi4oTAX8+/KdDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7q3pW3jDRoPc1ks/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZHbg9ri/5
        xOyxaVUnm8fmJfUefVtWMXp83iQXwBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl7HlWxNTwW+RitnzmtgbGHcIdjFyckgImEhs+X2KtYuRi0NI
        YCmjxNur3UxdjBxACSmJlXPTIWqEJf5c62KDqHnKKDHh9VZGkASbgKNE/9ITYM0iAjOYJJ7c
        mMwKkmAWKJe4NOs5O4gtLBAq0dx+GqyBRUBVYvfhk2wgNq+AtUTfhivMEBvkJdqXbweLcwrY
        SDz8NQXMFgKq6Vq8kAmiXlDi5MwnLCDHMQuoS6yfJwQS5hfQkljTdJ0FYq28RPPW2cwTGIVm
        IemYhdAxC0nVAkbmVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHxt+3Yzy07GLveBR9iFOBg
        VOLhrThnHS/EmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4ymQG9OZJYSTc4H
        poa8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2Mpm9PvFzu82Dh
        rTOH6xIeTdBJmrXbLlW7pnq9sue0SW6m2+8KaX5fmu4tEXz1FsOlbgeB984ODI9sptWzbj5Y
        +v/Mhy3Pghu2ue79KHySo3yrZbH3EV8rVYk9609czb5n2GAQL6fcI6G7WpGp+TzDo6nv9unn
        X+iU2dUirGKqGn962qPNJ6KMlFiKMxINtZiLihMBSsQZWtUCAAA=
X-CMS-MailID: 20200819123227eucas1p1f56cc06dc6c368abf2d3952ba04f37e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200819123227eucas1p1f56cc06dc6c368abf2d3952ba04f37e2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819123227eucas1p1f56cc06dc6c368abf2d3952ba04f37e2
References: <20200819123208.12337-1-l.stelmach@samsung.com>
        <CGME20200819123227eucas1p1f56cc06dc6c368abf2d3952ba04f37e2@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Rename S3C64XX_SPI_SLAVE_* to S3C64XX_SPI_CS_* to match documentation.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 4ab68cd1b821..6fe896f2be18 100644
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
@@ -312,18 +312,18 @@ static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
 
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
 
@@ -944,9 +944,9 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
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


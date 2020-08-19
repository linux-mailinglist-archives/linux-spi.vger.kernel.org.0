Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EE2249DEB
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgHSMdQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:33:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60199 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgHSMck (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:32:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200819123228euoutp010d21f811ff83b379cad9ddf2aa67cab2~sq1Tb6YRC2980229802euoutp01f
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 12:32:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200819123228euoutp010d21f811ff83b379cad9ddf2aa67cab2~sq1Tb6YRC2980229802euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597840348;
        bh=dodgnAl4aQ9JHWLPjyth7Ek4AxDLNCjB7Q2ZDPyW0+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NuaimugXLZRMElQAh0R57Va8jTcXjQ+CLPfqgkupGN/YUmXwiQdOXpF+umTE7fwMw
         Pkko905kbX9EUpjKaLzBpO+rjiby1HTK8Wy7rwobXdjhLBYsmxBRblnaRVoWmi0kC5
         fxIBFtf78UYCoykM1gs6gDgDbGiYe/JZ4G49cBGA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200819123228eucas1p28ecf3a4492d5091978a0d8f59aa69301~sq1TERT9k2958529585eucas1p2U;
        Wed, 19 Aug 2020 12:32:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 58.3B.06456.CDB1D3F5; Wed, 19
        Aug 2020 13:32:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200819123227eucas1p11ec027714c16d5a66c89c6ef1f7b3604~sq1Sp-jTa0820708207eucas1p1J;
        Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200819123227eusmtrp2101a6bb48ffcd56dc7f5fbb9180c5bb3~sq1SpYy982883128831eusmtrp2j;
        Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-b2-5f3d1bdcc277
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 34.DF.06314.BDB1D3F5; Wed, 19
        Aug 2020 13:32:27 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819123227eusmtip28a317d3b9767d8c4e833ddbc2aa0ead6~sq1SgmJje0116101161eusmtip2W;
        Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH 6/8] spi: spi-s3c64xx: Check return values
Date:   Wed, 19 Aug 2020 14:32:06 +0200
Message-Id: <20200819123208.12337-7-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819123208.12337-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djP87p3pG3jDZ7fELZY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yO3B7XF/y
        idlj06pONo/NS+o9+rasYvT4vEkugDWKyyYlNSezLLVI3y6BK6N/8gKWgpucFf/W/GVsYGzg
        6GLk5JAQMJGYt/wNUxcjF4eQwApGiTmLdzNCOF8YJV5vn88C4XxmlFh5ZDkLTMvsri1QieWM
        Er0nZkE5zxklfu1/xAZSxSbgKNG/9AQrSEJEYAKTxMNzb8ASzAKlEj07D4HZwgJWEqtmHwUb
        yyKgKvG0r5ERxOYVsJY4sWEiE8Q6eYn25dvB6jkFbCQe/prCBlEjKHFy5hOwXn4BLYk1TddZ
        IObLSzRvnc0MslhC4By7xPsJ54CGcgA5LhKnLwlCzBSWeHV8CzuELSPxf+d8JoiSeonJk8wg
        WnsYJbbN+QH1srXEnXO/2EBqmAU0Jdbv0ocIO0ps/LoUqpVP4sZbQYgL+CQmbZvODBHmleho
        E4KoVpFY178HaqCURO+rFYwTGJVmIfllFpL7ZyHsWsDIvIpRPLW0ODc9tdgwL7Vcrzgxt7g0
        L10vOT93EyMwIZ3+d/zTDsavl5IOMQpwMCrx8Facs44XYk0sK67MPcQowcGsJMLrdPZ0nBBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2Mm/63/1wkWeYZ
        kBg4Qbqm0nWZtu6P+Ocb1mdtPXV8EcO8pfd+GWW0RD+Zpv7ib9/F7hctFZEcB9cszDhUJlMo
        NkP1ifC1Nd9yNN5bGKbV2r+VdE5fbHBg77pJYVLex2I1fQSq1+d9eujWuPD75F8cv/a+3/Rq
        tu300qo7rwPdP966uee85EQ5cSWW4oxEQy3mouJEAIyZrshEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7q3pW3jDXoumlks/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZHbg9ri/5
        xOyxaVUnm8fmJfUefVtWMXp83iQXwBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl9E/eQFLwU3Oin9r/jI2MDZwdDFyckgImEjM7trC0sXIxSEk
        sJRRouvdfSCHAyghJbFybjpEjbDEn2tdbCC2kMBTRok5SwRBbDYBR4n+pSdYQXpFBGYwSTy5
        MZkVJMEsUC5xadZzdhBbWMBKYtXsoywgNouAqsTTvkZGEJtXwFrixIaJTBAL5CXal28HW8Ap
        YCPx8NcUqGXWEl2LFzJB1AtKnJz5BOw2ZgF1ifXzhEDC/AJaEmuarrNArJWXaN46m3kCo9As
        JB2zEDpmIalawMi8ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzD6th37uXkH46WNwYcYBTgY
        lXh4K85ZxwuxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp0JsTmaVEk/OB
        iSGvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenFDBWJknrZdtM7N+x
        f8vnx2ZfX6Qo/uyTq7n4ajf3t1r/iMAHeWc0l4nEqd46t8Lu/u/ZGtn3uTzPnPG7Nmd2TG/M
        niX/ZHYY1KWaKKuo36jcebXiYn+a+I+AlztPr93qzcASYSp+8Y79+pPak53jnp//zXz5Tud+
        4z3pevH+Zv+XyOeW3Lx6JVJUiaU4I9FQi7moOBEA3rAYbtQCAAA=
X-CMS-MailID: 20200819123227eucas1p11ec027714c16d5a66c89c6ef1f7b3604
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200819123227eucas1p11ec027714c16d5a66c89c6ef1f7b3604
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819123227eucas1p11ec027714c16d5a66c89c6ef1f7b3604
References: <20200819123208.12337-1-l.stelmach@samsung.com>
        <CGME20200819123227eucas1p11ec027714c16d5a66c89c6ef1f7b3604@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 505789f91fdf..27d77600a820 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -273,6 +273,7 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	struct s3c64xx_spi_driver_data *sdd;
 	struct dma_slave_config config;
 	struct dma_async_tx_descriptor *desc;
+	int ret;
 
 	memset(&config, 0, sizeof(config));
 
@@ -296,11 +297,22 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(&sdd->pdev->dev, "unable to prepare %s scatterlist",
+			dma->direction == DMA_DEV_TO_MEM ? "rx" : "tx");
+		return;
+	}
 
 	desc->callback = s3c64xx_spi_dmacb;
 	desc->callback_param = dma;
 
 	dma->cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(dma->cookie);
+	if (ret) {
+		dev_err(&sdd->pdev->dev, "dmaengine_submit() failed %d", ret);
+		return;
+	}
+
 	dma_async_issue_pending(dma->ch);
 }
 
-- 
2.26.2


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D1B249DE0
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgHSMce (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:32:34 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60627 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgHSMc2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:32:28 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200819123226euoutp027f69b40d3c6bfa40eccbf3a879fc22d6~sq1RqzmAV1325613256euoutp02y
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 12:32:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200819123226euoutp027f69b40d3c6bfa40eccbf3a879fc22d6~sq1RqzmAV1325613256euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597840346;
        bh=ehEA55cTOHzp/hMa1IHkDqb7+RqzzRP8GducSwbT9uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSroFa98Fmed1nwxfcqjXMuudOEqxwg6Tx7356ZYtuUtsyiWGjEpxFgDbmDiWzioI
         i1awtD96oK8O46+kNtNA81FdeiBn0fJ4onSmDdJ2G81cLoUMfUjimEplFOhAGjyHBN
         07M+Oh76hBt8eAUNaDpqk/5WORFqFBJC4UVHswB8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200819123226eucas1p2282009f27d2a3a6f20cee2b474ee357a~sq1RR8ZIx3168631686eucas1p2G;
        Wed, 19 Aug 2020 12:32:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 42.FC.05997.ADB1D3F5; Wed, 19
        Aug 2020 13:32:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200819123226eucas1p16c9b90330d957344f99f6ee461190085~sq1RA90g21043110431eucas1p19;
        Wed, 19 Aug 2020 12:32:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200819123226eusmtrp229df06d59e344512679ff5ccc252e348~sq1Q-hoDU2933429334eusmtrp2R;
        Wed, 19 Aug 2020 12:32:26 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-3b-5f3d1bda48c8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 32.DF.06314.ADB1D3F5; Wed, 19
        Aug 2020 13:32:26 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819123225eusmtip22c5abf3c7b70d51305b66d17f306f693~sq1Q3Cpdz3236932369eusmtip2O;
        Wed, 19 Aug 2020 12:32:25 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH 1/8] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
 s3c64xx_enable_datapath()
Date:   Wed, 19 Aug 2020 14:32:01 +0200
Message-Id: <20200819123208.12337-2-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819123208.12337-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7q3pG3jDSb/lrBY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yO3B7XF/y
        idlj06pONo/NS+o9+rasYvT4vEkugDWKyyYlNSezLLVI3y6BK+Ph9d2sBZPYKm6sf8DSwNjN
        2sXIySEhYCJxZtd09i5GLg4hgRWMEssmT2KGcL4wSsw8fYURwvnMKHHzPUgLB1hL64IIiPhy
        RokPXy+xQjjPGSU6T99lAZnLJuAo0b/0BFhCRGACk8TDc2/YQBLMAqUSPTsPgdnCAgkS345O
        YAeZyiKgKtGytxIkzCtgLTFl33kmiPvkJdqXbwcr5xSwkXj4awobRI2gxMmZT8B28QtoSaxp
        us4CMV5eonnrbGaI3nPsEr86uCFsF4lTS2FmCku8Or6FHcKWkfi/cz4TxGP1EpMnmYGcLCHQ
        wyixbc4PFogaa4k7536xgdQwC2hKrN+lDxF2lNhz5ytUK5/EjbeCEBfwSUzaNp0ZIswr0dEm
        BFGtIrGufw/UQCmJ3lcrGCcwKs1C8sssJPfPQti1gJF5FaN4amlxbnpqsVFearlecWJucWle
        ul5yfu4mRmAyOv3v+JcdjLv+JB1iFOBgVOLhrThnHS/EmlhWXJl7iFGCg1lJhNfp7Ok4Id6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhhbL1k3Hk38u0Hz
        7lcn/9XuqqXKnQ7fdl23XSizL/ewDHd+stziNJZCl698T04eavNo0o4RnfGD68/HPPH1czg3
        Hee+I1l4eb7GwZfejNP/KlktKV8UviB7/6nJUuW/HKuObUmSPPCAr+vfi04z5cor1l+27vR4
        3+Z0VqllHWv/hyVqlg9qXRyVWIozEg21mIuKEwG4CQEzQgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7q3pG3jDVYdZbdY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yO3B7XF/y
        idlj06pONo/NS+o9+rasYvT4vEkugDVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL+Ph9d2sBZPYKm6sf8DSwNjN2sXIwSEhYCLRuiCii5GLQ0hg
        KaNEx6ReZoi4lMTKueldjJxAprDEn2tdbBA1TxklDrbMZAJJsAk4SvQvPcEKkhARmMEk8eTG
        ZFaQBLNAucSlWc/ZQQYJC8RJXDjAA2KyCKhKtOytBKngFbCWmLLvPBPEfHmJ9uXb2UBsTgEb
        iYe/poDZQkA1XYsXMkHUC0qcnPmEBWQMs4C6xPp5QiBhfgEtiTVN11kglspLNG+dzTyBUWgW
        ko5ZCB2zkFQtYGRexSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERh524793LyD8dLG4EOMAhyM
        Sjy8Fees44VYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEU6MuJzFKiyfnA
        pJBXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoGxX8Xe6f5MjWwz
        9qXHG99nH+NvC+p+4Hp21SGGmL70EyJ6Rh9vLn+9R491/9/XhX9szzmuSH7iMVHTOShwy4de
        VwatKYrPDyyc9L0+JXNtoeO3Yo3P63WMjP/Zf/jLZOXoVlh1x+1GiDNrUltrqXbx40+XujUY
        12eEb3275ZLSh5wpj8QeKrAosRRnJBpqMRcVJwIA2w7Ux9ICAAA=
X-CMS-MailID: 20200819123226eucas1p16c9b90330d957344f99f6ee461190085
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200819123226eucas1p16c9b90330d957344f99f6ee461190085
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819123226eucas1p16c9b90330d957344f99f6ee461190085
References: <20200819123208.12337-1-l.stelmach@samsung.com>
        <CGME20200819123226eucas1p16c9b90330d957344f99f6ee461190085@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix issues with DMA transfers bigger than 512 on Exynos3250.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index cf67ea60dc0e..fb5e2ba4b6b9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -678,11 +678,11 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 		sdd->state &= ~RXBUSY;
 		sdd->state &= ~TXBUSY;
 
-		s3c64xx_enable_datapath(sdd, xfer, use_dma);
-
 		/* Start the signals */
 		s3c64xx_spi_set_cs(spi, true);
 
+		s3c64xx_enable_datapath(sdd, xfer, use_dma);
+
 		spin_unlock_irqrestore(&sdd->lock, flags);
 
 		if (use_dma)
-- 
2.26.2


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BE824DE74
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 19:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHURah (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 13:30:37 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38726 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgHUQOJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Aug 2020 12:14:09 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200821161406euoutp02d8658f144a68bebad1bdba03dc522be7~tVJYbdIxA0393803938euoutp02P
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2020 16:14:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200821161406euoutp02d8658f144a68bebad1bdba03dc522be7~tVJYbdIxA0393803938euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598026446;
        bh=PpDBZdajjDlgQHRWyQ9W5bbkjE+LhSCprllGPHPQdnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgpwJA7D9ftM6l82BbCVMbOYHUpC9VphRNwTKBwGJj8kmoECB+I+Qi42G0vPf9Clv
         5DxiT7DJMzbhf1sGBYp3QpRi7pS/rcTCM/TUl8Lw2nsp/lFWjJj1BOVuEVb5sMLoL2
         mFtMbyj4ASPcxV070a0vrqvak1AdgohsIvny5wAI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200821161405eucas1p1718cc0c7b3a44e59858c0a903cd46272~tVJX34oAl0797107971eucas1p1V;
        Fri, 21 Aug 2020 16:14:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9F.9E.05997.DC2FF3F5; Fri, 21
        Aug 2020 17:14:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200821161405eucas1p1d43a5970c6a26389cd506aab5f986bc8~tVJXWdlvZ3197331973eucas1p1v;
        Fri, 21 Aug 2020 16:14:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200821161405eusmtrp22d4f9c7b9b686ad1a253939c0c8f3ab1~tVJXVxjNn2998229982eusmtrp2b;
        Fri, 21 Aug 2020 16:14:05 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-c2-5f3ff2cdec30
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D9.17.06314.DC2FF3F5; Fri, 21
        Aug 2020 17:14:05 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200821161405eusmtip1af489f3f01105dae12c2bd3ed9135448~tVJXJ5vys1595415954eusmtip1E;
        Fri, 21 Aug 2020 16:14:05 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 1/9] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
 s3c64xx_enable_datapath()
Date:   Fri, 21 Aug 2020 18:13:53 +0200
Message-Id: <20200821161401.11307-2-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821161401.11307-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87pnP9nHG+w+YGyx+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV8atz/4Fp9grtm07ytbAuJCt
        i5GTQ0LAROLjjF/sXYxcHEICKxgl1uzZzgjhfGGUOHFnKQuE85lRYsX6zewwLZs67zNBJJYz
        SizuXQ42S0jgOaPE/WPaIDabgKNE/9ITrCBFIgITmCQennsDVsQsUCrRs/MQmC0skCyxbuNe
        oEkcHCwCqhK/V/mDhHkFrCX613ezQiyTl2hfvh2snFPARuL4pSZWiBpBiZMzn7CA2PwCWhJr
        mq6zQIyXl2jeOpsZZK+EwCV2ibXHpkENcpH4v+giM4QtLPHq+Baob2Qk/u+cD3aDhEC9xORJ
        ZhC9PYwS2+b8YIGosZa4c+4XG0gNs4CmxPpd+hBhR4mnU+azQ7TySdx4KwhxAp/EpG3TmSHC
        vBIdbUIQ1SoS6/r3QA2Ukuh9tYJxAqPSLCTPzELywCyEXQsYmVcxiqeWFuempxYb5aWW6xUn
        5haX5qXrJefnbmIEJqPT/45/2cG460/SIUYBDkYlHt4fh+zjhVgTy4orcw8xSnAwK4nwOp09
        HSfEm5JYWZValB9fVJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKYLBMHp1QDI6f9xssi
        L3VclsY7x05beUNJ9q/smbbveZ9Msuqlju3qy3ke1GSwO7df/uV6NU5Zdr6FS7XVRRsOL5vh
        3id9dy3/8x+xc5bUVcytezVzb1RfosD5tp/BEy/m9+m+6fmfGzf91p2IboV3z1yNllpm+AbY
        xm6qmeYfH2imau1+y16Aj1/a7N0DJZbijERDLeai4kQAxWUMEkIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xu7pnP9nHG9x4xWux+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsatz/4Fp9grtm07ytbAuJCti5GTQ0LARGJT532mLkYuDiGB
        pYwS/X3/GLsYOYASUhIr56ZD1AhL/LnWBVYvJPCUUeLjbH4Qm03AUaJ/6QlWkF4RgRlMEk9u
        TGYFSTALlEtcmvWcHcQWFkiUeDRzJivITBYBVYnfq/xBwrwC1hL967tZIebLS7Qv3w42n1PA
        RuL4pSZWiF3WEtsWX2aBqBeUODnzCQvIGGYBdYn184RAwvwCWhJrmq6zQGyVl2jeOpt5AqPQ
        LCQdsxA6ZiGpWsDIvIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMw8rYd+7l5B+OljcGHGAU4
        GJV4eH8cso8XYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFGU6AvJzJLiSbn
        A5NCXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxsSs4tCy9xZf
        WhucN/49vzW4ludujonwy4ls94RaVn5kd679scPe+d/m91tOioXr5fefjI9Skoz/OeN6zKM8
        xhulsgt77rx6vDfun56s+LSUHVv+V4ds59j3O+DyZJPl/1c7zrBtvz15ou+sPPVb/FJxV35P
        XujypujlYW6RipT1FcWzm5l+/FZiKc5INNRiLipOBAA1fNNU0gIAAA==
X-CMS-MailID: 20200821161405eucas1p1d43a5970c6a26389cd506aab5f986bc8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200821161405eucas1p1d43a5970c6a26389cd506aab5f986bc8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200821161405eucas1p1d43a5970c6a26389cd506aab5f986bc8
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <CGME20200821161405eucas1p1d43a5970c6a26389cd506aab5f986bc8@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This and the next patch fix issues with DMA transfers bigger than
512 bytes on Exynos3250. Without the patches such transfers fail
to complete. This solution to the problem is found in the vendor kernel
for ARTIK5 boards based on Exynos3250.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 924b24441789..26c7cb79cd78 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -685,11 +685,11 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
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


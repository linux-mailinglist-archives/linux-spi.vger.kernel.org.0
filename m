Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273A62802A4
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 17:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbgJAPX3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 11:23:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40832 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732591AbgJAPWt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 11:22:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201001152247euoutp0182c9828c8b5280f6037813b7f4bcc2c2~555SUiV3f2734527345euoutp01C
        for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2020 15:22:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201001152247euoutp0182c9828c8b5280f6037813b7f4bcc2c2~555SUiV3f2734527345euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601565767;
        bh=NVNjGrE9vr/guygdPxlaMnYBop/HI2z2S3vR10IzuAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvQl2EKvZtR8PKpbE4qe5O9IYCbC/ATe5JeFiv1+eDg131EABmkpicDmZY1j8EzBH
         B6mHGUl6V0Ted261WvmEN0VnGyOIm6CPzSkIkpj6CALEMTFy/yLWy2MXW9yEiknlKu
         aOThnfj7xJn10pq7ufHB9BvNoV5wcA2AnhcxezF0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201001152247eucas1p2d0abdd77d7f2bf0700485d6bef62a965~555R0lvLb1942719427eucas1p2D;
        Thu,  1 Oct 2020 15:22:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1C.EC.06318.744F57F5; Thu,  1
        Oct 2020 16:22:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201001152246eucas1p2fb22ab55c276d76c4508142842c90ab8~555RhXwJv2407924079eucas1p2G;
        Thu,  1 Oct 2020 15:22:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201001152246eusmtrp231fc89d4e2d3b9d29335647b6206df2a~555RgJmmH3010130101eusmtrp2P;
        Thu,  1 Oct 2020 15:22:46 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-9a-5f75f447e2a4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.A5.06314.644F57F5; Thu,  1
        Oct 2020 16:22:46 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201001152246eusmtip27567bf4ee78a026fc47809313be6e230~555RXVCPs0082600826eusmtip28;
        Thu,  1 Oct 2020 15:22:46 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 RESEND 2/9] spi: spi-s3s64xx: Add
 S3C64XX_SPI_QUIRK_CS_AUTO for Exynos3250
Date:   Thu,  1 Oct 2020 17:21:41 +0200
Message-Id: <20201001152148.29747-3-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001152148.29747-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djPc7ruX0rjDb4sFLRY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DK2PLtPXvB
        DraKgz+fszYwbmLtYuTkkBAwkTh9ZAuQzcUhJLCCUeJc9wwo5wujxPKO6ywQzmdGid1PNjDD
        tCyYMIUdIrGcUeLvt0VsEM5zRonW/beZQKrYBBwl+peeAJslIrCdSWLi5/MsIAlmgVKJnp2H
        2EBsYYF4ic29m4HiHBwsAqoSz9+bgYR5Bawl+o5sgdomL9G+fDtYOaeAjcS5iYfZIGoEJU7O
        fAI2kl9AS2JN03Wo8fISzVtnM4PslRC4xy7x+Mt0dohBLhIX7hxngrCFJV4d3wIVl5H4v3M+
        E8gNEgL1EpMnmUH09jBKbJvzgwWixlrizrlfbCA1zAKaEut36UOUO0q0XIIy+SRuvBWEuIBP
        YtK26cwQYV6JjjYhiBkqEuv690DNk5LofbWCcQKj0iwkv8xCcv8shFULGJlXMYqnlhbnpqcW
        G+ellusVJ+YWl+al6yXn525iBKao0/+Of93BuO9P0iFGAQ5GJR7ejEOl8UKsiWXFlbmHGCU4
        mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1Oq
        gVGzTSa039RAQIzrplb9sV2rJqsvUdJdsugkd3Kf6cMpk6LLD3w+b7xMa4H6VUbfhpPTZyk9
        +3JmoW7KlYkKB5eZPlknP02usc2esWaf74ImuV1lLXUrw1hXJy96u1LenInhnl56vxx/9zzF
        ZIYNtyLFV+VUHC7r8o64y9u26NbsBVp2lV/1w5VYijMSDbWYi4oTAQYRY11NAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7puX0rjDZavt7RY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL2PLtPXvBDraKgz+fszYwbmLtYuTkkBAw
        kVgwYQp7FyMXh5DAUkaJv2efATkcQAkpiZVz0yFqhCX+XOtig6h5yijRNnktO0iCTcBRon/p
        CVaQhIjAfiaJSxfus4AkmAXKJS7Neg5WJCwQK/H43U1GkKEsAqoSz9+bgYR5Bawl+o5sYYZY
        IC/Rvnw7G4jNKWAjcW7iYTBbSCBXYvfuo2wQ9YISJ2c+YQEZwyygLrF+nhBImF9AS2JN03Wo
        rfISzVtnM09gFJqFpGMWQscsJFULGJlXMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbktmM/
        N+9gvLQx+BCjAAejEg+vwIHSeCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYf
        YjQF+nIis5Rocj4wWeSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCU
        amAsXeFgOTcrUOmsYHXaovd6MmI5qtOfxdrzpLFvenm/PJvXaNERLkfHia3Kf14e3BCVpfCs
        0zHultVP790JJROnmM+9/XFlcDNvVfuueYuMla5Hux9XcXsxeblQUmNN+VLp5HcPSmcpRd1V
        cd94wzr/ZjOPhv8cjZ1q0z0U7rv2JtnlLp4lEqTEUpyRaKjFXFScCAAx+xko3gIAAA==
X-CMS-MailID: 20201001152246eucas1p2fb22ab55c276d76c4508142842c90ab8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201001152246eucas1p2fb22ab55c276d76c4508142842c90ab8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201001152246eucas1p2fb22ab55c276d76c4508142842c90ab8
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <20201001152148.29747-1-l.stelmach@samsung.com>
        <CGME20201001152246eucas1p2fb22ab55c276d76c4508142842c90ab8@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix issues with DMA transfers bigger than 512 bytes on Exynos3250. Without
the patches such transfers fail.

The vendor kernel for ARTIK5 handles CS in a simmilar way.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 26c7cb79cd78..22bf8c75580a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1379,6 +1379,7 @@ static struct s3c64xx_spi_port_config exynos4_spi_port_config = {
 	.tx_st_done	= 25,
 	.high_speed	= true,
 	.clk_from_cmu	= true,
+	.quirks		=  S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
 static struct s3c64xx_spi_port_config exynos7_spi_port_config = {
-- 
2.26.2


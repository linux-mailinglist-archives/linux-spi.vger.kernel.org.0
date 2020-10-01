Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABD02802A1
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 17:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbgJAPXY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 11:23:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40826 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbgJAPWt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 11:22:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201001152247euoutp01716f50a8a2a6f66c6d138636792b1b51~555R6YMKG2712227122euoutp01R
        for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2020 15:22:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201001152247euoutp01716f50a8a2a6f66c6d138636792b1b51~555R6YMKG2712227122euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601565767;
        bh=BzRv9HJb8VaLbApMv1Dmlo0K8h3v8k5w87oec/cJk9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j8KQVKiTtz1A3cik9vmEwSiDfPx+0BY/sNQSxsgcjwKJgFQRLAueuiqQczFJVhm+t
         wLhCHkBY5k1d32Ymh7d0tpLQr9EraWzkQSR5eapaFlN5d/2+zXFNw1Gxc8BRZl8Bbx
         rT1/Wtc+IHEZOKzYYf6JEH1BP3qpJ/B69BheqMxw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201001152246eucas1p2b7cb48c0444b0d6205f7e39ca90f4e08~555RhktW31941319413eucas1p2C;
        Thu,  1 Oct 2020 15:22:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 66.2F.06456.644F57F5; Thu,  1
        Oct 2020 16:22:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201001152246eucas1p1b4155ab4f06a39cc88f205b4a7cd47f9~555RM524D1726917269eucas1p1R;
        Thu,  1 Oct 2020 15:22:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201001152246eusmtrp1a47e25d5e19d404120af06da9ae4192f~555RMHHyf2671526715eusmtrp1h;
        Thu,  1 Oct 2020 15:22:46 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-43-5f75f446f3bf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E3.D5.06017.644F57F5; Thu,  1
        Oct 2020 16:22:46 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201001152246eusmtip2756b8b5264661f95b4e9dd99b220fe8b~555RCdfgq0103301033eusmtip25;
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
Subject: [PATCH v2 RESEND 1/9] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs()
 and s3c64xx_enable_datapath()
Date:   Thu,  1 Oct 2020 17:21:40 +0200
Message-Id: <20201001152148.29747-2-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001152148.29747-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djP87puX0rjDX7+MrdY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKeHI2p+Ap
        e0XLm2usDYx72boYOTkkBEwkXk/bB2RzcQgJrGCUmPvqKguE84VR4tS3KcwQzmdGiZ8/prPC
        tHw71QKVWM4oMW3SdXYI5zmjxLfGuYwgVWwCjhL9S0+wgiREBLYzSUz8fJ4FJMEsUCrRs/MQ
        2HZhgSyJey9fg9ksAqoS83uWMIHYvALWEk2nbjFDrJOXaF++HayGU8BG4tzEw2wQNYISJ2c+
        AZvJL6AlsabpOtR8eYnmrbPBzpMQuMcucWjFByaIQS4SN452QQ0Vlnh1fAs7hC0jcXpyD1Az
        B5BdLzF5khlEbw+jxLY5P1ggaqwl7pz7xQZSwyygKbF+lz5E2FHiw/15zBCtfBI33gpCnMAn
        MWnbdKgwr0RHmxBEtYrEuv49UAOlJHpfrWCcwKg0C8kzs5A8MAth1wJG5lWM4qmlxbnpqcWG
        eanlesWJucWleel6yfm5mxiBSer0v+OfdjB+vZR0iFGAg1GJhzfjUGm8EGtiWXFl7iFGCQ5m
        JRFep7On44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgSTZeLglGpg
        FKyt2/6758HttN8bT662r40penN4Tanl8pjWJ3Xftpp/rsk8rKK//K9f/lkX7ZWZ5TvZj9xQ
        TnU+cGriW2En5eX/ZIq/bAgRnLCi815DSYtma678N0nPfME1M3br8DIxVakrb1d3XbXgqr35
        vvLsP+6i9yRPvL1h1irKPWXH6ZRMEze7SapKSizFGYmGWsxFxYkAmrCkhU4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7puX0rjDRY1qFgs/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZLVbt+sPo
        wONxfcknZo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZ
        WlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlPDmbU/CUvaLlzTXWBsa9bF2MnBwSAiYS
        3061MHcxcnEICSxllLjx9gVrFyMHUEJKYuXcdIgaYYk/17rYIGqeMkps2jqHFSTBJuAo0b/0
        BCtIQkRgP5PEpQv3WUASzALlEpdmPWcHsYUFMiS+NUwGi7MIqErM71nCBGLzClhLNJ26xQyx
        QV6iffl2sIs4BWwkzk08DGYLCeRK7N59lA2iXlDi5MwnLCDHMQuoS6yfJwQS5hfQkljTdB1q
        rbxE89bZzBMYhWYh6ZiF0DELSdUCRuZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgRG57djP
        LTsYu94FH2IU4GBU4uEVOFAaL8SaWFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc1OJD
        jKZAb05klhJNzgcmi7ySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxS
        DYxr5+xZlKy4N+71D3GDJefDkvN4/0js27TlanJp3bY3NcaLb3NO1ZJW9j/bbdxeuuTYiqea
        WQuD8nYd6z7UzD9nrhr3rJB/y7SW7dizqKajz/Vo9XfVvYwvjgg8TfHjiRN9X+/9h22GT1Py
        o42rrki02qu5fzH0XVJ7/sGh+Yu3bHD04fxwu3aHEktxRqKhFnNRcSIALolJXd4CAAA=
X-CMS-MailID: 20201001152246eucas1p1b4155ab4f06a39cc88f205b4a7cd47f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201001152246eucas1p1b4155ab4f06a39cc88f205b4a7cd47f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201001152246eucas1p1b4155ab4f06a39cc88f205b4a7cd47f9
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <20201001152148.29747-1-l.stelmach@samsung.com>
        <CGME20201001152246eucas1p1b4155ab4f06a39cc88f205b4a7cd47f9@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix issues with DMA transfers bigger than 512 bytes on Exynos3250. Without
the patches such transfers fail to complete. This solution to the problem
is found in the vendor kernel for ARTIK5 boards based on Exynos3250.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
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


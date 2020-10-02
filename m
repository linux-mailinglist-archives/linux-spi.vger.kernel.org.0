Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E98B28126D
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbgJBMXa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 08:23:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54082 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387877AbgJBMWy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 08:22:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201002122252euoutp02bfb12a3b5ad61933c321c793db59841a~6LFeoxa6V2196421964euoutp02D
        for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201002122252euoutp02bfb12a3b5ad61933c321c793db59841a~6LFeoxa6V2196421964euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601641372;
        bh=BzRv9HJb8VaLbApMv1Dmlo0K8h3v8k5w87oec/cJk9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPO4j5o9SFiQprSJdfF58XgVs9rs/lCgUrNbO7ICqV3pmZJ0Isa98jLJ6vIwa+UmN
         uUEkDOecMWXfWeTooRDRiyAi4YKwBMeoUPa+8P4ESGdusxuaImqqVSBNQcTXodyGFR
         PY68KskNStTl54B1iERgXTDMKYzfJy6gE7tgw+Bc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201002122252eucas1p169c62e7c624d05c762f87f313c14a01f~6LFeOOIb70997709977eucas1p18;
        Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B0.42.06456.B9B177F5; Fri,  2
        Oct 2020 13:22:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201002122251eucas1p26b59b6a574f78200d0c696dd1aacc140~6LFd0O4c92501625016eucas1p2F;
        Fri,  2 Oct 2020 12:22:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201002122251eusmtrp1bfc3344390f81445ef703a373e56d285~6LFdxH3iZ1383613836eusmtrp11;
        Fri,  2 Oct 2020 12:22:51 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-90-5f771b9bc201
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8D.BD.06314.B9B177F5; Fri,  2
        Oct 2020 13:22:51 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201002122251eusmtip20501592c6d9078c27423915482d550d8~6LFdoAdtN1143811438eusmtip2Q;
        Fri,  2 Oct 2020 12:22:51 +0000 (GMT)
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
Subject: [PATCH v3 1/9] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
 s3c64xx_enable_datapath()
Date:   Fri,  2 Oct 2020 14:22:35 +0200
Message-Id: <20201002122243.26849-2-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002122243.26849-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfSzUcRzH+97v7vf73eX0c5TPsGxXRiYy0m+dWay2s7ZW81+tuPgN5bA7
        j63mIcvDiBjpaDURs4Sj81Sqy0OXcaN5KrYa5rElh2Qodz+W/16f7/v9/jxsXxITtfFsyPDI
        GEYRKYsQ4wKuputP3/ES2/jAEyOGU/SztWkOXV9cy6MLv0/idO7EPEbr9XUEPaqtQrR6YohH
        f24txelifTuHTvk1StA1HeMEXd26gc6YSYfLlzBpi2qckKqrM3FpQ3mS9H5jNZIa1Icv4pcF
        3iFMRHgco3DzCRKETfZGRE8RCWkLQ7xk9AbPQnwSKE/IKE3hZCEBKaKqECxOjCK2WEaw2rmx
        oxgQ6Ob7OLuRwcIMnpFFVCWClUxr1jSNYKzrp0nAKV/IrfjIMwpWVBMHHhj0XGOBUZ0IGr4N
        co0uSyoYphZGTcylHKBdM0gYWUhJ4PHqh50N7SG9ssnEfMobdGUanPVYgO7RpCl7gHKGF6nD
        Jsa2/XdflWDGYUB9IWA4bZrHNjoLm1tdiGVLmOtuJFi2g56C7O0wuc1JUJDvxWazEWhK17is
        RwJjfeu40YNRx6C21Y199oW3/YsYGzWHkR8W7ArmkK95uPMshIx7ItZ9FF7mvt5paAM5c1Uo
        D4lVe45R7TlA9X/WU4RVI2smVikPZZTukUy8q1ImV8ZGhroGR8nVaPtL9Wx1LzWjlYHrWkSR
        SGwmDNPGBop4sjhlolyLgMTEVkK/3p5rImGILPEWo4gKVMRGMEotsiW5YmuhR9nsVREVKoth
        bjJMNKPYVTkk3yYZXVq3H/ztoOPY1wfchiCv8P5l/o1zG2NDnoUDHRfy7Tclqe80FlPZHF16
        Y2+2ZdFzt+Hmg0U9S5IAqTnusvrYazbEx/+K7WZAXkVf/IxHh4HABKF2uOr9X8dP5+MmT+4f
        kTglNNc5S7wPtTj6tbkMlPrXfL1zpMnn9L70J7kzOU5irjJM5u6MKZSyf7ikiz9OAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7qzpcvjDSaeUbBY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeHI2p+Ape0XLm2usDYx72boYOTkkBEwk
        rk7tYO1i5OIQEljKKHF95VkghwMoISWxcm46RI2wxJ9rXWD1QgJPGSVudZSD2GwCjhL9S0+A
        9YoI7GeSuHThPguIwyxwmFHi8rp1TCBVwgKJEo+//AGzWQRUJfZtu8oOYvMKWEvM/XYY6gp5
        ifbl28FsTgEbiZOLtkFts5Zo/TiXFaJeUOLkzCcsIMcxC6hLrJ8nBBLmF9CSWNN0nQXEZgYa
        07x1NvMERqFZSDpmIXTMQlK1gJF5FaNIamlxbnpusaFecWJucWleul5yfu4mRmBEbjv2c/MO
        xksbgw8xCnAwKvHwChwojRdiTSwrrsw9xCjBwawkwut09nScEG9KYmVValF+fFFpTmrxIUZT
        oDcnMkuJJucDk0VeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZG
        7oNNc+cb+pyfEXbe5OUKtqg0u2qlS3r3U6+xLl6yaFr4Dq/yb4dMO7e8PXfpI88Z+2Vtr/Oq
        Q18YLllRvifxjMr3DRL3WM9NjDp529tCMerAud3yFr4/qr7MOnGzNHf/FF2vDqOzeTsmsucs
        bTvV++tsW4wB4zSJtUKtSq5lT5yv+omsnhD2UImlOCPRUIu5qDgRAL7qImTeAgAA
X-CMS-MailID: 20201002122251eucas1p26b59b6a574f78200d0c696dd1aacc140
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201002122251eucas1p26b59b6a574f78200d0c696dd1aacc140
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201002122251eucas1p26b59b6a574f78200d0c696dd1aacc140
References: <20201002122243.26849-1-l.stelmach@samsung.com>
        <CGME20201002122251eucas1p26b59b6a574f78200d0c696dd1aacc140@eucas1p2.samsung.com>
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


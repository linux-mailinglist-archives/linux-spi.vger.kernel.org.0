Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF33280289
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 17:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbgJAPWx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 11:22:53 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40873 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732681AbgJAPWv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 11:22:51 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201001152249euoutp01fe94139d48797c52d2bd6b4995f81cb4~555UAzFKy2712227122euoutp01Y
        for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2020 15:22:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201001152249euoutp01fe94139d48797c52d2bd6b4995f81cb4~555UAzFKy2712227122euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601565769;
        bh=+RhGw1aBvT/TFJWvkjxUmVoP7hLaAZ8E8m5e3M8QeyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMthWRY3T+6jsz5IrxrbH31WcxEeUoyGrigEM/q634Kg/tPwVsc7IB5jczw3Kw4zo
         PG3PFW5rqb9t+gMH0I9b6qFcWhXjTr63Si5a0wV+FRTvx2ASkXdKCyPCWNx1fZmV3/
         gPvhMHvons5HEWUovJiS2sxn6im+aVqQOMEu6PDo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201001152249eucas1p2a8d25d31e37e9de575a04164d63354ae~555Tk1Pms2407924079eucas1p2I;
        Thu,  1 Oct 2020 15:22:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 59.2F.06456.944F57F5; Thu,  1
        Oct 2020 16:22:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201001152248eucas1p132a63f588f62d902879322ebadd67173~555TRY1gd0137901379eucas1p1o;
        Thu,  1 Oct 2020 15:22:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201001152248eusmtrp1bbb5a920e4e336c568a84ae502568476~555TQtt1-2671626716eusmtrp1j;
        Thu,  1 Oct 2020 15:22:48 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-4b-5f75f44983c0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.A5.06314.844F57F5; Thu,  1
        Oct 2020 16:22:48 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201001152248eusmtip1c2222e55fb3d01f3e8a527901003c2e4~555TEpvrl2696126961eusmtip1L;
        Thu,  1 Oct 2020 15:22:48 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 RESEND 7/9] spi: spi-s3c64xx: Ensure cur_speed holds
 actual clock value
Date:   Thu,  1 Oct 2020 17:21:46 +0200
Message-Id: <20201001152148.29747-8-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001152148.29747-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+Xa2c47i9DgXvthFHAUpOBMrDqmRZjH/6kYYZdnMg5PclB1n
        aoFmqGWmqVi2pKQsRcrLvF8QndFK04FBaqk51LwheSUVyzweI/973u/9vc/7vPCRmKRG5ERG
        aGIYrUYZKcOthbXvV8zugYu6kAOPDAT9cnlcQFfml4voPMsoTmeNTGO02VxB0P3GEkQbRr6I
        6M+NBTidb24R0Lfn+gn67btBgi5tXEPHbBS9RfOYokE/SCgMpfdwRVVRoiKzuhQpFgx7TuMX
        rX3CmMiIWEbrcfSqtcpkfo2i1/G4pcY0LAlNidIRQQJ1EFZ2pCMrUkKVIBjqck9H1ht6EUHm
        r2IRXywgmLVMCziK47M7LEK+UYygKm+V4ItxBM3LA4ijcMoPsl592ByXUnUCyF4wC7kGRukg
        o8GIpyOSdKCCYeJrHCeF1D6YWAngCDHlDWtLzwl+mTOkFdfhnLaifKA7ux3nGXv4+GR009GO
        coM3yb1b7s5wp+Ypxs8OEdDUFM7rACj7PoN47QBTpuot/13QmZsh5CIAlQi5OYe5xEBlIKgt
        WBbyjDcMdK9uJsYoVyhv9OBxP5g1+/LSFvpm7PkAtpBT+xjjn8VwN1XCe+yFsqzmLT8neDBV
        gh4imX7bKfpt8fX/VxUirBQ5MjpWHc6wnhrmhpxVqlmdJlx+LUptQBufqfOPab4eLfWEGhFF
        IpmNWGXUhUhEylg2Xm1EQGIyqdi/q/OKRBymjE9gtFEhWl0kwxrRTlIocxR7vZi8LKHClTHM
        dYaJZrT/ugLSyikJadpCbLx6mLDfXir5D4XUBSusN4amoAR3//vrFrvowSA3+Ug3Cp4Y6xo9
        YXPmXIdD6thx/eScy5Fo07ihMnB//6eZ5OHqPt+zPysO+Reww+1BzxLOn6o0JY8SytVbQ99a
        UopbXOnW1uALc2fN0oXdResNze156ptyy8mZS1FtRTIhq1J6umFaVvkX8CCHJEgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7oeX0rjDf5161ss/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZLVbt+sPo
        wONxfcknZo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZ
        WlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlHD+/jLHgP1vF113tzA2Mr1i7GDk5JARM
        JCaeesjSxcjFISSwlFFi96r7QA4HUEJKYuXcdIgaYYk/17rYIGqeMkrc7pzGDJJgE3CU6F96
        ghUkISKwn0ni0gWQZk4OZoFyiUuznrOD2MICURKPV+xgBxnKIqAq8eKnC0iYV8Ba4s/X+ewQ
        C+Ql2pdvZwOxOQVsJM5NPAxmCwnkSuzefZQNol5Q4uTMJ2C3MQuoS6yfJwQS5hfQkljTdB1q
        q7xE89bZzBMYhWYh6ZiF0DELSdUCRuZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgRG57djP
        zTsYL20MPsQowMGoxMMrcKA0Xog1say4MvcQowQHs5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWH
        GE2BvpzILCWanA9MFnkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODil
        GhgTtsZsE2/60f6nz/z6+mmBz2qvVWn/vvY1Szt3aYPI4vwgp5IlHM8TNi1dMe3oi6hc2zN7
        JV+3Tv0vmBQ479LD+v/Fzm7hVUvWrmI9PG8xf7J3+zFZeUuNeTnLWVeovTrU6KARVsYpPP3H
        xj82v8/Me+r7K2H147lanNt2V2+c9z99RUwBN5evEktxRqKhFnNRcSIAweqE8t4CAAA=
X-CMS-MailID: 20201001152248eucas1p132a63f588f62d902879322ebadd67173
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201001152248eucas1p132a63f588f62d902879322ebadd67173
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201001152248eucas1p132a63f588f62d902879322ebadd67173
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <20201001152148.29747-1-l.stelmach@samsung.com>
        <CGME20201001152248eucas1p132a63f588f62d902879322ebadd67173@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Make sure the cur_speed value used in s3c64xx_enable_datapath()
to configure DMA channel and in s3c64xx_wait_for_*() to calculate the
transfer timeout is set to the actual value of (half) the clock speed.

Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 02de734b8ab1..89c162efe355 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -626,6 +626,7 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 		ret = clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
 		if (ret)
 			return ret;
+		sdd->cur_speed = clk_get_rate(sdd->src_clk) / 2;
 	} else {
 		/* Configure Clock */
 		val = readl(regs + S3C64XX_SPI_CLK_CFG);
-- 
2.26.2


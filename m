Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB1B24DE72
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 19:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgHURae (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 13:30:34 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38790 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgHUQOL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Aug 2020 12:14:11 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200821161406euoutp021d3a89375f1477e0662b8e0f3e058b4a~tVJY0ek9R0696006960euoutp02B
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2020 16:14:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200821161406euoutp021d3a89375f1477e0662b8e0f3e058b4a~tVJY0ek9R0696006960euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598026446;
        bh=KeqMlAnQDioCCu8vW3lN/TARMJriFxWP6OI28/BAWlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aScxBX/H9Dp1x6jyam5vwzJDJJr3efXztBr2k+/4S3luCx/mVnzSN2iZ0mbxKpwnf
         2wFtk4lJkrvg+2kWZYhlNi6DnGECYvV1Ws8OCVyx2fdkC6aR18A/ITSzkd/bmsPy2E
         p+g1vfFFRKzVt7yFLdAYcVkFxGX5iL3WVM7XeU6I=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200821161406eucas1p2111ed4bdeb3a760d71a878cfd0798d39~tVJYJCXCm1870518705eucas1p2l;
        Fri, 21 Aug 2020 16:14:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A1.B2.06318.EC2FF3F5; Fri, 21
        Aug 2020 17:14:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200821161405eucas1p20aad659cd41bc4f56d5123d3c63394f0~tVJXtZ90P1823418234eucas1p2h;
        Fri, 21 Aug 2020 16:14:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200821161405eusmtrp1c7883aee9cc58d774fe9cd425768a4ca~tVJXsxwz-1179011790eusmtrp13;
        Fri, 21 Aug 2020 16:14:05 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-d0-5f3ff2ce3dbb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id ED.A9.06017.DC2FF3F5; Fri, 21
        Aug 2020 17:14:05 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200821161405eusmtip1fbfb185c6d98c1845c601bf4c1ed7cdd~tVJXevJ1R1633816338eusmtip1J;
        Fri, 21 Aug 2020 16:14:05 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 2/9] spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for
 Exynos3250
Date:   Fri, 21 Aug 2020 18:13:54 +0200
Message-Id: <20200821161401.11307-3-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821161401.11307-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nZOS5nZ5vh2wqFlUGCWihyItEMf4xIMPoTYdnSg5o6ZcdZ
        U8oblBNvaJJNMfGCyy6rpdPMVJZlJk3zkkkpeEFLDUwzTEvTnUn+e97vubzvAx+JSUy4jIxR
        JTFqlTJOLhDyzW9+93paFwPDj+inCLp6ZYZHPy014nTJ+JSALpicw+je3icEPWIxINo0+RGn
        B1rKBXRpbxuPzvgxQtCPOkeJE7sUwzWLmMJUrxMontWkKfIb6pFiyeQaip8X+kcycTHJjNo7
        4JIwuml1EE+sFFyrHXtApCM9noMcSKB8YcCgQzlISEooA4LMyhqMG34iaF/L5nHDEoKNETN/
        29L+edpO1CEYmqrFuWEGQb9undhSCaggKKh9ayOcqUIejFvnBVsERmkg97nFhqXUOTD+XbPF
        8il3aH71Gm1hEXUcvnRsENw6N7hV12TTO1D+0NWfiXMaMXTfnbJ5d1Me8DBzmM/lu0FWY5mt
        BFBWAj505iMuKBh+9c3ZQ6Uw29Vgx/uhpzh300xu4jQoLvLjvLkIzOUr9s6bB1lXBVsajDoM
        xhZv7jkIht7peJzVCT59F3MnOEGR+Q7GPYsg+6aEUx+ExwWt9kAZ5M0aUCGS63eU0e8ooP+/
        qxJh9ciF0bDxUQzro2KuerHKeFajivKKSIg3oc2f1LPetdyM2v5ctiCKRHJH0YolMFyCK5NZ
        bbwFAYnJnUUn3/dclIgildoURp0QrtbEMawF7SP5cheRT9W3CxIqSpnExDJMIqPeZnmkgywd
        NYhjB5eMEyWpGcslCdUT189aKcm9G2Ed6f7mtqyxUBkbqu8T+0j9qiYP0RGu9HJYdEkepq06
        FYDRsoX0kAqiJrl7tHbxyoS7WRWysKY95ojvmZ5Wo/nZF5638/LDvlpOS6GCeOlrQGfClQf2
        lrUuNN5XpBxISI0NbtKM9cn5bLTyqAemZpX/AEFpOvtFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xu7pnP9nHG6xcqmyx+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsb2X1dYCxawVSy9t5q9gXEWaxcjJ4eEgInE/tvPmEBsIYGl
        jBK934HiHEBxKYmVc9MhSoQl/lzrYuti5AIqecoosXPCdnaQBJuAo0T/0hOsIAkRgRlMEk9u
        TAYbyixQLnFp1nN2kEHCAmESjxbWg4RZBFQldhw+yghi8wpYS9w58J8dYoG8RPvy7WwgNqeA
        jcTxS02sEPdYS2xbfJkFol5Q4uTMJywgI5kF1CXWzxMCCfMLaEmsabrOArFVXqJ562zmCYxC
        s5B0zELomIWkagEj8ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzA2Nt27OeWHYxd74IPMQpw
        MCrx8P44ZB8vxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOMpkBvTmSWEk3O
        B6aFvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjDp+/Ku9ypme
        Ch8/lPeWI3bKgYNC3yM2CahPjOw3Ntl54LyBsl//1eX96c6niprOd1/u4W67NP23psz7Bs+A
        GmXWB53af7mWbKq93b53506rJCluzk2ez/efaTU44vs1+6y0j3J5+/RvWZ83nSoRlXDzesCv
        eP5p8D6DuDT2jl9B13wb439cUGIpzkg01GIuKk4EAIuL3bjTAgAA
X-CMS-MailID: 20200821161405eucas1p20aad659cd41bc4f56d5123d3c63394f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200821161405eucas1p20aad659cd41bc4f56d5123d3c63394f0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200821161405eucas1p20aad659cd41bc4f56d5123d3c63394f0
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <CGME20200821161405eucas1p20aad659cd41bc4f56d5123d3c63394f0@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This and the previous patch fix issues with DMA transfers bigger than
512 bytes on Exynos3250. Without the patches such transfers fail.

The vendor kernel for ARTIK5 handles CS in a simmilar way.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
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


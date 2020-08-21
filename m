Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D9E24DE5E
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 19:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgHUR3a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 13:29:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38847 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgHUQOV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Aug 2020 12:14:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200821161409euoutp02b6dd4d1298aa2bc86ef810107bc83216~tVJbHn43n0536405364euoutp02q
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2020 16:14:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200821161409euoutp02b6dd4d1298aa2bc86ef810107bc83216~tVJbHn43n0536405364euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598026449;
        bh=f9ZoaiPzWLgD51UeFyh+Y/m4lqI80t9LqJw5EDwV3o4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ff3yudBMCM3oSkyke0r7TiTSjNobWWAzURQDgSfqlAAEyvpq3nE09kvfhmHJcmRB9
         u+HoqkvM1vJqB05iAqPsIl+oJ/D5RjcIV5r9MGjcEPzLDjT2fN2M1unG8gwRaY/27Z
         0V/zue6jR1XOxWQ2HUg+Djr+ME2ya/9WbGFM/+t0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200821161408eucas1p2f219698ed28e48498174566d657bb905~tVJaP7GNV1780817808eucas1p2i;
        Fri, 21 Aug 2020 16:14:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 59.D9.06456.0D2FF3F5; Fri, 21
        Aug 2020 17:14:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200821161408eucas1p196aa4b954b3d19ad1b89a48dbbe41fbc~tVJZ9b1760797107971eucas1p1Y;
        Fri, 21 Aug 2020 16:14:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200821161408eusmtrp2a6fdfcf29771ff7b7170690ca3f78348~tVJZ80IoL2998229982eusmtrp2i;
        Fri, 21 Aug 2020 16:14:08 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-da-5f3ff2d0505d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7D.17.06314.0D2FF3F5; Fri, 21
        Aug 2020 17:14:08 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200821161407eusmtip2b56ff438e1c05e1bcd9f07b3c42427d2~tVJZyH58K3023630236eusmtip2U;
        Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 9/9] spi: spi-s3c64xx: Turn on interrupts upon resume
Date:   Fri, 21 Aug 2020 18:14:01 +0200
Message-Id: <20200821161401.11307-10-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821161401.11307-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djP87oXPtnHGxy9L2ax+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV8by2UvZCraxVfz4N4mpgXEH
        axcjJ4eEgInE+iuzmLoYuTiEBFYwSly+v4UFwvnCKDF7z2qwKiGBz4wS/6d6w3Qcv7udHaJo
        OaPEnWczWCGc54wSWz7OYAKpYhNwlOhfegIsISIwgUni4bk3bCAJZoFSiZ6dh8BsYQEPicNf
        tzGC2CwCqhKH73WBxXkFbCQ2ntzJDrFOXqJ9+XawOCdQ/PilJlaIGkGJkzOfsIDY/AJaEmua
        rrNAzJeXaN46mxlksYTAOXaJnVM/MUIMcpFYMvMo1FBhiVfHt0DZMhL/d84HupoDyK6XmDzJ
        DKK3h1Fi25wfLBA11hJ3zv1iA6lhFtCUWL9LH6LcUeLCBA8Ik0/ixltBiAv4JCZtm84MEeaV
        6GgTgpihIrGufw/UPCmJ3lcrGCcwKs1C8sssJPfPQli1gJF5FaN4amlxbnpqsWFearlecWJu
        cWleul5yfu4mRmA6Ov3v+KcdjF8vJR1iFOBgVOLh/XHIPl6INbGsuDL3EKMEB7OSCK/T2dNx
        QrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTBucrlfzu7y
        3jet+GfE9n0Hn82bEOP5i3/bf94de71NLh6yjvnw7Om0KZ8Obl424fiU6M9n3zFesgiZM3O6
        hZUsR4m53tupaV1bYk7UFlyu6pU+8ODDnh+WK9RfupvuLPqc47E6fX5N57GacyafmXuqft/7
        odWZOn9m1LSqS3t/Tn/hs2u/Xs0NASWW4oxEQy3mouJEAA7f2j1DAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7oXPtnHG/xYy2yx+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsby2UvZCraxVfz4N4mpgXEHaxcjJ4eEgInE8bvb2bsYuTiE
        BJYySqxZtoqxi5EDKCElsXJuOkSNsMSfa11sILaQwFNGiV2bC0BsNgFHif6lJ1hBekUEZjBJ
        PLkxGWwos0C5xKVZz9lBbGEBD4nDX7cxgtgsAqoSh+9BDOIVsJHYeHInO8QCeYn25dvB4pxA
        8eOXmlghlllLbFt8mQWiXlDi5MwnLCC3MQuoS6yfJwQS5hfQkljTdJ0FYq28RPPW2cwTGIVm
        IemYhdAxC0nVAkbmVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHRt+3Yz807GC9tDD7EKMDB
        qMTD++OQfbwQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAr05kVlKNDkf
        mBjySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwGkyUW3x6S/vN
        mA6NqN039eu3vVQQO73dwHp+lIn60dN+cpGim4w2uD95o/4kWHJ/fiQT614GP/EfXbsZue9n
        vzmnZPi74sYLXZFPO6Yy/agMun3NZLnUj9JDEa/K+6PvV319m/gzd8m9yL7k2aEsqdvjphX9
        f7G314ll5oxfM0+kzUl+fVLpqRJLcUaioRZzUXEiAMi6GibUAgAA
X-CMS-MailID: 20200821161408eucas1p196aa4b954b3d19ad1b89a48dbbe41fbc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200821161408eucas1p196aa4b954b3d19ad1b89a48dbbe41fbc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200821161408eucas1p196aa4b954b3d19ad1b89a48dbbe41fbc
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <CGME20200821161408eucas1p196aa4b954b3d19ad1b89a48dbbe41fbc@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

s3c64xx_spi_hwinit() disables interrupts. In s3c64xx_spi_probe() after
calling s3c64xx_spi_hwinit() they are enabled with the following call.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ea5a22dec53d..53e3581bcd7b 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1378,6 +1378,10 @@ static int s3c64xx_spi_runtime_resume(struct device *dev)
 
 	s3c64xx_spi_hwinit(sdd);
 
+	writel(S3C64XX_SPI_INT_RX_OVERRUN_EN | S3C64XX_SPI_INT_RX_UNDERRUN_EN |
+	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
+	       sdd->regs + S3C64XX_SPI_INT_EN);
+
 	return 0;
 
 err_disable_src_clk:
-- 
2.26.2


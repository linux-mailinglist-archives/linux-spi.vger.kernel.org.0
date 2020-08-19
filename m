Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF87F249E1F
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgHSMf1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:35:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60632 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgHSMc2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:32:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200819123227euoutp02fbe7be59e686979f1cdd80b5f2896e73~sq1SIZENM1326013260euoutp02x
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200819123227euoutp02fbe7be59e686979f1cdd80b5f2896e73~sq1SIZENM1326013260euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597840347;
        bh=wC+kZeBMIoP/vOqNt2jjadNVY2MvENAt8cJunKTInRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBhGtnagLkJlblWP2Y9djgqiizJo+o4jMWhyXa2SlDqpVbJhzsd0GbWgLb2ewct52
         bGruvnobyWaiWcHmQrvT85FoT47GKd6WMGvn6Y9Cdyaw2Mm5KqbMbIC7PyrR5rCVDQ
         Hj26RjX8ijQA1dIqQWxu7thbv0UJuUCyrcSNccVo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200819123227eucas1p1a7cadbb2c9d686c1f4c5678862540fb5~sq1R1ygdz1243812438eucas1p14;
        Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 03.FC.05997.ADB1D3F5; Wed, 19
        Aug 2020 13:32:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200819123226eucas1p2f4be625abd7ddaac2f09bdf94395346b~sq1Rb96SQ2958129581eucas1p2V;
        Wed, 19 Aug 2020 12:32:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200819123226eusmtrp2ca36a987bd216452370f532caebeaea7~sq1RV57i72933229332eusmtrp2T;
        Wed, 19 Aug 2020 12:32:26 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-3c-5f3d1bdac06f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.DF.06314.ADB1D3F5; Wed, 19
        Aug 2020 13:32:26 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819123226eusmtip13c1446247c06b56af07ffb8180d64cf7~sq1RL5s-c3145531455eusmtip1M;
        Wed, 19 Aug 2020 12:32:26 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH 2/8] spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for
 Exynos3250
Date:   Wed, 19 Aug 2020 14:32:02 +0200
Message-Id: <20200819123208.12337-3-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819123208.12337-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7q3pW3jDU6+ZLRY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yO3B7XF/y
        idlj06pONo/NS+o9+rasYvT4vEkugDWKyyYlNSezLLVI3y6BK6Px6xX2gmssFdeez2BvYPzB
        3MXIySEhYCJxeOpLli5GLg4hgRWMEvevNzOCJIQEvjBKfPkUCpH4zChxpmUfC0zH5tffWCES
        yxklLi8/ywbR8ZxR4sq1bBCbTcBRon/pCbAiEYEJTBIPz70BK2IWKJXo2XkIzBYWCJXovnoO
        7A4WAVWJawfvsYPYvALWEksvTIS6T16iffl2sHpOARuJh7+msEHUCEqcnPkE7CJ+AS2JNU3X
        WSDmy0s0b53NDLJYQuAcu8ShlTtYIQa5SDQtuMAIYQtLvDq+hR3ClpH4v3M+UxcjB5BdLzF5
        khlEbw+jxLY5P6Betpa4c+4XG0gNs4CmxPpd+hBhR4mPR3YyQ7TySdx4KwhxAp/EpG3TocK8
        Eh1tQhDVKhLr+vdADZSS6H21gnECo9IsJM/MQvLALIRdCxiZVzGKp5YW56anFhvlpZbrFSfm
        Fpfmpesl5+duYgSmo9P/jn/ZwbjrT9IhRgEORiUe3opz1vFCrIllxZW5hxglOJiVRHidzp6O
        E+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoFRUqbt5scV
        l65sfPTp/R2/8qyOdawK+49e0rq6ZsPvpTu2ixVesrdgu/vRXD02IGnzotVnORJKxPsrL29g
        5/4V1fVoWlVIZMHG3/MeWG/T5ThuK1O/5bPo9jWHPtkL7WJeJ7nwz8I53Dyi07drN4f7FG3d
        kb+P7ZVKmzJjccLT+X2TG17XfeucrMRSnJFoqMVcVJwIAJKDEfNDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7q3pG3jDb7+lrFY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yO3B7XF/y
        idlj06pONo/NS+o9+rasYvT4vEkugDVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL6Px6xX2gmssFdeez2BvYPzB3MXIySEhYCKx+fU31i5GLg4h
        gaWMElf23QdyOIASUhIr56ZD1AhL/LnWxQZR85RRYuaR9awgCTYBR4n+pSfAmkUEZjBJPLkx
        GSzBLFAucWnWc3aQQcICwRJTHxmChFkEVCWuHbzHDmLzClhLLL0wEeoIeYn25dvZQGxOARuJ
        h7+mgNlCQDVdixcyQdQLSpyc+YQFZCSzgLrE+nlCIGF+AS2JNU3XWSC2yks0b53NPIFRaBaS
        jlkIHbOQVC1gZF7FKJJaWpybnltsqFecmFtcmpeul5yfu4kRGH3bjv3cvIPx0sbgQ4wCHIxK
        PLwV56zjhVgTy4orcw8xSnAwK4nwOp09HSfEm5JYWZValB9fVJqTWnyI0RTozYnMUqLJ+cDE
        kFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgZFT5k6TrAxH+rX9
        x7cl7Y32YvZ+rmKl8KkrbPl3C9MrRnt9FT9MWZeXE+M94ZDfrLd39xtt8uGveHn808buDd1i
        yZt+vDd9ynrCKHs6V808z/Lck5lrF4sqTL706+GPTmbXvpfXQv7ZXs/huPFo8iH7payWpmKu
        GvnXQ7tuVjh+MQ5elFtUY6nEUpyRaKjFXFScCAAN5Rja1AIAAA==
X-CMS-MailID: 20200819123226eucas1p2f4be625abd7ddaac2f09bdf94395346b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200819123226eucas1p2f4be625abd7ddaac2f09bdf94395346b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819123226eucas1p2f4be625abd7ddaac2f09bdf94395346b
References: <20200819123208.12337-1-l.stelmach@samsung.com>
        <CGME20200819123226eucas1p2f4be625abd7ddaac2f09bdf94395346b@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index fb5e2ba4b6b9..8fe44451d303 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1372,6 +1372,7 @@ static struct s3c64xx_spi_port_config exynos4_spi_port_config = {
 	.tx_st_done	= 25,
 	.high_speed	= true,
 	.clk_from_cmu	= true,
+	.quirks		=  S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
 static struct s3c64xx_spi_port_config exynos7_spi_port_config = {
-- 
2.26.2


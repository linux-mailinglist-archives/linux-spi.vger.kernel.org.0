Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3DC28126C
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbgJBMXa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 08:23:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54944 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387880AbgJBMWy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 08:22:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201002122252euoutp01b4dbe078f842b2b1dd5368d6e1bae30b~6LFez-7EF0677506775euoutp01B
        for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201002122252euoutp01b4dbe078f842b2b1dd5368d6e1bae30b~6LFez-7EF0677506775euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601641372;
        bh=GKVD4VWm7Cvdyywwusf1QceeQU4MFWyu++yW9esxCI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sPXSDLivzlBAoP4u/0req4FO5fQBvD1f7WIEeDvB34nf9JdG4hbib/CAQ9/6VDhPm
         4rUF25pss5LiKEwO7fzgKcIMq3RKJ24MCpKG/Oonjlu21qmBsND4zZWiYUG+OLhqsd
         TUW+s0mJSL/s6fYsrFy3+eao9wrdBq7uZjtKW5xo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201002122252eucas1p272f6377959e656acbf34bdf10f758c0e~6LFeav30l1010810108eucas1p20;
        Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 81.42.06456.C9B177F5; Fri,  2
        Oct 2020 13:22:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201002122251eucas1p235d6797ae11f075a09841be64dc65236~6LFeGki8F2502325023eucas1p2G;
        Fri,  2 Oct 2020 12:22:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201002122251eusmtrp2141758dc5face4f2c7fb60924e8976c5~6LFeF48ra0225802258eusmtrp2I;
        Fri,  2 Oct 2020 12:22:51 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-92-5f771b9caf6d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FD.B0.06017.B9B177F5; Fri,  2
        Oct 2020 13:22:51 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201002122251eusmtip10ba9a7279409444c21952bae83208a39~6LFd8yOpk0635906359eusmtip1O;
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
Subject: [PATCH v3 2/9] spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for
 Exynos3250
Date:   Fri,  2 Oct 2020 14:22:36 +0200
Message-Id: <20201002122243.26849-3-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002122243.26849-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djP87pzpMvjDSbM5LVY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKuPrnPWPB
        draKyz8vsDcwbmLtYuTkkBAwkdg37xVLFyMXh5DACkaJG5cnMUE4Xxglnh76zwzhfGaUeH/n
        FFzLxgm/GSESyxklpjQsYwZJCAk8Z5RYtkgexGYTcJToX3qCFaRIRGA7k8TEz+fBljALHGWU
        2PzgKgtIlbBAhMTtRf1sIDaLgKrEk1mzwFbwClhLXJv0gxlinbxE+/LtYDWcAjYSJxdtY4Oo
        EZQ4OfMJ2Bx+AS2JNU3XwWxmoPrmrbPB7pYQuMcusfzWRHaIQS4S0/++ZoKwhSVeHd8CFZeR
        +L9zPlCcA8iul5g8yQyit4dRYtucHywQNdYSd879YgOpYRbQlFi/Sx8i7Cix89gjRohWPokb
        bwUhTuCTmLRtOjNEmFeio00IolpFYl3/HqiBUhK9r1YwTmBUmoXkmVlIHpiFsGsBI/MqRvHU
        0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwDR1+t/xTzsYv15KOsQowMGoxMObcag0Xog1say4
        MvcQowQHs5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0tSC2C
        yTJxcEo1MOpnccsnLnnzQq6zfsXrZwHqjS/N5vdIBLz7EPBowYSo4GVyoiJtHbLnK15+sOF7
        VqCuvq7C+oPiDX+B8B3JF20+9Vl/mVtzikd6WkQBoxqHx5Tdz4PjXqmlb/FxVDfnT9MP+Liq
        ZHHd2V0pGw2+B7K7RNjvLyy+FybL93Xzy3s/nQ0vFv9RUGIpzkg01GIuKk4EAKOWIDlPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7qzpcvjDb5uN7VY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuPrnPWPBdraKyz8vsDcwbmLtYuTkkBAw
        kdg44TdjFyMXh5DAUkaJv69OsXUxcgAlpCRWzk2HqBGW+HOtiw2i5imjxLFVd8Ga2QQcJfqX
        nmAFSYgI7GeSuHThPguIwyxwmFHi8rp1TCBVwgJhEl+6e9lBbBYBVYkns2aBdfMKWEtcm/SD
        GWKFvET78u1sIDangI3EyUXbwGwhoJrWj3Oh6gUlTs58wgJyHbOAusT6eUIgYX4BLYk1TddZ
        QGxmoDHNW2czT2AUmoWkYxZCxywkVQsYmVcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERuW2
        Yz+37GDsehd8iFGAg1GJh1fgQGm8EGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNS
        iw8xmgK9OZFZSjQ5H5gw8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFx
        cEo1MLaJ5W5JnLBb/If+w4pY6bsVKSoiE9eYhf9s1PaYdsNUeVKY+p3LcS5uS0Le9gvc3sfB
        ta0o4zrL186SxnPcIrobrVy3zQmYOOtcp8HmmaGL+c+uCl0bzHs559HzslTZk/ytfU0friio
        SVmfeXn22dODp6y4bA4Jv5CT84rY90Jx6YEK+Z5pF5RYijMSDbWYi4oTAf5vxongAgAA
X-CMS-MailID: 20201002122251eucas1p235d6797ae11f075a09841be64dc65236
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201002122251eucas1p235d6797ae11f075a09841be64dc65236
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201002122251eucas1p235d6797ae11f075a09841be64dc65236
References: <20201002122243.26849-1-l.stelmach@samsung.com>
        <CGME20201002122251eucas1p235d6797ae11f075a09841be64dc65236@eucas1p2.samsung.com>
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
index 26c7cb79cd78..4a9ca9a99857 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1379,6 +1379,7 @@ static struct s3c64xx_spi_port_config exynos4_spi_port_config = {
 	.tx_st_done	= 25,
 	.high_speed	= true,
 	.clk_from_cmu	= true,
+	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
 static struct s3c64xx_spi_port_config exynos7_spi_port_config = {
-- 
2.26.2


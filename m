Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D467281256
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbgJBMXE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 08:23:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55010 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387908AbgJBMW6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 08:22:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201002122256euoutp013906925c45a12a13efc79795b6a63606~6LFh8f7xO0677506775euoutp01H
        for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2020 12:22:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201002122256euoutp013906925c45a12a13efc79795b6a63606~6LFh8f7xO0677506775euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601641376;
        bh=XzneccWbW6+CEoFf1aTmHjTyFh+KVtRq/ZUrB/a8b5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVFdCIh0o+oN9hEVa9UU5pcEJ11xpwHZK3x1CmR//SuJDqxXWPwhUMXvAFXwffKlO
         mkluil/+ggiEjEmzT/cHSBpK0MhBLx3u8hh/yds/cd6TzwsBs1xYK7LzgR1JTSn1sC
         mJxT5sKjwMnpgKz3MwDOUo61kKqdEuHFkvj/XyuY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201002122255eucas1p29804342cb1e06a80434922e3a3d9d6fc~6LFhiKCSK1013510135eucas1p2r;
        Fri,  2 Oct 2020 12:22:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 44.42.06456.F9B177F5; Fri,  2
        Oct 2020 13:22:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201002122255eucas1p21976a8ba0566564b79a9dd6f62cd4caf~6LFhQR6Jx1906319063eucas1p2e;
        Fri,  2 Oct 2020 12:22:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201002122255eusmtrp24330bdd13b9ea2ab8f6734720c6d228d~6LFhPq7HJ0225802258eusmtrp2M;
        Fri,  2 Oct 2020 12:22:55 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-9d-5f771b9fff00
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 13.C0.06017.F9B177F5; Fri,  2
        Oct 2020 13:22:55 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201002122255eusmtip11ff21a2427deff936bc232a76845b536~6LFhGZtVQ0581605816eusmtip1h;
        Fri,  2 Oct 2020 12:22:55 +0000 (GMT)
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
Subject: [PATCH v3 7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual
 clock value
Date:   Fri,  2 Oct 2020 14:22:41 +0200
Message-Id: <20201002122243.26849-8-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002122243.26849-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djPc7rzpcvjDbZ1KVss/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZLVbt+sPo
        wONxfcknZo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwRXHZpKTmZJalFunbJXBlTF2fW9DH
        UXFm5k+2BsYnbF2MnBwSAiYSl/6fYe1i5OIQEljBKDH7zho2COcLo8TBUz8YIZzPjBJzDn1g
        hGnZfLSdHcQWEljOKPFsFj9E0XNGif0bIIrYBBwl+peeAJsrIrCdSWLi5/MsIA6zwFFGic0P
        rrKAVAkLhEp83HUcrINFQFWit/UqUxcjBwevgLVE04Y6iG3yEu3Lt4MdyylgI3Fy0TYwm1dA
        UOLkzCdgY/gFtCTWNF0Hs5mB6pu3zmYG2SUhcI9dovvvYbCZEgIuEh+fFkLMFJZ4dXwLO4Qt
        I/F/53yoknqJyZPMIFp7GCW2zfnBAlFjLXHn3C82kBpmAU2J9bv0IcKOEtvuTYZq5ZO48VYQ
        4gI+iUnbpjNDhHklOtqEIKpVJNb174EaKCXR+2oF4wRGpVlIfpmF5P5ZCLsWMDKvYhRPLS3O
        TU8tNsxLLdcrTswtLs1L10vOz93ECExQp/8d/7SD8eulpEOMAhyMSjy8GYdK44VYE8uKK3MP
        MUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwT
        B6dUA2OO5/rF9s9rj0Z4ZZ33Lt7RZCLZuq0m78qttofWd1R7lx/d8Sh8LtvMfxsnBYWLPpq+
        9IE51/znltxTvW7a2VVuXLTsTa3anLqDZYvvVc+NVqn9k61/YcoVDs9v158L9c7hqEnd/VXw
        l19TXu6BJcWKPq9+y714xpm6v9Wjdcm+VIuIPM3jNgVKLMUZiYZazEXFiQBkK4k4TAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7rzpcvjDQ6d5bdY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLmLo+t6CPo+LMzJ9sDYxP2LoYOTkkBEwk
        Nh9tZ+9i5OIQEljKKLF77X8ghwMoISWxcm46RI2wxJ9rXWwQNU8ZJfa27mQFSbAJOEr0Lz3B
        CpIQEdjPJHHpwn0WEIdZ4DCjxOV165hAqoQFgiU6vnezgNgsAqoSva1XmUA28ApYSzRtqIPY
        IC/Rvnw72EWcAjYSJxdtA7OFgEpaP84FW8YrIChxcuYTFpBWZgF1ifXzhEDC/AJaEmuaroNN
        ZwYa07x1NvMERqFZSDpmIXTMQlK1gJF5FaNIamlxbnpusZFecWJucWleul5yfu4mRmBEbjv2
        c8sOxq53wYcYBTgYlXh4BQ6UxguxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4
        EKMp0JcTmaVEk/OBySKvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwen
        VAPjqsLzn6/Jevet6HJ+yzF/avxVnrCKKT/+G9SVmTxML2b8+ufVLCfvZKNrzclfy3YujdXw
        Xv/R/V/v1YUFNzlX82vLbvnF/3iJU+ieuFV/HTniF7Vq7N/JlDS9QIll7sNdFuv65GRbFiy4
        dUqwdUcXt13U49iw00LP50WuOsabxfdyWXG5odpLJZbijERDLeai4kQAd2m5jt4CAAA=
X-CMS-MailID: 20201002122255eucas1p21976a8ba0566564b79a9dd6f62cd4caf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201002122255eucas1p21976a8ba0566564b79a9dd6f62cd4caf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201002122255eucas1p21976a8ba0566564b79a9dd6f62cd4caf
References: <20201002122243.26849-1-l.stelmach@samsung.com>
        <CGME20201002122255eucas1p21976a8ba0566564b79a9dd6f62cd4caf@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Make sure the cur_speed value used in s3c64xx_enable_datapath()
to configure DMA channel and in s3c64xx_wait_for_*() to calculate the
transfer timeout is set to the actual value of (half) the clock speed.

Don't change non-CMU case, because no frequency calculation errors have
been reported.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index f85f40fd608c..0bd3e230350c 100644
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


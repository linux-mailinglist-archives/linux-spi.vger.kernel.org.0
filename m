Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1800424DE6B
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgHURaN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 13:30:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37234 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgHUQOM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Aug 2020 12:14:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200821161408euoutp0133acbac2eacc95d8204ffc251d1e64f4~tVJaJ3TBB2432124321euoutp01M
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2020 16:14:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200821161408euoutp0133acbac2eacc95d8204ffc251d1e64f4~tVJaJ3TBB2432124321euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598026448;
        bh=ELtloJOmnPn+Z5FT9bjX2f4AQc1qGik0EonV1Nsy8yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwT8AwNGH9XHwQ126s0HzoxR/FplwnzZiYl8bpir0rDBe0w99mPAhyTWxlNSLNvQS
         4bSWcEyiBzWgP6DsB45Bnx8XHhORrcmhEEbHbAAd3Jfg1tXLJ6dfTMerCjJphYBie+
         1sfImtpESYeqkACLqVZGwLnmCvbEIKNDcL7hHN8c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200821161407eucas1p1a2d41ca21fb435b7f8245db4846c33a9~tVJZpUPP50799907999eucas1p1g;
        Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D1.AE.05997.FC2FF3F5; Fri, 21
        Aug 2020 17:14:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200821161407eucas1p249e4833b8839f717cc2a496ab43bb8a2~tVJZTohaQ2033420334eucas1p2g;
        Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200821161407eusmtrp22df030d66edc36898d86dff9387529e4~tVJZTB1i42998229982eusmtrp2h;
        Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-c6-5f3ff2cfcec8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AC.17.06314.FC2FF3F5; Fri, 21
        Aug 2020 17:14:07 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200821161407eusmtip20e88d7dc8b87e49bb3c07ed8a38d71a4~tVJZICu6-3023630236eusmtip2T;
        Fri, 21 Aug 2020 16:14:07 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH v2 7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual
 clock value
Date:   Fri, 21 Aug 2020 18:13:59 +0200
Message-Id: <20200821161401.11307-8-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821161401.11307-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfSyUcRzA+91zz3OPm+NxbL5Jtd2yOhuK2LN5N39c/5Q/arUSDk/OuKM7
        RNMIRXphzPK2RbTDvOcurFg3y1tcaXnXEiVKzUvzMiN3j5b/Pt/v7/N9+f32IzFhG25DRiri
        GKVCGi0i+Fztmw29g37ZO/hk4biYrlif49BNhQ04XTA9S9A5Mz8wWq9v5NFjuipEN88M4/SH
        9lKCLtR3cOjbS2M8uq5rikev3NkmfEwlJanvuZKRymVM0lxzj5A8r0yRPGqpQZKV5iMBxGW+
        RzgTHZnAKJ28Qvgy7dx3XmwTkThfbZ2KKvBsRJJAnQZdpnM24pNCqgpBwZAaZ4NVBL9HP/Oy
        kclusIKgujXEwIaC3oG1PUmN4M9iG8EGcwj6OjOMFQTlCznPeoyWFZXLgenBn0YLo4oQbBRV
        cAyWJXUBshvf4gbmUnawsFNGGFhAuUOWph1j5x2FTPULY96E8oDuoTScdSygt2iWa2Bzyh5q
        00aMjO366ZoSzDAMqHEefJtfw9lG/tClqeOwbAkL3S08lm1hp+0Jh32NFMjPc2NrHyDQlq5z
        WccdJgc3CYODUWJoaHdidV9Q5/qzaAajixbsBmaQp32MsWkBZN0Vsj2OQX3Oy71+NvBwoQrl
        IlHxvrsU79u/+P+oMoTVIGsmXiWPYFTOCuaGo0oqV8UrIhzDYuTNaPdD9W93r7ai9q1QHaJI
        JDIVrOu8g4W4NEGVJNchIDGRlcBvoD9IKAiXJt1klDHByvhoRqVDh0iuyFrg8nT+qpCKkMYx
        UQwTyyj/nXJIE5tUxB/qPevuds5WnDzuF1Tusn0/yuFE0fG1ua+JC0GeKYdzpH3vrAM7k880
        OCu90jr6Pl2fTG+ql/06f4ks3nTqDOxxFauXprZcw8d8ljTx1woYt4kMO1ToeTAgNOz1yKth
        mUXtR47zaHmDFvviOSG5JRMnc/Nrr2jNHS62ph/QdShEXJVMesoeU6qkfwFoGQ2ZTAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7rnP9nHGxxrEbVY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW3xu/cfm
        wOMxu+Eii8f1JZ+YPTat6mTz2Lyk3qNvyypGj8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQM
        LS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQytj1/wV6wka3i5UrxBsbFrF2MnBwSAiYS
        J89+B7K5OIQEljJKfPyymbmLkQMoISWxcm46RI2wxJ9rXWwgtpDAU0aJf81FIDabgKNE/9IT
        YL0iAjOYJJ7cmAzmMAvMZpTo/9HMAlIlLBAsMengXkYQm0VAVeLV/wVgk3gFrCU6tu5ihtgg
        L9G+fDtYnFPARuL4pSZWiG3WEtsWX2aBqBeUODnzCQvIccwC6hLr5wmBhPkFtCTWNF0HK2EG
        GtO8dTbzBEahWUg6ZiF0zEJStYCReRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgRG479nPz
        DsZLG4MPMQpwMCrx8P44ZB8vxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM
        pkBvTmSWEk3OByaLvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFIN
        jBbdB+VM//bwN3P3b9L7qrb34r2tDVprt2b3y4TpWR81vPpnnb/epnsTLV3rXAp3VwoeLDt5
        wTvr03WXQzu+rdz7375JuTR2X33lidntntcCny1PEvT7umHis1t3/byiGw9Y3nWP+7Tyydl0
        Q+XMN/V/T8z6FPts7noZy44qk2gvTiaXDzaTw5VYijMSDbWYi4oTAcS6UfjeAgAA
X-CMS-MailID: 20200821161407eucas1p249e4833b8839f717cc2a496ab43bb8a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200821161407eucas1p249e4833b8839f717cc2a496ab43bb8a2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200821161407eucas1p249e4833b8839f717cc2a496ab43bb8a2
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <CGME20200821161407eucas1p249e4833b8839f717cc2a496ab43bb8a2@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

cur_speed is used to calculate transfer timeout and needs to be
set to the actual value of (half) the clock speed for precise
calculations.

Cc: Tomasz Figa <tfiga@chromium.org>
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


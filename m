Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78669280292
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 17:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbgJAPXF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 11:23:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41216 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732672AbgJAPWv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 11:22:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201001152250euoutp02ea7dbb571d5b4480c40e40f10433e839~555UwA-ND2409324093euoutp02N
        for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2020 15:22:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201001152250euoutp02ea7dbb571d5b4480c40e40f10433e839~555UwA-ND2409324093euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601565770;
        bh=tbbrF9drxp3pC+sI39T9dolcDVWc06CYhVYWFYzZKJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glDkB4uR9YmcfihHbkadImGxgNUHe/R8lbGURVk/J3b1+sleSJnhaJEnfogZw3h7i
         BGQ4q/qHpIdcMiDVKFqpFSZAxnyMUa+gKOjH/e6zwtD6CkgQMq6ciUKkPW1pTxj/IV
         dmX9t3dr4S51vktBxD/0w+L4RLFfIcWI6AorW2r4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201001152250eucas1p162a51ed471768b7e38a2ef5c9682dfad~555UXMCq-0403504035eucas1p1V;
        Thu,  1 Oct 2020 15:22:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8A.29.05997.944F57F5; Thu,  1
        Oct 2020 16:22:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201001152249eucas1p165b78adf542a48b38b49cb5e00500e26~555T8naj52388923889eucas1p1U;
        Thu,  1 Oct 2020 15:22:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201001152249eusmtrp159095f80c45780b374022dbabb6274ef~555T8ByB42671626716eusmtrp1l;
        Thu,  1 Oct 2020 15:22:49 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-58-5f75f4495ebf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F7.D5.06017.944F57F5; Thu,  1
        Oct 2020 16:22:49 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201001152249eusmtip2788ed82cb2e3736d5270d8767df6eeee~555TuJjq70082600826eusmtip2_;
        Thu,  1 Oct 2020 15:22:49 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 RESEND 9/9] spi: spi-s3c64xx: Turn on interrupts upon
 resume
Date:   Thu,  1 Oct 2020 17:21:48 +0200
Message-Id: <20201001152148.29747-10-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001152148.29747-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTcRTnf+92dxWn1yl4ME0aFmSlWSJXE0kJWV96fQgKfEy9qORUNmcZ
        5BMy36mUz/Ktw2zma04xk5WZaK5spmYLREU0InKj1ETbdpX89jvn/B7nwCFxwSDXmYxLSGak
        CeJ4IWHNUb3dnDx10SgPP63r86cbN1YwurOig0s/Wlgi6OLF7zit1b7g0XMaBaK7Fj9z6U8D
        NQRdoR3C6Mxfczz6+Rs9j24b2EbnbUQzTeu4qL9KzxN1teUSou6mdFFRTxsSGboOXyFuWgdE
        M/FxKYzUKzDCOnbhVTOWtEbc6X45jTLQCjcPWZFA+YChqdeErUkBpUDwczuXxxZGBPp5I84W
        BgR/n0ygfUn5lg5jB60I5vP3JSsIPuhVuJlFUEFQ3PzOYuxI9WFQYtByzAOckkNBv4YwYwfq
        KlQ3VPLMmEMdhd9LGRbMpwJgua+Wx8a5QU5rn4VvZepPlrwmWI49jFUuWTztKA9oz5rZ83eD
        7N5qy95AfeFBZ1Hd3t4XoLh8E2OxA6yN9uwFuMB4WYFJTJpwOpSV+rLaAgSqmg0OyzkHXye3
        CDMHp45Dx4AX2w4Cg1LDZaW2MPvDnl3BFkpV5Tjb5sOD+wKW7Q7K4sE9Q2coXFOgh0hYdeCY
        qgMHVP3PqkN4G3Ji5DJJDCM7k8Dc9pSJJTJ5QoxnVKKkC5l+anxn1KhGA9uRGkSRSGjDp4bl
        4QKuOEWWKtEgIHGhIz/4/XiYgB8tTr3LSBPDpfJ4RqZBh0iO0Il/tmE1VEDFiJOZWwyTxEj3
        pxhp5ZyBKo99e1qfdDmvcVZ3YuRIZGHajchpV4+Ua9tR8PiaMnTMbzdCvf6xoT0wcCQu44+C
        mbKbUrfX8rFufIbIr180XKKiMjtc8q4HSk/yJ3y9XXcdd5RZqZJsZ79nynv4jrHORx1i365r
        ycFWg/3D3NN8l4f6Q1oEMz4KnVY/HEQLObJYsbcHLpWJ/wGSRJquTwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7qeX0rjDa6ekLFY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeLh/KVPBK7aKzXuvMjYwPmftYuTkkBAw
        kZj+6woTiC0ksJRRYutVmy5GDqC4lMTKuekQJcISf651sXUxcgGVPGWUaF9znw0kwSbgKNG/
        9AQrSEJEYD+TxKUL91lAEswC5RKXZj1nB7GFBfwlPpy5DNbAIqAq8e1JA1icV8BG4un2+ewQ
        G+Ql2pdvB6vhBIqfm3iYDeKgXIndu4+yQdQLSpyc+YQF5DhmAXWJ9fOEQML8AloSa5quQ62V
        l2jeOpt5AqPQLCQdsxA6ZiGpWsDIvIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwIrcd+7ll
        B2PXu+BDjAIcjEo8vAIHSuOFWBPLiitzDzFKcDArifA6nT0dJ8SbklhZlVqUH19UmpNafIjR
        FOjNicxSosn5wGSRVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB
        8YplQpxeTeBHttmTX7QeFfSfvy3pqYZc3qVJWT+WvD3C7aB963Gi4MrpQlXdaWGz7j2wNMni
        jp90d1OMbsHHM10P7zv/d/wY/u63h9JG/2Sx9k9Wzg83XTT7or717r9vTv2Snl0bXv/w7dOJ
        NGXvMPbw/5Ted+nruWOhDnaGXlo5WfGHFrJZKbEUZyQaajEXFScCAPKNMsPeAgAA
X-CMS-MailID: 20201001152249eucas1p165b78adf542a48b38b49cb5e00500e26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201001152249eucas1p165b78adf542a48b38b49cb5e00500e26
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201001152249eucas1p165b78adf542a48b38b49cb5e00500e26
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <20201001152148.29747-1-l.stelmach@samsung.com>
        <CGME20201001152249eucas1p165b78adf542a48b38b49cb5e00500e26@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

s3c64xx_spi_hwinit() disables interrupts. In s3c64xx_spi_probe() after
calling s3c64xx_spi_hwinit() they are enabled with the following call.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
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


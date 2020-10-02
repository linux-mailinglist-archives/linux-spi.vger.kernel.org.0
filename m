Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC8A281266
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbgJBMXZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 08:23:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55008 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387905AbgJBMW6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 08:22:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201002122256euoutp0192b69b3067dafb724a2d9673ace67710~6LFh_vZs80512505125euoutp01J
        for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2020 12:22:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201002122256euoutp0192b69b3067dafb724a2d9673ace67710~6LFh_vZs80512505125euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601641376;
        bh=llLWfZCJtxROrMeiAZrYYreYA3AAoBgh09wtOE0v09o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HxVH/9DY4lpbz791oHy4uLubOippUyJbSJ/UfDuvIs0ic4DmLA+z1zRd6rBWM+HmF
         MM8iZOC0UwPAgnuQuj9BxltrXJjmrD2Y00UO3N1xGx4a+Kuxr3M8b2IHw7sL7tDX+T
         fVxi1WvCszAYmqz4DWmEHd6fvBBmxxQ678BIinY0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201002122255eucas1p1f29fd54387098d1322d9eabb09ae3b7e~6LFhgxtZ03162331623eucas1p1k;
        Fri,  2 Oct 2020 12:22:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 34.42.06456.F9B177F5; Fri,  2
        Oct 2020 13:22:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201002122255eucas1p2f361ef66b44801d69e0ee1425571f571~6LFg-c3h20642606426eucas1p26;
        Fri,  2 Oct 2020 12:22:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201002122255eusmtrp13dd4645ae24a205faaf6843f3c65e8c5~6LFg_sDgO1376413764eusmtrp1N;
        Fri,  2 Oct 2020 12:22:55 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-9c-5f771b9fc829
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 80.CD.06314.E9B177F5; Fri,  2
        Oct 2020 13:22:54 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201002122253eusmtip2086822cdaf3f38260cd2f44d61a24be2~6LFfc2tj31859318593eusmtip2S;
        Fri,  2 Oct 2020 12:22:53 +0000 (GMT)
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
Subject: [PATCH v3 6/9] spi: spi-s3c64xx: Fix doc comment for struct
 s3c64xx_spi_driver_data
Date:   Fri,  2 Oct 2020 14:22:40 +0200
Message-Id: <20201002122243.26849-7-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002122243.26849-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djPc7rzpcvjDVauV7BY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKePdxOVvB
        E+6KDS1nWRoY+zm7GDk5JARMJJbdus3YxcjFISSwglFi+/WFLBDOF0aJd4e7mCCcz4wS/3f9
        ZoRp2b/9EVRiOaNEZ+8DqP7njBIf919nAqliE3CU6F96ghUkISKwnUli4ufzYIOZBY4ySmx+
        cJUFpEpYIE7i4ZmvYHNZBFQl2m82gXXzClhLfLpzhxlin7xE+/LtbCA2p4CNxMlF29ggagQl
        Ts58AjaHX0BLYk3TdTCbGai+eetsZpBlEgKP2CW+Xn/ICjHIRWLbhtUsELawxKvjW9ghbBmJ
        05N7gOIcQHa9xORJZhC9PYwS2+b8gKq3lrhz7hcbSA2zgKbE+l36EGFHiaVvFrNCtPJJ3Hgr
        CHECn8SkbdOZIcK8Eh1tQhDVKhLr+vdADZSS6H21gnECo9IsJM/MQvLALIRdCxiZVzGKp5YW
        56anFhvmpZbrFSfmFpfmpesl5+duYgQmqtP/jn/awfj1UtIhRgEORiUe3oxDpfFCrIllxZW5
        hxglOJiVRHidzp6OE+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyW
        iYNTqoExeJrcublcb06ud+v1Nuj0ydt48/ypVdp9kfUNq213b73TNrvwvchRceNYP87votcK
        1BelbLt9aqvhnyK7V8u/fZjp0uei/DpM10Mz2iZOx+WS/MHm5xVml6UtD7ruDf9/LMhz2rE5
        VuXntnNfqA63vr1ZVL9i1y5+uR39Xc3seg9TEhNr5p1RYinOSDTUYi4qTgQAaVNMyVADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7rzpMvjDaadNbdY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLePdxOVvBE+6KDS1nWRoY+zm7GDk5JARM
        JPZvf8TUxcjFISSwlFHiz9NnrF2MHEAJKYmVc9MhaoQl/lzrYgMJCwk8ZZR4GgQSZhNwlOhf
        eoIVpFVEYD+TxKUL91lAHGaBw4wSl9etYwKpEhaIkfjeeYoRxGYRUJVov9kEFucVsJb4dOcO
        M8QCeYn25dvZQGxOARuJk4u2gdlCQDWtH+eyQtQLSpyc+YQF5AhmAXWJ9fOEQML8AloSa5qu
        s4DYzEBjmrfOZp7AKDQLSccshI5ZSKoWMDKvYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzI
        bcd+bt7BeGlj8CFGAQ5GJR5egQOl8UKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrN
        SS0+xGgK9OZEZinR5HxgssgriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPH
        xMEp1cDIcenKpsj82fnnjUTXM0fbHDiXqdt9xPqZvb6x48MXUzT/5HPzVWjp/d0uZHg178zN
        B8dFrrLlGPOema32I+seg2Mo09pD2/4nSB40y1f3ffhMSXEX+7HeH41r8g/f/Pt/9Z32jp6Y
        fGaJxUXdhycd62ldE/dhy3KvHY5t3BPufdrQ5sfpu0VOiaU4I9FQi7moOBEAul3CUN4CAAA=
X-CMS-MailID: 20201002122255eucas1p2f361ef66b44801d69e0ee1425571f571
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201002122255eucas1p2f361ef66b44801d69e0ee1425571f571
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201002122255eucas1p2f361ef66b44801d69e0ee1425571f571
References: <20201002122243.26849-1-l.stelmach@samsung.com>
        <CGME20201002122255eucas1p2f361ef66b44801d69e0ee1425571f571@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Remove descriptions for non-existent fields and fix indentation.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 13b53f9a5c3e..f85f40fd608c 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -162,11 +162,8 @@ struct s3c64xx_spi_port_config {
  * @cntrlr_info: Platform specific data for the controller this driver manages.
  * @lock: Controller specific lock.
  * @state: Set of FLAGS to indicate status.
- * @rx_dmach: Controller's DMA channel for Rx.
- * @tx_dmach: Controller's DMA channel for Tx.
  * @sfr_start: BUS address of SPI controller regs.
  * @regs: Pointer to ioremap'ed controller registers.
- * @irq: interrupt
  * @xfer_completion: To indicate completion of xfer task.
  * @cur_mode: Stores the active configuration of the controller.
  * @cur_bpw: Stores the active bits per word settings.
@@ -183,7 +180,7 @@ struct s3c64xx_spi_driver_data {
 	struct clk                      *ioclk;
 	struct platform_device          *pdev;
 	struct spi_master               *master;
-	struct s3c64xx_spi_info  *cntrlr_info;
+	struct s3c64xx_spi_info         *cntrlr_info;
 	spinlock_t                      lock;
 	unsigned long                   sfr_start;
 	struct completion               xfer_completion;
-- 
2.26.2


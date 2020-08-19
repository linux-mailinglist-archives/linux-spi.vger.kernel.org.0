Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F7249DE4
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHSMct (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:32:49 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60173 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgHSMch (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:32:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200819123227euoutp0109687d0e9521fd305896730b40fadadb~sq1SagNII2727427274euoutp01j
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200819123227euoutp0109687d0e9521fd305896730b40fadadb~sq1SagNII2727427274euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597840347;
        bh=bD6acsWiSYtcxnLapp4okxd9iLVm6ou2mGNH7IDBWDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJ9wvAczDuFORSya0itZUngf79/lqHNTzGFumbhq4LuDfmoRaLdqyOMDv0mEz6qtG
         NaQIAhHgAUAaMumE9wLYW9vD5khbuVYsLRslGV4ZOd0IPjGLlHRgaT4ICi9NbkljGP
         QbAXRLQPNdVEeLETWXv9/4Sc3h5PcVr+gIE/3pb0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200819123227eucas1p21864bf4b7d237f4ffcfa7cbaf126be7a~sq1SBssiJ2958529585eucas1p2S;
        Wed, 19 Aug 2020 12:32:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C3.FC.05997.BDB1D3F5; Wed, 19
        Aug 2020 13:32:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200819123226eucas1p2dc50cd60f71f2155524ec21bf4dcdd74~sq1Rsc4hE2428624286eucas1p2J;
        Wed, 19 Aug 2020 12:32:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200819123226eusmtrp1ddbce7041bdae136f2a3618dc98d54ba~sq1Rrw1-W1680116801eusmtrp18;
        Wed, 19 Aug 2020 12:32:26 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-3d-5f3d1bdb5791
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3E.63.06017.ADB1D3F5; Wed, 19
        Aug 2020 13:32:26 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819123226eusmtip1a68e77ea0c68b513f6c34ad23bfb81bb~sq1RgttCh3139831398eusmtip1Y;
        Wed, 19 Aug 2020 12:32:26 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH 3/8] spi: spi-s3c64xx: Report more information when errors
 occur
Date:   Wed, 19 Aug 2020 14:32:03 +0200
Message-Id: <20200819123208.12337-4-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819123208.12337-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSyUcRzf757nnnscp8ex+Y5K3eqP5KW32WNonRr3V2v9U2y5rjwd6+7o
        HkRrKC2y8zIvkawUxizhHC6Z1dUQuSu2ZIVulJJMoXG11N3D8t/n9/u8fD/f334kJm7ie5Hx
        miRGq1GoJIQQb+9Zsfi/8w6T7xlbFNLVy9M8uqW8iU+XWqcIumDyK0ZbLM0CetRUj2j95Bs+
        PdxZSdDllm4efeX7qIBufD4mOOQsG6n5gcn0DTcIWWtNhizf0IBkC/qtx/jRwtBYRhWfwmgD
        D54Wxlm7p/DEfip14aeBn4lKRbnIiQTqAFTZOni5SEiKqXoEtY/H+dxhEcHyyJM1ZgHBSE4e
        lotIh2VuzsvuFlN1CJ4uRXKaaQT14724nSAoKRTU9jmSPKhCHljNs4SdwKhk0D0yObA7dRxW
        2/oEdoxTO6G8a55nxyIqBAZWDAKunw9k13U49E5UKFhtJQSncYMXt6YcwzZRvvDg6gjO5ftA
        VtttjPOaBTBfJ+XwETB/shIcdoeZ3vX8zTBQrMO5xTKguCjI3hkoHYL2ymWc04TAe7ONsGsw
        ahc0dQZy11KoNt5CnNUV3n5z4xq4QlF72dpTiSDnuphT74CHBV1rgV6QN1OPCpGkYsMuFRv6
        V/yfVYWwBuTJJLNqJcPu0zAXA1iFmk3WKAPOJqj16N83GvjTu2hEnb/PmBBFIomLKNUcIhfz
        FSlsmtqEgMQkHqLwwYEYsShWkXaJ0SbItckqhjUhbxKXeIr23/9ySkwpFUnMeYZJZLTrLI90
        8spEjeHS9KroYOnkh+lWf2X/tYKhEltYoltAUJyv7WSN8cJ89mXVbsUviEwxbYt5FVV6Z7Yy
        6vXne2oki9uuy282ZER8xLMjysYYZ/ms9AQRNCqNNQ61PjNvyThXEWZkb4LGL2nYbdXlZfVE
        8IRzS9Tho7almcFev6y69Ls9bTpvCc7GKfb6YlpW8Rd2tasGQgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xu7q3pG3jDdbOMLJY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yO3B7XF/y
        idlj06pONo/NS+o9+rasYvT4vEkugDVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL+PhvicsBacEKj5/28LawDiVt4uRg0NCwETi3TupLkYuDiGB
        pYwSl3ctZ4aIS0msnJvexcgJZApL/LnWxQZR85RRYt+BeywgCTYBR4n+pSdYQRIiAjOYJJ7c
        mMwKkmAWKJe4NOs5O8ggYYEAiQMNqiBhFgFViRl7PjCB2LwC1hKnf25hh1ggL9G+fDsbiM0p
        YCPx8NcUMFsIqKZr8UKoekGJkzOfsICMZBZQl1g/TwgkzC+gJbGm6ToLxFZ5ieats5knMArN
        QtIxC6FjFpKqBYzMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjb9uxn1t2MHa9Cz7EKMDB
        qMTDW3HOOl6INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxhNgd6cyCwlmpwP
        TAt5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYdx6W/yCQYVah
        /NIvRlsgOixKUvFHwg/R7dtEMra0Tu/h+h36V/3hlt8fJy1PeHDsztxzxXM9XBTyWg+vZBWQ
        vjRd9vwxz+TE3+0Lk1IOPwr88UQuZOUM6zlG5yyu3NvSuVjmX9IlqVNB85+735n1MPLsrW1H
        H06+kyha/sfzwA/njLatq+N9C5RYijMSDbWYi4oTASYPkNHTAgAA
X-CMS-MailID: 20200819123226eucas1p2dc50cd60f71f2155524ec21bf4dcdd74
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200819123226eucas1p2dc50cd60f71f2155524ec21bf4dcdd74
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819123226eucas1p2dc50cd60f71f2155524ec21bf4dcdd74
References: <20200819123208.12337-1-l.stelmach@samsung.com>
        <CGME20200819123226eucas1p2dc50cd60f71f2155524ec21bf4dcdd74@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Report amount of pending data when a transfer stops due to errors.

Report if DMA was used to transfer data and print the status code.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8fe44451d303..4ab68cd1b821 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -122,6 +122,7 @@
 
 struct s3c64xx_spi_dma_data {
 	struct dma_chan *ch;
+	dma_cookie_t cookie;
 	enum dma_transfer_direction direction;
 };
 
@@ -297,7 +298,7 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	desc->callback = s3c64xx_spi_dmacb;
 	desc->callback_param = dma;
 
-	dmaengine_submit(desc);
+	dma->cookie = dmaengine_submit(desc);
 	dma_async_issue_pending(dma->ch);
 }
 
@@ -692,17 +693,28 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 
 		if (status) {
 			dev_err(&spi->dev,
-				"I/O Error: rx-%d tx-%d res:rx-%c tx-%c len-%d\n",
+				"I/O Error: rx-%d tx-%d rx-%c tx-%c len-%d dma-%d res-(%d)\n",
 				xfer->rx_buf ? 1 : 0, xfer->tx_buf ? 1 : 0,
 				(sdd->state & RXBUSY) ? 'f' : 'p',
 				(sdd->state & TXBUSY) ? 'f' : 'p',
-				xfer->len);
+				xfer->len, use_dma ? 1 : 0, status);
 
 			if (use_dma) {
-				if (xfer->tx_buf && (sdd->state & TXBUSY))
+				struct dma_tx_state s;
+
+				if (xfer->tx_buf && (sdd->state & TXBUSY)) {
+					dmaengine_pause(sdd->tx_dma.ch);
+					dmaengine_tx_status(sdd->tx_dma.ch, sdd->tx_dma.cookie, &s);
 					dmaengine_terminate_all(sdd->tx_dma.ch);
-				if (xfer->rx_buf && (sdd->state & RXBUSY))
+					dev_err(&spi->dev, "TX residue: %d\n", s.residue);
+
+				}
+				if (xfer->rx_buf && (sdd->state & RXBUSY)) {
+					dmaengine_pause(sdd->rx_dma.ch);
+					dmaengine_tx_status(sdd->rx_dma.ch, sdd->rx_dma.cookie, &s);
 					dmaengine_terminate_all(sdd->rx_dma.ch);
+					dev_err(&spi->dev, "RX residue: %d\n", s.residue);
+				}
 			}
 		} else {
 			s3c64xx_flush_fifo(sdd);
-- 
2.26.2


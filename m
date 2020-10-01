Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275B0280297
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbgJAPWu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 11:22:50 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40848 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbgJAPWu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 11:22:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201001152248euoutp013b5a8951bb814ea44a1f1ab922ebc279~555TFx7l62712727127euoutp01U
        for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2020 15:22:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201001152248euoutp013b5a8951bb814ea44a1f1ab922ebc279~555TFx7l62712727127euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601565768;
        bh=Rv21L8gszpO5by2jlyKs6+bspQDGl/g+ezAY1QP7hmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+OjS8rM3GU5zQhxzR+dczmMRHuhfLmykQTw8K5jqJwXTZhjghVp2eYtBUBvhFyVe
         j+8YVgMqfHGM6d6o5BKIy8yG55XzhoamaVzF6TZncloRg34iT/53N49rsbZCkSQDpn
         +kWX63vaNqjbnUjaaXPb6vq0nnpCbF8mHFexFOsc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201001152248eucas1p2f9a090b2e102c60b6fca9a5a7e238bdb~555SpMVon0243902439eucas1p2r;
        Thu,  1 Oct 2020 15:22:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 37.2F.06456.844F57F5; Thu,  1
        Oct 2020 16:22:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201001152247eucas1p2afff5b5b73f78d7c5111ac1c800e718a~555SRLhsW2407924079eucas1p2H;
        Thu,  1 Oct 2020 15:22:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201001152247eusmtrp17da508423efebc6111439d94e089926e~555SQj2xH2671626716eusmtrp1f;
        Thu,  1 Oct 2020 15:22:47 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-45-5f75f448300d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 25.D5.06017.744F57F5; Thu,  1
        Oct 2020 16:22:47 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201001152247eusmtip2a59a8e0502d96f5b43cf74ad7456662f~555SGTk_s0103301033eusmtip26;
        Thu,  1 Oct 2020 15:22:47 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 RESEND 4/9] spi: spi-s3c64xx: Report more information
 when errors occur
Date:   Thu,  1 Oct 2020 17:21:43 +0200
Message-Id: <20201001152148.29747-5-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001152148.29747-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUgTYRjv3W1353D2tgQf7EMYFWRljfVxkX0YQROC6t+o1qrDWW7ari2N
        IE3ItJVNkWwOLK1co+Uy29Qi8YqsJBcp6UwlsVqWC0ojC8223SL/+73P7+t54KUJeYskkc40
        HGeNBm2WgpSKPU9/da5Qj5s0qz68oJnaiYCIuVtZL2Eqht6TTOnwF4Lx+dwU4+cdiGkYfiNh
        ulrsJFPpeyRiCr75Kcb1ZIBinC2TaEusuuf6d0LdbBug1A3OYlJ97/pp9cVGJ1KPNSzcRe6R
        ph5mszLNrHHlpgNS3dcXQ6IcvyyXH+6m8lFQWoJiaMCrwVt9gwhjOXYgKO47VoKkITyOgLd2
        iQRiDMFTe/I/gzt/SiyI6hAEe5yU8AggmK71RKJInAalN55JwkQ89orAOuYThwkCm8DSzJNh
        PBfvhba2e5EKMV4Mr9+NRrAMb4Amy6BYqEuCojpvRB+DU6HT+pgUNHPg+ZX3Ec1snAy3z/RE
        85Og8H4VES4G3EdBQadHJARtg6nznygBz4XP7Y1RPB86yi0hMx3Cp6G8bK3gtSDw2CeiS2yA
        /s7fZFhD4KVQ37JSGKfBYMUQJVjjoDc4R1ghDso8lwlhLINzZ+WCehHcKX0YDUyEC58d6BJS
        2GYcY5txgO1/11VEOFECa+L0GSynNLAnUjitnjMZMlIOZesbUOhHdfxp/96Efrw+yCNMI0Ws
        TMebNHKJ1szl6XkENKGIl2192bFfLjuszTvJGrM1RlMWy/FoHi1WJMhUNSP75DhDe5w9yrI5
        rPEfK6JjEvMRVNLr1pvG41npaLXbqpuIU7WXWxqXfNTXBty3cF3vAr46qUT5ZXuj60jCxret
        s9LSM6c1a2Ldk4XpFfZgrX/RKdeKzc/NKaruaodvp3nqVXor/fMuJ1qmHO/YMe3SjOo478t3
        /dhblNJTtVc1a2vNtd4A/jDyoH7wpmr57lyFmNNplcmEkdP+Bb51X9tNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7ruX0rjDbp36Vgs/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZLVbt+sPo
        wONxfcknZo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZ
        WlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlvDv1kKngJm/FocdX2BsY33J1MXJySAiY
        SGxo+MvSxcjFISSwlFHidPcJIIcDKCElsXJuOkSNsMSfa11sEDVPGSUmL2tlAkmwCThK9C89
        wQqSEBHYzyRx6cJ9FpAEs0C5xKVZz9lBBgkLREn8vugOEmYRUJW49OANWC+vgLXEjp57LBAL
        5CXal29nA7E5BWwkzk08DGYLCeRK7N59lA2iXlDi5MwnYLcxC6hLrJ8nBBLmF9CSWNN0HWqr
        vETz1tnMExiFZiHpmIXQMQtJ1QJG5lWMIqmlxbnpucVGesWJucWleel6yfm5mxiBEbnt2M8t
        Oxi73gUfYhTgYFTi4RU4UBovxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM
        pkBvTmSWEk3OByaLvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFIN
        jFVNv7w9PX6cfa3i8Cvgu6qUzlRLhSpll5/1qcz/d4ZX1VqWrMvWn2Z+2ENhes42rkt1ccpW
        y5ZYfp40I1o3RcMgz+biBnWJzTee/bu+TYIh9sESUcuvXgJ7nwnKVyUtU/u2mv2J7TSbPuuO
        fLcHq45kMzqohtyoFix9JXz+Ttus5WsiMu+wK7EUZyQaajEXFScCAIhNVlHeAgAA
X-CMS-MailID: 20201001152247eucas1p2afff5b5b73f78d7c5111ac1c800e718a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201001152247eucas1p2afff5b5b73f78d7c5111ac1c800e718a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201001152247eucas1p2afff5b5b73f78d7c5111ac1c800e718a
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <20201001152148.29747-1-l.stelmach@samsung.com>
        <CGME20201001152247eucas1p2afff5b5b73f78d7c5111ac1c800e718a@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Report amount of pending data when a transfer stops due to errors.

Report if DMA was used to transfer data and print the status code.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index f7482f2f1e13..5be6f2484e86 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -731,17 +731,28 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 
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


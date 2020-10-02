Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017D6281264
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbgJBMXY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 08:23:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54175 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbgJBMW6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 08:22:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201002122253euoutp0217bd2a28a64339662e761321993300e5~6LFfzrzU82316423164euoutp02E
        for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2020 12:22:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201002122253euoutp0217bd2a28a64339662e761321993300e5~6LFfzrzU82316423164euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601641373;
        bh=iXskg/sx29oFhxvkuUJCTKesUirKCfDhLmYOrideYI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYUL8CBevNMnnWB5+a4bJ7zp/2/IAMUn2jXJx3sk9RKs2YmIhQKI/o7uoKDaqnwNU
         9Ezmp/koB/OBUJ/OoEgafNYh0/XxjUkzcqkXdbm2jrWAmVmtACu0ZwDBWfdvH9lgxQ
         PpxjD7+9JrxGb3geY5qo9ok0aoH5H8gF12sNikNM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201002122253eucas1p29500b4eab654b6b88bfbbb001d8eba76~6LFfUQQQH1017010170eucas1p2y;
        Fri,  2 Oct 2020 12:22:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0D.EB.05997.D9B177F5; Fri,  2
        Oct 2020 13:22:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201002122252eucas1p1496d896453d21acda6ab83ef9b7f0b8a~6LFe1JcCP0998409984eucas1p18;
        Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201002122252eusmtrp28e2b31faae470ee4be13388ae961c29f~6LFe0knR00251002510eusmtrp2S;
        Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-51-5f771b9d0384
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.B0.06017.C9B177F5; Fri,  2
        Oct 2020 13:22:52 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201002122252eusmtip118bf3517dc183d5f8db4a6598c647f5b~6LFemdknH0635906359eusmtip1P;
        Fri,  2 Oct 2020 12:22:52 +0000 (GMT)
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
Subject: [PATCH v3 4/9] spi: spi-s3c64xx: Report more information when
 errors occur
Date:   Fri,  2 Oct 2020 14:22:38 +0200
Message-Id: <20201002122243.26849-5-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002122243.26849-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djP87pzpcvjDToWcVos/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZLVbt+sPo
        wONxfcknZo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwRXHZpKTmZJalFunbJXBlzL03j7ng
        Jm/Fg00nmRoY33J1MXJySAiYSLw9+Iyli5GLQ0hgBaPE2jUnmCCcL4wSX6Y3MoFUCQl8ZpSY
        cbsCpmPBmT/MEEXLGSVed/5ig3CeM0os6prOCFLFJuAo0b/0BCtIQkRgO5PExM/nwZYwCxxl
        lNj84CqQw8EhLBAq8XSZIIjJIqAqcfKxDkgvr4C1xK41TWwQ2+Ql2pdvB7M5BWwkTi7axgZR
        IyhxcuYTFhCbX0BLYk3TdTCbGai+eetssOskBB6xSzQcOscIMchFYuudy1C2sMSr41vYIWwZ
        if875zOB3CAhUC8xeZIZRG8Po8S2OT9YIGqsJe6cA/mSA2iBpsT6XfoQYUeJ7R/vMkO08knc
        eCsIcQKfxKRt06HCvBIdbUIQ1SoS6/r3QA2Ukuh9tYJxAqPSLCTPzELywCyEXQsYmVcxiqeW
        FuempxYb5aWW6xUn5haX5qXrJefnbmIEpqjT/45/2cG460/SIUYBDkYlHl6BA6XxQqyJZcWV
        uYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFM
        lomDU6qBcQPXOuOjt/uW2PtWrU3nVBGx+ZnpyjM73WzpAW61+rd9ty1PsvjbzFq0pnnPNHWp
        P01TefW6T/+f8Yml+P/q7FDW1XYKIb8/Lco7/krLtt2laBKDf9aW5WyXC0ObkyX7NP+575Gq
        WaCwMG22aseGnoS8IhXdvps8Mc4x8ut/LJK1XvV9hn6IEktxRqKhFnNRcSIAGHIau00DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7pzpMvjDb7OULZY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLmHtvHnPBTd6KB5tOMjUwvuXqYuTkkBAw
        kVhw5g9zFyMXh5DAUkaJfb/OsXYxcgAlpCRWzk2HqBGW+HOtiw2i5imjxMOHV9hAEmwCjhL9
        S0+wgiREBPYzSVy6cJ8FxGEWOMwocXndOiaQKmGBYIml924wgUxlEVCVOPlYByTMK2AtsWtN
        ExvEBnmJ9uXbwWxOARuJk4u2gdlCQDWtH+eyQtQLSpyc+YQFZAyzgLrE+nlCIGF+AS2JNU3X
        WUBsZqAxzVtnM09gFJqFpGMWQscsJFULGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbk
        tmM/t+xg7HoXfIhRgINRiYdX4EBpvBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pz
        UosPMZoCfTmRWUo0OR+YLvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQx
        cXBKNTCyVX7T97l8v/UQ56nS0L/ndkV+/d56Ufe364fYz8cl6y8/X9W3XV+uLDV4r4Tt9Pwr
        x7fvEPPT2t637U7njn3lLxJ67yjF82gVzOWbN0XzX0Zdn7nlBlVjtjspLI/DHLUcm5vtHrMt
        jlZ15ZrJtuhLvd6eFa1Fp3886MuOFXboDbPedyzruLESS3FGoqEWc1FxIgDpESyj3wIAAA==
X-CMS-MailID: 20201002122252eucas1p1496d896453d21acda6ab83ef9b7f0b8a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201002122252eucas1p1496d896453d21acda6ab83ef9b7f0b8a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201002122252eucas1p1496d896453d21acda6ab83ef9b7f0b8a
References: <20201002122243.26849-1-l.stelmach@samsung.com>
        <CGME20201002122252eucas1p1496d896453d21acda6ab83ef9b7f0b8a@eucas1p1.samsung.com>
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
index 48afd4818558..86b6125b24a6 100644
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


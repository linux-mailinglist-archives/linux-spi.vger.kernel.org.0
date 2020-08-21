Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E821E24DE73
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 19:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHURaf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 13:30:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38786 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgHUQOK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Aug 2020 12:14:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200821161406euoutp02c0d38d6639644c6ceb97881e8c8676d2~tVJYxqtbf0484004840euoutp027
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2020 16:14:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200821161406euoutp02c0d38d6639644c6ceb97881e8c8676d2~tVJYxqtbf0484004840euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598026446;
        bh=ccU0tT3tsz9DJYTKMLpd1LpyWr9vzOvbufZouJOY0YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKCmIHFDlSFXI2/ZztE9Fhnc/CGFc4hB+THYVqIRTkgXZvNprOl1kjgMToCyba6Mv
         tl/LHBPwbMBwBsc0naXcEd1REZHV3yxEIk7X8ivrQVJz1k9i4gDlvhi+Koz2BbHpLh
         o05tFgBPLINa4d3QSFuyFpG+QNCx2uwlnpbw1M1I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200821161406eucas1p2870eafd118f65f4d8f90f8f3033c0738~tVJYbvCw21823418234eucas1p2i;
        Fri, 21 Aug 2020 16:14:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B0.AE.05997.EC2FF3F5; Fri, 21
        Aug 2020 17:14:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200821161405eucas1p19280babcd73926b5c22a48830f5fecd7~tVJX99PZB2678326783eucas1p1C;
        Fri, 21 Aug 2020 16:14:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200821161405eusmtrp2223e2fc934230c1c7f1c8c6d00434110~tVJX9XnAT2998229982eusmtrp2c;
        Fri, 21 Aug 2020 16:14:05 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-c3-5f3ff2ceb9f8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AA.17.06314.DC2FF3F5; Fri, 21
        Aug 2020 17:14:05 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200821161405eusmtip211f4dbf242ffa723f842573625fdb2c1~tVJX0TxsU2051720517eusmtip2l;
        Fri, 21 Aug 2020 16:14:05 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 3/9] spi: spi-s3c64xx: Report more information when
 errors occur
Date:   Fri, 21 Aug 2020 18:13:55 +0200
Message-Id: <20200821161401.11307-4-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821161401.11307-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7rnPtnHG9zfLGmx+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV8a19ZsYC04JVCyZspClgXEq
        bxcjJ4eEgInEo4ctzF2MXBxCAisYJa7f2ccI4XxhlFjcO58NwvnMKNGzt58ZpuXso+VQVcsZ
        JR62Tofqf84ocWnJZiaQKjYBR4n+pSdYQRIiAhOYJB6ee8MGkmAWKJXo2XkIyObgEBYIlTjz
        PQ/EZBFQlWg/LQpSwStgLTF5+RNGiGXyEu3Lt4N1cgrYSBy/1MQKUSMocXLmExYQm19AS2JN
        03UWiOnyEs1bZ4PdIyFwiV3i4oVbrBCDXCRWL53LBGELS7w6voUdwpaR+L9zPhPIDRIC9RKT
        J5lB9PYwSmyb84MFosZa4s65X2AnMwtoSqzfpQ8RdpR48mwZG0Qrn8SNt4IQJ/BJTNoGChKQ
        MK9ER5sQRLWKxLr+PVADpSR6X61gnMCoNAvJM7OQPDALYdcCRuZVjOKppcW56anFRnmp5XrF
        ibnFpXnpesn5uZsYgeno9L/jX3Yw7vqTdIhRgINRiYf3xyH7eCHWxLLiytxDjBIczEoivE5n
        T8cJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwKh8fJvg
        5AKnn5JTDBc6bmW/o3bU7+Ln24mKj+s7n2a1KQlunMEoMuvaN16GgFdc2i+Kp/19qrDV8I3t
        0Q3T+xe2ybBtd+Tk7pOrCJ7QnnB73acL5uanJj3I/G6WeUFPpOzTmfzc8NjNyRds24/xXrr5
        4u7T0/k6/GUfhAOkHzLe+B31pUJYb6USS3FGoqEWc1FxIgD6ZttRQwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7pnP9nHG2yebWmx+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsa19ZsYC04JVCyZspClgXEqbxcjJ4eEgInE2UfLGbsYuTiE
        BJYySsydfZq1i5EDKCElsXJuOkSNsMSfa11sEDVPGSXuzd/LCJJgE3CU6F96ghUkISIwg0ni
        yY3JrCAJZoFyiUuznrOD2MICwRJtH9YwgwxlEVCVaD8tChLmFbCWmLz8CSPEAnmJ9uXb2UBs
        TgEbieOXmsDGCAHVbFt8mQWiXlDi5MwnLCBjmAXUJdbPEwIJ8wtoSaxpus4CsVVeonnrbOYJ
        jEKzkHTMQuiYhaRqASPzKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMDo23bs5+YdjJc2Bh9i
        FOBgVOLh/XHIPl6INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxhNgb6cyCwl
        mpwPTAx5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYq1n0b82X
        3rdwSbXXXGWz518uzlLqy03zUWmN2rtyfX9ei5LxG7F3xbq3J5nb9563yzly78ffH7tSe1VF
        bdJ+bq5+mux/KiVeqzjI8Potj1+RdmUW6z1uu5rpPzLvfFq0uURc+QDzwubCQOYpXr47X2iq
        f4rPC7Trmi94ZbaspZbAlYKTvnZKLMUZiYZazEXFiQAupp4b1AIAAA==
X-CMS-MailID: 20200821161405eucas1p19280babcd73926b5c22a48830f5fecd7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200821161405eucas1p19280babcd73926b5c22a48830f5fecd7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200821161405eucas1p19280babcd73926b5c22a48830f5fecd7
References: <20200821161401.11307-1-l.stelmach@samsung.com>
        <CGME20200821161405eucas1p19280babcd73926b5c22a48830f5fecd7@eucas1p1.samsung.com>
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
index 22bf8c75580a..3364d362ed21 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -122,6 +122,7 @@
 
 struct s3c64xx_spi_dma_data {
 	struct dma_chan *ch;
+	dma_cookie_t cookie;
 	enum dma_transfer_direction direction;
 };
 
@@ -304,7 +305,7 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	desc->callback = s3c64xx_spi_dmacb;
 	desc->callback_param = dma;
 
-	dmaengine_submit(desc);
+	dma->cookie = dmaengine_submit(desc);
 	dma_async_issue_pending(dma->ch);
 }
 
@@ -699,17 +700,28 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 
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


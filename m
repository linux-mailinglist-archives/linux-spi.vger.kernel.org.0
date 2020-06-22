Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D2E20354B
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jun 2020 13:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgFVLGB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Jun 2020 07:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgFVLGA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Jun 2020 07:06:00 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA7C20767;
        Mon, 22 Jun 2020 11:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592823960;
        bh=bfVZtAFU8NdMRRNSEVZYVNoiKI0ceYpx6CxgFvwkv3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuFBEsCGCO32GnoZZXedi+W8XKo3fucdlXJrWtbSMRxhxS2ZXsh6vO3KitDLZtt3q
         vrliGSvpcYHocYrBfFQb3lz++9bVCLJb9QaIhJ2dDC86wS8nMPy6BiW7Au39Gf8FPL
         nDH7Ko+oj8aUZ0h823e/HyllJ3ITvDrncJPz4vT8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Peng Ma <peng.ma@nxp.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Wolfram Sang <wsa@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 4/4] spi: spi-fsl-dspi: Initialize completion before possible interrupt
Date:   Mon, 22 Jun 2020 13:05:43 +0200
Message-Id: <20200622110543.5035-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622110543.5035-1-krzk@kernel.org>
References: <20200622110543.5035-1-krzk@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The interrupt handler calls completion and is IRQ requested before the
completion is initialized.  Logically it should be the other way.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. None

Changes since v1:
1. Rework the commit msg.
---
 drivers/spi/spi-fsl-dspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index e0b30e4b1b69..91c6affe139c 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1389,6 +1389,8 @@ static int dspi_probe(struct platform_device *pdev)
 		goto poll_mode;
 	}
 
+	init_completion(&dspi->xfer_done);
+
 	ret = request_threaded_irq(dspi->irq, dspi_interrupt, NULL,
 				   IRQF_SHARED, pdev->name, dspi);
 	if (ret < 0) {
@@ -1396,8 +1398,6 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	init_completion(&dspi->xfer_done);
-
 poll_mode:
 
 	if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
-- 
2.17.1


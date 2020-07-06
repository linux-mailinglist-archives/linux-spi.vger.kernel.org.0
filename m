Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112DD215990
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 16:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgGFOew (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 10:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgGFOew (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 10:34:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC3C061755
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 07:34:51 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jsSCl-0005DP-FV; Mon, 06 Jul 2020 16:34:47 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 04/10] spi: spi-sun6i: sun6i_spi_transfer_one(): remove not needed masking of transfer length
Date:   Mon,  6 Jul 2020 16:34:37 +0200
Message-Id: <20200706143443.9855-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706143443.9855-1-mkl@pengutronix.de>
References: <20200706143443.9855-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In sun6i_spi_transfer_one() the driver ensures that the length of the transfer
is smaller or equal to SUN6I_MAX_XFER_SIZE. This means the masking of the
length to SUN6I_MAX_XFER_SIZE can be skipped when writing the transfer length
into the registers.

This patch removes the useless masking of the transfer length to
SUN6I_MAX_XFER_SIZE.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-sun6i.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 955be8921c45..882492774986 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -73,13 +73,10 @@
 #define SUN6I_MAX_XFER_SIZE		0xffffff
 
 #define SUN6I_BURST_CNT_REG		0x30
-#define SUN6I_BURST_CNT(cnt)			((cnt) & SUN6I_MAX_XFER_SIZE)
 
 #define SUN6I_XMIT_CNT_REG		0x34
-#define SUN6I_XMIT_CNT(cnt)			((cnt) & SUN6I_MAX_XFER_SIZE)
 
 #define SUN6I_BURST_CTL_CNT_REG		0x38
-#define SUN6I_BURST_CTL_CNT_STC(cnt)		((cnt) & SUN6I_MAX_XFER_SIZE)
 
 #define SUN6I_TXDATA_REG		0x200
 #define SUN6I_RXDATA_REG		0x300
@@ -305,10 +302,9 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 		tx_len = tfr->len;
 
 	/* Setup the counters */
-	sun6i_spi_write(sspi, SUN6I_BURST_CNT_REG, SUN6I_BURST_CNT(tfr->len));
-	sun6i_spi_write(sspi, SUN6I_XMIT_CNT_REG, SUN6I_XMIT_CNT(tx_len));
-	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG,
-			SUN6I_BURST_CTL_CNT_STC(tx_len));
+	sun6i_spi_write(sspi, SUN6I_BURST_CNT_REG, tfr->len);
+	sun6i_spi_write(sspi, SUN6I_XMIT_CNT_REG, tx_len);
+	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG, tx_len);
 
 	/* Fill the TX FIFO */
 	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
-- 
2.27.0


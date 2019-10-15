Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED030D7457
	for <lists+linux-spi@lfdr.de>; Tue, 15 Oct 2019 13:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbfJOLM1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Oct 2019 07:12:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50264 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfJOLM0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Oct 2019 07:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hBbz2YMw4mWZNYFfDdAkK1J+CjKJ2UJbISIx0WfGlq4=; b=qaApRJgATEqF
        3xuhl6uK45ubPQlUDEzy7sQutPYENuVjOvWHUhrS5K8lCjV6qgD8Cb4pVD/WnC2FWspJsgW9xOKcG
        Fk7w1Z7j4l0qlc8XRJ84gNk9hcgf/4MMjkfgKyFOAQ71RtQq92+k0qAm6kc9MlmhD+lwIJqUWDjqc
        6zYkE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKKkX-00020a-WA; Tue, 15 Oct 2019 11:12:22 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6B2EE27419E4; Tue, 15 Oct 2019 12:12:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: use new `spi_transfer_delay_exec` helper where straightforward" to the spi tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20191015111221.6B2EE27419E4@ypsilon.sirena.org.uk>
Date:   Tue, 15 Oct 2019 12:12:21 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: use new `spi_transfer_delay_exec` helper where straightforward

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From e74dc5c763448004ec8add422e9db53ee246acce Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:37 +0300
Subject: [PATCH] spi: use new `spi_transfer_delay_exec` helper where
 straightforward

For many places in the spi drivers, using the new `spi_transfer_delay`
helper is straightforward.
It's just replacing:
```
  if (t->delay_usecs)
     udelay(t->delay_usecs);
```
with `spi_transfer_delay(t)` which handles both `delay_usecs` and the new
`delay` field.

This change replaces in all places (in the spi drivers)  where this change
is simple.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-10-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c         |  3 +--
 drivers/spi/spi-bcm63xx-hsspi.c |  3 +--
 drivers/spi/spi-cavium.c        |  3 +--
 drivers/spi/spi-fsl-dspi.c      |  3 +--
 drivers/spi/spi-fsl-espi.c      |  3 +--
 drivers/spi/spi-fsl-spi.c       |  3 +--
 drivers/spi/spi-mpc512x-psc.c   |  3 +--
 drivers/spi/spi-mpc52xx-psc.c   |  3 +--
 drivers/spi/spi-omap-100k.c     |  3 +--
 drivers/spi/spi-pl022.c         | 25 +++++++++++--------------
 drivers/spi/spi-sc18is602.c     |  3 +--
 drivers/spi/spi-sh-hspi.c       |  3 +--
 drivers/spi/spi-topcliff-pch.c  |  7 +------
 drivers/spi/spi-txx9.c          |  3 +--
 drivers/spi/spi-xcomm.c         |  3 +--
 15 files changed, 25 insertions(+), 46 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 1471b049f99a..e34ab587b980 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1366,8 +1366,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		&& as->use_pdc)
 		atmel_spi_dma_unmap_xfer(master, xfer);
 
-	if (xfer->delay_usecs)
-		udelay(xfer->delay_usecs);
+	spi_transfer_delay_exec(xfer);
 
 	if (xfer->cs_change) {
 		if (list_is_last(&xfer->transfer_list,
diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index c6836a931dbf..7327309ea3d5 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -291,8 +291,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 
 		msg->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		if (t->cs_change)
 			bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
diff --git a/drivers/spi/spi-cavium.c b/drivers/spi/spi-cavium.c
index 5aaf21582cb5..6854c3ce423b 100644
--- a/drivers/spi/spi-cavium.c
+++ b/drivers/spi/spi-cavium.c
@@ -119,8 +119,7 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 			*rx_buf++ = (u8)v;
 		}
 
-	if (xfer->delay_usecs)
-		udelay(xfer->delay_usecs);
+	spi_transfer_delay_exec(xfer);
 
 	return xfer->len;
 }
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c0e96cc7fc51..442cff71a0d2 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -827,8 +827,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			dev_err(&dspi->pdev->dev,
 				"Waiting for transfer to complete failed!\n");
 
-		if (transfer->delay_usecs)
-			udelay(transfer->delay_usecs);
+		spi_transfer_delay_exec(transfer);
 	}
 
 out:
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f72daf66f3f3..e60581283a24 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -427,8 +427,7 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 
 	ret = fsl_espi_bufs(spi, trans);
 
-	if (trans->delay_usecs)
-		udelay(trans->delay_usecs);
+	spi_transfer_delay_exec(trans);
 
 	return ret;
 }
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 4b80ace1d137..114801a32371 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -416,8 +416,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 		}
 		m->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		if (cs_change) {
 			ndelay(nsecs);
diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index a337b842ae8c..ea1b07953d38 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -311,8 +311,7 @@ static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
 			break;
 		m->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		if (cs_change)
 			mpc512x_psc_spi_deactivate_cs(spi);
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index c7e478b9b586..17935e71b02f 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -234,8 +234,7 @@ static void mpc52xx_psc_spi_work(struct work_struct *work)
 				break;
 			m->actual_length += t->len;
 
-			if (t->delay_usecs)
-				udelay(t->delay_usecs);
+			spi_transfer_delay_exec(t);
 
 			if (cs_change)
 				mpc52xx_psc_spi_deactivate_cs(spi);
diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 43a4785fc89b..5c704ba6d8ea 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -321,8 +321,7 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
 			}
 		}
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		/* ignore the "leave it on after last xfer" hint */
 
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 7fedea67159c..3024c30e7f2e 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -485,12 +485,11 @@ static void giveback(struct pl022 *pl022)
 					struct spi_transfer, transfer_list);
 
 	/* Delay if requested before any change in chip select */
-	if (last_transfer->delay_usecs)
-		/*
-		 * FIXME: This runs in interrupt context.
-		 * Is this really smart?
-		 */
-		udelay(last_transfer->delay_usecs);
+	/*
+	 * FIXME: This runs in interrupt context.
+	 * Is this really smart?
+	 */
+	spi_transfer_delay_exec(last_transfer);
 
 	if (!last_transfer->cs_change) {
 		struct spi_message *next_msg;
@@ -1401,12 +1400,11 @@ static void pump_transfers(unsigned long data)
 		previous = list_entry(transfer->transfer_list.prev,
 					struct spi_transfer,
 					transfer_list);
-		if (previous->delay_usecs)
-			/*
-			 * FIXME: This runs in interrupt context.
-			 * Is this really smart?
-			 */
-			udelay(previous->delay_usecs);
+		/*
+		 * FIXME: This runs in interrupt context.
+		 * Is this really smart?
+		 */
+		spi_transfer_delay_exec(previous);
 
 		/* Reselect chip select only if cs_change was requested */
 		if (previous->cs_change)
@@ -1520,8 +1518,7 @@ static void do_polling_transfer(struct pl022 *pl022)
 			previous =
 			    list_entry(transfer->transfer_list.prev,
 				       struct spi_transfer, transfer_list);
-			if (previous->delay_usecs)
-				udelay(previous->delay_usecs);
+			spi_transfer_delay_exec(previous);
 			if (previous->cs_change)
 				pl022_cs_control(pl022, SSP_CHIP_SELECT);
 		} else {
diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 11acddc83304..5497eeb3bf3e 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -211,8 +211,7 @@ static int sc18is602_transfer_one(struct spi_master *master,
 		}
 		status = 0;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 	}
 	m->status = status;
 	spi_finalize_current_message(master);
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 7f73f91d412a..a62034e2a7cb 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -190,8 +190,7 @@ static int hspi_transfer_one_message(struct spi_controller *ctlr,
 
 		msg->actual_length += t->len;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		if (cs_change) {
 			ndelay(nsecs);
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index f88cbb94ce12..223353fa2d8a 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1229,12 +1229,7 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 			"%s:data->current_msg->actual_length=%d\n",
 			__func__, data->current_msg->actual_length);
 
-		/* check for delay */
-		if (data->cur_trans->delay_usecs) {
-			dev_dbg(&data->master->dev, "%s:delay in usec=%d\n",
-				__func__, data->cur_trans->delay_usecs);
-			udelay(data->cur_trans->delay_usecs);
-		}
+		spi_transfer_delay_exec(data->cur_trans);
 
 		spin_lock(&data->lock);
 
diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 51759d3fd45f..83daaa597acc 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -248,8 +248,7 @@ static void txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
 			len -= count * wsize;
 		}
 		m->actual_length += t->len;
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		if (!cs_change)
 			continue;
diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index a3496c46cc1b..1d9b3f03d986 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -188,8 +188,7 @@ static int spi_xcomm_transfer_one(struct spi_master *master,
 		}
 		status = 0;
 
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
+		spi_transfer_delay_exec(t);
 
 		is_first = false;
 	}
-- 
2.20.1


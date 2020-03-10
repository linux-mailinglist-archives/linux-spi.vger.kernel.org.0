Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725B217FD34
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 14:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgCJN0g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 09:26:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40517 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgCJMzy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 08:55:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id e26so1219770wme.5;
        Tue, 10 Mar 2020 05:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tbjDWzq/l2jrbG3u5/MfQgZvvxeb8f+2VciawpYeynk=;
        b=WpO99kUK+qHBDl9If27BUE2QK4ZoFBlkwztaFleRDlker3+judsPEfNRIB30bRCzpS
         YQ9ev59erhyelVwVNajKwqsMpAGih7L4XXs7Ip9DLue9tYFELwulL93D0FqmZ9laUAdI
         I4FMuttFKHbsXP6HSeyRFVmSVmf4bVHOyFJkdiyZQVo5GA1ltZEldH9SLdvwqTJ+JH/O
         8xDM93T22dw6p81RBVtJ/KkfyovX9do2FLGAGESKbZYU8fAMaHwDFzw+89rcBcbhEVG7
         dHm7ClYsbVHw10KfBoy5ZZxeLIj86HdI/IVFT3RvvnDn3Ht+2Cou09wRcv9q8ClbfMh/
         t0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tbjDWzq/l2jrbG3u5/MfQgZvvxeb8f+2VciawpYeynk=;
        b=pasaA7mHN1Ok/K7OCJyN9adLQXE991ovNifc3U/lPUMUWtC/3iSAuBLOxDPFH+aIB6
         SD+qW6GtrCmPFzmOxDFOiWyovsAsl1pi1uMl9ELcrFnxwHMUq1ULd2tcbg3dQkembfd4
         cjD/fKV9vb9vl+XTdqV2euKDYeXc/urEZQkug8uGcIIHZsMQfNcRHPZUK+1TbkW6sSvX
         +rB/Q+KpCJKY4qSBEmVEkFax+y9Gbo4TkckbBC7r4aeFE89rojL9/m4ZVDUT6IEK6lmb
         Wy4RUpReyEHX55nQS22vfY7LloYybfVNUN4o795eLcvic/GAngAPBOTt0HolPD1omuf9
         2NPw==
X-Gm-Message-State: ANhLgQ2NZmdYjgRSwZvTrCSDiokGkrjy6djvDi4SkaMQlgh+bzGwWvpV
        cvB0/K19zQ0Xx31tfrVh27E=
X-Google-Smtp-Source: ADFU+vtRTW6yZoQCw/OigJJYUmiKOWDql1rrP+JEaARjCYTnuygX2qybJCnS+3Q5Ctw6MKrfisAVEw==
X-Received: by 2002:a1c:1fc9:: with SMTP id f192mr2181043wmf.4.1583844952793;
        Tue, 10 Mar 2020 05:55:52 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id t81sm4018594wmb.15.2020.03.10.05.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 05:55:52 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 2/7] spi: spi-fsl-dspi: Avoid use-after-free in interrupt mode
Date:   Tue, 10 Mar 2020 14:55:37 +0200
Message-Id: <20200310125542.5939-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310125542.5939-1-olteanv@gmail.com>
References: <20200310125542.5939-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

When the wait_event_interruptible call fails, there is still a chance
that the dspi_interrupt may arrive (for example the kernel thread doing
the SPI pump really is interrupted).

In that case, dspi_transfer_one_message will return execution all the
way to the spi_device driver, which may free the spi_message and
spi_transfer structures.

But when the interrupt arrives, the driver still accesses those
structures, leading to use-after-free issues as can be seen below:

hexdump -C /dev/mtd0
00000000  00 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
|.uhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
|................|
*
^C[   38.495955] fsl-dspi 2120000.spi: Waiting for transfer to complete failed!
[   38.503097] spi_master spi2: failed to transfer one message from queue
[   38.509729] Unable to handle kernel paging request at virtual address ffff800095ab3377
[   38.517676] Mem abort info:
[   38.520474]   ESR = 0x96000045
[   38.523533]   EC = 0x25: DABT (current EL), IL = 32 bits
[   38.528861]   SET = 0, FnV = 0
[   38.531921]   EA = 0, S1PTW = 0
[   38.535067] Data abort info:
[   38.537952]   ISV = 0, ISS = 0x00000045
[   38.541797]   CM = 0, WnR = 1
[   38.544771] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000082621000
[   38.551494] [ffff800095ab3377] pgd=00000020fffff003, p4d=00000020fffff003, pud=0000000000000000
[   38.560229] Internal error: Oops: 96000045 [#1] PREEMPT SMP
[   38.565819] Modules linked in:
[   38.568882] CPU: 0 PID: 2729 Comm: hexdump Not tainted 5.6.0-rc4-next-20200306-00052-gd8730cdc8a0b-dirty #193
[   38.578834] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier (DT)
[   38.587129] pstate: 20000085 (nzCv daIf -PAN -UAO)
[   38.591941] pc : ktime_get_real_ts64+0x3c/0x110
[   38.596487] lr : spi_take_timestamp_pre+0x40/0x90
[   38.601203] sp : ffff800010003d90
[   38.604525] x29: ffff800010003d90 x28: ffff80001200e000
[   38.609854] x27: ffff800011da9000 x26: ffff002079c40400
[   38.615184] x25: ffff8000117fe018 x24: ffff800011daa1a0
[   38.620513] x23: ffff800015ab3860 x22: ffff800095ab3377
[   38.625841] x21: 000000000000146e x20: ffff8000120c3000
[   38.631170] x19: ffff0020795f6e80 x18: ffff800011da9948
[   38.636498] x17: 0000000000000000 x16: 0000000000000000
[   38.641826] x15: ffff800095ab3377 x14: 0720072007200720
[   38.647155] x13: 0720072007200765 x12: 0775076507750771
[   38.652483] x11: 0720076d076f0772 x10: 0000000000000040
[   38.657812] x9 : ffff8000108e2100 x8 : ffff800011dcabe8
[   38.663139] x7 : 0000000000000000 x6 : ffff800015ab3a60
[   38.668468] x5 : 0000000007200720 x4 : ffff800095ab3377
[   38.673796] x3 : 0000000000000000 x2 : 0000000000000ab0
[   38.679125] x1 : ffff800011daa000 x0 : 0000000000000026
[   38.684454] Call trace:
[   38.686905]  ktime_get_real_ts64+0x3c/0x110
[   38.691100]  spi_take_timestamp_pre+0x40/0x90
[   38.695470]  dspi_fifo_write+0x58/0x2c0
[   38.699315]  dspi_interrupt+0xbc/0xd0
[   38.702987]  __handle_irq_event_percpu+0x78/0x2c0
[   38.707706]  handle_irq_event_percpu+0x3c/0x90
[   38.712161]  handle_irq_event+0x4c/0xd0
[   38.716008]  handle_fasteoi_irq+0xbc/0x170
[   38.720115]  generic_handle_irq+0x2c/0x40
[   38.724135]  __handle_domain_irq+0x68/0xc0
[   38.728243]  gic_handle_irq+0xc8/0x160
[   38.732000]  el1_irq+0xb8/0x180
[   38.735149]  spi_nor_spimem_read_data+0xe0/0x140
[   38.739779]  spi_nor_read+0xc4/0x120
[   38.743364]  mtd_read_oob+0xa8/0xc0
[   38.746860]  mtd_read+0x4c/0x80
[   38.750007]  mtdchar_read+0x108/0x2a0
[   38.753679]  __vfs_read+0x20/0x50
[   38.757002]  vfs_read+0xa4/0x190
[   38.760237]  ksys_read+0x6c/0xf0
[   38.763471]  __arm64_sys_read+0x20/0x30
[   38.767319]  el0_svc_common.constprop.3+0x90/0x160
[   38.772125]  do_el0_svc+0x28/0x90
[   38.775449]  el0_sync_handler+0x118/0x190
[   38.779468]  el0_sync+0x140/0x180
[   38.782793] Code: 91000294 1400000f d50339bf f9405e80 (f90002c0)
[   38.788910] ---[ end trace 55da560db4d6bef7 ]---
[   38.793540] Kernel panic - not syncing: Fatal exception in interrupt
[   38.799914] SMP: stopping secondary CPUs
[   38.803849] Kernel Offset: disabled
[   38.807344] CPU features: 0x10002,20006008
[   38.811451] Memory Limit: none
[   38.814513] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

The solution is to mask interrupts when we know we can't deal with them.
Also, to make sure they won't bite when we enable them back, we clear
the status register such that stale interrupt requests will just be lost
(as is expected on timeout or wait interruption).

Fixes: 349ad66c0ab0 ("spi:Add Freescale DSPI driver for Vybrid VF610 platform")
Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v3:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 63 +++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0ce26c1cbf62..f2ba0731aebe 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -911,15 +911,39 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void dspi_enable_interrupts(struct fsl_dspi *dspi, bool on)
+{
+	u32 spi_rser = 0;
+
+	if (on) {
+		switch (dspi->devtype_data->trans_mode) {
+		case DSPI_EOQ_MODE:
+			spi_rser = SPI_RSER_EOQFE;
+			break;
+		case DSPI_XSPI_MODE:
+			spi_rser = SPI_RSER_CMDTCFE;
+			break;
+		default:
+			/* Interrupts not necessary for DMA mode */
+			return;
+		}
+	}
+
+	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
+	regmap_write(dspi->regmap, SPI_RSER, spi_rser);
+}
+
 static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				     struct spi_message *message)
 {
 	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
 	struct spi_device *spi = message->spi;
-	enum dspi_trans_mode trans_mode;
 	struct spi_transfer *transfer;
 	int status = 0;
 
+	if (dspi->irq)
+		dspi_enable_interrupts(dspi, true);
+
 	message->actual_length = 0;
 
 	list_for_each_entry(transfer, &message->transfers, transfer_list) {
@@ -965,37 +989,24 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		spi_take_timestamp_pre(dspi->ctlr, dspi->cur_transfer,
 				       dspi->progress, !dspi->irq);
 
-		trans_mode = dspi->devtype_data->trans_mode;
-		switch (trans_mode) {
-		case DSPI_EOQ_MODE:
-			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
-			dspi_fifo_write(dspi);
-			break;
-		case DSPI_XSPI_MODE:
-			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_CMDTCFE);
-			dspi_fifo_write(dspi);
-			break;
-		case DSPI_DMA_MODE:
+		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
 			regmap_write(dspi->regmap, SPI_RSER,
 				     SPI_RSER_TFFFE | SPI_RSER_TFFFD |
 				     SPI_RSER_RFDFE | SPI_RSER_RFDFD);
 			status = dspi_dma_xfer(dspi);
-			break;
-		default:
-			dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
-				trans_mode);
-			status = -EINVAL;
-			goto out;
-		}
+			if (status)
+				goto out;
+		} else if (dspi->irq) {
+			/* Kick off the interrupt train */
+			dspi_fifo_write(dspi);
 
-		if (!dspi->irq) {
-			do {
-				status = dspi_poll(dspi);
-			} while (status == -EINPROGRESS);
-		} else if (trans_mode != DSPI_DMA_MODE) {
 			status = wait_event_interruptible(dspi->waitq,
 							  dspi->waitflags);
 			dspi->waitflags = 0;
+		} else {
+			do {
+				status = dspi_poll(dspi);
+			} while (status == -EINPROGRESS);
 		}
 		if (status)
 			dev_err(&dspi->pdev->dev,
@@ -1005,6 +1016,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 	}
 
 out:
+	if (dspi->irq)
+		dspi_enable_interrupts(dspi, false);
+
 	message->status = status;
 	spi_finalize_current_message(ctlr);
 
@@ -1208,7 +1222,6 @@ static void dspi_init(struct fsl_dspi *dspi)
 		mcr |= SPI_MCR_MASTER;
 
 	regmap_write(dspi->regmap, SPI_MCR, mcr);
-	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
 }
 
 static int dspi_slave_abort(struct spi_master *master)
-- 
2.17.1


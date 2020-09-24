Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9990E276A24
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 09:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgIXHLb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 03:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgIXHL2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Sep 2020 03:11:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38B8C0613D5
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2020 00:11:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so2527666wrm.9
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2020 00:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FpHhGb46CyVbDBWjnhy1CeIzsuoq/d3dnPpjc6AO4uU=;
        b=hrdgbXAboLISP+VljySuk/ub/83ZeVnaaf0RPZVmp3OaX+RJMlAWWHdcCyRpjHtmhV
         ZW6q/wn9hyT6orEro4StwtqrAclxV2RxU4eI+lDxnXNtn5l6AQUNFfu2rWg3Hwvmw+1D
         wvWkqu2bztkOP9y3Ue7jAhxNDXI6EsUEgmWLq5Yu8Thr7eoVxQcOrUY56MD6UvtwL8JA
         JeqhWfVZdSVbC6I8cClnpqUghH8aYytb1gjv5J2fzGFwA/5Ky0dfnVKz37bNUVHZSbbp
         xoNmM5djrBBdiNpxvRisH0huge5IIj0HLH/m2+WzNYnbtQ80fgqTVxNuKukGP7GPH3Kj
         DyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FpHhGb46CyVbDBWjnhy1CeIzsuoq/d3dnPpjc6AO4uU=;
        b=aqjQfm1cM7izWdYRFx/4tCl+xqZq6RHOdp8VOgihEdWBdG+P9DdpUz35Kogph7gX+v
         08R6ca41xtiY3sj/saerQrhIB6RpKVi/sxbN42LvcBiCRqTjQvFGVP2xxvjmSpS2s0VY
         nMyZTDCRhESui1NTRz5gNz+aJnBbqSIa+NjJ6r8iGYP68Fqsaot959CtPbwTi7a8Z6HA
         CJzl2CqnbQHYZiS6QK67v4T6fQf/H0w8F8n3AJ4t22JAUzxO+en2UWyM16nzgwOHLalu
         hUxUcbt0E1GJ0UGXg+e1PEargLR2VQ1suNRtCgbFC0Q4hT0mM2p+Ah4jT84NVBI+lJsA
         WL2A==
X-Gm-Message-State: AOAM533uMAsHJ42L/UcFdVXiSWDptWvqNzd9dJfDswUwwcmFn45jvbLj
        4csEoAVnfLqXrLosrxI+/WdlE+n/dVR0aAxn
X-Google-Smtp-Source: ABdhPJxz41Q0Xd1LKHN7W2jvaXPJG8HNVXHPRV9xfT+Z658sSpCY5fZ78BGYVRDC4KvjqaRtOgeRcg==
X-Received: by 2002:a5d:444b:: with SMTP id x11mr3382755wrr.402.1600931486496;
        Thu, 24 Sep 2020 00:11:26 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id l4sm2563279wrc.14.2020.09.24.00.11.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:11:25 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     broonie@kernel.org
Cc:     amit.kumar-mahapatra@xilinx.com, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RESEND v2 PATCH 1/3] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
Date:   Thu, 24 Sep 2020 09:11:17 +0200
Message-Id: <ba5920c57eee06fafa6f9d1df9859e69819ac301.1600931476.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600931476.git.michal.simek@xilinx.com>
References: <cover.1600931476.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>

Fix kernel-doc warnings in ZynqMP qspi driver file.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/spi/spi-zynqmp-gqspi.c | 45 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index e17a20125255..b479b9c3d1e6 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -173,9 +173,10 @@ struct zynqmp_qspi {
 };
 
 /**
- * zynqmp_gqspi_read:	For GQSPI controller read operation
+ * zynqmp_gqspi_read - For GQSPI controller read operation
  * @xqspi:	Pointer to the zynqmp_qspi structure
  * @offset:	Offset from where to read
+ * Return:      Value at the offset
  */
 static u32 zynqmp_gqspi_read(struct zynqmp_qspi *xqspi, u32 offset)
 {
@@ -183,7 +184,7 @@ static u32 zynqmp_gqspi_read(struct zynqmp_qspi *xqspi, u32 offset)
 }
 
 /**
- * zynqmp_gqspi_write:	For GQSPI controller write operation
+ * zynqmp_gqspi_write - For GQSPI controller write operation
  * @xqspi:	Pointer to the zynqmp_qspi structure
  * @offset:	Offset where to write
  * @val:	Value to be written
@@ -195,7 +196,7 @@ static inline void zynqmp_gqspi_write(struct zynqmp_qspi *xqspi, u32 offset,
 }
 
 /**
- * zynqmp_gqspi_selectslave:	For selection of slave device
+ * zynqmp_gqspi_selectslave - For selection of slave device
  * @instanceptr:	Pointer to the zynqmp_qspi structure
  * @slavecs:	For chip select
  * @slavebus:	To check which bus is selected- upper or lower
@@ -242,7 +243,7 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
 }
 
 /**
- * zynqmp_qspi_init_hw:	Initialize the hardware
+ * zynqmp_qspi_init_hw - Initialize the hardware
  * @xqspi:	Pointer to the zynqmp_qspi structure
  *
  * The default settings of the QSPI controller's configurable parameters on
@@ -330,7 +331,7 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 }
 
 /**
- * zynqmp_qspi_copy_read_data:	Copy data to RX buffer
+ * zynqmp_qspi_copy_read_data - Copy data to RX buffer
  * @xqspi:	Pointer to the zynqmp_qspi structure
  * @data:	The variable where data is stored
  * @size:	Number of bytes to be copied from data to RX buffer
@@ -344,7 +345,7 @@ static void zynqmp_qspi_copy_read_data(struct zynqmp_qspi *xqspi,
 }
 
 /**
- * zynqmp_prepare_transfer_hardware:	Prepares hardware for transfer.
+ * zynqmp_prepare_transfer_hardware - Prepares hardware for transfer.
  * @master:	Pointer to the spi_master structure which provides
  *		information about the controller.
  *
@@ -361,7 +362,7 @@ static int zynqmp_prepare_transfer_hardware(struct spi_master *master)
 }
 
 /**
- * zynqmp_unprepare_transfer_hardware:	Relaxes hardware after transfer
+ * zynqmp_unprepare_transfer_hardware - Relaxes hardware after transfer
  * @master:	Pointer to the spi_master structure which provides
  *		information about the controller.
  *
@@ -378,7 +379,7 @@ static int zynqmp_unprepare_transfer_hardware(struct spi_master *master)
 }
 
 /**
- * zynqmp_qspi_chipselect:	Select or deselect the chip select line
+ * zynqmp_qspi_chipselect - Select or deselect the chip select line
  * @qspi:	Pointer to the spi_device structure
  * @is_high:	Select(0) or deselect (1) the chip select line
  */
@@ -423,7 +424,7 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 }
 
 /**
- * zynqmp_qspi_setup_transfer:	Configure QSPI controller for specified
+ * zynqmp_qspi_setup_transfer - Configure QSPI controller for specified
  *				transfer
  * @qspi:	Pointer to the spi_device structure
  * @transfer:	Pointer to the spi_transfer structure which provides
@@ -482,7 +483,7 @@ static int zynqmp_qspi_setup_transfer(struct spi_device *qspi,
 }
 
 /**
- * zynqmp_qspi_setup:	Configure the QSPI controller
+ * zynqmp_qspi_setup - Configure the QSPI controller
  * @qspi:	Pointer to the spi_device structure
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer,
@@ -498,7 +499,7 @@ static int zynqmp_qspi_setup(struct spi_device *qspi)
 }
 
 /**
- * zynqmp_qspi_filltxfifo:	Fills the TX FIFO as long as there is room in
+ * zynqmp_qspi_filltxfifo - Fills the TX FIFO as long as there is room in
  *				the FIFO or the bytes required to be
  *				transmitted.
  * @xqspi:	Pointer to the zynqmp_qspi structure
@@ -524,7 +525,7 @@ static void zynqmp_qspi_filltxfifo(struct zynqmp_qspi *xqspi, int size)
 }
 
 /**
- * zynqmp_qspi_readrxfifo:	Fills the RX FIFO as long as there is room in
+ * zynqmp_qspi_readrxfifo - Fills the RX FIFO as long as there is room in
  *				the FIFO.
  * @xqspi:	Pointer to the zynqmp_qspi structure
  * @size:	Number of bytes to be copied from RX buffer to RX FIFO
@@ -552,7 +553,7 @@ static void zynqmp_qspi_readrxfifo(struct zynqmp_qspi *xqspi, u32 size)
 }
 
 /**
- * zynqmp_process_dma_irq:	Handler for DMA done interrupt of QSPI
+ * zynqmp_process_dma_irq - Handler for DMA done interrupt of QSPI
  *				controller
  * @xqspi:	zynqmp_qspi instance pointer
  *
@@ -600,7 +601,7 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
 }
 
 /**
- * zynqmp_qspi_irq:	Interrupt service routine of the QSPI controller
+ * zynqmp_qspi_irq - Interrupt service routine of the QSPI controller
  * @irq:	IRQ number
  * @dev_id:	Pointer to the xqspi structure
  *
@@ -654,7 +655,7 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 }
 
 /**
- * zynqmp_qspi_selectspimode:	Selects SPI mode - x1 or x2 or x4.
+ * zynqmp_qspi_selectspimode - Selects SPI mode - x1 or x2 or x4.
  * @xqspi:	xqspi is a pointer to the GQSPI instance
  * @spimode:	spimode - SPI or DUAL or QUAD.
  * Return:	Mask to set desired SPI mode in GENFIFO entry.
@@ -682,7 +683,7 @@ static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
 }
 
 /**
- * zynq_qspi_setuprxdma:	This function sets up the RX DMA operation
+ * zynq_qspi_setuprxdma - This function sets up the RX DMA operation
  * @xqspi:	xqspi is a pointer to the GQSPI instance.
  */
 static void zynq_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
@@ -732,7 +733,7 @@ static void zynq_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 }
 
 /**
- * zynqmp_qspi_txrxsetup:	This function checks the TX/RX buffers in
+ * zynqmp_qspi_txrxsetup - This function checks the TX/RX buffers in
  *				the transfer and sets up the GENFIFO entries,
  *				TX FIFO as required.
  * @xqspi:	xqspi is a pointer to the GQSPI instance.
@@ -783,7 +784,7 @@ static void zynqmp_qspi_txrxsetup(struct zynqmp_qspi *xqspi,
 }
 
 /**
- * zynqmp_qspi_start_transfer:	Initiates the QSPI transfer
+ * zynqmp_qspi_start_transfer - Initiates the QSPI transfer
  * @master:	Pointer to the spi_master structure which provides
  *		information about the controller.
  * @qspi:	Pointer to the spi_device structure
@@ -891,7 +892,7 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
 }
 
 /**
- * zynqmp_qspi_suspend:	Suspend method for the QSPI driver
+ * zynqmp_qspi_suspend - Suspend method for the QSPI driver
  * @dev:	Address of the platform_device structure
  *
  * This function stops the QSPI driver queue and disables the QSPI controller
@@ -910,7 +911,7 @@ static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
 }
 
 /**
- * zynqmp_qspi_resume:	Resume method for the QSPI driver
+ * zynqmp_qspi_resume - Resume method for the QSPI driver
  * @dev:	Address of the platform_device structure
  *
  * The function starts the QSPI driver queue and initializes the QSPI
@@ -1000,7 +1001,7 @@ static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops = {
 };
 
 /**
- * zynqmp_qspi_probe:	Probe method for the QSPI driver
+ * zynqmp_qspi_probe - Probe method for the QSPI driver
  * @pdev:	Pointer to the platform_device structure
  *
  * This function initializes the driver data structures and the hardware.
@@ -1112,7 +1113,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 }
 
 /**
- * zynqmp_qspi_remove:	Remove method for the QSPI driver
+ * zynqmp_qspi_remove - Remove method for the QSPI driver
  * @pdev:	Pointer to the platform_device structure
  *
  * This function is called if a device is physically removed from the system or
-- 
2.28.0


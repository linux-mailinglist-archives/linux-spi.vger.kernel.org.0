Return-Path: <linux-spi+bounces-118-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4A680159A
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 22:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F07281C9B
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 21:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FD259157;
	Fri,  1 Dec 2023 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="cRGJHK1G"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F058210D0
	for <linux-spi@vger.kernel.org>; Fri,  1 Dec 2023 13:41:27 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-423e7e0a619so22086721cf.1
        for <linux-spi@vger.kernel.org>; Fri, 01 Dec 2023 13:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1701466886; x=1702071686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=59mXeYglHvFe+i0q8a+nNQILZScUscbdHfS/fP8kp0o=;
        b=cRGJHK1Gf02sJnV6elAOh99xCx4MP65bmpP4BtcDT7D92BfirX1OYHwgC4IT6rKMv+
         b96+LMav+i8mm1vFDCxIUBT8iyIqhMfOpfCa5uU69CauqSlAx1yxgIuMWNO/Xsbk+lcE
         ZwoNYakZiz95QWWVV4nFEXjD9deXgtA4XXplF/R+cpjkDb2D4BQaXp7JWeiPsIZgXOY6
         1Wz95gf/O211yM273HUS49UJ0cOTYsIuVS2Lovm5tPlwGQjg6qU0ZYXRWSSGs5K3CyYB
         tq4J0YJBBf+qxDqIH+h8GGOFIikU4lxgGLHve4JNsF8suz76KLFu/Yy7eh2P8PXxzrYu
         EE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701466886; x=1702071686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59mXeYglHvFe+i0q8a+nNQILZScUscbdHfS/fP8kp0o=;
        b=mhoFiC+Ue34Nh+S6f53INnBWn3fRfdLEUi9+E7czhZ7jtLvv4fZrg3Sj6GGtYTtVzN
         NNj5UEzlKcg6RBGCohOFtNdoXyaBj+F0S4xoP0f8Az52v287HtCGDycSjxtrhg2FveHC
         uOzHtRPyhfyhqVNrdMhHjFQ2AXV4p4U/0XncIT0YmPsrh/QgkYoTJ5wt0h8FM3lF2FHe
         LRjzzaRVCwSotFPqmUEC62C2IHazuXBOUdnjqne0MI/32wsNKUvUhoww5e1S9XW3Vkuy
         5bD2UzQQB+Pl426CPoFXTAG74U9yZyuE9sp+0Sp9/jcFUsULwYDlsr19uS6DGG7FtMCE
         Dtgw==
X-Gm-Message-State: AOJu0YyXdW6vq6yNhf2Gqea2jAfiVPTrsdB8SW8l3Cx+KqEsZqh1Uyte
	/YsUQewM8kQv8rOA5vqAZ1K+NvHm5T3aSBBUPyA=
X-Google-Smtp-Source: AGHT+IGoHQeQx+AvBZHeMuz4zrtTBJeL+RuLI8owzZH0hlPvq2bzzBRU91U6JRy1DLfm1yGhJb+4/A==
X-Received: by 2002:a05:622a:1306:b0:425:4054:bc51 with SMTP id v6-20020a05622a130600b004254054bc51mr236289qtk.45.1701466886267;
        Fri, 01 Dec 2023 13:41:26 -0800 (PST)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id v20-20020ac873d4000000b00423af25edefsm1834582qtp.27.2023.12.01.13.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 13:41:25 -0800 (PST)
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] spi: stm32: enable controller before asserting CS
Date: Fri,  1 Dec 2023 16:40:14 -0500
Message-ID: <20231201214014.2539031-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the STM32F4/7, the SPI pins float while the controller is disabled.
Currently, the controller is enabled in the transfer_one() callback,
which runs after CS is asserted. Therefore, there is a period where the
SPI pins are floating while CS is asserted, making it possible for stray
signals to disrupt communications. An analogous problem occurs at the
end of the transfer when the controller is disabled before CS is
released.

This problem can be reliably observed by enabling the pull-up (if
CPOL=0) or pull-down (if CPOL=1) on the clock pin. This will cause two
extra unintended clock edges per transfer, when the controller is
enabled and disabled.

This patch fixes the bug by enabling the controller in prepare_message()
and disabling it in unprepare_message(), which are called while CS is
not asserted.

Note that bug is likely not present on the STM32H7, because it supports
the AFCNTR bit (and this driver sets it), which keeps the SPI pins
driven even while the controller is disabled.

This patch has been tested on an STM32F746 with a MAX14830 UART
expander.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/spi/spi-stm32.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 94df3836834c..885f53a51441 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -948,10 +948,8 @@ static irqreturn_t stm32fx_spi_irq_event(int irq, void *dev_id)
 static irqreturn_t stm32fx_spi_irq_thread(int irq, void *dev_id)
 {
 	struct spi_controller *ctrl = dev_id;
-	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 
 	spi_finalize_current_transfer(ctrl);
-	stm32fx_spi_disable(spi);
 
 	return IRQ_HANDLED;
 }
@@ -1118,6 +1116,8 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 			 ~clrb) | setb,
 			spi->base + spi->cfg->regs->cpol.reg);
 
+	stm32_spi_enable(spi);
+
 	spin_unlock_irqrestore(&spi->lock, flags);
 
 	return 0;
@@ -1135,7 +1135,6 @@ static void stm32fx_spi_dma_tx_cb(void *data)
 
 	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
 		spi_finalize_current_transfer(spi->ctrl);
-		stm32fx_spi_disable(spi);
 	}
 }
 
@@ -1150,7 +1149,6 @@ static void stm32_spi_dma_rx_cb(void *data)
 	struct stm32_spi *spi = data;
 
 	spi_finalize_current_transfer(spi->ctrl);
-	spi->cfg->disable(spi);
 }
 
 /**
@@ -1235,8 +1233,6 @@ static int stm32fx_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	stm32_spi_set_bits(spi, STM32FX_SPI_CR2, cr2);
 
-	stm32_spi_enable(spi);
-
 	/* starting data transfer when buffer is loaded */
 	if (spi->tx_buf)
 		spi->cfg->write_tx(spi);
@@ -1273,8 +1269,6 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	spin_lock_irqsave(&spi->lock, flags);
 
-	stm32_spi_enable(spi);
-
 	/* Be sure to have data in fifo before starting data transfer */
 	if (spi->tx_buf)
 		stm32h7_spi_write_txfifo(spi);
@@ -1306,8 +1300,6 @@ static void stm32fx_spi_transfer_one_dma_start(struct stm32_spi *spi)
 		 */
 		stm32_spi_set_bits(spi, STM32FX_SPI_CR2, STM32FX_SPI_CR2_ERRIE);
 	}
-
-	stm32_spi_enable(spi);
 }
 
 /**
@@ -1341,8 +1333,6 @@ static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
 
 	stm32_spi_set_bits(spi, STM32H7_SPI_IER, ier);
 
-	stm32_spi_enable(spi);
-
 	if (STM32_SPI_MASTER_MODE(spi))
 		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
 }
-- 
2.42.1



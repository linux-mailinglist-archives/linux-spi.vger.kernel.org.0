Return-Path: <linux-spi+bounces-3039-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA358CD066
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 12:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BBF1C2283B
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1F313D51A;
	Thu, 23 May 2024 10:33:41 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8613C9CF
	for <linux-spi@vger.kernel.org>; Thu, 23 May 2024 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460421; cv=none; b=Y+rE2i4Lsp8P9ibsiIIT5P/yK+tpx63ahOTUeU86H3JjZbWPNCUVwKxYtMSLRMz+n8zRPUyO3HxybnPjnT1YD8M5MzTznxFkRBPFgJpfO3pkTLm4SCriXcxVF9Zzo3S04xp0WzdOp57cY/RaQUEGsvHceicJ6wf2N6cTZ5WbuCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460421; c=relaxed/simple;
	bh=6tuNnoLkJ2tXDCxIpUaYwWLi21/Zzu/baG1ufTacAHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nPs/aGwdhPPfpNFZkaKx3DAPr/xO3QJukCtR2gVej1Bl4qGyVTnPP4wJNfq0/kXox8t8G0hlvnpEBKXYAtyQcIVl1IDAD6PMqadJQc9nXJMGkvk7bWUuAWRCu8PAL1wbyTG3qub63P/fopZNJiDWokYMVO/LV7zgfXULwQBfVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1sA5lK-0007kH-Ly; Thu, 23 May 2024 12:33:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1sA5lI-002eDf-Q5; Thu, 23 May 2024 12:33:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1sA5lI-00AfcR-2K;
	Thu, 23 May 2024 12:33:28 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Subject: [PATCH] spi: stm32: Revert change that enabled controller before asserting CS
Date: Thu, 23 May 2024 12:33:25 +0200
Message-ID: <20240523103326.792907-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3022; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6tuNnoLkJ2tXDCxIpUaYwWLi21/Zzu/baG1ufTacAHE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmTxt2iwSlG4f6TMyHvH9Enp+HExKclnaGmgUv5 sT2/d4d1iaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZk8bdgAKCRCPgPtYfRL+ TrlmB/4gV8s2Y7NT/84tO/LJQeNFA/eP0C2EtjPHZS1/32AOwgO6TFQcrzJcpZh45yk0wPYPMHb aFTODdWZv8lTX3BfpTP7YfvWwPffd/xX2QoXNZeNFmn19qksWILTn53/v+W1LztEshxRElS42t1 C0R0HoVbnbPEOb9q7MS4GrqiyCvuh3hGsHrItLh9QCy3gISo3HAi33TyIHWUbIG6sl1nhB7z3Nq bw4UOdOKXSU7blghuSU7ZVwLBAbVJxUoKudwG3UPt3CDErvpUawdnQRmbHIPMY//vHCXhADehof Y5cdLRs/dcOLq1HXB4ZE/ljlT87kerC3elpMKT4LGN4i0JAr
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

On stm32mp157 enabling the controller before asserting CS makes the
hardware trigger spurious interrupts in a tight loop and the transfers
fail. Revert the commit that swapped the order of enable and CS. This
reintroduces the problem that swapping was supposed to fix, which
however is less grave.

Reported-by: Leonard Göhrs <l.goehrs@pengutronix.de>
Link: https://lore.kernel.org/all/39033ed7-3e57-4339-80b4-fc8919e26aa7@pengutronix.de/
Fixes: 52b62e7a5d4f ("spi: stm32: enable controller before asserting CS")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-stm32.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4a68abcdcc35..e4e7ddb7524a 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1016,8 +1016,10 @@ static irqreturn_t stm32fx_spi_irq_event(int irq, void *dev_id)
 static irqreturn_t stm32fx_spi_irq_thread(int irq, void *dev_id)
 {
 	struct spi_controller *ctrl = dev_id;
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 
 	spi_finalize_current_transfer(ctrl);
+	stm32fx_spi_disable(spi);
 
 	return IRQ_HANDLED;
 }
@@ -1185,8 +1187,6 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 			 ~clrb) | setb,
 			spi->base + spi->cfg->regs->cpol.reg);
 
-	stm32_spi_enable(spi);
-
 	spin_unlock_irqrestore(&spi->lock, flags);
 
 	return 0;
@@ -1204,6 +1204,7 @@ static void stm32fx_spi_dma_tx_cb(void *data)
 
 	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
 		spi_finalize_current_transfer(spi->ctrl);
+		stm32fx_spi_disable(spi);
 	}
 }
 
@@ -1218,6 +1219,7 @@ static void stm32_spi_dma_rx_cb(void *data)
 	struct stm32_spi *spi = data;
 
 	spi_finalize_current_transfer(spi->ctrl);
+	spi->cfg->disable(spi);
 }
 
 /**
@@ -1305,6 +1307,8 @@ static int stm32fx_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	stm32_spi_set_bits(spi, STM32FX_SPI_CR2, cr2);
 
+	stm32_spi_enable(spi);
+
 	/* starting data transfer when buffer is loaded */
 	if (spi->tx_buf)
 		spi->cfg->write_tx(spi);
@@ -1341,6 +1345,8 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	spin_lock_irqsave(&spi->lock, flags);
 
+	stm32_spi_enable(spi);
+
 	/* Be sure to have data in fifo before starting data transfer */
 	if (spi->tx_buf)
 		stm32h7_spi_write_txfifo(spi);
@@ -1372,6 +1378,8 @@ static void stm32fx_spi_transfer_one_dma_start(struct stm32_spi *spi)
 		 */
 		stm32_spi_set_bits(spi, STM32FX_SPI_CR2, STM32FX_SPI_CR2_ERRIE);
 	}
+
+	stm32_spi_enable(spi);
 }
 
 /**
@@ -1405,6 +1413,8 @@ static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
 
 	stm32_spi_set_bits(spi, STM32H7_SPI_IER, ier);
 
+	stm32_spi_enable(spi);
+
 	if (STM32_SPI_HOST_MODE(spi))
 		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
 }

base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
-- 
2.39.2



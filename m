Return-Path: <linux-spi+bounces-8876-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B401FAED5D5
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 09:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A8E7A6D05
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74961E502;
	Mon, 30 Jun 2025 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZEOB92+a"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC18258A;
	Mon, 30 Jun 2025 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269033; cv=none; b=LBOxPLy/tzti8MLjQjkVX8cz0FB72Mlby84PcUXMyX5tDAi2lk2kpAGPTVhzVM1HgmIWM4xMyG70NByD2r6n7wtlp1Cgn5obdmHASSMChYhleQdO+YJ5Kp/XYPO4WLJRnOVDhxwctAHKN9D6QrxnehxD+JXrhIp0iSx94bxFQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269033; c=relaxed/simple;
	bh=ND7Q4m6yED4/nU3qdzo6WhqdgulCkdGdQKYpK7ib2cI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KtFXsgRqThUzZaf9Hb+rpKhcxhvZd5jbs6DZhf8Za/B2u4xCcMSpn7Tydqrm8j+DeEkMUsttVx1U2VLF1nlkNQ1bHu+g51gUFQmPQlVC0WsHnbxNj0jma5COyAmxUwS71x6r9TjkOhXRSntKzDZ5hKSfd2Cqmd1LVX+X5fzZdBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZEOB92+a; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1751269032; x=1782805032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ND7Q4m6yED4/nU3qdzo6WhqdgulCkdGdQKYpK7ib2cI=;
  b=ZEOB92+aGY1z5z6F29uhauGsFcm9MaVDqTV1mvMbY3Zu4ZqbUCaUJuru
   dLZgkSYUyLdHcxvfIfZAm19D2RPd2XGaSlz+UhcTy6fID+duaUvrnaH5a
   eG25Fc9YcmAAn79X5atowBOUF3CK9/tIdgePmFq03bWCT6jaknNomLLeS
   MZC88GIQrHqCpbsupkiaMrZj1fLYkG0wpwJUJZXhiUVepHJ9Vz4OFlm76
   1bvydZujfnATFcLBPUsMJ2HF+xOcAI49dFK3xfpTakSRZJU+TS6VkIQSl
   1aydRIAlVx1K9e510RsUMsOG2jtSOyECKBVpu0FgkJgXjrDBdadJ9F7K+
   A==;
X-CSE-ConnectionGUID: KbPkVfubRmajejs2jq0tUA==
X-CSE-MsgGUID: Wn20V2IWSymGofEIlfw2Pg==
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="274767124"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2025 00:37:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 30 Jun 2025 00:36:35 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 30 Jun 2025 00:36:33 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <unglinuxdriver@microchip.com>
Subject: [PATCH v1 for-next] spi: spi-pci1xxxx: enable concurrent DMA read/write across SPI transfers
Date: Mon, 30 Jun 2025 13:02:33 +0530
Message-ID: <20250630073233.7356-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Refactor the pci1xxxx SPI driver to allow overlapping DMA read and
write operations across SPI transfers. This improves throughput and
reduces idle time between SPI transactions.

Transfer sequence:
- Start with a DMA read to load TX data from host to device buffer.
- After DMA read completes, trigger the SPI transfer.
- On SPI completion:
  - Start DMA write to copy received data from RX buffer to host.
  - Start the next DMA read to prepare TX data for the following transfer.
- Begin the next SPI transfer after both DMA write and read complete.

To implement this sequence, the following changes were made:
- Added dma_completion_count to track and synchronize DMA completions.
- Split DMA setup into separate functions for TX (read) and RX (write).
- Introduced separate spinlocks for safe access to RD and WR DMA registers.

This new flow enables efficient pipelining by overlapping data
preparation and completion stages, leading to better SPI transfer
performance and utilization of DMA engines.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/spi/spi-pci1xxxx.c | 82 ++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index f44fe5841139..8577a19705de 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -140,6 +140,7 @@ struct pci1xxxx_spi_internal {
 	int irq[NUM_VEC_PER_INST];
 	int mode;
 	bool spi_xfer_in_progress;
+	atomic_t dma_completion_count;
 	void *rx_buf;
 	bool dma_aborted_rd;
 	u32 bytes_recvd;
@@ -163,8 +164,10 @@ struct pci1xxxx_spi {
 	u8 dev_rev;
 	void __iomem *reg_base;
 	void __iomem *dma_offset_bar;
-	/* lock to safely access the DMA registers in isr */
-	spinlock_t dma_reg_lock;
+	/* lock to safely access the DMA RD registers in isr */
+	spinlock_t dma_rd_reg_lock;
+	/* lock to safely access the DMA RD registers in isr */
+	spinlock_t dma_wr_reg_lock;
 	bool can_dma;
 	struct pci1xxxx_spi_internal *spi_int[] __counted_by(total_hw_instances);
 };
@@ -330,7 +333,8 @@ static int pci1xxxx_spi_dma_init(struct pci1xxxx_spi *spi_bus, int hw_inst, int
 	if (ret)
 		return ret;
 
-	spin_lock_init(&spi_bus->dma_reg_lock);
+	spin_lock_init(&spi_bus->dma_rd_reg_lock);
+	spin_lock_init(&spi_bus->dma_wr_reg_lock);
 	writel(SPI_DMA_ENGINE_EN, spi_bus->dma_offset_bar + SPI_DMA_GLOBAL_WR_ENGINE_EN);
 	writel(SPI_DMA_ENGINE_EN, spi_bus->dma_offset_bar + SPI_DMA_GLOBAL_RD_ENGINE_EN);
 
@@ -464,6 +468,7 @@ static void pci1xxxx_start_spi_xfer(struct pci1xxxx_spi_internal *p)
 {
 	u32 regval;
 
+	atomic_set(&p->dma_completion_count, 0);
 	regval = readl(p->parent->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
 	regval |= SPI_MST_CTL_GO;
 	writel(regval, p->parent->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
@@ -536,7 +541,6 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 {
 	struct pci1xxxx_spi_internal *p = spi_controller_get_devdata(spi_ctlr);
 	struct pci1xxxx_spi *par = p->parent;
-	dma_addr_t rx_dma_addr = 0;
 	dma_addr_t tx_dma_addr = 0;
 	int ret = 0;
 	u32 regval;
@@ -545,6 +549,7 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 	p->tx_sgl = xfer->tx_sg.sgl;
 	p->rx_sgl = xfer->rx_sg.sgl;
 	p->rx_buf = xfer->rx_buf;
+	atomic_set(&p->dma_completion_count, 1);
 	regval = readl(par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 	writel(regval, par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 
@@ -561,13 +566,9 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 	writel(regval, par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 
 	tx_dma_addr = sg_dma_address(p->tx_sgl);
-	rx_dma_addr = sg_dma_address(p->rx_sgl);
 	p->tx_sgl_len = sg_dma_len(p->tx_sgl);
-	p->rx_sgl_len = sg_dma_len(p->rx_sgl);
 	pci1xxxx_spi_setup(par, p->hw_inst, p->mode, p->clkdiv, p->tx_sgl_len);
 	pci1xxxx_spi_setup_dma_to_io(p, (tx_dma_addr), p->tx_sgl_len);
-	if (rx_dma_addr)
-		pci1xxxx_spi_setup_dma_from_io(p, rx_dma_addr, p->rx_sgl_len);
 	writel(p->hw_inst, par->dma_offset_bar + SPI_DMA_RD_DOORBELL_REG);
 
 	reinit_completion(&p->spi_xfer_done);
@@ -657,32 +658,33 @@ static irqreturn_t pci1xxxx_spi_isr_io(int irq, void *dev)
 	return spi_int_fired;
 }
 
-static void pci1xxxx_spi_setup_next_dma_transfer(struct pci1xxxx_spi_internal *p)
+static void pci1xxxx_spi_setup_next_dma_to_io_transfer(struct pci1xxxx_spi_internal *p)
 {
 	dma_addr_t tx_dma_addr = 0;
-	dma_addr_t rx_dma_addr = 0;
 	u32 prev_len;
 
 	p->tx_sgl = sg_next(p->tx_sgl);
-	if (p->rx_sgl)
-		p->rx_sgl = sg_next(p->rx_sgl);
-	if (!p->tx_sgl) {
-		/* Clear xfer_done */
-		complete(&p->spi_xfer_done);
-	} else {
+	if (p->tx_sgl) {
 		tx_dma_addr = sg_dma_address(p->tx_sgl);
 		prev_len = p->tx_sgl_len;
 		p->tx_sgl_len = sg_dma_len(p->tx_sgl);
+		pci1xxxx_spi_setup_dma_to_io(p, tx_dma_addr, p->tx_sgl_len);
+		writel(p->hw_inst, p->parent->dma_offset_bar + SPI_DMA_RD_DOORBELL_REG);
 		if (prev_len != p->tx_sgl_len)
 			pci1xxxx_spi_setup(p->parent,
 					   p->hw_inst, p->mode, p->clkdiv, p->tx_sgl_len);
-		pci1xxxx_spi_setup_dma_to_io(p, tx_dma_addr, p->tx_sgl_len);
-		if (p->rx_sgl) {
-			rx_dma_addr = sg_dma_address(p->rx_sgl);
-			p->rx_sgl_len = sg_dma_len(p->rx_sgl);
-			pci1xxxx_spi_setup_dma_from_io(p, rx_dma_addr, p->rx_sgl_len);
-		}
-		writel(p->hw_inst, p->parent->dma_offset_bar + SPI_DMA_RD_DOORBELL_REG);
+	}
+}
+
+static void pci1xxxx_spi_setup_next_dma_from_io_transfer(struct pci1xxxx_spi_internal *p)
+{
+	dma_addr_t rx_dma_addr = 0;
+
+	if (p->rx_sgl) {
+		rx_dma_addr = sg_dma_address(p->rx_sgl);
+		p->rx_sgl_len = sg_dma_len(p->rx_sgl);
+		pci1xxxx_spi_setup_dma_from_io(p, rx_dma_addr, p->rx_sgl_len);
+		writel(p->hw_inst, p->parent->dma_offset_bar + SPI_DMA_WR_DOORBELL_REG);
 	}
 }
 
@@ -693,22 +695,24 @@ static irqreturn_t pci1xxxx_spi_isr_dma_rd(int irq, void *dev)
 	unsigned long flags;
 	u32 regval;
 
-	spin_lock_irqsave(&p->parent->dma_reg_lock, flags);
 	/* Clear the DMA RD INT and start spi xfer*/
 	regval = readl(p->parent->dma_offset_bar + SPI_DMA_INTR_RD_STS);
 	if (regval) {
 		if (regval & SPI_DMA_DONE_INT_MASK(p->hw_inst)) {
-			pci1xxxx_start_spi_xfer(p);
+			/* Start the SPI transfer only if both DMA read and write are completed */
+			if (atomic_inc_return(&p->dma_completion_count) == 2)
+				pci1xxxx_start_spi_xfer(p);
 			spi_int_fired = IRQ_HANDLED;
 		}
 		if (regval & SPI_DMA_ABORT_INT_MASK(p->hw_inst)) {
 			p->dma_aborted_rd = true;
 			spi_int_fired = IRQ_HANDLED;
 		}
+		spin_lock_irqsave(&p->parent->dma_rd_reg_lock, flags);
+		writel((SPI_DMA_DONE_INT_MASK(p->hw_inst) | SPI_DMA_ABORT_INT_MASK(p->hw_inst)),
+		       p->parent->dma_offset_bar + SPI_DMA_INTR_RD_CLR);
+		spin_unlock_irqrestore(&p->parent->dma_rd_reg_lock, flags);
 	}
-	writel((SPI_DMA_DONE_INT_MASK(p->hw_inst) | SPI_DMA_ABORT_INT_MASK(p->hw_inst)),
-	       p->parent->dma_offset_bar + SPI_DMA_INTR_RD_CLR);
-	spin_unlock_irqrestore(&p->parent->dma_reg_lock, flags);
 	return spi_int_fired;
 }
 
@@ -719,22 +723,29 @@ static irqreturn_t pci1xxxx_spi_isr_dma_wr(int irq, void *dev)
 	unsigned long flags;
 	u32 regval;
 
-	spin_lock_irqsave(&p->parent->dma_reg_lock, flags);
 	/* Clear the DMA WR INT */
 	regval = readl(p->parent->dma_offset_bar + SPI_DMA_INTR_WR_STS);
 	if (regval) {
 		if (regval & SPI_DMA_DONE_INT_MASK(p->hw_inst)) {
-			pci1xxxx_spi_setup_next_dma_transfer(p);
 			spi_int_fired = IRQ_HANDLED;
+			if (sg_is_last(p->rx_sgl)) {
+				complete(&p->spi_xfer_done);
+			} else {
+				p->rx_sgl =  sg_next(p->rx_sgl);
+				if (atomic_inc_return(&p->dma_completion_count) == 2)
+					pci1xxxx_start_spi_xfer(p);
+			}
+
 		}
 		if (regval & SPI_DMA_ABORT_INT_MASK(p->hw_inst)) {
 			p->dma_aborted_wr = true;
 			spi_int_fired = IRQ_HANDLED;
 		}
+		spin_lock_irqsave(&p->parent->dma_wr_reg_lock, flags);
+		writel((SPI_DMA_DONE_INT_MASK(p->hw_inst) | SPI_DMA_ABORT_INT_MASK(p->hw_inst)),
+		       p->parent->dma_offset_bar + SPI_DMA_INTR_WR_CLR);
+		spin_unlock_irqrestore(&p->parent->dma_wr_reg_lock, flags);
 	}
-	writel((SPI_DMA_DONE_INT_MASK(p->hw_inst) | SPI_DMA_ABORT_INT_MASK(p->hw_inst)),
-	       p->parent->dma_offset_bar + SPI_DMA_INTR_WR_CLR);
-	spin_unlock_irqrestore(&p->parent->dma_reg_lock, flags);
 	return spi_int_fired;
 }
 
@@ -747,10 +758,11 @@ static irqreturn_t pci1xxxx_spi_isr_dma(int irq, void *dev)
 	/* Clear the SPI GO_BIT Interrupt */
 	regval = readl(p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 	if (regval & SPI_INTR) {
-		writel(p->hw_inst, p->parent->dma_offset_bar + SPI_DMA_WR_DOORBELL_REG);
+		pci1xxxx_spi_setup_next_dma_from_io_transfer(p);
+		pci1xxxx_spi_setup_next_dma_to_io_transfer(p);
 		spi_int_fired = IRQ_HANDLED;
+		writel(regval, p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 	}
-	writel(regval, p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 	return spi_int_fired;
 }
 
-- 
2.25.1



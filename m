Return-Path: <linux-spi+bounces-8722-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523AAE5A86
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 05:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185CC4A5D95
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 03:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E0C26ACB;
	Tue, 24 Jun 2025 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="blQkzaQ1"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CAB38FA3;
	Tue, 24 Jun 2025 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750736091; cv=none; b=Ig4k+LCNsD6E58a/V79/VBi/0J8K/T5rtIr7dmtDfo9dn8s0X+8q59wPuXP1BNJfwTzKmRMZOlRv6G+Hz+5jbatUEXZyWrtADfw0QNvu/DHzKgXKhUZ/oZ89KQgSpL03E5yvLvu0Ra8XXGBc/eBPiAhT1xutGXcbameqwaUBlbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750736091; c=relaxed/simple;
	bh=vKd4FYnogUm1KS1nvFHCn3nIDQHCqVmKQb9y4TDJne4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SDsGuUlzKZwCn8ZFTqg5LlV1vtPiEaCg826luU35jofRCDuz4kTBjEZrRCKs9ezpyWe7mWVs4KVG2ythxFBBBR823hNgIdAgn60gxW6bkewkGCwFYms/m7oOWyZy4QnJi/z8QPxQk5XIEr9gPXcu8s8C1JpiKEi6WsGL39ZZ8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=blQkzaQ1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1750736090; x=1782272090;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vKd4FYnogUm1KS1nvFHCn3nIDQHCqVmKQb9y4TDJne4=;
  b=blQkzaQ1JsQHxWtKg20C+F67wYjBjA2kGbPHMH0TGqAhRyPC0ybZ4qn0
   LfvzKK9GsIdLTZHapt3RPWdniaDfwKSGuWt1Lg0lcVhFndH/Lyin6n2/K
   dTWpPXyVB5n4/DkQs6uwDxpbyaJ4RyNC4i7KxgClLGtmLCdOuha6PC9fk
   B8WNNXwT4OMTUaSxCMJIPIhmw2y7M6XxodE0phfEqYQwpmPXrwzg8Ub/T
   uIeQ/MyaMbpIVhf+NQ/YACLciMTyf1pPgVVkGZztA4J0pAi+XWgrOvYc6
   4TSZOyvETOcXIw5X2Yjxh0gTlZQPeFglO9V+R9M3DT0T6X5TbWd2ZfS07
   A==;
X-CSE-ConnectionGUID: 0ruxbsyNQhuV3Dbw/3/YrQ==
X-CSE-MsgGUID: 8lplY0suT26FIaIPD6WO1g==
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="43141027"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2025 20:34:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Jun 2025 20:34:28 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 23 Jun 2025 20:34:27 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 for-next] spi: spi-pci1xxxx: Add support for per-instance DMA interrupt vectors
Date: Tue, 24 Jun 2025 09:00:28 +0530
Message-ID: <20250624033028.74389-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for dedicated DMA interrupt vectors for each SPI hardware
instance in the pci1xxxx driver. This improves scalability and interrupt
handling for systems using multiple SPI instances with DMA.

Introduce a constant `NUM_VEC_PER_INST` to define the number of IRQ
vectors per instance (main, DMA write, DMA read). Update the
`pci1xxxx_spi_internal` structure to use an IRQ array.

Refactor IRQ allocation and DMA initialization logic:
- Assign separate IRQ vectors for DMA read and write interrupts.
- Split the original DMA ISR into two handlers:
  `pci1xxxx_spi_isr_dma_rd` and `pci1xxxx_spi_isr_dma_wr`.
- Configure IMWR registers per instance using cached MSI data.
- Move DMA register configuration into a new helper function,
  `pci1xxxx_spi_dma_config()`.

Invoke the DMA initialization after all instances are configured to
ensure correct IRQ vector mapping.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
v2
- Resubmitted due to patch apply failures.

v1
- Initial submission

 drivers/spi/spi-pci1xxxx.c | 212 +++++++++++++++++++++++++------------
 1 file changed, 144 insertions(+), 68 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index a6c8bf228288..f44fe5841139 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -97,8 +97,8 @@
 #define SPI_DMA_CH1_DONE_INT		BIT(1)
 #define SPI_DMA_CH0_ABORT_INT		BIT(16)
 #define SPI_DMA_CH1_ABORT_INT		BIT(17)
-#define SPI_DMA_DONE_INT_MASK		(SPI_DMA_CH0_DONE_INT | SPI_DMA_CH1_DONE_INT)
-#define SPI_DMA_ABORT_INT_MASK		(SPI_DMA_CH0_ABORT_INT | SPI_DMA_CH1_ABORT_INT)
+#define SPI_DMA_DONE_INT_MASK(x)	(1 << (x))
+#define SPI_DMA_ABORT_INT_MASK(x)	(1 << (16 + (x)))
 #define DMA_CH_CONTROL_LIE		BIT(3)
 #define DMA_CH_CONTROL_RIE		BIT(4)
 #define DMA_INTR_EN			(DMA_CH_CONTROL_RIE | DMA_CH_CONTROL_LIE)
@@ -132,10 +132,12 @@
 #define SPI_SUSPEND_CONFIG 0x101
 #define SPI_RESUME_CONFIG 0x203
 
+#define NUM_VEC_PER_INST 3
+
 struct pci1xxxx_spi_internal {
 	u8 hw_inst;
 	u8 clkdiv;
-	int irq;
+	int irq[NUM_VEC_PER_INST];
 	int mode;
 	bool spi_xfer_in_progress;
 	void *rx_buf;
@@ -193,6 +195,9 @@ static const struct pci_device_id pci1xxxx_spi_pci_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, pci1xxxx_spi_pci_id_table);
 
+static irqreturn_t pci1xxxx_spi_isr_dma_rd(int irq, void *dev);
+static irqreturn_t pci1xxxx_spi_isr_dma_wr(int irq, void *dev);
+
 static int pci1xxxx_set_sys_lock(struct pci1xxxx_spi *par)
 {
 	writel(SPI_SYSLOCK, par->reg_base + SPI_SYSLOCK_REG);
@@ -213,13 +218,16 @@ static void pci1xxxx_release_sys_lock(struct pci1xxxx_spi *par)
 	writel(0x0, par->reg_base + SPI_SYSLOCK_REG);
 }
 
-static int pci1xxxx_check_spi_can_dma(struct pci1xxxx_spi *spi_bus, int irq)
+static int pci1xxxx_check_spi_can_dma(struct pci1xxxx_spi *spi_bus, int hw_inst, int num_vector)
 {
 	struct pci_dev *pdev = spi_bus->dev;
 	u32 pf_num;
 	u32 regval;
 	int ret;
 
+	if (num_vector != hw_inst * NUM_VEC_PER_INST)
+		return -EOPNOTSUPP;
+
 	/*
 	 * DEV REV Registers is a system register, HW Syslock bit
 	 * should be acquired before accessing the register
@@ -247,16 +255,6 @@ static int pci1xxxx_check_spi_can_dma(struct pci1xxxx_spi *spi_bus, int irq)
 	if (spi_bus->dev_rev < 0xC0 || pf_num)
 		return -EOPNOTSUPP;
 
-	/*
-	 * DMA Supported only with MSI Interrupts
-	 * One of the SPI instance's MSI vector address and data
-	 * is used for DMA Interrupt
-	 */
-	if (!irq_get_msi_desc(irq)) {
-		dev_warn(&pdev->dev, "Error MSI Interrupt not supported, will operate in PIO mode\n");
-		return -EOPNOTSUPP;
-	}
-
 	spi_bus->dma_offset_bar = pcim_iomap(pdev, 2, pci_resource_len(pdev, 2));
 	if (!spi_bus->dma_offset_bar) {
 		dev_warn(&pdev->dev, "Error failed to map dma bar, will operate in PIO mode\n");
@@ -273,29 +271,90 @@ static int pci1xxxx_check_spi_can_dma(struct pci1xxxx_spi *spi_bus, int irq)
 	return 0;
 }
 
-static int pci1xxxx_spi_dma_init(struct pci1xxxx_spi *spi_bus, int irq)
+static void pci1xxxx_spi_dma_config(struct pci1xxxx_spi *spi_bus)
 {
+	struct pci1xxxx_spi_internal *spi_sub_ptr;
+	u8 iter, irq_index;
 	struct msi_msg msi;
+	u32 regval;
+	u16 data;
+
+	irq_index = spi_bus->total_hw_instances;
+	for (iter = 0; iter < spi_bus->total_hw_instances; iter++) {
+		spi_sub_ptr = spi_bus->spi_int[iter];
+		get_cached_msi_msg(spi_sub_ptr->irq[1], &msi);
+		if (iter == 0) {
+			writel(msi.address_hi, spi_bus->dma_offset_bar +
+			       SPI_DMA_INTR_IMWR_WDONE_HIGH);
+			writel(msi.address_hi, spi_bus->dma_offset_bar +
+			       SPI_DMA_INTR_IMWR_WABORT_HIGH);
+			writel(msi.address_hi, spi_bus->dma_offset_bar +
+			       SPI_DMA_INTR_IMWR_RDONE_HIGH);
+			writel(msi.address_hi, spi_bus->dma_offset_bar +
+			       SPI_DMA_INTR_IMWR_RABORT_HIGH);
+			writel(msi.address_lo, spi_bus->dma_offset_bar +
+			       SPI_DMA_INTR_IMWR_WDONE_LOW);
+			writel(msi.address_lo, spi_bus->dma_offset_bar +
+			       SPI_DMA_INTR_IMWR_WABORT_LOW);
+			writel(msi.address_lo, spi_bus->dma_offset_bar +
+			       SPI_DMA_INTR_IMWR_RDONE_LOW);
+			writel(msi.address_lo, spi_bus->dma_offset_bar +
+			       SPI_DMA_INTR_IMWR_RABORT_LOW);
+			writel(0, spi_bus->dma_offset_bar + SPI_DMA_INTR_WR_IMWR_DATA);
+			writel(0, spi_bus->dma_offset_bar + SPI_DMA_INTR_RD_IMWR_DATA);
+		}
+		regval = readl(spi_bus->dma_offset_bar + SPI_DMA_INTR_WR_IMWR_DATA);
+		data = msi.data + irq_index;
+		writel((regval | (data << (iter * 16))), spi_bus->dma_offset_bar +
+		       SPI_DMA_INTR_WR_IMWR_DATA);
+		regval = readl(spi_bus->dma_offset_bar + SPI_DMA_INTR_WR_IMWR_DATA);
+		irq_index++;
+
+		data = msi.data + irq_index;
+		regval = readl(spi_bus->dma_offset_bar + SPI_DMA_INTR_RD_IMWR_DATA);
+		writel(regval | (data << (iter * 16)), spi_bus->dma_offset_bar +
+		       SPI_DMA_INTR_RD_IMWR_DATA);
+		regval = readl(spi_bus->dma_offset_bar + SPI_DMA_INTR_RD_IMWR_DATA);
+		irq_index++;
+	}
+}
+
+static int pci1xxxx_spi_dma_init(struct pci1xxxx_spi *spi_bus, int hw_inst, int num_vector)
+{
+	struct pci1xxxx_spi_internal *spi_sub_ptr;
+	u8 iter, irq_index;
 	int ret;
 
-	ret = pci1xxxx_check_spi_can_dma(spi_bus, irq);
+	irq_index = hw_inst;
+	ret = pci1xxxx_check_spi_can_dma(spi_bus, hw_inst, num_vector);
 	if (ret)
 		return ret;
 
 	spin_lock_init(&spi_bus->dma_reg_lock);
-	get_cached_msi_msg(irq, &msi);
 	writel(SPI_DMA_ENGINE_EN, spi_bus->dma_offset_bar + SPI_DMA_GLOBAL_WR_ENGINE_EN);
 	writel(SPI_DMA_ENGINE_EN, spi_bus->dma_offset_bar + SPI_DMA_GLOBAL_RD_ENGINE_EN);
-	writel(msi.address_hi, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_WDONE_HIGH);
-	writel(msi.address_hi, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_WABORT_HIGH);
-	writel(msi.address_hi, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_RDONE_HIGH);
-	writel(msi.address_hi, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_RABORT_HIGH);
-	writel(msi.address_lo, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_WDONE_LOW);
-	writel(msi.address_lo, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_WABORT_LOW);
-	writel(msi.address_lo, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_RDONE_LOW);
-	writel(msi.address_lo, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_RABORT_LOW);
-	writel(msi.data, spi_bus->dma_offset_bar + SPI_DMA_INTR_WR_IMWR_DATA);
-	writel(msi.data, spi_bus->dma_offset_bar + SPI_DMA_INTR_RD_IMWR_DATA);
+
+	for (iter = 0; iter < hw_inst; iter++) {
+		spi_sub_ptr = spi_bus->spi_int[iter];
+		spi_sub_ptr->irq[1] = pci_irq_vector(spi_bus->dev, irq_index);
+		ret = devm_request_irq(&spi_bus->dev->dev, spi_sub_ptr->irq[1],
+				       pci1xxxx_spi_isr_dma_wr, PCI1XXXX_IRQ_FLAGS,
+				       pci_name(spi_bus->dev), spi_sub_ptr);
+		if (ret < 0)
+			return ret;
+
+		irq_index++;
+
+		spi_sub_ptr->irq[2] = pci_irq_vector(spi_bus->dev, irq_index);
+		ret = devm_request_irq(&spi_bus->dev->dev, spi_sub_ptr->irq[2],
+				       pci1xxxx_spi_isr_dma_rd, PCI1XXXX_IRQ_FLAGS,
+				       pci_name(spi_bus->dev), spi_sub_ptr);
+		if (ret < 0)
+			return ret;
+
+		irq_index++;
+	}
+	pci1xxxx_spi_dma_config(spi_bus);
 	dma_set_max_seg_size(&spi_bus->dev->dev, PCI1XXXX_SPI_BUFFER_SIZE);
 	spi_bus->can_dma = true;
 	return 0;
@@ -401,13 +460,13 @@ static void pci1xxxx_spi_setup(struct pci1xxxx_spi *par, u8 hw_inst, u32 mode,
 	writel(regval, par->reg_base + SPI_MST_CTL_REG_OFFSET(hw_inst));
 }
 
-static void pci1xxxx_start_spi_xfer(struct pci1xxxx_spi_internal *p, u8 hw_inst)
+static void pci1xxxx_start_spi_xfer(struct pci1xxxx_spi_internal *p)
 {
 	u32 regval;
 
-	regval = readl(p->parent->reg_base + SPI_MST_CTL_REG_OFFSET(hw_inst));
+	regval = readl(p->parent->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
 	regval |= SPI_MST_CTL_GO;
-	writel(regval, p->parent->reg_base + SPI_MST_CTL_REG_OFFSET(hw_inst));
+	writel(regval, p->parent->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
 }
 
 static int pci1xxxx_spi_transfer_with_io(struct spi_controller *spi_ctlr,
@@ -451,7 +510,7 @@ static int pci1xxxx_spi_transfer_with_io(struct spi_controller *spi_ctlr,
 				    &tx_buf[bytes_transfered], len);
 			bytes_transfered += len;
 			pci1xxxx_spi_setup(par, p->hw_inst, spi->mode, clkdiv, len);
-			pci1xxxx_start_spi_xfer(p, p->hw_inst);
+			pci1xxxx_start_spi_xfer(p);
 
 			/* Wait for DMA_TERM interrupt */
 			result = wait_for_completion_timeout(&p->spi_xfer_done,
@@ -627,7 +686,7 @@ static void pci1xxxx_spi_setup_next_dma_transfer(struct pci1xxxx_spi_internal *p
 	}
 }
 
-static irqreturn_t pci1xxxx_spi_isr_dma(int irq, void *dev)
+static irqreturn_t pci1xxxx_spi_isr_dma_rd(int irq, void *dev)
 {
 	struct pci1xxxx_spi_internal *p = dev;
 	irqreturn_t spi_int_fired = IRQ_NONE;
@@ -637,36 +696,53 @@ static irqreturn_t pci1xxxx_spi_isr_dma(int irq, void *dev)
 	spin_lock_irqsave(&p->parent->dma_reg_lock, flags);
 	/* Clear the DMA RD INT and start spi xfer*/
 	regval = readl(p->parent->dma_offset_bar + SPI_DMA_INTR_RD_STS);
-	if (regval & SPI_DMA_DONE_INT_MASK) {
-		if (regval & SPI_DMA_CH0_DONE_INT)
-			pci1xxxx_start_spi_xfer(p, SPI0);
-		if (regval & SPI_DMA_CH1_DONE_INT)
-			pci1xxxx_start_spi_xfer(p, SPI1);
-		spi_int_fired = IRQ_HANDLED;
-	}
-	if (regval & SPI_DMA_ABORT_INT_MASK) {
-		p->dma_aborted_rd = true;
-		spi_int_fired = IRQ_HANDLED;
+	if (regval) {
+		if (regval & SPI_DMA_DONE_INT_MASK(p->hw_inst)) {
+			pci1xxxx_start_spi_xfer(p);
+			spi_int_fired = IRQ_HANDLED;
+		}
+		if (regval & SPI_DMA_ABORT_INT_MASK(p->hw_inst)) {
+			p->dma_aborted_rd = true;
+			spi_int_fired = IRQ_HANDLED;
+		}
 	}
-	writel(regval, p->parent->dma_offset_bar + SPI_DMA_INTR_RD_CLR);
+	writel((SPI_DMA_DONE_INT_MASK(p->hw_inst) | SPI_DMA_ABORT_INT_MASK(p->hw_inst)),
+	       p->parent->dma_offset_bar + SPI_DMA_INTR_RD_CLR);
+	spin_unlock_irqrestore(&p->parent->dma_reg_lock, flags);
+	return spi_int_fired;
+}
 
+static irqreturn_t pci1xxxx_spi_isr_dma_wr(int irq, void *dev)
+{
+	struct pci1xxxx_spi_internal *p = dev;
+	irqreturn_t spi_int_fired = IRQ_NONE;
+	unsigned long flags;
+	u32 regval;
+
+	spin_lock_irqsave(&p->parent->dma_reg_lock, flags);
 	/* Clear the DMA WR INT */
 	regval = readl(p->parent->dma_offset_bar + SPI_DMA_INTR_WR_STS);
-	if (regval & SPI_DMA_DONE_INT_MASK) {
-		if (regval & SPI_DMA_CH0_DONE_INT)
-			pci1xxxx_spi_setup_next_dma_transfer(p->parent->spi_int[SPI0]);
-
-		if (regval & SPI_DMA_CH1_DONE_INT)
-			pci1xxxx_spi_setup_next_dma_transfer(p->parent->spi_int[SPI1]);
-
-		spi_int_fired = IRQ_HANDLED;
-	}
-	if (regval & SPI_DMA_ABORT_INT_MASK) {
-		p->dma_aborted_wr = true;
-		spi_int_fired = IRQ_HANDLED;
+	if (regval) {
+		if (regval & SPI_DMA_DONE_INT_MASK(p->hw_inst)) {
+			pci1xxxx_spi_setup_next_dma_transfer(p);
+			spi_int_fired = IRQ_HANDLED;
+		}
+		if (regval & SPI_DMA_ABORT_INT_MASK(p->hw_inst)) {
+			p->dma_aborted_wr = true;
+			spi_int_fired = IRQ_HANDLED;
+		}
 	}
-	writel(regval, p->parent->dma_offset_bar + SPI_DMA_INTR_WR_CLR);
+	writel((SPI_DMA_DONE_INT_MASK(p->hw_inst) | SPI_DMA_ABORT_INT_MASK(p->hw_inst)),
+	       p->parent->dma_offset_bar + SPI_DMA_INTR_WR_CLR);
 	spin_unlock_irqrestore(&p->parent->dma_reg_lock, flags);
+	return spi_int_fired;
+}
+
+static irqreturn_t pci1xxxx_spi_isr_dma(int irq, void *dev)
+{
+	struct pci1xxxx_spi_internal *p = dev;
+	irqreturn_t spi_int_fired = IRQ_NONE;
+	u32 regval;
 
 	/* Clear the SPI GO_BIT Interrupt */
 	regval = readl(p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
@@ -764,7 +840,7 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 			if (!spi_bus->reg_base)
 				return -EINVAL;
 
-			num_vector = pci_alloc_irq_vectors(pdev, 1, hw_inst_cnt,
+			num_vector = pci_alloc_irq_vectors(pdev, 1, hw_inst_cnt * NUM_VEC_PER_INST,
 							   PCI_IRQ_INTX | PCI_IRQ_MSI);
 			if (num_vector < 0) {
 				dev_err(&pdev->dev, "Error allocating MSI vectors\n");
@@ -778,27 +854,23 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 			regval &= ~SPI_INTR;
 			writel(regval, spi_bus->reg_base +
 			       SPI_MST_EVENT_MASK_REG_OFFSET(spi_sub_ptr->hw_inst));
-			spi_sub_ptr->irq = pci_irq_vector(pdev, 0);
+			spi_sub_ptr->irq[0] = pci_irq_vector(pdev, 0);
 
 			if (num_vector >= hw_inst_cnt)
-				ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq,
+				ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq[0],
 						       pci1xxxx_spi_isr, PCI1XXXX_IRQ_FLAGS,
 						       pci_name(pdev), spi_sub_ptr);
 			else
-				ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq,
+				ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq[0],
 						       pci1xxxx_spi_shared_isr,
 						       PCI1XXXX_IRQ_FLAGS | IRQF_SHARED,
 						       pci_name(pdev), spi_bus);
 			if (ret < 0) {
 				dev_err(&pdev->dev, "Unable to request irq : %d",
-					spi_sub_ptr->irq);
+					spi_sub_ptr->irq[0]);
 				return -ENODEV;
 			}
 
-			ret = pci1xxxx_spi_dma_init(spi_bus, spi_sub_ptr->irq);
-			if (ret && ret != -EOPNOTSUPP)
-				return ret;
-
 			/* This register is only applicable for 1st instance */
 			regval = readl(spi_bus->reg_base + SPI_PCI_CTRL_REG_OFFSET(0));
 			if (!only_sec_inst)
@@ -820,13 +892,13 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 			writel(regval, spi_bus->reg_base +
 			       SPI_MST_EVENT_MASK_REG_OFFSET(spi_sub_ptr->hw_inst));
 			if (num_vector >= hw_inst_cnt) {
-				spi_sub_ptr->irq = pci_irq_vector(pdev, iter);
-				ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq,
+				spi_sub_ptr->irq[0] = pci_irq_vector(pdev, iter);
+				ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq[0],
 						       pci1xxxx_spi_isr, PCI1XXXX_IRQ_FLAGS,
 						       pci_name(pdev), spi_sub_ptr);
 				if (ret < 0) {
 					dev_err(&pdev->dev, "Unable to request irq : %d",
-						spi_sub_ptr->irq);
+						spi_sub_ptr->irq[0]);
 					return -ENODEV;
 				}
 			}
@@ -849,6 +921,10 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 		if (ret)
 			return ret;
 	}
+	ret = pci1xxxx_spi_dma_init(spi_bus, hw_inst_cnt, num_vector);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
 	pci_set_drvdata(pdev, spi_bus);
 
 	return 0;
-- 
2.25.1



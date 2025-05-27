Return-Path: <linux-spi+bounces-8308-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34916AC4C54
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 12:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E461D17A765
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 10:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B63F1FCF41;
	Tue, 27 May 2025 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F1AFC8op"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52461F4C89;
	Tue, 27 May 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748342230; cv=none; b=Fxms5qUVCW65NW+dVCst5SkteSx+f9hx5JPkllavamkq+nxUSC5blwmwoSOOJBKov3LRSd3MmHx4GClpj7BhD7Ja37Dae81gtA9norqEF7/ETAGY53GdlHXDqI99QRkfgcLcZyfBw3PgMYZ5NM3/V5YeXcGQnLnVHOsc0Pn2klE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748342230; c=relaxed/simple;
	bh=14eEI/4GHUx4YFPwfbjK7l6nKVMJ5IDSQaNzymYE4+Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sN3ojmp3V7v4VjItA9csKPifXjZYf7E/a0zwF/7WoHyZaQF7R0wfQ93K8o8o++U/F4csq55mUPtfoKoB1FLyMlGXIwx4SBgYqUSvzoRpNmgfNze6sU2kFaTxxLIZfhKBGjzpHBY8jV9u2l0uS1y1hGlvAUSL5s5+AUwws6jFJrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F1AFC8op; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748342228; x=1779878228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=14eEI/4GHUx4YFPwfbjK7l6nKVMJ5IDSQaNzymYE4+Q=;
  b=F1AFC8op+3xshviq9w077/RTrL436D81LKu299X4yB6CCVU7kjbPduki
   y9CRXABYA4XoV8Ufj1jnqEv+GyzhkPvET5+5H0f5X6wo+3mMh0Cq8RYHk
   3uCo4Lba/V7CKySDzpbvVAuMyTgCJ3sPHkK8cXggDVBUTJUGj4oXsV2fR
   yi9Q0ICDO4k8PkZ+DZ2rJTT4bONMDKar7mVSTuo5sQpjnDXj5cCUQM9LI
   mPywakU9iBl9Ej0xahqumU+jNmmYimry34pBF8GJIQxhP90Z8Y/ongyAT
   kVwUaxE2cg/TQOcyofuRc1snQiQ+9d/1in2RU4ygBfov+4AsucP/l2OC9
   Q==;
X-CSE-ConnectionGUID: k+/LUUWvTcqTr/vhfMigFA==
X-CSE-MsgGUID: jeyk1K1ZQ/eMsbZPGCbFjA==
X-IronPort-AV: E=Sophos;i="6.15,318,1739862000"; 
   d="scan'208";a="42655830"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2025 03:37:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 27 May 2025 03:36:50 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 27 May 2025 03:36:47 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <UNGLinuxDriver@microchip.com>
Subject: [PATCH v1 for-next] spi: spi-pci1xxxx: Fix Probe failure with Dual SPI instance with INTx interrupts
Date: Tue, 27 May 2025 16:02:44 +0530
Message-ID: <20250527103244.26861-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Fixes a probe failure that occurs when dual SPI controllers are
enabled and INTx interrupts are used. Reduces the minimum required
number of interrupt vectors to 1 and registers a shared ISR when
the allocated vectors are fewer than the number of controllers.
This change ensures that the probe succeeds even with limited
vectors, restoring INTx functionality when multiple SPI
controllers are present.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/spi/spi-pci1xxxx.c | 48 +++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index e9153570e9e9..9a7b86a5ec75 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -688,6 +688,17 @@ static irqreturn_t pci1xxxx_spi_isr(int irq, void *dev)
 		return pci1xxxx_spi_isr_io(irq, dev);
 }
 
+static irqreturn_t pci1xxxx_spi_shared_isr(int irq, void *dev)
+{
+	struct pci1xxxx_spi *par = dev;
+	u8 i = 0;
+
+	for (i = 0; i < par->total_hw_instances; i++)
+		pci1xxxx_spi_isr(irq, par->spi_int[i]);
+
+	return IRQ_HANDLED;
+}
+
 static bool pci1xxxx_spi_can_dma(struct spi_controller *host,
 				 struct spi_device *spi,
 				 struct spi_transfer *xfer)
@@ -705,6 +716,7 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 	struct device *dev = &pdev->dev;
 	struct pci1xxxx_spi *spi_bus;
 	struct spi_controller *spi_host;
+	int num_vector = 0;
 	u32 regval;
 	int ret;
 
@@ -752,9 +764,9 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 			if (!spi_bus->reg_base)
 				return -EINVAL;
 
-			ret = pci_alloc_irq_vectors(pdev, hw_inst_cnt, hw_inst_cnt,
-						    PCI_IRQ_ALL_TYPES);
-			if (ret < 0) {
+			num_vector = pci_alloc_irq_vectors(pdev, 1, hw_inst_cnt,
+							   PCI_IRQ_ALL_TYPES);
+			if (num_vector < 0) {
 				dev_err(&pdev->dev, "Error allocating MSI vectors\n");
 				return ret;
 			}
@@ -768,9 +780,15 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 			       SPI_MST_EVENT_MASK_REG_OFFSET(spi_sub_ptr->hw_inst));
 			spi_sub_ptr->irq = pci_irq_vector(pdev, 0);
 
-			ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq,
-					       pci1xxxx_spi_isr, PCI1XXXX_IRQ_FLAGS,
-					       pci_name(pdev), spi_sub_ptr);
+			if (num_vector >= hw_inst_cnt)
+				ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq,
+						       pci1xxxx_spi_isr, PCI1XXXX_IRQ_FLAGS,
+						       pci_name(pdev), spi_sub_ptr);
+			else
+				ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq,
+						       pci1xxxx_spi_shared_isr,
+						       PCI1XXXX_IRQ_FLAGS | IRQF_SHARED,
+						       pci_name(pdev), spi_bus);
 			if (ret < 0) {
 				dev_err(&pdev->dev, "Unable to request irq : %d",
 					spi_sub_ptr->irq);
@@ -801,14 +819,16 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 			regval &= ~SPI_INTR;
 			writel(regval, spi_bus->reg_base +
 			       SPI_MST_EVENT_MASK_REG_OFFSET(spi_sub_ptr->hw_inst));
-			spi_sub_ptr->irq = pci_irq_vector(pdev, iter);
-			ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq,
-					       pci1xxxx_spi_isr, PCI1XXXX_IRQ_FLAGS,
-					       pci_name(pdev), spi_sub_ptr);
-			if (ret < 0) {
-				dev_err(&pdev->dev, "Unable to request irq : %d",
-					spi_sub_ptr->irq);
-				return -ENODEV;
+			if (num_vector >= hw_inst_cnt) {
+				spi_sub_ptr->irq = pci_irq_vector(pdev, iter);
+				ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq,
+						       pci1xxxx_spi_isr, PCI1XXXX_IRQ_FLAGS,
+						       pci_name(pdev), spi_sub_ptr);
+				if (ret < 0) {
+					dev_err(&pdev->dev, "Unable to request irq : %d",
+						spi_sub_ptr->irq);
+					return -ENODEV;
+				}
 			}
 		}
 
-- 
2.25.1



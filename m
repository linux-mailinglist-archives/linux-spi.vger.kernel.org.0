Return-Path: <linux-spi+bounces-10428-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F421EBB3DBC
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 14:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90393C655E
	for <lists+linux-spi@lfdr.de>; Thu,  2 Oct 2025 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35B93101DE;
	Thu,  2 Oct 2025 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fhQIOLqt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAFC30FF3B
	for <linux-spi@vger.kernel.org>; Thu,  2 Oct 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407301; cv=none; b=GLrx+Yr8F23gq79WF1zOJRqDAjWhb+RmhZx517WMbFhl3hRMXrtTzT5Tz6qHzY3MXrrd7efoZ7NVxvb9yMCK7QH/N7yjYgE6UllTiJEzqmu8rtf+oxTL+Ai4KjTEtEmg1aGQMbn+6hTH/r44NKKVseCD3cFPECu2G8yW+EEe1U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407301; c=relaxed/simple;
	bh=hVnrm8LAV7i3iTfAtSZSVl9aIzhXWYpVq9NgQru9pZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eNqBkuc0XRWRRkfZuZfCTC3fea0GvpVNyTwsLF90BFr9t/id1m1FAWaa+Lh8TULI5m+aMlRAHogNDYC8Gd9ycz3XMzuGj9Nir2/17sIzMEQXzsKrefxrPVeBp1fL6C3a34WB4Mij7PWSSaySMDXYx65twCN5Xb6u48Qm3QobVy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fhQIOLqt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EFA854E40E73
	for <linux-spi@vger.kernel.org>; Thu,  2 Oct 2025 12:14:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C09546062C;
	Thu,  2 Oct 2025 12:14:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78F23102F06E7;
	Thu,  2 Oct 2025 14:14:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759407297; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=55qKq9XUEwMg11SwoucBKDCPf/P3augAEJP1FaUSztE=;
	b=fhQIOLqt/ahoZNDiKUdPQ1cbc7iEMsCIlSYbKxAlqjnwXM+qqREWIzr0LhZaeEXHSHK74Z
	GQ3dyj0M3uJ0camelXBBbPrjNezT71YQL+nZHXZanYB550IwOobRu8viKRkqYO3AW6pIyB
	F0Ho/qaQSSFKyu7FCxpQfXiNmLuVWGywoKIwcUVkxGqbPY+W3AGS2CPWUoG05jNqjPQLBv
	kBidtWU56ax77OeM3MKkk4cW1h+mdDZqNd/7dOnNQJCaqCEPVKClWPInGrJ+q5gOGEZUcX
	7bTdhYMi/LSU4m+wayPy9cMY77m+XJHt6wb8J6FuFDsEZcZL9FPJrWO6gwc2dg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Thu, 02 Oct 2025 14:14:38 +0200
Subject: [PATCH RFC 2/2] spi: dw: add target mode support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251002-spi-dw-target-v1-2-993e91c1a712@bootlin.com>
References: <20251002-spi-dw-target-v1-0-993e91c1a712@bootlin.com>
In-Reply-To: <20251002-spi-dw-target-v1-0-993e91c1a712@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Implement target mode for the DesignWare controller with the following
changes:

Allocate an SPI controller of the correct type based on the spi-slave
property in dw_spi_add_controller() and set the controller properties
depending on its type. Since they are only relevant when acting as a host
controller, settings related to chip-select control and the set_cs()
callback are only set in host mode, as are the loopback support, the
memory operations and the maximum frequency. The target_abort() callback
is set only when configured in target mode.

The number of chip-select is set to 1 in dw_spi_hw_init() since the
controller only has one CS input in target mode.

In dw_spi_update_config(), return after setting the CTRLR0 register as
the other registers are only relevant in host mode and are read-only
in target mode. This function is called as part of the transfer_one()
callback, which is identical in both the host and target mode.

Move the code implementing the handle_err() callback to a new function
named dw_spi_abort(), and use it to implement both the handle_err()
and the target_abort() callbacks.

Finally, drop the error path on the spi-slave property in
dw_spi_mmio_probe(), as it is now a valid configuration.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/spi/spi-dw-core.c | 82 ++++++++++++++++++++++++++++++++---------------
 drivers/spi/spi-dw-mmio.c |  5 ---
 2 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 90dea6f9b3dab773204c667cb12f3ecaef1d7108..9ebf244294f89db1c5f26471d18eb298ae804cd9 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -332,6 +332,9 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
+	if (spi_controller_is_target(dws->ctlr))
+		return;
+
 	if (cfg->tmode == DW_SPI_CTRLR0_TMOD_EPROMREAD ||
 	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO)
 		dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf ? cfg->ndf - 1 : 0);
@@ -462,8 +465,7 @@ static int dw_spi_transfer_one(struct spi_controller *ctlr,
 	return 1;
 }
 
-static void dw_spi_handle_err(struct spi_controller *ctlr,
-			      struct spi_message *msg)
+static inline void dw_spi_abort(struct spi_controller *ctlr)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
 
@@ -473,6 +475,19 @@ static void dw_spi_handle_err(struct spi_controller *ctlr,
 	dw_spi_reset_chip(dws);
 }
 
+static void dw_spi_handle_err(struct spi_controller *ctlr,
+			      struct spi_message *msg)
+{
+	dw_spi_abort(ctlr);
+}
+
+static int dw_spi_target_abort(struct spi_controller *ctlr)
+{
+	dw_spi_abort(ctlr);
+
+	return 0;
+}
+
 static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	if (op->data.dir == SPI_MEM_DATA_IN)
@@ -834,18 +849,23 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 			DW_SPI_GET_BYTE(dws->ver, 1));
 	}
 
-	/*
-	 * Try to detect the number of native chip-selects if the platform
-	 * driver didn't set it up. There can be up to 16 lines configured.
-	 */
-	if (!dws->num_cs) {
-		u32 ser;
+	if (spi_controller_is_target(dws->ctlr)) {
+		/* There is only one CS input signal in target mode */
+		dws->num_cs = 1;
+	} else {
+		/*
+		 * Try to detect the number of native chip-selects if the platform
+		 * driver didn't set it up. There can be up to 16 lines configured.
+		 */
+		if (!dws->num_cs) {
+			u32 ser;
 
-		dw_writel(dws, DW_SPI_SER, 0xffff);
-		ser = dw_readl(dws, DW_SPI_SER);
-		dw_writel(dws, DW_SPI_SER, 0);
+			dw_writel(dws, DW_SPI_SER, 0xffff);
+			ser = dw_readl(dws, DW_SPI_SER);
+			dw_writel(dws, DW_SPI_SER, 0);
 
-		dws->num_cs = hweight16(ser);
+			dws->num_cs = hweight16(ser);
+		}
 	}
 
 	/*
@@ -901,12 +921,18 @@ static const struct spi_controller_mem_caps dw_spi_mem_caps = {
 int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 {
 	struct spi_controller *ctlr;
+	bool target;
 	int ret;
 
 	if (!dws)
 		return -EINVAL;
 
-	ctlr = spi_alloc_host(dev, 0);
+	target = device_property_read_bool(dev, "spi-slave");
+	if (target)
+		ctlr = spi_alloc_target(dev, 0);
+	else
+		ctlr = spi_alloc_host(dev, 0);
+
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -929,8 +955,7 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 
 	dw_spi_init_mem_ops(dws);
 
-	ctlr->use_gpio_descriptors = true;
-	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
 	if (dws->caps & DW_SPI_CAP_DFS32)
 		ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	else
@@ -939,20 +964,27 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 	ctlr->num_chipselect = dws->num_cs;
 	ctlr->setup = dw_spi_setup;
 	ctlr->cleanup = dw_spi_cleanup;
-	if (dws->set_cs)
-		ctlr->set_cs = dws->set_cs;
-	else
-		ctlr->set_cs = dw_spi_set_cs;
 	ctlr->transfer_one = dw_spi_transfer_one;
 	ctlr->handle_err = dw_spi_handle_err;
-	if (dws->mem_ops.exec_op) {
-		ctlr->mem_ops = &dws->mem_ops;
-		ctlr->mem_caps = &dw_spi_mem_caps;
-	}
-	ctlr->max_speed_hz = dws->max_freq;
-	ctlr->flags = SPI_CONTROLLER_GPIO_SS;
 	ctlr->auto_runtime_pm = true;
 
+	if (!target) {
+		ctlr->use_gpio_descriptors = true;
+		ctlr->mode_bits |= SPI_LOOP;
+		if (dws->set_cs)
+			ctlr->set_cs = dws->set_cs;
+		else
+			ctlr->set_cs = dw_spi_set_cs;
+		if (dws->mem_ops.exec_op) {
+			ctlr->mem_ops = &dws->mem_ops;
+			ctlr->mem_caps = &dw_spi_mem_caps;
+		}
+		ctlr->max_speed_hz = dws->max_freq;
+		ctlr->flags = SPI_CONTROLLER_GPIO_SS;
+	} else {
+		ctlr->target_abort = dw_spi_target_abort;
+	}
+
 	/* Get default rx sample delay */
 	device_property_read_u32(dev, "rx-sample-delay-ns",
 				 &dws->def_rx_sample_dly_ns);
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index cc16139e121bf2dae29a16e362db56ea8ad3a18b..f2cd675a9a1980fba447e13e356bb81a0395256e 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -321,11 +321,6 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	struct dw_spi *dws;
 	int ret;
 
-	if (device_property_read_bool(&pdev->dev, "spi-slave")) {
-		dev_warn(&pdev->dev, "spi-slave is not yet supported\n");
-		return -ENODEV;
-	}
-
 	dwsmmio = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mmio),
 			GFP_KERNEL);
 	if (!dwsmmio)

-- 
2.51.0



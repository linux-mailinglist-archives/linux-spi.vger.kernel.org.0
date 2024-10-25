Return-Path: <linux-spi+bounces-5469-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F579B097B
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D571C22EC9
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B40B13212A;
	Fri, 25 Oct 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S4NjRkZJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981118BC33
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872909; cv=none; b=YFTEz7hK0ngn2m7aKBVPRk3lu+4rky1g9ta/PXPj+8GcYm7i5nFv/eUu/SlTuBIjzf7mGZ6Em6HrlGtfhhT6aaxJDCiSas2RmlNk6lBAjTaJOxZccOu25HcQIE2HwOWnK8ybsLt28Xxe73poyLquy59OliPKcBSgtPNkB/YSbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872909; c=relaxed/simple;
	bh=UHxQeabx6W+4ehmErb/kCPeF6wFYajb230df1C9IBYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwIpZnRXOBGY//a/qMEq2XICLbgy/B+/hQs7PigQbaTqAKepZHN0TbVPK76E0Rk+8EHETvIWdjbvlKPXy+a8oqfZth6HreF7aTugCXu/DEJjrODetyWrgMmvDbpADrmCa16hcf6ORrHj2VH6y4C055S3FbXLuQhmI2kcPROYPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S4NjRkZJ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A096E0006;
	Fri, 25 Oct 2024 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24zgJ1SOwtcpnsboCjjPZCjULnvdSoTsG66ZvB9nNQI=;
	b=S4NjRkZJhfB7j3euDlq+6t4XbXNr9GiPFPjpTuFEFNXcAFXuqz3kl9AlB5Ryd1do6jgWGD
	/V1567W1jZU8IbffTaAiCYtA4uLVEW8VIynra270j9XmmYc9EYIj7cZEoc4rH5AqP8vqyB
	t2a8z6of9UTlt0MJDHTjZHIWa9pRR/8us9jWUKUVD5gxpXcgNv5V55d4BLzSAslI1ExGc9
	nux6teBIf+Ff0JqMvrs0Gfi4cLLmKJBcJ2iKqzqVmRBOP3JYPd2+eM6QEgRPAwxczfw6Dt
	AW2dhZ2vJJYtbibGCBVe7QScEf9dDh1WSjeMdiSyp8RARqL8vcNHl/chC9E1Qg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>,
	Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 01/24] spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
Date: Fri, 25 Oct 2024 18:14:38 +0200
Message-ID: <20241025161501.485684-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025161501.485684-1-miquel.raynal@bootlin.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

In the spi subsystem, the bus frequency is derived as follows:
- the controller may expose a minimum and maximum operating frequency
- the hardware description, through the spi peripheral properties,
  advise what is the maximum acceptable frequency from a device/wiring
  point of view.
Transfers must be observed at a frequency which fits both (so in
practice, the lowest maximum).

Actually, this second point mixes two information and already takes the
lowest frequency among:
- what the spi device is capable of (what is written in the component
  datasheet)
- what the wiring allows (electromagnetic sensibility, crossovers,
  terminations, antenna effect, etc).

This logic works until spi devices are no longer capable of sustaining
their highest frequency regardless of the operation. Spi memories are
typically subject to such variation. Some devices are capable of
spitting their internally stored data (essentially in read mode) at a
very fast rate, typically up to 166MHz on Winbond SPI-NAND chips, using
"fast" commands. However, some of the low-end operations, such as
regular page read-from-cache commands, are more limited and can only be
executed at 54MHz at most. This is currently a problem in the SPI-NAND
subsystem. Another situation, even if not yet supported, will be with
DTR commands, when the data is latched on both edges of the clock. The
same chips as mentioned previously are in this case limited to
80MHz. Yet another example might be continuous reads, which, under
certain circumstances, can also run at most at 104 or 120MHz.

As a matter of fact, the "one frequency per chip" policy is outdated and
more fine grain configuration is needed: we need to allow per-operation
frequency limitations. So far, all datasheets I encountered advertise a
maximum default frequency, which need to be lowered for certain specific
operations. So based on the current infrastructure, we can still expect
firmware (device trees in general) to continued advertising the same
maximum speed which is a mix between the PCB limitations and the chip
maximum capability, and expect per-operation lower frequencies when this
is relevant.

Add a `struct spi_mem_op` member to carry this information. Not
providing this field explicitly from upper layers means that there is no
further constraint and the default spi device maximum speed will be
carried instead. The SPI_MEM_OP() macro is also expanded with an
optional frequency argument, because virtually all operations can be
subject to such a limitation, and this will allow for a smooth and
discrete transition.

For controller drivers which do not implement the spi-mem interface, the
per-transfer speed is also set acordingly to a lower (than the maximum
default) speed, or 0, to comply with the current API.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c       |  8 ++++++++
 include/linux/spi/spi-mem.h | 11 ++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 17b8baf749e6..ab650ae953bb 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -356,6 +356,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	unsigned int tmpbufsize, xferpos = 0, totalxferlen = 0;
 	struct spi_controller *ctlr = mem->spi->controller;
+	unsigned int xfer_speed = op->max_freq;
 	struct spi_transfer xfers[4] = { };
 	struct spi_message msg;
 	u8 *tmpbuf;
@@ -368,6 +369,9 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (!spi_mem_internal_supports_op(mem, op))
 		return -EOPNOTSUPP;
 
+	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
+		((struct spi_mem_op *)op)->max_freq = mem->spi->max_speed_hz;
+
 	if (ctlr->mem_ops && ctlr->mem_ops->exec_op && !spi_get_csgpiod(mem->spi, 0)) {
 		ret = spi_mem_access_start(mem);
 		if (ret)
@@ -407,6 +411,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	xfers[xferpos].tx_buf = tmpbuf;
 	xfers[xferpos].len = op->cmd.nbytes;
 	xfers[xferpos].tx_nbits = op->cmd.buswidth;
+	xfers[xferpos].speed_hz = xfer_speed;
 	spi_message_add_tail(&xfers[xferpos], &msg);
 	xferpos++;
 	totalxferlen++;
@@ -421,6 +426,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		xfers[xferpos].tx_buf = tmpbuf + 1;
 		xfers[xferpos].len = op->addr.nbytes;
 		xfers[xferpos].tx_nbits = op->addr.buswidth;
+		xfers[xferpos].speed_hz = xfer_speed;
 		spi_message_add_tail(&xfers[xferpos], &msg);
 		xferpos++;
 		totalxferlen += op->addr.nbytes;
@@ -432,6 +438,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		xfers[xferpos].len = op->dummy.nbytes;
 		xfers[xferpos].tx_nbits = op->dummy.buswidth;
 		xfers[xferpos].dummy_data = 1;
+		xfers[xferpos].speed_hz = xfer_speed;
 		spi_message_add_tail(&xfers[xferpos], &msg);
 		xferpos++;
 		totalxferlen += op->dummy.nbytes;
@@ -447,6 +454,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		}
 
 		xfers[xferpos].len = op->data.nbytes;
+		xfers[xferpos].speed_hz = xfer_speed;
 		spi_message_add_tail(&xfers[xferpos], &msg);
 		xferpos++;
 		totalxferlen += op->data.nbytes;
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index f866d5c8ed32..8963f236911b 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -68,6 +68,9 @@ enum spi_mem_data_dir {
 	SPI_MEM_DATA_OUT,
 };
 
+#define SPI_MEM_OP_MAX_FREQ(__freq)				\
+	.max_freq = __freq
+
 /**
  * struct spi_mem_op - describes a SPI memory operation
  * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
@@ -95,6 +98,9 @@ enum spi_mem_data_dir {
  *		 operation does not involve transferring data
  * @data.buf.in: input buffer (must be DMA-able)
  * @data.buf.out: output buffer (must be DMA-able)
+ * @max_freq: frequency limitation wrt this operation. 0 means there is no
+ *	      specific constraint and the highest achievable frequency can be
+ *	      attempted).
  */
 struct spi_mem_op {
 	struct {
@@ -132,14 +138,17 @@ struct spi_mem_op {
 			const void *out;
 		} buf;
 	} data;
+
+	unsigned int max_freq;
 };
 
-#define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
+#define SPI_MEM_OP(__cmd, __addr, __dummy, __data, ...)		\
 	{							\
 		.cmd = __cmd,					\
 		.addr = __addr,					\
 		.dummy = __dummy,				\
 		.data = __data,					\
+		__VA_ARGS__					\
 	}
 
 /**
-- 
2.43.0



Return-Path: <linux-spi+bounces-7244-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03787A6A5A4
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 13:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE354846B2
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 11:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D5F224224;
	Thu, 20 Mar 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VuWNkm7m"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451EB2222A0
	for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471812; cv=none; b=iTVSgicoiR31d2ebYY424XLkuv16omn0EwrsQVTLhC0A15jf6zNNmkOMPnb298A1MDJB/HZQuR+zpahsfEcEgtE8XazIznR2t2m5S9UI2ccuHUhowx4YdLQhxPz8OSxwqBo9KCRjwqN6IZogO2wNJmpucUdku5SI1sMqTS3Ep/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471812; c=relaxed/simple;
	bh=WVor5m3mbnrL3MedZdiLuNiEk+8o9BLWI0Lc4lBZLU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQpmzIIgTV64d5D9n1qOQ1jXs6D5m1cX5o+3KGviYy8gyaGw8P1zjlHwNb0mPnmvue/7uDptB8UjrIWddBvLzmemXOt+pF3+N3wc6pNLy7zXIdtBOleBnpfKdDJj+DHLX+5q9lk42NRFP1onzsMPiTclcguxsDr0uwSNXojTcHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VuWNkm7m; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5855244385;
	Thu, 20 Mar 2025 11:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742471807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RrpUX2OXuDUhZRsn6w7EKaY4qY5AvVZ6xE/Z2kuruH4=;
	b=VuWNkm7m3hHVaoyEWBwMudbnHbcUsY95uC/1am4IJ5jPwTrlRVfiTql+2GJdGbRRILSOFK
	gPvKEfcroqX7+cK1uH+pMyiJ0AOlrA1F5DYTXgdEPWRU5E16DBvOX5nFuLWNxxh4uLG+vz
	iaHeqi4LJPbX8jkOjByw1AX7zpZzpOopBlQpRwHOh3qosl1wq7RFCLi0rtXpaq4Ya9Wm0m
	1QYHKGld8tvbHv8mrlVgeaPQzl+rnV/tekbeeH5X+uDcqFKN0UQXtwHRZlo+TPlaawHJ5y
	AyqiBk5+kVNzxwFbQOIdoVawjoZBpJ+FpAoLBcRoREKTpH8TGxZLTg2IVXGq8A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2] spi: spi-mem: Introduce a default ->exec_op() debug log
Date: Thu, 20 Mar 2025 12:56:44 +0100
Message-ID: <20250320115644.2231240-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeetfeduleefjeffheevleeggfdtvdduhfdugeeuieejveejiedvhfdugfettdehnecukfhppeelvddrudekgedruddutddrfedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrdduuddtrdeftddphhgvlhhopehffidrshhtvghphhgrnhigphdrlhhotggrlhdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehtuhguohhrrdgrmhgsrghruhhssehlihhnrghrohdrohhrghdprhgtphhtthhop
 ehprhgrthihuhhshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrggvlhesfigrlhhlvgdrtggtpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Many spi-mem controller drivers have a very similar debug log at the
beginning of their ->exec_op() callback implementation. This debug log is
effectively useful, so let's create one that is complete and concise
enough, so developers no longer need to write their own. The verbosity
being high, VERBOSE_DEBUG will be required in this case.

Remove the debug log from individual drivers and propose a common one.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Changes in v2:
- Switch to dev_vdbg() as the log is quite chatty as advised by Tudor.
- Use two characters for the dummy bytes number to make sure alignment
  is not broken in octal mode.
---
 drivers/spi/spi-aspeed-smc.c   |  7 -------
 drivers/spi/spi-mem.c          | 11 +++++++++++
 drivers/spi/spi-mtk-snfi.c     |  3 ---
 drivers/spi/spi-npcm-fiu.c     |  5 -----
 drivers/spi/spi-stm32-qspi.c   |  5 -----
 drivers/spi/spi-zynq-qspi.c    |  4 ----
 drivers/spi/spi-zynqmp-gqspi.c |  4 ----
 7 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index e9beae95dded..62a11142bd63 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -303,13 +303,6 @@ static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 	u32 ctl_val;
 	int ret = 0;
 
-	dev_dbg(aspi->dev,
-		"CE%d %s OP %#x mode:%d.%d.%d.%d naddr:%#x ndummies:%#x len:%#x",
-		chip->cs, op->data.dir == SPI_MEM_DATA_IN ? "read" : "write",
-		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
-		op->dummy.buswidth, op->data.buswidth,
-		op->addr.nbytes, op->dummy.nbytes, op->data.nbytes);
-
 	addr_mode = readl(aspi->regs + CE_CTRL_REG);
 	addr_mode_backup = addr_mode;
 
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index a9f0f47f4759..a31a1db07aa4 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -377,6 +377,17 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	/* Make sure the operation frequency is correct before going futher */
 	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
 
+	dev_vdbg(&mem->spi->dev, "[cmd: 0x%02x][%dB addr: %#8llx][%2dB dummy][%4dB data %s] %d%c-%d%c-%d%c-%d%c @ %uHz\n",
+		 op->cmd.opcode,
+		 op->addr.nbytes, (op->addr.nbytes ? op->addr.val : 0),
+		 op->dummy.nbytes,
+		 op->data.nbytes, (op->data.nbytes ? (op->data.dir == SPI_MEM_DATA_IN ? " read" : "write") : "     "),
+		 op->cmd.buswidth, op->cmd.dtr ? 'D' : 'S',
+		 op->addr.buswidth, op->addr.dtr ? 'D' : 'S',
+		 op->dummy.buswidth, op->dummy.dtr ? 'D' : 'S',
+		 op->data.buswidth, op->data.dtr ? 'D' : 'S',
+		 op->max_freq ? op->max_freq : mem->spi->max_speed_hz);
+
 	ret = spi_mem_check_op(op);
 	if (ret)
 		return ret;
diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index fdbea9dffb62..e82ee6dcf498 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -1284,9 +1284,6 @@ static int mtk_snand_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct mtk_snand *ms = spi_controller_get_devdata(mem->spi->controller);
 
-	dev_dbg(ms->dev, "OP %02x ADDR %08llX@%d:%u DATA %d:%u", op->cmd.opcode,
-		op->addr.val, op->addr.buswidth, op->addr.nbytes,
-		op->data.buswidth, op->data.nbytes);
 	if (mtk_snand_is_page_ops(op)) {
 		if (op->data.dir == SPI_MEM_DATA_IN)
 			return mtk_snand_read_page_cache(ms, op);
diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 958bab27a081..67cc1d86de42 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -550,11 +550,6 @@ static int npcm_fiu_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	int ret = 0;
 	u8 *buf;
 
-	dev_dbg(fiu->dev, "cmd:%#x mode:%d.%d.%d.%d addr:%#llx len:%#x\n",
-		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
-		op->dummy.buswidth, op->data.buswidth, op->addr.val,
-		op->data.nbytes);
-
 	if (fiu->spix_mode || op->addr.nbytes > 4)
 		return -EOPNOTSUPP;
 
diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 540b6948b24d..9691197bbf5a 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -362,11 +362,6 @@ static int stm32_qspi_send(struct spi_device *spi, const struct spi_mem_op *op)
 	u32 ccr, cr;
 	int timeout, err = 0, err_poll_status = 0;
 
-	dev_dbg(qspi->dev, "cmd:%#x mode:%d.%d.%d.%d addr:%#llx len:%#x\n",
-		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
-		op->dummy.buswidth, op->data.buswidth,
-		op->addr.val, op->data.nbytes);
-
 	cr = readl_relaxed(qspi->io_base + QSPI_CR);
 	cr &= ~CR_PRESC_MASK & ~CR_FSEL;
 	cr |= FIELD_PREP(CR_PRESC_MASK, flash->presc);
diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 2bd25c75f881..5232483c4a3a 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -540,10 +540,6 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 	int err = 0, i;
 	u8 *tmpbuf;
 
-	dev_dbg(xqspi->dev, "cmd:%#x mode:%d.%d.%d.%d\n",
-		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
-		op->dummy.buswidth, op->data.buswidth);
-
 	zynq_qspi_chipselect(mem->spi, true);
 	zynq_qspi_config_op(xqspi, mem->spi, op);
 
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index d800d79f62a7..1c78713ad61a 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1067,10 +1067,6 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 	u16 opcode = op->cmd.opcode;
 	u64 opaddr;
 
-	dev_dbg(xqspi->dev, "cmd:%#x mode:%d.%d.%d.%d\n",
-		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
-		op->dummy.buswidth, op->data.buswidth);
-
 	mutex_lock(&xqspi->op_lock);
 	zynqmp_qspi_config_op(xqspi, op);
 	zynqmp_qspi_chipselect(mem->spi, false);
-- 
2.48.1



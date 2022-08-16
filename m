Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101F8595CDA
	for <lists+linux-spi@lfdr.de>; Tue, 16 Aug 2022 15:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiHPNIa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Aug 2022 09:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbiHPNIY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Aug 2022 09:08:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E55B5F5E
        for <linux-spi@vger.kernel.org>; Tue, 16 Aug 2022 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660655287; x=1692191287;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lBfCEfElX6Ag2tOwkyZ+uq6qfLVZPWOmtbNNq268Qk8=;
  b=Xg4FDmBska2tQBg97/e233S4E9YpEXkYnmyfLi79c/a4D+I+PfeHeA0x
   DFLEjiTxhhSTd36dAcuo6t/1YrgiljFQdMylXgliZdk6Ew+iUUGMxwyj3
   4e9dZ+OU/t75kpn5LFoBBhtMc1VjzmGTCZD6w8xEX1owaJ0T+CEP9qYfO
   iQ0Cts0DNpqje+5omKk1iCbDPK2vN3z1veQxsyMc2bEaEW41TAvemU+Vp
   19J9Mh6vjppdVBommrhrKs/T7tPzFqZtdKNhlUyJGoeJYrmLrSGTpAw1N
   Z6s/LCgGKr/ga42+lWIaB3teeoT5JqL4eSIDSUY9LK0JQJ3wTWq+W5YRO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293007881"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="293007881"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 06:08:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="603512473"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2022 06:08:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D72D1363; Tue, 16 Aug 2022 16:08:18 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: intel: Add support for second flash chip
Date:   Tue, 16 Aug 2022 16:08:18 +0300
Message-Id: <20220816130818.89600-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Intel SPI flash controller has been supporting two chip selects long
time already even if the most common configuration is to have a single
flash chip for the BIOS and related data. This adds support for the
second chip select if we find out that there are two flash components
(this information is available in the mandatory flash descriptor on the
first chip). The second chip is exposed as is without any partition
information.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel.c | 163 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 147 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index c020b276e238..55f4ee2db002 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -116,6 +116,22 @@
 #define ERASE_64K_OPCODE_SHIFT		16
 #define ERASE_64K_OPCODE_MASK		(0xff << ERASE_OPCODE_SHIFT)
 
+/* Flash descriptor fields */
+#define FLVALSIG_MAGIC			0x0ff0a55a
+#define FLMAP0_NC_MASK			GENMASK(9, 8)
+#define FLMAP0_NC_SHIFT			8
+#define FLMAP0_FCBA_MASK		GENMASK(7, 0)
+
+#define FLCOMP_C0DEN_MASK		GENMASK(3, 0)
+#define FLCOMP_C0DEN_512K		0x00
+#define FLCOMP_C0DEN_1M			0x01
+#define FLCOMP_C0DEN_2M			0x02
+#define FLCOMP_C0DEN_4M			0x03
+#define FLCOMP_C0DEN_8M			0x04
+#define FLCOMP_C0DEN_16M		0x05
+#define FLCOMP_C0DEN_32M		0x06
+#define FLCOMP_C0DEN_64M		0x07
+
 #define INTEL_SPI_TIMEOUT		5000 /* ms */
 #define INTEL_SPI_FIFO_SZ		64
 
@@ -129,6 +145,7 @@
  * @master: Pointer to the SPI controller structure
  * @nregions: Maximum number of regions
  * @pr_num: Maximum number of protected range registers
+ * @chip0_size: Size of the first flash chip in bytes
  * @locked: Is SPI setting locked
  * @swseq_reg: Use SW sequencer in register reads/writes
  * @swseq_erase: Use SW sequencer in erase operation
@@ -146,6 +163,7 @@ struct intel_spi {
 	struct spi_controller *master;
 	size_t nregions;
 	size_t pr_num;
+	size_t chip0_size;
 	bool locked;
 	bool swseq_reg;
 	bool swseq_erase;
@@ -158,6 +176,7 @@ struct intel_spi_mem_op {
 	struct spi_mem_op mem_op;
 	u32 replacement_op;
 	int (*exec_op)(struct intel_spi *ispi,
+		       const struct spi_mem *mem,
 		       const struct intel_spi_mem_op *iop,
 		       const struct spi_mem_op *op);
 };
@@ -441,7 +460,16 @@ static int intel_spi_sw_cycle(struct intel_spi *ispi, u8 opcode, size_t len,
 	return 0;
 }
 
-static int intel_spi_read_reg(struct intel_spi *ispi,
+static u32 intel_spi_chip_addr(const struct intel_spi *ispi,
+			       const struct spi_mem *mem)
+{
+	/* Pick up the correct start address */
+	if (!mem)
+		return 0;
+	return mem->spi->chip_select == 1 ? ispi->chip0_size : 0;
+}
+
+static int intel_spi_read_reg(struct intel_spi *ispi, const struct spi_mem *mem,
 			      const struct intel_spi_mem_op *iop,
 			      const struct spi_mem_op *op)
 {
@@ -449,8 +477,7 @@ static int intel_spi_read_reg(struct intel_spi *ispi,
 	u8 opcode = op->cmd.opcode;
 	int ret;
 
-	/* Address of the first chip */
-	writel(0, ispi->base + FADDR);
+	writel(intel_spi_chip_addr(ispi, mem), ispi->base + FADDR);
 
 	if (ispi->swseq_reg)
 		ret = intel_spi_sw_cycle(ispi, opcode, nbytes,
@@ -464,7 +491,7 @@ static int intel_spi_read_reg(struct intel_spi *ispi,
 	return intel_spi_read_block(ispi, op->data.buf.in, nbytes);
 }
 
-static int intel_spi_write_reg(struct intel_spi *ispi,
+static int intel_spi_write_reg(struct intel_spi *ispi, const struct spi_mem *mem,
 			       const struct intel_spi_mem_op *iop,
 			       const struct spi_mem_op *op)
 {
@@ -511,7 +538,7 @@ static int intel_spi_write_reg(struct intel_spi *ispi,
 	if (opcode == SPINOR_OP_WRDI)
 		return 0;
 
-	writel(0, ispi->base + FADDR);
+	writel(intel_spi_chip_addr(ispi, mem), ispi->base + FADDR);
 
 	/* Write the value beforehand */
 	ret = intel_spi_write_block(ispi, op->data.buf.out, nbytes);
@@ -524,13 +551,13 @@ static int intel_spi_write_reg(struct intel_spi *ispi,
 	return intel_spi_hw_cycle(ispi, opcode, nbytes);
 }
 
-static int intel_spi_read(struct intel_spi *ispi,
+static int intel_spi_read(struct intel_spi *ispi, const struct spi_mem *mem,
 			  const struct intel_spi_mem_op *iop,
 			  const struct spi_mem_op *op)
 {
-	void *read_buf = op->data.buf.in;
+	u32 addr = intel_spi_chip_addr(ispi, mem) + op->addr.val;
 	size_t block_size, nbytes = op->data.nbytes;
-	u32 addr = op->addr.val;
+	void *read_buf = op->data.buf.in;
 	u32 val, status;
 	int ret;
 
@@ -585,13 +612,13 @@ static int intel_spi_read(struct intel_spi *ispi,
 	return 0;
 }
 
-static int intel_spi_write(struct intel_spi *ispi,
+static int intel_spi_write(struct intel_spi *ispi, const struct spi_mem *mem,
 			   const struct intel_spi_mem_op *iop,
 			   const struct spi_mem_op *op)
 {
+	u32 addr = intel_spi_chip_addr(ispi, mem) + op->addr.val;
 	size_t block_size, nbytes = op->data.nbytes;
 	const void *write_buf = op->data.buf.out;
-	u32 addr = op->addr.val;
 	u32 val, status;
 	int ret;
 
@@ -648,12 +675,12 @@ static int intel_spi_write(struct intel_spi *ispi,
 	return 0;
 }
 
-static int intel_spi_erase(struct intel_spi *ispi,
+static int intel_spi_erase(struct intel_spi *ispi, const struct spi_mem *mem,
 			   const struct intel_spi_mem_op *iop,
 			   const struct spi_mem_op *op)
 {
+	u32 addr = intel_spi_chip_addr(ispi, mem) + op->addr.val;
 	u8 opcode = op->cmd.opcode;
-	u32 addr = op->addr.val;
 	u32 val, status;
 	int ret;
 
@@ -765,7 +792,7 @@ static int intel_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *o
 	if (!iop)
 		return -EOPNOTSUPP;
 
-	return iop->exec_op(ispi, iop, op);
+	return iop->exec_op(ispi, mem, iop, op);
 }
 
 static const char *intel_spi_get_name(struct spi_mem *mem)
@@ -805,7 +832,7 @@ static ssize_t intel_spi_dirmap_read(struct spi_mem_dirmap_desc *desc, u64 offs,
 	op.data.nbytes = len;
 	op.data.buf.in = buf;
 
-	ret = iop->exec_op(ispi, iop, &op);
+	ret = iop->exec_op(ispi, desc->mem, iop, &op);
 	return ret ? ret : len;
 }
 
@@ -821,7 +848,7 @@ static ssize_t intel_spi_dirmap_write(struct spi_mem_dirmap_desc *desc, u64 offs
 	op.data.nbytes = len;
 	op.data.buf.out = buf;
 
-	ret = iop->exec_op(ispi, iop, &op);
+	ret = iop->exec_op(ispi, desc->mem, iop, &op);
 	return ret ? ret : len;
 }
 
@@ -1227,10 +1254,98 @@ static void intel_spi_fill_partition(struct intel_spi *ispi,
 	}
 }
 
+static int intel_spi_read_desc(struct intel_spi *ispi)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ, 0),
+			   SPI_MEM_OP_ADDR(3, 0, 0),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_IN(0, NULL, 0));
+	u32 buf[2], nc, fcba, flcomp;
+	ssize_t ret;
+
+	op.addr.val = 0x10;
+	op.data.buf.in = buf;
+	op.data.nbytes = sizeof(buf);
+
+	ret = intel_spi_read(ispi, NULL, NULL, &op);
+	if (ret) {
+		dev_warn(ispi->dev, "failed to read descriptor\n");
+		return ret;
+	}
+
+	dev_dbg(ispi->dev, "FLVALSIG=0x%08x\n", buf[0]);
+	dev_dbg(ispi->dev, "FLMAP0=0x%08x\n", buf[1]);
+
+	if (buf[0] != FLVALSIG_MAGIC) {
+		dev_warn(ispi->dev, "descriptor signature not valid\n");
+		return -ENODEV;
+	}
+
+	fcba = (buf[1] & FLMAP0_FCBA_MASK) << 4;
+	dev_dbg(ispi->dev, "FCBA=%#x\n", fcba);
+
+	op.addr.val = fcba;
+	op.data.buf.in = &flcomp;
+	op.data.nbytes = sizeof(flcomp);
+
+	ret = intel_spi_read(ispi, NULL, NULL, &op);
+	if (ret) {
+		dev_warn(ispi->dev, "failed to read FLCOMP\n");
+		return -ENODEV;
+	}
+
+	dev_dbg(ispi->dev, "FLCOMP=0x%08x\n", flcomp);
+
+	switch (flcomp & FLCOMP_C0DEN_MASK) {
+	case FLCOMP_C0DEN_512K:
+		ispi->chip0_size = SZ_512K;
+		break;
+	case FLCOMP_C0DEN_1M:
+		ispi->chip0_size = SZ_1M;
+		break;
+	case FLCOMP_C0DEN_2M:
+		ispi->chip0_size = SZ_2M;
+		break;
+	case FLCOMP_C0DEN_4M:
+		ispi->chip0_size = SZ_4M;
+		break;
+	case FLCOMP_C0DEN_8M:
+		ispi->chip0_size = SZ_8M;
+		break;
+	case FLCOMP_C0DEN_16M:
+		ispi->chip0_size = SZ_16M;
+		break;
+	case FLCOMP_C0DEN_32M:
+		ispi->chip0_size = SZ_32M;
+		break;
+	case FLCOMP_C0DEN_64M:
+		ispi->chip0_size = SZ_64M;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(ispi->dev, "chip0 size %zd KB\n", ispi->chip0_size / SZ_1K);
+
+	nc = (buf[1] & FLMAP0_NC_MASK) >> FLMAP0_NC_SHIFT;
+	if (!nc)
+		ispi->master->num_chipselect = 1;
+	else if (nc == 1)
+		ispi->master->num_chipselect = 2;
+	else
+		return -EINVAL;
+
+	dev_dbg(ispi->dev, "%u flash components found\n",
+		ispi->master->num_chipselect);
+	return 0;
+}
+
 static int intel_spi_populate_chip(struct intel_spi *ispi)
 {
 	struct flash_platform_data *pdata;
 	struct spi_board_info chip;
+	int ret;
 
 	pdata = devm_kzalloc(ispi->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -1248,7 +1363,23 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
 	snprintf(chip.modalias, 8, "spi-nor");
 	chip.platform_data = pdata;
 
-	return spi_new_device(ispi->master, &chip) ? 0 : -ENODEV;
+	if (!spi_new_device(ispi->master, &chip))
+		return -ENODEV;
+
+	/* Add the second chip if present */
+	if (ispi->master->num_chipselect < 2)
+		return 0;
+
+	ret = intel_spi_read_desc(ispi);
+	if (ret)
+		return ret;
+
+	chip.platform_data = NULL;
+	chip.chip_select = 1;
+
+	if (!spi_new_device(ispi->master, &chip))
+		return -ENODEV;
+	return 0;
 }
 
 /**
-- 
2.35.1


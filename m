Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB660C3F7
	for <lists+linux-spi@lfdr.de>; Tue, 25 Oct 2022 08:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiJYGqS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Oct 2022 02:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJYGqP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Oct 2022 02:46:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBF514C51B
        for <linux-spi@vger.kernel.org>; Mon, 24 Oct 2022 23:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666680366; x=1698216366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lxNQ3fTP5JmxZZ3aqUO1kwvmULX9Z9mNE6pxRPVFAt8=;
  b=cmpMPVsYGY/ZNMFEa1e+ShsmP0dwK6PZwH0ahirSbIm/80ISG1BiU+05
   YwV3E0sz7Np8BMf3ZSPsJgcAYsMSD2CGQNBcjzG7YJgvH+vX4fBmHqd84
   wyXJ4ErO0PNMc66Wc3vynzVT2NlEsspgplFID1Y71/cFng6zbC+Wcm+Cd
   sgJ/u09pz2cIbwRiXWIAii7A2/28y8ZXsEK5m1AEnKeTiJD8PtQitpvZw
   tc2CwG56DwMhhqwGUH897OQ+lqYoSmhH87J+GoEAbEOztyY0fyvxhXh2g
   0phKDN3YpKbM+mvUX9vJmAXLAwV0ktjufcuyCyjGnS5Msk8OPytpaQE+F
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290904767"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="290904767"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 23:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582670120"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="582670120"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2022 23:46:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1229949; Tue, 25 Oct 2022 09:46:24 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH 1/4] spi: intel: Use ->replacement_op in intel_spi_hw_cycle()
Date:   Tue, 25 Oct 2022 09:46:20 +0300
Message-Id: <20221025064623.22808-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
References: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This way we do not need the SPI-NOR opcode -> Intel controller opcode
mapping in the function anymore.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel.c | 52 ++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index acd8ec4f86a7..b3685460d848 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -352,34 +352,25 @@ static int intel_spi_opcode_index(struct intel_spi *ispi, u8 opcode, int optype)
 	return 0;
 }
 
-static int intel_spi_hw_cycle(struct intel_spi *ispi, u8 opcode, size_t len)
+static int intel_spi_hw_cycle(struct intel_spi *ispi,
+			      const struct intel_spi_mem_op *iop, size_t len)
 {
 	u32 val, status;
 	int ret;
 
+	if (!iop->replacement_op)
+		return -EINVAL;
+
 	val = readl(ispi->base + HSFSTS_CTL);
 	val &= ~(HSFSTS_CTL_FCYCLE_MASK | HSFSTS_CTL_FDBC_MASK);
 
-	switch (opcode) {
-	case SPINOR_OP_RDID:
-		val |= HSFSTS_CTL_FCYCLE_RDID;
-		break;
-	case SPINOR_OP_WRSR:
-		val |= HSFSTS_CTL_FCYCLE_WRSR;
-		break;
-	case SPINOR_OP_RDSR:
-		val |= HSFSTS_CTL_FCYCLE_RDSR;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	if (len > INTEL_SPI_FIFO_SZ)
 		return -EINVAL;
 
 	val |= (len - 1) << HSFSTS_CTL_FDBC_SHIFT;
 	val |= HSFSTS_CTL_FCERR | HSFSTS_CTL_FDONE;
 	val |= HSFSTS_CTL_FGO;
+	val |= iop->replacement_op;
 	writel(val, ispi->base + HSFSTS_CTL);
 
 	ret = intel_spi_wait_hw_busy(ispi);
@@ -483,7 +474,7 @@ static int intel_spi_read_reg(struct intel_spi *ispi, const struct spi_mem *mem,
 		ret = intel_spi_sw_cycle(ispi, opcode, nbytes,
 					 OPTYPE_READ_NO_ADDR);
 	else
-		ret = intel_spi_hw_cycle(ispi, opcode, nbytes);
+		ret = intel_spi_hw_cycle(ispi, iop, nbytes);
 
 	if (ret)
 		return ret;
@@ -548,7 +539,7 @@ static int intel_spi_write_reg(struct intel_spi *ispi, const struct spi_mem *mem
 	if (ispi->swseq_reg)
 		return intel_spi_sw_cycle(ispi, opcode, nbytes,
 					  OPTYPE_WRITE_NO_ADDR);
-	return intel_spi_hw_cycle(ispi, opcode, nbytes);
+	return intel_spi_hw_cycle(ispi, iop, nbytes);
 }
 
 static int intel_spi_read(struct intel_spi *ispi, const struct spi_mem *mem,
@@ -912,18 +903,21 @@ static const struct spi_controller_mem_ops intel_spi_mem_ops = {
  */
 #define INTEL_SPI_GENERIC_OPS						\
 	/* Status register operations */				\
-	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),		\
-			 SPI_MEM_OP_NO_ADDR,				\
-			 INTEL_SPI_OP_DATA_IN(1),			\
-			 intel_spi_read_reg),				\
-	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 1),		\
-			 SPI_MEM_OP_NO_ADDR,				\
-			 INTEL_SPI_OP_DATA_IN(1),			\
-			 intel_spi_read_reg),				\
-	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),		\
-			 SPI_MEM_OP_NO_ADDR,				\
-			 INTEL_SPI_OP_DATA_OUT(1),			\
-			 intel_spi_write_reg),				\
+	INTEL_SPI_MEM_OP_REPL(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),	\
+			      SPI_MEM_OP_NO_ADDR,			\
+			      INTEL_SPI_OP_DATA_IN(1),			\
+			      intel_spi_read_reg,			\
+			      HSFSTS_CTL_FCYCLE_RDID),			\
+	INTEL_SPI_MEM_OP_REPL(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 1),	\
+			      SPI_MEM_OP_NO_ADDR,			\
+			      INTEL_SPI_OP_DATA_IN(1),			\
+			      intel_spi_read_reg,			\
+			      HSFSTS_CTL_FCYCLE_RDSR),			\
+	INTEL_SPI_MEM_OP_REPL(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),	\
+			      SPI_MEM_OP_NO_ADDR,			\
+			      INTEL_SPI_OP_DATA_OUT(1),			\
+			      intel_spi_write_reg,			\
+			      HSFSTS_CTL_FCYCLE_WRSR),			\
 	/* Normal read */						\
 	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ, 1),		\
 			 INTEL_SPI_OP_ADDR(3),				\
-- 
2.35.1


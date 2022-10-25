Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A564760C3F6
	for <lists+linux-spi@lfdr.de>; Tue, 25 Oct 2022 08:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiJYGqQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Oct 2022 02:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiJYGqM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Oct 2022 02:46:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE43114BB6D
        for <linux-spi@vger.kernel.org>; Mon, 24 Oct 2022 23:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666680363; x=1698216363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5JNOFxzo1aGrrSmB11wspQdqWXe6Y53E/D5P3pp5b6g=;
  b=CVsf6UbceJ9wGskjTTeADAsgA3AbIVKtcDZQlFz73Pb6yoz7+t2mKnEu
   NBtVAc/HZHw/gK8gMPjSMa+Gv6RxE78k+xgJhcLCFVUHGFLYMHR3+oSLc
   9muHWi6USzHByedmWooL3As8+hoEEhLPKKFvsetdc5r1NEmFoAH+ZApz7
   0NQ9VKl48yaNYsOHHk1dPRhRXyO6RdwWZ1MFcytOEVZW35rvN9glAUY/1
   XGFyRO9ilFzz9T6ZkIyhGhjpCGHqIRux3FvLS3o98/gCnv6rqqZGPYy/A
   mxw6RlJQcnoM/PsNZ24x4aZ65lFWo7CQTgyCJDTvCcN/MexjlHUK5Ky+m
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="295004877"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="295004877"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 23:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626323786"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="626323786"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2022 23:46:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1FA073F9; Tue, 25 Oct 2022 09:46:24 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH 3/4] spi: intel: Take possible chip address into account in intel_spi_read/write_reg()
Date:   Tue, 25 Oct 2022 09:46:22 +0300
Message-Id: <20221025064623.22808-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
References: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI-NOR operation can have non-zero chip address as well so take
this into account in intel_spi_read/write_reg().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 13a3a61239d2..8b07e41daafe 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -457,11 +457,12 @@ static int intel_spi_read_reg(struct intel_spi *ispi, const struct spi_mem *mem,
 			      const struct intel_spi_mem_op *iop,
 			      const struct spi_mem_op *op)
 {
+	u32 addr = intel_spi_chip_addr(ispi, mem) + op->addr.val;
 	size_t nbytes = op->data.nbytes;
 	u8 opcode = op->cmd.opcode;
 	int ret;
 
-	writel(intel_spi_chip_addr(ispi, mem), ispi->base + FADDR);
+	writel(addr, ispi->base + FADDR);
 
 	if (ispi->swseq_reg)
 		ret = intel_spi_sw_cycle(ispi, opcode, nbytes,
@@ -479,6 +480,7 @@ static int intel_spi_write_reg(struct intel_spi *ispi, const struct spi_mem *mem
 			       const struct intel_spi_mem_op *iop,
 			       const struct spi_mem_op *op)
 {
+	u32 addr = intel_spi_chip_addr(ispi, mem) + op->addr.val;
 	size_t nbytes = op->data.nbytes;
 	u8 opcode = op->cmd.opcode;
 	int ret;
@@ -522,7 +524,7 @@ static int intel_spi_write_reg(struct intel_spi *ispi, const struct spi_mem *mem
 	if (opcode == SPINOR_OP_WRDI)
 		return 0;
 
-	writel(intel_spi_chip_addr(ispi, mem), ispi->base + FADDR);
+	writel(addr, ispi->base + FADDR);
 
 	/* Write the value beforehand */
 	ret = intel_spi_write_block(ispi, op->data.buf.out, nbytes);
-- 
2.35.1


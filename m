Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F362260C3F9
	for <lists+linux-spi@lfdr.de>; Tue, 25 Oct 2022 08:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJYGqV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Oct 2022 02:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiJYGqQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Oct 2022 02:46:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0814214C52E
        for <linux-spi@vger.kernel.org>; Mon, 24 Oct 2022 23:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666680367; x=1698216367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZQWmkGATLKYZqGYwdxoVSjtTpUnRpjoHA1x77HC3Duw=;
  b=LiubHDzrZBP2kgb4EBAY2hSzEPQZNp9DJAT+f0gpTX07Pp1VOKdxpg/C
   bcCXDvmT+dZarB6/HunQu9B7K3vrFvynKeBn4/V+sW2Hw4rmGctr5sLiK
   3YPMrynKBkHZfzqoM65UVx88VM1IoNuR5ll8Lj/GfR6WSScxOU7m58g7m
   qfzmaGgg6TLIQdxXmEhlC8QsfaAX3KeXje/U+LOvGog9ywns4OzfM4en0
   8bh2nnUGOYnsK7Tx8Hr3T2cr0xWc36iW3dWLGIpMkyGOK8FpOlxmrzKpN
   g3eaPOnaVyQkF6bixJ5fCsdKYu3LZuErrVUYFEmBRCYqaP1nncdVmCZBu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="295004878"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="295004878"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 23:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626323784"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="626323784"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2022 23:46:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 193DD291; Tue, 25 Oct 2022 09:46:24 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH 2/4] spi: intel: Implement adjust_op_size()
Date:   Tue, 25 Oct 2022 09:46:21 +0300
Message-Id: <20221025064623.22808-3-mika.westerberg@linux.intel.com>
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

This allows us to get rid of the checks in the intel_spi_[sh]w_cycle()
and makes it possible for the SPI-NOR core to split the transaction into
smaller chunks as needed.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index b3685460d848..13a3a61239d2 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -363,10 +363,6 @@ static int intel_spi_hw_cycle(struct intel_spi *ispi,
 
 	val = readl(ispi->base + HSFSTS_CTL);
 	val &= ~(HSFSTS_CTL_FCYCLE_MASK | HSFSTS_CTL_FDBC_MASK);
-
-	if (len > INTEL_SPI_FIFO_SZ)
-		return -EINVAL;
-
 	val |= (len - 1) << HSFSTS_CTL_FDBC_SHIFT;
 	val |= HSFSTS_CTL_FCERR | HSFSTS_CTL_FDONE;
 	val |= HSFSTS_CTL_FGO;
@@ -397,9 +393,6 @@ static int intel_spi_sw_cycle(struct intel_spi *ispi, u8 opcode, size_t len,
 	if (ret < 0)
 		return ret;
 
-	if (len > INTEL_SPI_FIFO_SZ)
-		return -EINVAL;
-
 	/*
 	 * Always clear it after each SW sequencer operation regardless
 	 * of whether it is successful or not.
@@ -704,6 +697,12 @@ static int intel_spi_erase(struct intel_spi *ispi, const struct spi_mem *mem,
 	return 0;
 }
 
+static int intel_spi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	op->data.nbytes = clamp_val(op->data.nbytes, 0, INTEL_SPI_FIFO_SZ);
+	return 0;
+}
+
 static bool intel_spi_cmp_mem_op(const struct intel_spi_mem_op *iop,
 				 const struct spi_mem_op *op)
 {
@@ -844,6 +843,7 @@ static ssize_t intel_spi_dirmap_write(struct spi_mem_dirmap_desc *desc, u64 offs
 }
 
 static const struct spi_controller_mem_ops intel_spi_mem_ops = {
+	.adjust_op_size = intel_spi_adjust_op_size,
 	.supports_op = intel_spi_supports_mem_op,
 	.exec_op = intel_spi_exec_mem_op,
 	.get_name = intel_spi_get_name,
-- 
2.35.1


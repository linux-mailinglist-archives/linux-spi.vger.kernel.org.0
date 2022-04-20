Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF1508639
	for <lists+linux-spi@lfdr.de>; Wed, 20 Apr 2022 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377040AbiDTKsQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Apr 2022 06:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378012AbiDTKsE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Apr 2022 06:48:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D789820BE9
        for <linux-spi@vger.kernel.org>; Wed, 20 Apr 2022 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650451503; x=1681987503;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o5yT9UzNrraQ2tLA5o16WyRIH7hvHJDrSDqIy32sChE=;
  b=gt8vdk6NPa+/R8DSFdHtH4YfmNdJnEWj9GJoRDWvnbvayXq1nVJpfMj7
   AHv+ZSMEhJg24zvDhkCGX5r0+MrZde/t9Zhw4CkHgwGbUmzlpIqZXxPdl
   Z/OarkLuusTrtMC/2T4wsWbtgR8RXOscnWtxFQXnBN2UJ1w6p8ISeG45g
   6JkebzOveRR3TnjTlZdktUiHb7bnh89zhYzmEzj24/v5SC1PzcMDObLts
   ivSavlX8+UkJqM2L4KsUPzwdAjCAH3ZoErGq/biFhv0O1q8Epe1uhwZ9/
   DqPZAc//p28eA3vXqFuZIMi81brycs8CSJIEn88j5lPCAjaSU/W5TnE1b
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261599901"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="261599901"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 03:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="626013234"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2022 03:43:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0FE40179; Wed, 20 Apr 2022 13:43:50 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Hongli Li <hongli.li@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v2] spi: intel: Implement dirmap hooks
Date:   Wed, 20 Apr 2022 13:43:50 +0300
Message-Id: <20220420104350.19510-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently the driver goes over the supported opcodes list each time
->exec_op() is called and finds the suitable for the given operation.
This consumes unnecessary amount of CPU cycles because the operation is
always the same. For this reason populate dirmap hooks for the driver so
that we cache the selected operation and then simply call it on each
read/write.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
v1: https://lore.kernel.org/linux-spi/20220411113158.2037-2-mika.westerberg@linux.intel.com/

Changes from v1:

  * Fix build error by passing correct number of arguments to ->exec_op().

 drivers/spi/spi-intel.c | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 1bdb227e0ca2..50f42983b950 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -779,10 +779,59 @@ static const char *intel_spi_get_name(struct spi_mem *mem)
 	return dev_name(ispi->dev);
 }
 
+static int intel_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct intel_spi *ispi = spi_master_get_devdata(desc->mem->spi->master);
+	const struct intel_spi_mem_op *iop;
+
+	iop = intel_spi_match_mem_op(ispi, &desc->info.op_tmpl);
+	if (!iop)
+		return -EOPNOTSUPP;
+
+	desc->priv = (void *)iop;
+	return 0;
+}
+
+static ssize_t intel_spi_dirmap_read(struct spi_mem_dirmap_desc *desc, u64 offs,
+				     size_t len, void *buf)
+{
+	struct intel_spi *ispi = spi_master_get_devdata(desc->mem->spi->master);
+	const struct intel_spi_mem_op *iop = desc->priv;
+	struct spi_mem_op op = desc->info.op_tmpl;
+	int ret;
+
+	/* Fill in the gaps */
+	op.addr.val = offs;
+	op.data.nbytes = len;
+	op.data.buf.in = buf;
+
+	ret = iop->exec_op(ispi, iop, &op);
+	return ret ? ret : len;
+}
+
+static ssize_t intel_spi_dirmap_write(struct spi_mem_dirmap_desc *desc, u64 offs,
+				      size_t len, const void *buf)
+{
+	struct intel_spi *ispi = spi_master_get_devdata(desc->mem->spi->master);
+	const struct intel_spi_mem_op *iop = desc->priv;
+	struct spi_mem_op op = desc->info.op_tmpl;
+	int ret;
+
+	op.addr.val = offs;
+	op.data.nbytes = len;
+	op.data.buf.out = buf;
+
+	ret = iop->exec_op(ispi, iop, &op);
+	return ret ? ret : len;
+}
+
 static const struct spi_controller_mem_ops intel_spi_mem_ops = {
 	.supports_op = intel_spi_supports_mem_op,
 	.exec_op = intel_spi_exec_mem_op,
 	.get_name = intel_spi_get_name,
+	.dirmap_create = intel_spi_dirmap_create,
+	.dirmap_read = intel_spi_dirmap_read,
+	.dirmap_write = intel_spi_dirmap_write,
 };
 
 #define INTEL_SPI_OP_ADDR(__nbytes)					\
-- 
2.35.1


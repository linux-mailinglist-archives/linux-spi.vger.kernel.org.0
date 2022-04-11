Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E2E4FBAF8
	for <lists+linux-spi@lfdr.de>; Mon, 11 Apr 2022 13:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiDKLeR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Apr 2022 07:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345779AbiDKLeQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Apr 2022 07:34:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6EC45780
        for <linux-spi@vger.kernel.org>; Mon, 11 Apr 2022 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649676721; x=1681212721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PV29Orv9pBDJt8XEvCOh3NTUHG4PLQEFzrylRgRophk=;
  b=HuU9tsnfy3v3LC27gU0mtnrP8Hu0JgHHl/UyqHl4pV43KugUHkCx6nAO
   ofFdGrBuwfiA/oTEygr/j3fJNUxO/reYVWoIH37ZBpG5PCBe+f0p3JBSS
   Lwwj1+lL4w+2IIju6E7S0QxsmkU1wZ9XKbLWn5OOoR0PRxTREpPYq7ugb
   rfxP4qcLGo2r3xv52ZwXZGhj/MqnbycwePUqTnPJsMelAhCA0mprPUMAs
   8dwW+b++RpwJDZBoKcyQ6IIwZtirIqHmHsAI/MKOzCzvrn//9ae5AZvOT
   vIwbhHcF1CT4FzGXVUFt/wbkXaTLC9GrjQFukWMW+RwVCnyinjMRS5luD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="249375390"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="249375390"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:32:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572083694"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 11 Apr 2022 04:31:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 81975144; Mon, 11 Apr 2022 14:31:58 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Hongli Li <hongli.li@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 2/2] spi: intel: Implement dirmap hooks
Date:   Mon, 11 Apr 2022 14:31:58 +0300
Message-Id: <20220411113158.2037-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411113158.2037-1-mika.westerberg@linux.intel.com>
References: <20220411113158.2037-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/spi/spi-intel.c | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 1bdb227e0ca2..43c3ddced86d 100644
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
+	ret = iop->exec_op(ispi, desc->mem, iop, &op);
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
+	ret = iop->exec_op(ispi, desc->mem, iop, &op);
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


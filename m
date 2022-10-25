Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F99A60C3F8
	for <lists+linux-spi@lfdr.de>; Tue, 25 Oct 2022 08:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiJYGqU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Oct 2022 02:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiJYGqQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Oct 2022 02:46:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9736414C51C
        for <linux-spi@vger.kernel.org>; Mon, 24 Oct 2022 23:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666680367; x=1698216367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9MClQt/Cv1PcR7GHEtxf2XpTSY9GQz2DSlOZ1vat9j0=;
  b=FGF9SLCqHGkZnHpDUYOugJbjCXrxBs3lgBr/oDF9SY33wMw++v6KFUyi
   2bJooyZDw4fX5r5ckMpnt1FhnH3rNG6qUFt8kwl8PsiL+wGOODJEA5rH9
   w9hvFyHc2SXy4NqRsFD0EiHwWGFVxieTW5S9b/hM0B+sxowgI/wpr1k3J
   RuX1OsXr66WNmzOdOtB3itx4MfSEsrlSY8s+oeHyMkN1YYAE2dUZXHd1w
   oIxEcK1TX/YO9K/qccwUG2MhdremkFYWgdz9z72KY4qWpDhDoVVcvAqj4
   eSd9nN11fYDxCFEmq2iYvW/h20gAi+T+FF4zmOXFziXDtXGV3kPFu2CKF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="295004879"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="295004879"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 23:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626323787"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="626323787"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2022 23:46:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2C5F06DA; Tue, 25 Oct 2022 09:46:24 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH 4/4] spi: intel: Add support for SFDP opcode
Date:   Tue, 25 Oct 2022 09:46:23 +0300
Message-Id: <20221025064623.22808-5-mika.westerberg@linux.intel.com>
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

The Intel SPI-NOR controller supports SFDP (Serial Flash Discoverable
Parameter) opcode so add it to the list of supported opcodes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 8b07e41daafe..049c81717101 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -33,6 +33,7 @@
 #define HSFSTS_CTL_FCYCLE_WRITE		(0x02 << HSFSTS_CTL_FCYCLE_SHIFT)
 #define HSFSTS_CTL_FCYCLE_ERASE		(0x03 << HSFSTS_CTL_FCYCLE_SHIFT)
 #define HSFSTS_CTL_FCYCLE_ERASE_64K	(0x04 << HSFSTS_CTL_FCYCLE_SHIFT)
+#define HSFSTS_CTL_FCYCLE_RDSFDP	(0x05 << HSFSTS_CTL_FCYCLE_SHIFT)
 #define HSFSTS_CTL_FCYCLE_RDID		(0x06 << HSFSTS_CTL_FCYCLE_SHIFT)
 #define HSFSTS_CTL_FCYCLE_WRSR		(0x07 << HSFSTS_CTL_FCYCLE_SHIFT)
 #define HSFSTS_CTL_FCYCLE_RDSR		(0x08 << HSFSTS_CTL_FCYCLE_SHIFT)
@@ -920,6 +921,11 @@ static const struct spi_controller_mem_ops intel_spi_mem_ops = {
 			      INTEL_SPI_OP_DATA_OUT(1),			\
 			      intel_spi_write_reg,			\
 			      HSFSTS_CTL_FCYCLE_WRSR),			\
+	INTEL_SPI_MEM_OP_REPL(SPI_MEM_OP_CMD(SPINOR_OP_RDSFDP, 1),	\
+			      INTEL_SPI_OP_ADDR(3),			\
+			      INTEL_SPI_OP_DATA_IN(1),			\
+			      intel_spi_read_reg,			\
+			      HSFSTS_CTL_FCYCLE_RDSFDP),		\
 	/* Normal read */						\
 	INTEL_SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ, 1),		\
 			 INTEL_SPI_OP_ADDR(3),				\
-- 
2.35.1


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D311944D21F
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 07:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhKKG52 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 01:57:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:34073 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231723AbhKKG5X (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Nov 2021 01:57:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="230324755"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="230324755"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 22:54:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="642864923"
Received: from ubuntu18.png.intel.com ([10.88.229.69])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2021 22:54:30 -0800
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v3 3/5] spi: dw: Add support for master mode selection for DWC SSI controller
Date:   Thu, 11 Nov 2021 14:51:59 +0800
Message-Id: <20211111065201.10249-4-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111065201.10249-1-nandhini.srikandan@intel.com>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Add support to select the controller mode as master mode by setting
Bit 31 of CTRLR0 register. This feature is supported for controller
versions above v1.02.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
---
 drivers/spi/spi-dw-core.c | 4 ++--
 drivers/spi/spi-dw.h      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index bfa075a4f779..26d0ef87661d 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -308,8 +308,8 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 		/* CTRLR0[14] Slave Select Toggle Enable */
 		cr0 |= chip->sste << DWC_SSI_CTRLR0_SSTE_OFFSET;
 
-		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
-			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
+		/* CTRLR0[31] MST */
+		cr0 |= DWC_SSI_CTRLR0_MST;
 	}
 
 	return cr0;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2ee3f839de39..d67f62ff79c9 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -78,11 +78,11 @@
 #define DWC_SSI_CTRLR0_DFS_OFFSET	0
 
 /*
- * For Keem Bay, CTRLR0[31] is used to select controller mode.
+ * CTRLR0[31] is used to select controller mode.
  * 0: SSI is slave
  * 1: SSI is master
  */
-#define DWC_SSI_CTRLR0_KEEMBAY_MST	BIT(31)
+#define DWC_SSI_CTRLR0_MST		BIT(31)
 
 /* Bit fields in CTRLR1 */
 #define SPI_NDF_MASK			GENMASK(15, 0)
-- 
2.17.1


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242861FF9D2
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgFRRBt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 13:01:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:38106 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgFRRBt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 13:01:49 -0400
IronPort-SDR: b01uvsWBBgHi2Pep7L8an/5VUoiQ+5FqB4WNx+tCf7nul4q4gdDKeqeMYnCUJvKCyFy6OjpVYD
 LxFIkwUDDYNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="122881263"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="122881263"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 10:01:48 -0700
IronPort-SDR: AKY/p8n/8Bu9WpBqLqs44a04wbsNEBRWFcgpq9C47/mJvRfdWfOd0arw51y6nNHEWvph9IQEGX
 hE7sW4FE92Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="421565100"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 18 Jun 2020 10:01:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9ABD0130; Thu, 18 Jun 2020 20:01:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] spi: npcm-fiu: Reuse BITS_PER_BYTE definition
Date:   Thu, 18 Jun 2020 20:01:44 +0300
Message-Id: <20200618170144.57433-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

No need to redefine already existing definition.
So, replace custom by generic one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-npcm-fiu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index d25ee32862e0..9468e71f03ad 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Nuvoton Technology corporation.
 
+#include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -177,7 +178,6 @@ enum {
 #define MAP_SIZE_16MB			0x1000000
 #define MAP_SIZE_8MB			0x800000
 
-#define NUM_BITS_IN_BYTE		8
 #define FIU_DRD_MAX_DUMMY_NUMBER	3
 #define NPCM_MAX_CHIP_NUM		4
 #define CHUNK_SIZE			16
@@ -252,8 +252,8 @@ static void npcm_fiu_set_drd(struct npcm_fiu_spi *fiu,
 	fiu->drd_op.addr.buswidth = op->addr.buswidth;
 	regmap_update_bits(fiu->regmap, NPCM_FIU_DRD_CFG,
 			   NPCM_FIU_DRD_CFG_DBW,
-			   ((op->dummy.nbytes * ilog2(op->addr.buswidth))
-			    / NUM_BITS_IN_BYTE) << NPCM_FIU_DRD_DBW_SHIFT);
+			   ((op->dummy.nbytes * ilog2(op->addr.buswidth)) / BITS_PER_BYTE)
+			   << NPCM_FIU_DRD_DBW_SHIFT);
 	fiu->drd_op.dummy.nbytes = op->dummy.nbytes;
 	regmap_update_bits(fiu->regmap, NPCM_FIU_DRD_CFG,
 			   NPCM_FIU_DRD_CFG_RDCMD, op->cmd.opcode);
-- 
2.27.0


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE53245A983
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 18:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhKWRDy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 12:03:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:22040 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236033AbhKWRDv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 12:03:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="258935907"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="258935907"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 09:00:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="509079586"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 23 Nov 2021 09:00:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 34E3DB8; Tue, 23 Nov 2021 19:00:37 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/3] spi: Replace memset() with __GFP_ZERO
Date:   Tue, 23 Nov 2021 19:00:33 +0200
Message-Id: <20211123170034.41253-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211123170034.41253-1-andriy.shevchenko@linux.intel.com>
References: <20211123170034.41253-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

krealloc() as any other kernel memory allocation calls accepts GFP flags,
one of which is __GFP_ZERO. Hence, no need to call memset() explicitly on
the reallocated buffer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: no changes
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 15688acc952c..2e6e4b3ca96e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1222,11 +1222,10 @@ static int spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 
 		if (max_tx) {
 			tmp = krealloc(ctlr->dummy_tx, max_tx,
-				       GFP_KERNEL | GFP_DMA);
+				       GFP_KERNEL | GFP_DMA | __GFP_ZERO);
 			if (!tmp)
 				return -ENOMEM;
 			ctlr->dummy_tx = tmp;
-			memset(tmp, 0, max_tx);
 		}
 
 		if (max_rx) {
-- 
2.33.0


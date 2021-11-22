Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AC24593D5
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 18:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhKVRUb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Nov 2021 12:20:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:52906 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231140AbhKVRU3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Nov 2021 12:20:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="258669361"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="258669361"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 09:17:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="474418992"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2021 09:17:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9530D9F; Mon, 22 Nov 2021 19:17:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] spi: Replace memset() with __GFP_ZERO
Date:   Mon, 22 Nov 2021 19:17:20 +0200
Message-Id: <20211122171721.61553-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211122171721.61553-1-andriy.shevchenko@linux.intel.com>
References: <20211122171721.61553-1-andriy.shevchenko@linux.intel.com>
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
v2: new patch
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9d19d9bae253..3b9010a67397 100644
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


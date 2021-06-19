Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92463AD9C5
	for <lists+linux-spi@lfdr.de>; Sat, 19 Jun 2021 13:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhFSLRR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Jun 2021 07:17:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:29627 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233146AbhFSLRR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 19 Jun 2021 07:17:17 -0400
IronPort-SDR: H+Tnpn9dSHKXDPY7ZiiIzenA7mtqTcoEd/5BM8mS1Zuj5kPNWhw0hyprhrrz7JRl67MvvYeZV1
 r16UMieuc7zg==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="203643437"
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="203643437"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 04:15:06 -0700
IronPort-SDR: VOHIfHYdaYsxNBeDMl6EsAEVVpmXySX5K/MF8oRIOKSzqT42AQp+48ALE6X+KVSxRv7qCK6VoR
 Y4awXHbXJJ/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="453417325"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jun 2021 04:15:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9B715262; Sat, 19 Jun 2021 14:15:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Remove unneeded parentheses in spi_map_buf()
Date:   Sat, 19 Jun 2021 14:15:26 +0300
Message-Id: <20210619111526.27776-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The boolean expression to get kmap_buf is hard to read due to
too many unneeded parentheses. Remove them for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 16b377581d16..0e4917a55eaa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -873,9 +873,8 @@ int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
 	const bool vmalloced_buf = is_vmalloc_addr(buf);
 	unsigned int max_seg_size = dma_get_max_seg_size(dev);
 #ifdef CONFIG_HIGHMEM
-	const bool kmap_buf = ((unsigned long)buf >= PKMAP_BASE &&
-				(unsigned long)buf < (PKMAP_BASE +
-					(LAST_PKMAP * PAGE_SIZE)));
+	const bool kmap_buf = (unsigned long)buf >= PKMAP_BASE &&
+			      (unsigned long)buf < (PKMAP_BASE + LAST_PKMAP * PAGE_SIZE);
 #else
 	const bool kmap_buf = false;
 #endif
-- 
2.30.2


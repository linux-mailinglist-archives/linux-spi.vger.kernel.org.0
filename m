Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF46251E0E
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 19:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHYRSV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Aug 2020 13:18:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:48204 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgHYRSR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Aug 2020 13:18:17 -0400
IronPort-SDR: a0z26XiXx5ypY3uBuMN3GhU3mogApj1uthYG4O32B061eYIyxZM4orJZvcdO0q0UqjpWPo5G7N
 goC2rCu5SXyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="156152592"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="156152592"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 10:18:10 -0700
IronPort-SDR: VQY7582Jj3+CkjHqOtYsgVgiG78E8Qyy1jvxQJJMk9z+rb6yjwgL7koWV92hctgUNNqzMc7VgL
 WqZK4r8CmJjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="499929081"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2020 10:18:08 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, Cezary Rojewski <cezary.rojewski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] spi: pxa2xx: Add SSC2 and SSPSP2 SSP registers
Date:   Tue, 25 Aug 2020 19:17:30 +0200
Message-Id: <20200825171730.17638-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Update list of SSP registers with SSC2 and SSPSP2. These registers are
utilized by LPT/WPT AudioDSP architecture.

While SSC2 shares the same offset (0x40) as SSACDD, description of this
register for SSP device present on mentioned AudioDSP is different so
define separate constant to avoid any ambiguity.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/linux/pxa2xx_ssp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 6facf27865f9..935d7db5bc32 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -41,6 +41,8 @@
 #define SSTSS		(0x38)  /* SSP Timeslot Status */
 #define SSACD		(0x3C)  /* SSP Audio Clock Divider */
 #define SSACDD		(0x40)	/* SSP Audio Clock Dither Divider */
+#define SSC2		(0x40)	/* SSP Command / Status 2 */
+#define SSPSP2		(0x44)	/* SSP Programmable Serial Protocol 2 */
 
 /* Common PXA2xx bits first */
 #define SSCR0_DSS	(0x0000000f)	/* Data Size Select (mask) */
-- 
2.17.1


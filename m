Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2402521CB
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 22:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHYUR6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Aug 2020 16:17:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:21727 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYUR6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Aug 2020 16:17:58 -0400
IronPort-SDR: gnzdHumHvRRm9IuqOI5Y1bd/uMWD+DLx6sZTar9eSYwg/aXsQAiYAry69cQ3k6wAGwbs59pDZU
 D2e81m1UyjFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="217739661"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="217739661"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 13:17:56 -0700
IronPort-SDR: xOpPe1nQiHs9Oc1hVmlKJfQjd8ogSy+bD/JRwmrQ1S8fPYjts1ppf5OXR4adrY+QfIzatdy9JA
 xcFnuR5tBpfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="373157335"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orsmga001.jf.intel.com with ESMTP; 25 Aug 2020 13:17:55 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, Cezary Rojewski <cezary.rojewski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] spi: pxa2xx: Add SSC2 and SSPSP2 SSP registers
Date:   Tue, 25 Aug 2020 22:17:43 +0200
Message-Id: <20200825201743.4926-1-cezary.rojewski@intel.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pxa2xx_ssp.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 6facf27865f9..1608c760fe91 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -186,6 +186,10 @@
 #define SSIRF			0x48		/* RX FIFO trigger level */
 #define SSIRF_RxThresh(x)	((x) - 1)
 
+/* LPT/WPT SSP */
+#define SSCR2		(0x40)	/* SSP Command / Status 2 */
+#define SSPSP2		(0x44)	/* SSP Programmable Serial Protocol 2 */
+
 enum pxa_ssp_type {
 	SSP_UNDEFINED = 0,
 	PXA25x_SSP,  /* pxa 210, 250, 255, 26x */
-- 
2.17.1


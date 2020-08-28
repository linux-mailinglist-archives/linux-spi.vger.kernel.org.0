Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53220255BC5
	for <lists+linux-spi@lfdr.de>; Fri, 28 Aug 2020 15:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgH1N7d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Aug 2020 09:59:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:6422 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgH1N6x (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 Aug 2020 09:58:53 -0400
IronPort-SDR: 60n0EW5w2qDt46UfIrM8cOs/rVjpo1fDZw8iqmxPztrzauVoBl6sGnz/obB0JwnA0vjo4fCBMl
 rmagkNpf7Q6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="136728050"
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="136728050"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 06:58:36 -0700
IronPort-SDR: caX8ccmEMk+m59N5MlBLRR5sFrCPVHJGuEeD4JHaCtFsW0eb61Mc5K7a/OP9wfGh/uR1HFJ9GB
 xd4GSN73qAgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="337500883"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Aug 2020 06:58:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 914881B4; Fri, 28 Aug 2020 16:58:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] spi: dw: Replace dma_request_slave_channel() with dma_request_chan()
Date:   Fri, 28 Aug 2020 16:58:18 +0300
Message-Id: <20200828135818.2492-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Drivers should use dma_request_chan() instead of dma_request_slave_channel().

dma_request_slave_channel() is a simple wrapper for dma_request_chan() eating
up the error code for channel request failure and makes deferred probing
impossible.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index bb390ff67d1d..afc2f11a3473 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -107,11 +107,11 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
 static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 {
-	dws->rxchan = dma_request_slave_channel(dev, "rx");
+	dws->rxchan = dma_request_chan(dev, "rx");
 	if (!dws->rxchan)
 		return -ENODEV;
 
-	dws->txchan = dma_request_slave_channel(dev, "tx");
+	dws->txchan = dma_request_chan(dev, "tx");
 	if (!dws->txchan) {
 		dma_release_channel(dws->rxchan);
 		dws->rxchan = NULL;
-- 
2.28.0


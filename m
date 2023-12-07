Return-Path: <linux-spi+bounces-172-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC1809520
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 23:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6892E281EB7
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 22:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446DF840EF;
	Thu,  7 Dec 2023 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvfkDxCV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA9310F1;
	Thu,  7 Dec 2023 14:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701987276; x=1733523276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eZrxGwvAgFB0+puF74LZGetWU1/ZtE90ClSmlKQ8eEM=;
  b=PvfkDxCVK8SKvJRq+WukJ1bwWBVC9fjofUFWVJ5+0Ouyla4xqxAvudLE
   hnunuCppeuNM9is/AiCMOEJpH6aYptpXHi0OtQDljX281C2IOrDPgt9oF
   nlZxy+/9Gye1p2x3KBWByAL41lPBe4cJYuZj4/Et5ZsA/08oNs6ejK91H
   chF7d4lo5iIEYVj558fkRY4e3ywbxAS6F63Fg6CmeSE+gMRaQaxUzEUTV
   hFKafu0zuG10J8FwDcJxvRZbInLnb2K10b1IARnYvv7QRksq5fy3g8i1e
   cbhHM5FPWJ/Lqle7tThiqgx9dShhaxIx0haWnuoC33KERHcFVeNnE+0ye
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1197557"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1197557"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:14:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842365246"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="842365246"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2023 14:14:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1993E648; Fri,  8 Dec 2023 00:14:33 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/2] spi: pxa2xx: Update DMA mapping and using logic in the documentation
Date: Fri,  8 Dec 2023 00:13:40 +0200
Message-ID: <20231207221426.3259806-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
References: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DMA mapping and using logic in the documentation to follow what
the code does.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/spi/pxa2xx.rst | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/spi/pxa2xx.rst b/Documentation/spi/pxa2xx.rst
index b66702724ccf..61c7b9dd833b 100644
--- a/Documentation/spi/pxa2xx.rst
+++ b/Documentation/spi/pxa2xx.rst
@@ -193,17 +193,14 @@ mode supports both coherent and stream based DMA mappings.
 The following logic is used to determine the type of I/O to be used on
 a per "spi_transfer" basis::
 
-  if !enable_dma then
-	always use PIO transfers
+  if spi_message.len > 65536 then
+        if spi_message.is_dma_mapped or rx_dma_buf != 0 or tx_dma_buf != 0 then
+              reject premapped transfers
 
-  if spi_message.len > 8191 then
 	print "rate limited" warning
 	use PIO transfers
 
-  if spi_message.is_dma_mapped and rx_dma_buf != 0 and tx_dma_buf != 0 then
-	use coherent DMA mode
-
-  if rx_buf and tx_buf are aligned on 8 byte boundary then
+  if enable_dma and the size is in the range [DMA burst size..65536] then
 	use streaming DMA mode
 
   otherwise
-- 
2.43.0.rc1.1.gbec44491f096



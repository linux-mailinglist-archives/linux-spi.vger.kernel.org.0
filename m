Return-Path: <linux-spi+bounces-179-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE4F80A9FE
	for <lists+linux-spi@lfdr.de>; Fri,  8 Dec 2023 18:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A97028161A
	for <lists+linux-spi@lfdr.de>; Fri,  8 Dec 2023 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A2537D29;
	Fri,  8 Dec 2023 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNh0BFgf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23AF10EB;
	Fri,  8 Dec 2023 09:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702055080; x=1733591080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VWVAoJVhNy69aBR1eMnYwRmj8xiYxr2EMDRIqEoEaI0=;
  b=mNh0BFgfbgeIC+FbCp14Dm8s0nIoYp4ddWMiEpgBD1eY7ap/uD0Oa5tz
   reAGinNZ/QjN1BlPtZI8Em1/6VUqdYBt3QlHEAdhiCw5Z4IzrOJo2BXUD
   i/lQsBa4kbn90v1Co077eMHdmfe4mucF6gvtRVpM6ToQOeZToIx6OE/3E
   w/Tm9oYDmm0d1gTJQEHSvRu9hBVfMThupjg4Q9U7dlnkxSVNAJCIGw7F9
   gMPGD7t3OADB8zJ2FFy1X0/8qIMRSkIEymqlajrLf6atIYyxzdaqgUIHV
   ThaFqS50cJUizsQ43qSPco/e2JJc2gCzFRdqrBNlOKshOxojA7jGjQXz3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="374593146"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="374593146"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="748401426"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="748401426"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 08 Dec 2023 09:04:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AE54D284; Fri,  8 Dec 2023 19:04:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/2] spi: pxa2xx: Update DMA mapping and using logic in the documentation
Date: Fri,  8 Dec 2023 19:02:55 +0200
Message-ID: <20231208170436.3309648-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231208170436.3309648-1-andriy.shevchenko@linux.intel.com>
References: <20231208170436.3309648-1-andriy.shevchenko@linux.intel.com>
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
index 143f1df83f79..19479b801826 100644
--- a/Documentation/spi/pxa2xx.rst
+++ b/Documentation/spi/pxa2xx.rst
@@ -193,17 +193,14 @@ mode supports both coherent and stream based DMA mappings.
 The following logic is used to determine the type of I/O to be used on
 a per "spi_transfer" basis::
 
-  if !enable_dma then
-	always use PIO transfers
+  if spi_message.len > 65536 then
+	if spi_message.is_dma_mapped or rx_dma_buf != 0 or tx_dma_buf != 0 then
+		reject premapped transfers
 
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



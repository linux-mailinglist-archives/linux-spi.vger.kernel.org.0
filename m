Return-Path: <linux-spi+bounces-7362-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91768A7634C
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 11:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED03C3AB355
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE241DE2DF;
	Mon, 31 Mar 2025 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbba7Rsp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83015624B;
	Mon, 31 Mar 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743413961; cv=none; b=JRF0a6IUKUmP/lgLo0tefX9HQ+60RKe8bFYWq3h0njyGZrTLv1KCPNNfuQw13CY9eW0tNvOZO/Kz+844IWwcb8auBtQtfQu7W3qpzzF93WUdxcaR80ugBQ9dZo4Yl6GSTtqjsoXQLffD7DECS5EqOdsRink38CkHFuog/oP6zxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743413961; c=relaxed/simple;
	bh=4uom/3aeQovgWxdAY4nl2Wy/3w6pShuSWqh3tlZ0uck=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pqT5foKEiK0kOYSroaMkat6qbPabNxBW9hn3r4W8nzJTpODi1eK5EW02SmV7Tf4D7QGpi25yla8RwKasoEYaeIquZ1ssnlp1HO/OVRvnYPDRfthHM977gMEvarnkDQ2O95JSuSi3Qhello543JguL4OeSB1FUhFMFLLUp9sjduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbba7Rsp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743413960; x=1774949960;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4uom/3aeQovgWxdAY4nl2Wy/3w6pShuSWqh3tlZ0uck=;
  b=lbba7RspMmn8gDXayUC0uEQIfmayd1GE6PzN7Ch5y6NLgS7M1yOXw/fe
   Z/oXgCd8ArcTATrqrT6drwyayzzd2akS42aWPt/Z/4lgEonNncJ28sVz8
   ZX/seUXP1doraZiM8+tRndylcXm+2MIHUcJs9F8IDz65rqjVq1l1w335E
   dCdHfk6T/DLHhZYeX4FuG+0EueIqVxe62xInoIdekt8GbDsyf3RNgj26H
   Mx8awqD5wrPjQs/OFPtDFwg91dE5eEUSjQIvxblCAtlmHiIe0ptmjZI0k
   iyExSq13XeluAsZ1wZpcG1ZXeU6NS4QnpPCY6+yveDa2Zp3bPmMR8uM6m
   w==;
X-CSE-ConnectionGUID: 1bYzEb1NS6ueCkBwY1YLRQ==
X-CSE-MsgGUID: P3g/2/83SlOSIqyhbG+rxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="44798815"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="44798815"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 02:39:19 -0700
X-CSE-ConnectionGUID: J1h8THy1RjSpWI1d8gpXPw==
X-CSE-MsgGUID: 6xkcZlNERc+Vok5TIZCvqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="125942145"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 31 Mar 2025 02:39:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A25CA1CE; Mon, 31 Mar 2025 12:39:16 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] spi: Simplify conditionals in spi_set_cs()
Date: Mon, 31 Mar 2025 12:39:15 +0300
Message-ID: <20250331093915.4041600-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First of all, the (foo && bar) || (!foo && !bar) when foo and bar
are booleans is equivalent to (foo == bar). Second, reuse variable
that holds already the calculation of the SPI CS mode to be
active-high. No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ef755d11374d..3c6c70468899 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1077,10 +1077,8 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	 * Avoid calling into the driver (or doing delays) if the chip select
 	 * isn't actually changing from the last time this was called.
 	 */
-	if (!force && ((enable && spi->controller->last_cs_index_mask == spi->cs_index_mask &&
-			spi_is_last_cs(spi)) ||
-		       (!enable && spi->controller->last_cs_index_mask == spi->cs_index_mask &&
-			!spi_is_last_cs(spi))) &&
+	if (!force && (enable == spi_is_last_cs(spi)) &&
+	    (spi->controller->last_cs_index_mask == spi->cs_index_mask) &&
 	    (spi->controller->last_cs_mode_high == (spi->mode & SPI_CS_HIGH)))
 		return;
 
@@ -1089,9 +1087,9 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	spi->controller->last_cs_index_mask = spi->cs_index_mask;
 	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
 		spi->controller->last_cs[idx] = enable ? spi_get_chipselect(spi, 0) : SPI_INVALID_CS;
-	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
 
-	if (spi->mode & SPI_CS_HIGH)
+	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
+	if (spi->controller->last_cs_mode_high)
 		enable = !enable;
 
 	/*
-- 
2.47.2



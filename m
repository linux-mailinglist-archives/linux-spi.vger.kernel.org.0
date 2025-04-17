Return-Path: <linux-spi+bounces-7641-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA09AA9216D
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 17:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AFBA7AD061
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B4F253B6A;
	Thu, 17 Apr 2025 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O09ri3A1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3B25395D;
	Thu, 17 Apr 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903538; cv=none; b=QtkvAz44m3cfHQ7ZpuGqFTItEB1q6h3t6fo6IEVjwUOSBBHpd4jLQT9ZfsM1MFi4SOx8fjb62vHI7gwumUq187AcxgsSWenj54sha3sp2vYBkSH/0l+VHOZ3NrB3+B1ZCBXXVzZ2e5p8MB0cmU4Lb53q1uf379GuBybOBY6Ibu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903538; c=relaxed/simple;
	bh=YNzxg2Cgltshvv/jkfeOT+fz/8OO2VlMUUBbnoXm6YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ane+LyvhpzgoPj3lJA2iLCF2LR/TrbwGPJnnJxRqT+biIO1ntNIK9COq5baLpJbAgy/hWLDGEVaToTEvYmWR2xu6Z4USbYoM05UH2FdkzKQpp1tJjlPA4SO/Md2OPRlf4qPzANCxz4TI3BANyqkF5VXeiVrhj8PZV9yUzJFt24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O09ri3A1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744903537; x=1776439537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YNzxg2Cgltshvv/jkfeOT+fz/8OO2VlMUUBbnoXm6YE=;
  b=O09ri3A1HRDprZ7e5xz5Yea03c8YUTHy+FPjGS6EzWXmYvpq57LomOLz
   F+XA+Nqp/I2/IzgZrBMCIUMDHlsXA0+qbY+yyUZqi9DVV/h/aADzDO6/o
   tv06MpUuQxdBj3WWswGhlctIWYRsw8WiPNFhqqg36X3wl8vCVawOsZ1dC
   kiAPtpGaCzvt1Y9QTSOZ9bqw4Lb5tfE3ApiHrYQgC6Vvcfp4Ot/LItHvF
   /1Ilo9FlOsUE9vtHVvaQttXXZwvMgBFTCWP/g0DpyCwlpoDEiHzr1SwTj
   1mFlYVPBUSwPXPbD+ZOxy3LCpiH/7ghktAXq4G/qEHtBXcO/ldVlEiufJ
   g==;
X-CSE-ConnectionGUID: V/RnkkpNRXyGcueI1vIZOQ==
X-CSE-MsgGUID: Iy250Iy7SSWmkW6HMixiZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57869097"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57869097"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:25:35 -0700
X-CSE-ConnectionGUID: 3/m8YRdqRRe7mSJr2TeNOQ==
X-CSE-MsgGUID: cz51Zs37StOzlep8bpTmsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="136008919"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 17 Apr 2025 08:25:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CEF1985E; Thu, 17 Apr 2025 18:25:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 2/2] spi: dw: Use spi_bpw_to_bytes() helper
Date: Thu, 17 Apr 2025 18:24:47 +0300
Message-ID: <20250417152529.490582-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250417152529.490582-1-andriy.shevchenko@linux.intel.com>
References: <20250417152529.490582-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing helper to get amount of bytes (as power-of-two value)
from bits per word.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 941ecc6f59f8..b3b883cb9541 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -423,7 +423,7 @@ static int dw_spi_transfer_one(struct spi_controller *host,
 	int ret;
 
 	dws->dma_mapped = 0;
-	dws->n_bytes = roundup_pow_of_two(BITS_TO_BYTES(transfer->bits_per_word));
+	dws->n_bytes = spi_bpw_to_bytes(transfer->bits_per_word);
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_len = transfer->len / dws->n_bytes;
 	dws->rx = transfer->rx_buf;
-- 
2.47.2



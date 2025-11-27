Return-Path: <linux-spi+bounces-11639-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA5BC8FF7D
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 20:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF55E4E6C1A
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA62B304BCA;
	Thu, 27 Nov 2025 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzkVwjCF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A91303A04;
	Thu, 27 Nov 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270040; cv=none; b=n/D1NUyzSU4lWZizq5BIQ+DyQkuUtTX44odcAo1mzd8IDTz4r2FEK5KFu/Q89goEw+d1MxESQ49c0dmu9KsM7IkX2vEHFA0fK3l5FlebuC2FkngjvjIF7yVR7gy2KaSwVzwuAfeQhuqWjJPbTctPKp2oyjLHakrdkGHf9CjyHMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270040; c=relaxed/simple;
	bh=yrR4M3AM8ocRqZG2rAtrM+zbjICYzoD9wcqeo39DKV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kR9mgID9UZQZtVgZ3HiKNv6m3nVSUel0k8OAlsNmqEpk8/p/DC8TMyAR7X1s0VZnleymMHxeF4w9/xv12F4oslxvlIQMakWW5DPGTyEs1x30U+y0hf9r2ti4gcFJJyR5Ired2ixTJFNaKe5W4zqueS4d7zhvGCi1hZ9wMDZac/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzkVwjCF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764270039; x=1795806039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yrR4M3AM8ocRqZG2rAtrM+zbjICYzoD9wcqeo39DKV0=;
  b=lzkVwjCFm42mJpYQ8ssOBQb9Fw0RRw5aO9h5MpNRlmQB/EBadhk1WHt+
   ON7VeNzO4bKADcvznVgPNfvBLsEDrKNTysvkmnYf1E5LbIpbv31tkGrg6
   Hw2XaUtfCNmj+2YsRfiH0HpTIDID/7K58CfezbWq+hYAddGGSitjDJ1ob
   OkN1u4rC4YVJWAb3B2azvOMc91nRPNlYLMXOOmG/3pA5vr8aL2ZQLReo4
   JN4XilTe7aIvIcy8Eo4b/hVAL9q4Drnvy+afxhtc3Jj1ins8jCjNbAqWj
   Z5wBQIaquObMYR94+pFfSrfqn2QGdJVx9amZ1EbJ38BmPP3oJv6dAqW3O
   w==;
X-CSE-ConnectionGUID: VS+t6cShSa+i52TRFjX01Q==
X-CSE-MsgGUID: nkJA2n+LTM+CFZ4sUAiAhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="91796265"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="91796265"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:00:37 -0800
X-CSE-ConnectionGUID: Ai4awCLGRmeJh4R5OK9SDA==
X-CSE-MsgGUID: 9OgXqwRzT2SOH21mVUJyfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="216645904"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2025 11:00:35 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4A0FEA4; Thu, 27 Nov 2025 20:00:32 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 5/6] spi: microchip-core: Use SPI_MODE_X_MASK
Date: Thu, 27 Nov 2025 19:59:02 +0100
Message-ID: <20251127190031.2998705-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
References: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use SPI_MODE_X_MASK instead of open coded variant.

Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 0ece51460ee0..d37e193e282f 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -153,8 +153,6 @@ static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
 
 static int mchp_corespi_setup(struct spi_device *spi)
 {
-	u32 dev_mode = spi->mode & (SPI_CPOL | SPI_CPHA);
-
 	if (spi_get_csgpiod(spi, 0))
 		return 0;
 
@@ -163,7 +161,7 @@ static int mchp_corespi_setup(struct spi_device *spi)
 		return -EOPNOTSUPP;
 	}
 
-	if (dev_mode & ~spi->controller->mode_bits) {
+	if ((spi->mode ^ spi->controller->mode_bits) & SPI_MODE_X_MASK) {
 		dev_err(&spi->dev, "incompatible CPOL/CPHA, must match controller's Motorola mode\n");
 		return -EINVAL;
 	}
-- 
2.50.1



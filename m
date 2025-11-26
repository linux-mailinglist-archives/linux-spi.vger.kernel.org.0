Return-Path: <linux-spi+bounces-11565-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2A2C88877
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B2A3B67F2
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DF33168EF;
	Wed, 26 Nov 2025 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWRegO90"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6172E7198;
	Wed, 26 Nov 2025 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143768; cv=none; b=Dzw+dmKc/R3FaNr9m0Bgkdr+XnHc3RT9DM5GFclymP+2mqHoBY6+d5479c+tWE9D4c6Zvpio4b28Ph20g9EN9FXUcUkoXi2Blyupamt9cHZMCYMZu3K3iMrbyo6YxKcnzlvPe9fAfwfHI2cSARVwGaQmNRTmdI+5SDFFJ437SRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143768; c=relaxed/simple;
	bh=z4PWdIXvys/n3of334bkeQ2r4HBRsP5WhNYdmnJZdsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+cZ/xioYpOAADwmYvjwHobJAJUH3twSBVKZeS8Xvl+NWZeUipHmHWPR/XqEq0YZckhDPsm68wJ2efsPF+8JH/RdWyJhEVxYfVFNd+EPL6Bx2yJZFBng9SHjr3ZO4SqwyVHpWDxjcd1RoosBWK3ma4VTnp5V9omZUwsCdqyrZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWRegO90; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764143766; x=1795679766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z4PWdIXvys/n3of334bkeQ2r4HBRsP5WhNYdmnJZdsM=;
  b=DWRegO90Z0nucDdzPpzLQmh3NGkIVVahxPRGNVxf79NNWPSxD5ZZ1oz3
   RhYBtDPQeHuLWWDq/4N7dIKTg4cNgQCuP6hvrMt5wyjazjjg1dwzHblZt
   764Aee9tz/9EraUyA/Gsmbjb3QG3qOeffzmJPhwxwFXCfn2Gjhcm/8TNz
   tKNMpCNFsE/7QnGsYGUWEtC+4opHrkpIZsH6mqjDSw2c9fRGJjqln6Omm
   ay1E6PTm/dKSGOzlGPyHfIoiBjoRlu+def2OswC0UhS71nHiFKBIFuihb
   wd+QKKaJkFtHSE5IPldJvWbuZPJ99ElWpXfJu9K6rPaFiTbr0eo7bAsUA
   A==;
X-CSE-ConnectionGUID: ld3YN4/aSLKBUb/jaZOR1g==
X-CSE-MsgGUID: G18p4QAXTauAVRYPDoU2rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="65360572"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="65360572"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:56:04 -0800
X-CSE-ConnectionGUID: cxMbML3dReumtFIdAjjb3w==
X-CSE-MsgGUID: g6R8s72zTyqgMCd4CUCEqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="192006627"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 25 Nov 2025 23:56:04 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2C93FA5; Wed, 26 Nov 2025 08:56:00 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 5/6] spi: microchip-core: Use SPI_MODE_X_MASK
Date: Wed, 26 Nov 2025 08:54:43 +0100
Message-ID: <20251126075558.2035012-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use SPI_MODE_X_MASK instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 0dca46dcdc2f..941b7e23eac3 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -148,8 +148,6 @@ static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
 
 static int mchp_corespi_setup(struct spi_device *spi)
 {
-	u32 dev_mode = spi->mode & (SPI_CPOL | SPI_CPHA);
-
 	if (spi_get_csgpiod(spi, 0))
 		return 0;
 
@@ -158,7 +156,7 @@ static int mchp_corespi_setup(struct spi_device *spi)
 		return -EOPNOTSUPP;
 	}
 
-	if (dev_mode & ~spi->controller->mode_bits) {
+	if (spi->mode & SPI_MODE_X_MASK & ~spi->controller->mode_bits) {
 		dev_err(&spi->dev, "incompatible CPOL/CPHA, must match controller's Motorola mode\n");
 		return -EINVAL;
 	}
-- 
2.50.1



Return-Path: <linux-spi+bounces-11657-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7279BC92FA7
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 19:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC1FD34F508
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 18:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DA833290F;
	Fri, 28 Nov 2025 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fsEsnzkA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5930326E6F6;
	Fri, 28 Nov 2025 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764356125; cv=none; b=lIfAYXGgI8vYkGr5OcZUojvJAFuY7VNcpeXmdi9xro/IiHKQkBgrtrxdmUfawBwdUuavw+DM4be1sh73a6YyoXs5+4fy7DnQJqD2zrvH4/BLwqW6EFy0uIrYMeTeIfToRXVpupYZ4ksciHDjAUjElH+q2q9x+7WJR/OnXjbRi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764356125; c=relaxed/simple;
	bh=QTXFkDoItWuX3QVUDfL2ipcz4Tzy87snHGDqslonopc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8ijFWwzA7unaPOL6P4C0ezTyzY/b0BGHsP20HoAJ4CDUz3bNeGoScIwtxx1OQCzCdkBkiYK1deIAiCaWWVpXtkkAFq0tFOpaQpaIQJ60fJXsDTAhjTAfDWfkRfjZjWM1xFk4NNwm1XCXXKWA/NJdPaRvMIelcnV6ppxZiDhGf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fsEsnzkA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764356123; x=1795892123;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=QTXFkDoItWuX3QVUDfL2ipcz4Tzy87snHGDqslonopc=;
  b=fsEsnzkAONubfq/ICnxEe1wFFrb+ZawLSCQlAa+32FjBBV6r5bJMChgi
   KifaMPKzvwMMD/DrtAmv2/u296STAxn9/kc4wroPBFGzpD4xfy+V9wBHD
   s9QjXSvk+lyIcmNNwRVzAD54QUwJSHF3MEGZlIQd00q1PHwf1n52Fis4J
   mjMuSBBC+VAbR8gz5C/Ntd9Weh32A6xIRtg5h3e7an1F/R13Y3W5OXAV/
   +GdTPvmaV9r/KzAQc1iY5KJvmzZVmhKYPkE5DCDzhibdI4s57C7RLJIKf
   7LShvIPZ2SDAVr1gkPomFylGumsWyH9ffrEXcBVhAKvQUQ0BxSerIwECH
   w==;
X-CSE-ConnectionGUID: dX4O8sAuSH6sCJ6o5h67LQ==
X-CSE-MsgGUID: YDpReluRSw2+pv7kV17HXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="66103470"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66103470"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 10:55:22 -0800
X-CSE-ConnectionGUID: Am9LJefCT7eyET6GjVZA4g==
X-CSE-MsgGUID: +VNEkxV3R5yFLv75Tu7smg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="192641504"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 28 Nov 2025 10:55:21 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8FF63A1; Fri, 28 Nov 2025 19:55:19 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] spi: microchip-core: use XOR instead of ANDNOT to simplify the logic
Date: Fri, 28 Nov 2025 19:52:40 +0100
Message-ID: <20251128185518.3989250-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251128185518.3989250-1-andriy.shevchenko@linux.intel.com>
References: <20251128185518.3989250-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use XOR instead of ANDNOT to simplify the logic. The current approach
with (foo & BAR & ~baz) is harder to process than more usual pattern
for the comparing misconfiguration using ((foo ^ baz) & BAR) which
can be read as "find all different bits between foo and baz that are
related to BAR (mask)". Besides that it makes binary code shorter.

Function                                     old     new   delta
mchp_corespi_setup                           103      99      -4

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 98bf0e6cd00e..2f4b21ad56a7 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -161,7 +161,7 @@ static int mchp_corespi_setup(struct spi_device *spi)
 		return -EOPNOTSUPP;
 	}
 
-	if (spi->mode & SPI_MODE_X_MASK & ~spi->controller->mode_bits) {
+	if ((spi->mode ^ spi->controller->mode_bits) & SPI_MODE_X_MASK) {
 		dev_err(&spi->dev, "incompatible CPOL/CPHA, must match controller's Motorola mode\n");
 		return -EINVAL;
 	}
-- 
2.50.1



Return-Path: <linux-spi+bounces-12225-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1451CD05307
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 18:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B07F300A6FA
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1934F2E7162;
	Thu,  8 Jan 2026 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="am1gwent"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5523C4FD;
	Thu,  8 Jan 2026 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894669; cv=none; b=EQeT3bs/1yZarwPTEsaw4LdnFADyxLWSDHX+n+dq/H/zVUkVmfG9jzQRja77LSV4xBlohiUZTm+qk2KmB7w7zWgkuDOsdzzs64SRnM22EXLuff/qeIWTKOLHff8PMEbtf895Kdlwt0/DEX6rjXQ00oikfoPCPmPJ79cAfBWfhjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894669; c=relaxed/simple;
	bh=J9M7wezW9yDMdZEIGTcHmrWl6b87r7j61/dVE9vGbuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+vXBVxyDPQyxT8EKfGwuwGyDxaHBIsdDUcWPHuayyR1a5lmYdZsC6baiuDYJzU8ePhjyS9kN+cldU4PkQRhBmcWhzuoKVcbF4nlZN7WXQtfATFiqJCvXCx+f0f/8SNmMgmZ4dxKGOhg6xdbNgQ934OOVnYd77MGDCtekdz3c6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=am1gwent; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767894667; x=1799430667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J9M7wezW9yDMdZEIGTcHmrWl6b87r7j61/dVE9vGbuE=;
  b=am1gwentdnbyusvy4A1s5QY+9UsHqK5+Ich2n4umeUGY8pIgMLetqsak
   p8NoJi2FJ4GyXDeYxd11kxgDSgDKhtv/EE1NTr79BJcia76rz0k3M0jnC
   rDg0OItUae+qC3N/AQna0X2HOnnU57lzqoIGP7TKa3o2MDgxArONliHlc
   c/vcahui5t3B17T/cbdsqH6uHJZP/+0J4x1onyD5MDXFww6wOf6zq6Jmn
   iLMaZyGNy3rE0jGSxqThxL+vSdlNrX1pUa2UJ8LqD3VP9p55WXfylwCJ1
   D+YKm2Ml2nfjWY6j/aaTBIVPwvAFs8BBim2kCF75gV31OC99lE+RCaHqO
   Q==;
X-CSE-ConnectionGUID: p7pFOfuwQIWxiFapsJdclg==
X-CSE-MsgGUID: T+z8wUZyRBuXnYkvVyDSsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="56836576"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="56836576"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 09:51:06 -0800
X-CSE-ConnectionGUID: Fz+JWH5gSgiJw7qGfUbWZw==
X-CSE-MsgGUID: 3bMnv5gIR/S/HRqvxmfQ4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="207747357"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 08 Jan 2026 09:51:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0241898; Thu, 08 Jan 2026 18:51:03 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v1 1/1] spi: microchip-core: use XOR instead of ANDNOT to fix the logic
Date: Thu,  8 Jan 2026 18:49:40 +0100
Message-ID: <20260108175100.3535306-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use XOR instead of ANDNOT to fix the logic. The current approach with
(foo & BAR & ~baz) is harder to process, and it proved to be wrong,
than more usual pattern for the comparing misconfiguration using
((foo ^ baz) & BAR) which can be read as "find all different bits
between foo and baz that are related to BAR (mask)". Besides that
it makes the binary code shorter.

Function                                     old     new   delta
mchp_corespi_setup                           103      99      -4

Fixes: 059f545832be ("spi: add support for microchip "soft" spi controller")
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Updated the commit message, added Fixes and Test-by tags, and sent
as standalone patch.

 drivers/spi/spi-microchip-core-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 89e40fc45d73..c8ebb58e0369 100644
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



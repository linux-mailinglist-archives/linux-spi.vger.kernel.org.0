Return-Path: <linux-spi+bounces-11540-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF1C86FCE
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 21:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 990D14EB0CC
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A639233DEC2;
	Tue, 25 Nov 2025 20:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MA0S2xa6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FE33C190;
	Tue, 25 Nov 2025 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101830; cv=none; b=MuPvSB1jWKsHZWEZFmuivtct+9FIkqmSIM+frEKfVjLt8V0buArYZHqi+Ep3XaMyrc4G3j03GZRfBu0i/OmkwVYDuEU/CWgIKw6hfWXZewXOpSP8WC0chKVchp7ch+y3GGZtfzEDbWScS9YZ7ERJI28VI+gTSUh32lyPadG9hfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101830; c=relaxed/simple;
	bh=mbDlDmdnDiUfu3Kyh9JWefo4n4vtOg6EiX8Tf/XxLjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5iB+BleqzemkKA1bvZEWs/FXyCTX2TQHexrk0cO2MFiXKONv9R4Xtmwf/tNpqUHWTIw5mE7cKEbQg0WgwHea44fyvesd9wW965dsp4UD/VF+AKiKdMikiiDrb682dQQwM/Mm8LcEt/CUMlQYynGKC2mJQgcUQWRstTX2NJrxU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MA0S2xa6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764101829; x=1795637829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mbDlDmdnDiUfu3Kyh9JWefo4n4vtOg6EiX8Tf/XxLjA=;
  b=MA0S2xa6KPXa4I+EcXK5kJi+WWRlebqwEyvrsuNbNZX2XSNM0FP1nKid
   S8ofC2kZDCTmuwLep8jOjh98MKkXRL73BEQ7Q25+Ef6Fx6JvUlubaocS3
   NsxyR0vxf8nX7XpY4GVxVcnNl8fbv1v0JO7BhHTszqaClTT8ILrmUJnrV
   BQSyEGHSCFOxEsseKg12gND85Om42LoGwM9iHNntd2/hHhjg143zbOwtI
   n5Vv1NkfBbUaRBdOFByn3YVPDGvernPwSnT9c5b03JAKWRzzWwe839uLy
   twmxM5RGTHs7bqWY8mA9+KvQlu7Dpad7XmroHCobbq2/FFkWNbmn1BTXn
   A==;
X-CSE-ConnectionGUID: N+fzLTSsTR2i0WXBscxM6w==
X-CSE-MsgGUID: 9qIc46zuRCWbTfxHiCMAkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="69990035"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="69990035"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:17:07 -0800
X-CSE-ConnectionGUID: EXIQCvywTjqoaUc/RZ7eRQ==
X-CSE-MsgGUID: iqLyzyxDS0eT3MjWOIjXsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="223720990"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 25 Nov 2025 12:17:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5B22CA6; Tue, 25 Nov 2025 21:17:02 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 6/7] spi: microchip-core: Use SPI_MODE_X_MASK
Date: Tue, 25 Nov 2025 21:15:36 +0100
Message-ID: <20251125201700.1901959-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
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
index 68b136157fac..2d7ee556eafd 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -149,8 +149,6 @@ static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
 
 static int mchp_corespi_setup(struct spi_device *spi)
 {
-	u32 dev_mode = spi->mode & (SPI_CPOL | SPI_CPHA);
-
 	if (spi_get_csgpiod(spi, 0))
 		return 0;
 
@@ -159,7 +157,7 @@ static int mchp_corespi_setup(struct spi_device *spi)
 		return -EOPNOTSUPP;
 	}
 
-	if (dev_mode & ~spi->controller->mode_bits) {
+	if (spi->mode & SPI_MODE_X_MASK & ~spi->controller->mode_bits) {
 		dev_err(&spi->dev, "incompatible CPOL/CPHA, must match controller's Motorola mode\n");
 		return -EINVAL;
 	}
-- 
2.50.1



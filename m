Return-Path: <linux-spi+bounces-11559-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B33EC88850
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC2084E1FC8
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A2128DF07;
	Wed, 26 Nov 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIMZgcbT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16E3595D;
	Wed, 26 Nov 2025 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143764; cv=none; b=BkkpIJ93wzXVZANoCKHYtXsTJ7pS4YdFR9+bYYTjl00bHDep2g9BCaCuK9hZhm79TWrFwThaZaDuWRS80ewYCKFIESmLXpSCWu5nuESv+Ylbnk2VYX/XGXVLDhAxJAOCU4MGgl5PG8SESVgSRqFxhhIjylcXxtWNfSC09qESSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143764; c=relaxed/simple;
	bh=0Gxg0vEsT7iC/VAzcpRM5cLCaCdcyKzm8Jx20MYavrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fmk+rAHTijiO6WzZtvQ9Z9BZtjAN4ktszAh7Xn40wFXk+gR/o0O7dG4LKiZMBz6QKY5QHQ3EjqkGcfPf74mJ24P2Tv5419GAzlt21lGDlTx4zuNNYUt6ftmcb8IYUYBcOqZvUJrW8V1DOFszKiY9fnsFUXDR8dKK5cGPrkq3UI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIMZgcbT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764143763; x=1795679763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Gxg0vEsT7iC/VAzcpRM5cLCaCdcyKzm8Jx20MYavrQ=;
  b=OIMZgcbTuKLGwEAKSQH7YebLufIqQy9+uworpGZCEBwqJgLRrQSwtkm4
   5BUhbeHnXSrsjtnJg0luKTidb0Uu5d24Qh1T2TwZZJ9Vv7zzvLkXm0Uvw
   kLIzsZPnXSg121Q15iT9S+3xmNU9q+kQEDImJc4A/x+ejxSV/hpiQmN8x
   3Kdk53IP2BhFHtPOFLFk8RblZAahfcVEYvXD0FKcWag5gUJD+m2Qw9/Qq
   tygF1qjjfiJQDqkUJRrxvGeqZ8aZlwgh5kJWyLTLqvCLSAkBPu5VCvUKL
   pzPLPv4QBwdpk3r90puXRFSDGrZX8/ICCFkwIs0UmxN+GLalt0k4ZQYpi
   w==;
X-CSE-ConnectionGUID: r2IzGIlRTZaahZ3ogXMUBQ==
X-CSE-MsgGUID: l9bEM4UdScqOtp9XtG9nCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="65360561"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="65360561"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:56:02 -0800
X-CSE-ConnectionGUID: H5tZ8kjfSeKX703NDEVOrQ==
X-CSE-MsgGUID: LcbDyVpdQAuQfoxvGnIGSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="192006616"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 25 Nov 2025 23:56:02 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 24467A3; Wed, 26 Nov 2025 08:56:00 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/6] spi: microchip-core: Replace dead code (-ENOMEM error message)
Date: Wed, 26 Nov 2025 08:54:41 +0100
Message-ID: <20251126075558.2035012-4-andriy.shevchenko@linux.intel.com>
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

First of all, the convention in the kernel that we do not issue
error messages for -ENOMEM. Second, it's ignored by dev_err_probe().
Replace dead code by a simple return statement.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-microchip-core-spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index f8184b711272..8ea382c6fee7 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -293,8 +293,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 
 	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
 	if (!host)
-		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "unable to allocate host for SPI controller\n");
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, host);
 
-- 
2.50.1



Return-Path: <linux-spi+bounces-6618-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254E8A278EB
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2025 18:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE127A2FB6
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2025 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F8D2144CA;
	Tue,  4 Feb 2025 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aub9vdNR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E9D1537C3;
	Tue,  4 Feb 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691113; cv=none; b=az1kZBl/UUTodrO1BLhclDoh/OnEvTdj4GFrtpvfqlq6r8IH0j4zoqV5QkgwFKjPF41hJowd/9Uh+85DVrSHe7jQfmBYxbkKkUWlIAHHqKSd6EaDw7+4z7uOmjUolPdetUxpj4RhlnOCrg/Yi1PumjyPLnTW5j1ClvDzw+WyfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691113; c=relaxed/simple;
	bh=1fpGWk6mcJocAb/EGYVT3NiN/ozuxcKfoYEQ/m8hVfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKKIM4kkF4FpvYQhtR28w/uYSaprVCS7ISgnocNUAd4FVhtf85KxYHX05qH0UWl181/grCbX1qP9IjoPboefizm8hAe3Tb40e6I3rLVKg7F4AhVn7GLt01NqTr3i7kwL5YoRxm//MOMFr26nyH+89DddRoe69S5gK4l405Mytgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aub9vdNR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691112; x=1770227112;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1fpGWk6mcJocAb/EGYVT3NiN/ozuxcKfoYEQ/m8hVfU=;
  b=aub9vdNRH25mX7rxkgdoJC+FtNbhwmbpXcKf5I5K8ncqwJltqwkKx1P9
   91SD3pnyMw8QD70Q1j/AN+rYnGkwR0T/Ed6WjSo55Lzhx1UBE1neVazr3
   C+1N4/yr2mmFa+wR9S1ldv1VNCZSB9BwZoekdN1nmU2k6o9CCLQ2TNBJi
   tN+QWtlCCQt95/itYnQCnoEk8wtyevOiti6GSNi+/SCOuYKuLyEpB4UHT
   1/jQ7C1qxJvTLcGDS7stDFI4r5mK7tJmWGEXtNElQ/boG+3eQXtWuwcye
   +R0k1yHOsdEs7NJUSSKJ3n34GogggjebsRiQIoNz4BKQTGYofHCye0bbf
   g==;
X-CSE-ConnectionGUID: ENaLIiOTTtWBE5nTqgY7PQ==
X-CSE-MsgGUID: nT+/b6hlTp2APu4HXMtHEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56656273"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="56656273"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:45:11 -0800
X-CSE-ConnectionGUID: MV74HgZMSmu9/X1xXcp4IQ==
X-CSE-MsgGUID: 9ieNoHT7TsKGKxBMxnGQlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="141526270"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 04 Feb 2025 09:45:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A96A5353; Tue, 04 Feb 2025 19:45:07 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Lord <mlord@pobox.com>
Subject: [PATCH v1 1/1] spi: pxa2xx: Fix regression when toggling chip select on LPSS devices
Date: Tue,  4 Feb 2025 19:45:06 +0200
Message-ID: <20250204174506.149978-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Lord <mlord@pobox.com>

The commit 78b435c9044a ("spi: pxa2xx: Introduce __lpss_ssp_update_priv()
helper") broke speaker output on my ASUS UX5304MA laptop. The problem is
in inverted value that got written in the private register.

Simple bug, simple fix.

Fixes: 78b435c9044a ("spi: pxa2xx: Introduce __lpss_ssp_update_priv() helper")
Signed-off-by: Mark Lord <mlord@pobox.com>
Tested-by: Mark Lord <mlord@pobox.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 5f9cac41baff..06711a62fa3d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -399,7 +399,7 @@ static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
 		lpss_ssp_select_cs(spi, config);
 
 	mask = LPSS_CS_CONTROL_CS_HIGH;
-	__lpss_ssp_update_priv(drv_data, config->reg_cs_ctrl, mask, enable ? mask : 0);
+	__lpss_ssp_update_priv(drv_data, config->reg_cs_ctrl, mask, enable ? 0 : mask);
 	if (config->cs_clk_stays_gated) {
 		/*
 		 * Changing CS alone when dynamic clock gating is on won't
-- 
2.43.0.rc1.1336.g36b5255a03ac



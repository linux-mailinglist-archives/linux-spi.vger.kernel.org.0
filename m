Return-Path: <linux-spi+bounces-5892-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46429E3525
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 09:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2179B372A8
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF27190485;
	Wed,  4 Dec 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIZjFoY9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D426190662
	for <linux-spi@vger.kernel.org>; Wed,  4 Dec 2024 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299334; cv=none; b=TeWCFozocwKMDJ9F+CD27ryYbLps5B2pflgyaheOb17NpCQ3lX0oWDoRx0aIuwBYF/sfn22FSl1eneZa2zR9XEzOs2fqUOoWacnO1CsPOdRP9ak+lUmmW0/0YkIpQ9h7uSOnI47/uCCHdtbwUgoAfzInA2WL03FLGSL4UFzWYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299334; c=relaxed/simple;
	bh=dUK6xy7siYMT5YffM3X1lg5y+TLmLgWLylgHSgZVyj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMR86mMso7Z/9oxii3kIYd9W2TvU4OBmvhhFO0d+Nn1M9gy4ym4++rn8zWbzM3ufzzvGSaqWe85iUJUMClbjeGNj4CH50lyzT7x4cKp0ycXo8/aLWLMxLZFCJ5KC9f6C0FGs0CEGBjfuRo40fGQkU9/m9dkcqJ20D4YvncWibKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIZjFoY9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733299332; x=1764835332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dUK6xy7siYMT5YffM3X1lg5y+TLmLgWLylgHSgZVyj4=;
  b=KIZjFoY91lM3+NmNTWJSD6Ln+LVVG5QGsOEdnujHHE9vvDcuQ2m4YcjC
   AZcltruDu8WX9DYH7slrdBGqX6aMLyRYhxbh5hQTVyiH0/SC9tt2eN2W/
   rxOTRbcW1sK+vda1bZrSry2tNpknWkHeSponce8gCP/BoRyRL65Yq5Osw
   yiiVZJBBIw6l422wsMaTCQDx3iDNGAFubhgQOuM4DmLPNuLohtPpYxmxu
   xe80Kn6BQWGyCenWCt5QZ338lM2iW3Gxn5GOxcw08a8u1bKmd9NM6i0Un
   wvwFPV8c7gxP/n2eRsRmanRZumKZ6956avwgv2NfwmciJYdLicdUGtftn
   A==;
X-CSE-ConnectionGUID: cYUwo/AeQbWvMA3RNMHSRA==
X-CSE-MsgGUID: g7fAetpsRJ2FvcXGD7bD2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="58952728"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="58952728"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 00:02:11 -0800
X-CSE-ConnectionGUID: EjUJDVqSS8ChKSGs9AUFTA==
X-CSE-MsgGUID: 1XbZRRp0RPOyoml/L9Kp8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="94521381"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 04 Dec 2024 00:02:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id B877027C; Wed, 04 Dec 2024 10:02:08 +0200 (EET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Aapo Vienamo <aapo.vienamo@iki.fi>,
	linux-spi@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] spi: intel: Add Panther Lake SPI controller support
Date: Wed,  4 Dec 2024 10:02:08 +0200
Message-ID: <20241204080208.1036537-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aapo Vienamo <aapo.vienamo@iki.fi>

The Panther Lake SPI controllers are compatible with the Cannon Lake
controllers. Add support for following SPI controller device IDs:
 - H-series: 0xe323
 - P-series: 0xe423
 - U-series: 0xe423

Signed-off-by: Aapo Vienamo <aapo.vienamo@iki.fi>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index c3b54928143d..4d9ffec900bb 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -86,6 +86,8 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa823), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xe323), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xe423), (unsigned long)&cnl_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
-- 
2.45.2



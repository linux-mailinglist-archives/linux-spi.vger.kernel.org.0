Return-Path: <linux-spi+bounces-12411-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A51D245F6
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 13:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 382AC301EA3D
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 12:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0D43624CC;
	Thu, 15 Jan 2026 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/1E/9tF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5E734846A
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478617; cv=none; b=UWqPmY+KsjSwPBYUzyffM9wDs5VVhJv5SBTm542JSp9VhESIA63Ig3nR1Wz6H5KZEsddZJbyccheOukdMU2Rx7zOIJngGQsHuWVsDVTgflSDPjZSkui9f1FAvMOL0/NP4BXXnpOlMzI6nYJAm+BwvycJCE2SshR6T1Jo9FDu4AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478617; c=relaxed/simple;
	bh=0jEriwcViPyahU1z/NFthMwBsGsNXS/C7c7UFgPOvfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gx0wkJMWIOBZYYnIXK89EUj5HESGqv7dPrpiogc5bJdnpgaEq+5oCE6yLU3O2xQnjBdh5/mLQ3RKmepw+84S4NDfWtAJHcHvEdTHoHKwz7LN59vuWQ+EqnG0/NeMitNXdUahuwU4UBLsYp9ssLiNpd3xcTtDLIVivWlbs0LZkWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/1E/9tF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768478616; x=1800014616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0jEriwcViPyahU1z/NFthMwBsGsNXS/C7c7UFgPOvfU=;
  b=f/1E/9tFUcTOuxLR5mMMT9DT8dsmjvS0v5pRMe19BL/1ORfFC3172c1y
   7gqNo9NxAnKe1l+lJ1VOL+C1me53j5kRfUrryIr8kZCPPguVXS7g1aepz
   y9+edrZ1l+bjt6tFV7H1JfRi9sQdaLpCvWEgI/RjBzgTdPOxyhGIzbswU
   4Rd5cxXkI0S2P1EBaZ1zI2/Dnf8DKBKUrUf0Es9j6D+HFlTmTjqg3r89d
   S72R4OqzliYzd7S5/1aHRkLc6h3nQCj1i7Pe2QxYnSC42bDV088aw3YWR
   VDEJ78CE7u80zkZtdVYj+QsD15YXAzQKPD0ZEiOfucmjYKWDTMdO7cqEQ
   g==;
X-CSE-ConnectionGUID: Ez6h12rVSUq5+jn3Eq0jLA==
X-CSE-MsgGUID: 16DXvPb4QE+ti2ILOWupxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80084668"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="80084668"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 04:03:36 -0800
X-CSE-ConnectionGUID: dsofFHLiTz23Dftt0OZk6A==
X-CSE-MsgGUID: UBvyPkZWRnKucE9I7bW4nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="204972724"
Received: from krybak-mobl1.ger.corp.intel.com (HELO aborzesz-mobl2.intel.com) ([10.245.246.157])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 04:03:33 -0800
From: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	mika.westerberg@linux.intel.com,
	alan.borzeszkowski@linux.intel.com
Subject: [PATCH] spi: intel-pci: Add support for Nova Lake SPI serial flash
Date: Thu, 15 Jan 2026 13:03:05 +0100
Message-ID: <20260115120305.10080-1-alan.borzeszkowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Intel Nova Lake PCH-S SPI serial flash PCI ID to the list of
supported devices. This is the same controller found in previous
generations.

Signed-off-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index b8c572394aac..bce3d149bea1 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -81,6 +81,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x54a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x5794), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x5825), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x6e24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7723), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
-- 
2.43.0



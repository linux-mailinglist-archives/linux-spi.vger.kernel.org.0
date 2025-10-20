Return-Path: <linux-spi+bounces-10725-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE86BBF1EF7
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 16:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48D624F296F
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 14:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9351514F7;
	Mon, 20 Oct 2025 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTabIjEQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7679C227E95
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972062; cv=none; b=tfd8CS0nBvdfORhm/EMX7h5ZoTa+D5U4d8rBGy6BEEWXpeuDns3tuam4NmRheLaNaxbvuktM6+yWMGX0KECfyaS6HJXwNYmFaa2O++46yr652on8Xohr7wThz/TwF6x3RiBbdXIOduI9Hcv063kVDduv/DrXNkZtH87RavTO/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972062; c=relaxed/simple;
	bh=Xx+zIAWO2IbeH9jD1mXUTY1ot3X14rVyTPArZ44ZBQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQHy8kQnHrzRIJgCFLaUXeFB62vzi4HFL+QAusqFmrHEEJSNjtFWZhYA+N618iE/057rcv4XHV2Qu4s5313N5R84+K8S9NvFb8TuFL7Gu+29HaPaeCS5eL6ullmgEDo+AwyydaMdCdPCjlYirN/rkkBnq3KMYQdE1hun78+bIy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YTabIjEQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760972061; x=1792508061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xx+zIAWO2IbeH9jD1mXUTY1ot3X14rVyTPArZ44ZBQs=;
  b=YTabIjEQmce5Nl5+nRHIAaPz72hu6sXx8seR/hiG3uBnGevXB1P8ORAt
   49EUuGscyWcY9RxATMeB0Y78NqTGMjnp4iWHt+P0Q84qNuoDU2nwup8VR
   ffRiLGeOwwZ2pylRAb/sgyLwe3+cuROprVgmo4tb134LB7CbghqBraBAT
   /pnvOmawUilgRLwdAKoyixdcXFKB9bqit4zL/6Gsqz0IVGe+zGv5kJ23i
   TbjjanVV6+fdCLHdFbeW+U7daXSq0nZgZJXKp5Y4sg0JUAL6IYmt/7ipq
   0hMOtTcxWYQFxDRRApt2pCg3OdeC78LGYlozkRePwPCvuqlDhZ9opQcYD
   w==;
X-CSE-ConnectionGUID: UBiShrMsTpmjOposMQ+Gfg==
X-CSE-MsgGUID: MkWrn6mFQxWRohx+xvqDbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63006639"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63006639"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 07:54:18 -0700
X-CSE-ConnectionGUID: GNOmoEU5QO2HTErP1tcjrA==
X-CSE-MsgGUID: HIYYdj6uSju7xeeUYR0yzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183756360"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 20 Oct 2025 07:54:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 7189E98; Mon, 20 Oct 2025 16:54:15 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 3/3] spi: intel-pci: Add support for Intel Wildcat Lake SPI serial flash
Date: Mon, 20 Oct 2025 16:54:15 +0200
Message-ID: <20251020145415.3377022-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020145415.3377022-1-mika.westerberg@linux.intel.com>
References: <20251020145415.3377022-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Intel Wildcat Lake SPI serial flash PCI ID to the list of supported
devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 49b4d3061197..7765fb27c37c 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -75,6 +75,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x38a4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x43a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x4b24), (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x4d23), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x4da4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x51a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x54a4), (unsigned long)&cnl_info },
-- 
2.50.1



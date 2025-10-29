Return-Path: <linux-spi+bounces-10909-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659DC18846
	for <lists+linux-spi@lfdr.de>; Wed, 29 Oct 2025 07:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C39F1C6364F
	for <lists+linux-spi@lfdr.de>; Wed, 29 Oct 2025 06:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68372D839A;
	Wed, 29 Oct 2025 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqXSV7mg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A972135C5
	for <linux-spi@vger.kernel.org>; Wed, 29 Oct 2025 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720624; cv=none; b=eSH8ljbOVbBgYPXL7CcMp/hsPsn3LhmthH+JsNdN8Cq2ffE+KPkzkvoGVoQzGhgyotPizLGe0cPwWFmzkyh5NrYg74992zclp6ssw1LxO76IoVgCulx/kxAoOsxaxL5JW1PZEIgxZ0k7xsOrPO01MElkpOpJZBYB5SC1JAxOluk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720624; c=relaxed/simple;
	bh=gIegXoMR79F17OSgY0zxnyPOujDAs0fM/jhrVH+4eOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oe4/uVr70OQAlINCQjZwmdrBti2bPfEwAkMaVgJTl5jidzUN74R4nCvHda0vESGZlNG/lPQXkjVmP3GI+7NUxlylj5dIX2sw1hxNL8vbBMvp0vnIr53KPGjcDm/Pu0pbsVtHjzwUCJloHZ6VrLBoQTdanFmXFhaG4BknVi+Za4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqXSV7mg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761720623; x=1793256623;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gIegXoMR79F17OSgY0zxnyPOujDAs0fM/jhrVH+4eOQ=;
  b=mqXSV7mgAfWmx/si0ogUD+febs7oBA2q7iMVCezabhrKVNm2W3PSyPcE
   scAKnqMz2DPgzOpawthSc0kMS83z0QIF8UoeubYvs4G+sE8h8IM66h1BV
   FBeti17gLwcbv/0MVgU6nMCGt7clfClfqep9k/swClkQ6UnAtfvCB00nQ
   27GdsxrDnbYzbQwKrp5kQT2LZAwA57KwKrAWsYrfrjpiSxd7bR5p2xQzm
   mmIuFdpyN0+XsoG43e0QxRIajeYfzFviCfUm1v2bl4mXoLgCkemLlypKS
   6ZvRecaH728FYTuqk7W4G/2i7HQp6k6lnG7iB1cmYt8ZDIhxwV8Q0S3zB
   w==;
X-CSE-ConnectionGUID: dKVT/IGUT+yDyavETeOCig==
X-CSE-MsgGUID: 7ibJNOhhSVOKs+0mKdaEuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67696290"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="67696290"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 23:50:22 -0700
X-CSE-ConnectionGUID: +bjVsIb7T/G/htz26QjNVg==
X-CSE-MsgGUID: uLOL84+5S2qPfnkNFT+gEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="190703901"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 28 Oct 2025 23:50:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 7D25E95; Wed, 29 Oct 2025 07:50:20 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: intel: Add support for Oak Stream SPI serial flash
Date: Wed, 29 Oct 2025 07:50:20 +0100
Message-ID: <20251029065020.2920213-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Add Oak Stream PCI ID to the driver list of supported devices.

This patch was originally written by Zeng Guang.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 7765fb27c37c..b8c572394aac 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -80,6 +80,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x51a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x54a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x5794), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x5825), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7723), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
-- 
2.50.1



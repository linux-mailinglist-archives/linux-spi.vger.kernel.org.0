Return-Path: <linux-spi+bounces-3973-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C651393B25A
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 16:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDEA1F211A6
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED94DDC5;
	Wed, 24 Jul 2024 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ha7filn6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D6EEAB
	for <linux-spi@vger.kernel.org>; Wed, 24 Jul 2024 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830172; cv=none; b=MIqshBPwzt/FjbWbks25j258/3lQXFyIqwJbVp5mKz1RtTLokkZSbKZvqUhfjPrQticU8NNPmnmQjnvd6n+huKQKW8hdi+kvcBRkU6ZXTXTmjtZu8aOGjdzLNYOtXydZ8OvvUi8g5ppV0t3aSA2ZyNusoGWVyO+qTfJBM3IBQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830172; c=relaxed/simple;
	bh=ykvhi9CLDv624qgten1HNwsh5CZkKKRX9KCLAGda0l8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PAl3ICScuCVeJff/2ui8wFinTs7jWMyosYcPuKrmTLMjDGTQ0ipfV+BFNCFtdmQIs1qipebZEs/2uPvwIaF1YZEKDuDz+Z5LFWYfl/MeSAFq9ZdhGYdG/VdnnKXPBbUAPyWHrETs01y5K4ibgRR+fqdtkRnT7SuzFwWSDhun+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ha7filn6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721830171; x=1753366171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ykvhi9CLDv624qgten1HNwsh5CZkKKRX9KCLAGda0l8=;
  b=ha7filn6isce7fYeMoChDwm0c0LFvDAEpE0Pj6ecLH6wq5ldbJ57BAJF
   pgShu89I9wZyOfELBclDstCm3Jqz/M5sueAcreD6XDQEXj5G8cEUY/GON
   alISrPkA79buJMApczmaQNebbyXdS0Bzso5sdzNfhX/OvpjkQaLCpP50f
   5k1nseSmkzxMKFaY4H9ARc8EWpGc3YUesfF8F7xT2Z8Gx6wLKhm113pOe
   gutwPXIq7oWvNb/hgpcJq7Oc40H0HoKE022tN4HlajMRRPSyT3jFTZ336
   orHMDZz6dcsbdSF3YueLDCJTVw+9XLOwnoPvkGlqdPzZGohchjou2Vz5t
   g==;
X-CSE-ConnectionGUID: RmHPzhLKTAKQl3Eg9y5DIQ==
X-CSE-MsgGUID: Sc6fw2uURSixc8czkw9OvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30173834"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="30173834"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 07:09:30 -0700
X-CSE-ConnectionGUID: cBmtjbbiTDGmj5HX7zKuSw==
X-CSE-MsgGUID: MWeu4XEDSKmS5d6ZGaTciA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="83211540"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 07:09:26 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Mark Brown <broonie@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-spi@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH v2 09/12] drm/i915/spi: add intel_spi_region map
Date: Wed, 24 Jul 2024 17:00:11 +0300
Message-Id: <20240724140014.428991-10-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724140014.428991-1-alexander.usyskin@intel.com>
References: <20240724140014.428991-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomas Winkler <tomas.winkler@intel.com>

Add the dGFX spi region map and convey it via auxiliary device
to the spi child device.

CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/i915/spi/intel_spi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/i915/spi/intel_spi.c b/drivers/gpu/drm/i915/spi/intel_spi.c
index 17e4c7861ef5..8dd4065551e2 100644
--- a/drivers/gpu/drm/i915/spi/intel_spi.c
+++ b/drivers/gpu/drm/i915/spi/intel_spi.c
@@ -11,6 +11,13 @@
 
 #define GEN12_GUNIT_SPI_SIZE 0x80
 
+static const struct intel_dg_spi_region regions[INTEL_DG_SPI_REGIONS] = {
+	[0] = { .name = "DESCRIPTOR", },
+	[2] = { .name = "GSC", },
+	[11] = { .name = "OptionROM", },
+	[12] = { .name = "DAM", },
+};
+
 static void i915_spi_release_dev(struct device *dev)
 {
 }
@@ -31,6 +38,7 @@ void intel_spi_init(struct drm_i915_private *dev_priv)
 	spi->bar.end = spi->bar.start + GEN12_GUNIT_SPI_SIZE - 1;
 	spi->bar.flags = IORESOURCE_MEM;
 	spi->bar.desc = IORES_DESC_NONE;
+	spi->regions = regions;
 
 	aux_dev->name = "spi";
 	aux_dev->id = (pci_domain_nr(pdev->bus) << 16) |
-- 
2.34.1



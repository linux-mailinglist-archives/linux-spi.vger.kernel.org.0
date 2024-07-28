Return-Path: <linux-spi+bounces-4034-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F7593E57B
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1C11F21591
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 13:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B94A46BF;
	Sun, 28 Jul 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrLeVrYG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8071B86C2
	for <linux-spi@vger.kernel.org>; Sun, 28 Jul 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722172559; cv=none; b=tgezt8nbTS32JW55KHxtvppfGHFT7g/LvmUndNFlpeRrwkN7QZUm1iHqsSzSNI1pfAnqw/u67Xx/+clmaLpFUZ4QPx36T1q4vF1OloS+/RcqMFx6xdRyWwox+c+jGqZse0T5fQu/SoRzLVdPsjvMJgVYwIBAvyRNqe9Zv98cENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722172559; c=relaxed/simple;
	bh=+i+Z8QNOPGGxK7/2DGH5tcM27kZR7UTgKdQ4u2/N/78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XkX8dqpZtSD464ABH/M5Gr1sKsOWGmXkfhmioqzkkjmy8JWUA6C9oQF8GQl4bHGK5nt2P3T6JjeGP4fgwLqAIeS4lCtCHXb4EQjFaIxdWt+j5i3VJUG3byJULJAkW7b0Nz5Obc1bIajSPl4aMkrHfy8B5TpDBmgam/GxV5UMbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrLeVrYG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722172557; x=1753708557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+i+Z8QNOPGGxK7/2DGH5tcM27kZR7UTgKdQ4u2/N/78=;
  b=BrLeVrYGppWSHnOGk43ntL5TnL5v6Z11tIYMiMXuOT8tZkt9kBAAD/R+
   XMwZVnD/XkKVwWeaLLIn+fggWoC6namSpyJNZFowkHpRrFIlu6/v5mHpQ
   SeCxLStoWNv/V1TyeiFIuXK9sqk8VBxtRqcnJ0qQo1+e3JuKly0NBXphg
   BLPbw8p3zZBQ9Ev3QfAkNV69/F3dPlWl9RYiBbmgBeU7pM6lM4F3MyeH8
   L64dv7RsVAlrgZZkvZuS9sZ7afCFAA5rtULZejv1lBAofaLAyJN6HlQnq
   vgHwbN2BezafICxoGIZ9zMEVCa9Ae7jMDOS8GntSye12lfTTjcZUfs3rP
   Q==;
X-CSE-ConnectionGUID: Xp06V6cGTuOhNqz10Xr6SA==
X-CSE-MsgGUID: xLrTKltlRu2YOuBCMKyMKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="23713482"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="23713482"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 06:15:57 -0700
X-CSE-ConnectionGUID: rE3M/wnjQli9aCcEGhd8vA==
X-CSE-MsgGUID: msEJhyL4QluT27KWIRwzGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="53389337"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 06:15:52 -0700
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
Subject: [PATCH v4 10/12] drm/i915/spi: add support for access mode
Date: Sun, 28 Jul 2024 16:06:36 +0300
Message-Id: <20240728130638.1930463-11-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240728130638.1930463-1-alexander.usyskin@intel.com>
References: <20240728130638.1930463-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check SPI access mode from GSC FW status registers
and overwrite access status read from SPI descriptor, if needed.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/i915/spi/intel_spi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/i915/spi/intel_spi.c b/drivers/gpu/drm/i915/spi/intel_spi.c
index 200139531d26..e2b76e5cbc0c 100644
--- a/drivers/gpu/drm/i915/spi/intel_spi.c
+++ b/drivers/gpu/drm/i915/spi/intel_spi.c
@@ -10,6 +10,7 @@
 #include "spi/intel_spi.h"
 
 #define GEN12_GUNIT_SPI_SIZE 0x80
+#define HECI_FW_STATUS_2_SPI_ACCESS_MODE BIT(3)
 
 static const struct intel_dg_spi_region regions[INTEL_DG_SPI_REGIONS] = {
 	[0] = { .name = "DESCRIPTOR", },
@@ -22,6 +23,29 @@ static void i915_spi_release_dev(struct device *dev)
 {
 }
 
+static bool i915_spi_writeable_override(struct drm_i915_private *dev_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
+	resource_size_t base;
+	bool writeable_override;
+
+	if (IS_DG1(dev_priv)) {
+		base = DG1_GSC_HECI2_BASE;
+	} else if (IS_DG2(dev_priv)) {
+		base = DG2_GSC_HECI2_BASE;
+	} else {
+		dev_err(&pdev->dev, "Unknown platform\n");
+		return true;
+	}
+
+	writeable_override =
+		!(intel_uncore_read(&dev_priv->uncore, HECI_FWSTS(base, 2)) &
+		  HECI_FW_STATUS_2_SPI_ACCESS_MODE);
+	if (writeable_override)
+		dev_info(&pdev->dev, "SPI access overridden by jumper\n");
+	return writeable_override;
+}
+
 void intel_spi_init(struct drm_i915_private *dev_priv)
 {
 	struct intel_dg_spi_dev *spi = &dev_priv->spi;
@@ -33,6 +57,7 @@ void intel_spi_init(struct drm_i915_private *dev_priv)
 	if (!IS_DGFX(dev_priv))
 		return;
 
+	spi->writeable_override = i915_spi_writeable_override(dev_priv);
 	spi->bar.parent = &pdev->resource[0];
 	spi->bar.start = GEN12_GUNIT_SPI_BASE + pdev->resource[0].start;
 	spi->bar.end = spi->bar.start + GEN12_GUNIT_SPI_SIZE - 1;
-- 
2.34.1



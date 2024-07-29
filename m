Return-Path: <linux-spi+bounces-4051-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533A993F050
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 10:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4D71F22C2B
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 08:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E7413CFA3;
	Mon, 29 Jul 2024 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYY2q0HP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E3F13C80F
	for <linux-spi@vger.kernel.org>; Mon, 29 Jul 2024 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243163; cv=none; b=g0xdLIOYpQnMWnyyk4WtCAvs0Oxd5VpbEruC4bRDGyG3PkhPgYs7QIJfACqIwlHLxWYiK1OfOkm9F7mImNZr5Ln1GGcm/s2JKBeruHRZLrukCzhThzfgHvnR6VCavEDp/10BAj1omk+3eCoeVurig8rlQHuWy9FTfB9xPzMlMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243163; c=relaxed/simple;
	bh=+i+Z8QNOPGGxK7/2DGH5tcM27kZR7UTgKdQ4u2/N/78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EO52G+/1RmrrbJtEf5q18gtOq6bNnrbI/JB/1E+AVv24FAStrdmQCNM2sidKKKBJI+RrSfmhzTCxbm5Syjdhe6xuOVg9YgDR3tPbmhoJqgcpbAeBjgwZwDbgUkDgr0mogSQGnVckw6etCpr/dqS6YEKAOIZEEbnpRdB17a2eh/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYY2q0HP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722243162; x=1753779162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+i+Z8QNOPGGxK7/2DGH5tcM27kZR7UTgKdQ4u2/N/78=;
  b=IYY2q0HPKHRx6orF7nnw+8waCXnPH8LhAGGQly9ru2o2HlfuYUOgK0Wh
   RF+GKjA74EeM4FeEvVdxZk/cDLTIWBf++MTm2q4GqRkqf8P6U5gPKM+9T
   dnnaVSrhUeP5Cy7Zl21bMUgkFW8uh/hFr0B4Nw1RSsBcVMfQSihLoPQDx
   3PhvZgBkUvh0dyY7UtpPy2CRFxiOJCIrWqi6VggpMXQqIIgZ9V3b5ewv0
   yc0LgYi1P4enTgnS8RLqFiGJiXd4udIQozAZPhri4rkF/EGsI9iuJO2J/
   HQ3um8Ckk/GTKgmce0dezCjUlHN1l19Qkqw/OrT/a/C/bx2pKEQ0uFX5h
   Q==;
X-CSE-ConnectionGUID: rNw1RSLwShGkOxtfO+Malg==
X-CSE-MsgGUID: D6WUclbARzitjS/H+0IXKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="42509123"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="42509123"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:52:42 -0700
X-CSE-ConnectionGUID: 6enPkPRYRgiZ2y/JvF4Shg==
X-CSE-MsgGUID: ZwKcNUZdTd2sBaR1GLuJTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="54708698"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:52:37 -0700
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
Subject: [PATCH v5 10/12] drm/i915/spi: add support for access mode
Date: Mon, 29 Jul 2024 11:43:24 +0300
Message-Id: <20240729084326.2278014-11-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729084326.2278014-1-alexander.usyskin@intel.com>
References: <20240729084326.2278014-1-alexander.usyskin@intel.com>
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



Return-Path: <linux-spi+bounces-4832-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFA697A3B3
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2024 16:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F162D28CF74
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2024 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1840B19413C;
	Mon, 16 Sep 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GX3D6Uam"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73045194124
	for <linux-spi@vger.kernel.org>; Mon, 16 Sep 2024 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495142; cv=none; b=je4EW3vwtRzV1A4B98a6Y2fV8HnERSG49ZFr5RVbG06/VGcv2yZMLqYUAThrKPhw+wTKGZyu4ujHNfDZTiO5s2xKAnA2Vo8y3JyZB2r7fv9/dsfSkI/nmYPrri3rE9ZQMZUeX7Z3PdqBxvA+7LDAr6RoBXPT0/+zcg6uLBmeF2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495142; c=relaxed/simple;
	bh=+i+Z8QNOPGGxK7/2DGH5tcM27kZR7UTgKdQ4u2/N/78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VfcX/27txLcsYB9Nhd/8S2BOy1CYPWrszYIKLCiP2R7KFkHG7hiudQiDCe3ygKEwxMUPYHHVik/OCihth25axC0R/T6nnM6EcAlz/SPpi72CxUtsaAgY1cx0ZXSiZ8korkDGEXhKglB/Z2YWNaoafvlrFrqBVQVPn3sgoKs9+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GX3D6Uam; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726495140; x=1758031140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+i+Z8QNOPGGxK7/2DGH5tcM27kZR7UTgKdQ4u2/N/78=;
  b=GX3D6UamAUgHUVUBK0q5zY0OY3ZK4H4MPf0U8H/W3OCb6ShnkJ48clvO
   RqGzsDxgIUs4QVV/gWEYWvbaR/PzhnsRnl78sgbjNJ4bGXDNarNtnAuDW
   /pBLaQ1B7BVkwR3sTHf3lNhuPO5UFQsqSBdRmQhmehll5jtChjUDCoDW8
   B4x/agnDaT/jLGRZN2mTU4Az/ULID8qEvxwyoIlGknQPkw70AKpRz8UjH
   yxXEjEHxW0Sd4bK7nepUwlc/xqBYCsQ5nanVYDGkchbfBzo2lfbIow1gO
   Ok0ruIh/91tKhBPl+hrXmIvyZDYnPaxDls2iHrPPCfdIM0F4VAG/cU5z3
   Q==;
X-CSE-ConnectionGUID: QtHN+bhIS9eGAx4j+V94KQ==
X-CSE-MsgGUID: gKStHcnoS+2mvPTM/nRomw==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="36666917"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="36666917"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 06:58:17 -0700
X-CSE-ConnectionGUID: thWLqYcMRqeTDE/7hRAl2g==
X-CSE-MsgGUID: Bfg0s3z/SpeARIr8/1frjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="68837481"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 06:58:13 -0700
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
Subject: [PATCH v6 10/12] drm/i915/spi: add support for access mode
Date: Mon, 16 Sep 2024 16:49:26 +0300
Message-Id: <20240916134928.3654054-11-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916134928.3654054-1-alexander.usyskin@intel.com>
References: <20240916134928.3654054-1-alexander.usyskin@intel.com>
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



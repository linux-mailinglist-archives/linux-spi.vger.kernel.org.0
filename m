Return-Path: <linux-spi+bounces-4050-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DACD93F04E
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 10:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F30BBB20806
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751AA13C801;
	Mon, 29 Jul 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INfunyKO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC4513CFA3
	for <linux-spi@vger.kernel.org>; Mon, 29 Jul 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243160; cv=none; b=qgykjVIJm69XuNhcXPFqxISGzSFbJcqdEM7amXJPB2e2sdEX04NVPRWFWscjeP0iU6lqu30wMAU+bYH92EiAOSG+fBW0WUY4IEaCW5mZCsNfBS6wpg6SNyPojs+qE/oFs7TKXj6jHkYzwznwd1szh0ALCTIpuQztrGaHfXFtcfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243160; c=relaxed/simple;
	bh=XwjfPtNKP3xj4mYiGTP+Pjdqb0DSUXkzIDtfWZSx5QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=meXcq1wfsESvN9nnFOlR+TwHrClCf82MGz0tsjGUWLcz9BD2jZiEWAStR5ETMKoMvJGOeKLTdcergisYk8mBjRl7/qz3yygqoUsN77dahpMBZCoOwXO5QcZ0dKS5FX8HLCeu4QfdoiC3w1d17UPyRUp6PSsIxh2KLER0aTFD2Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INfunyKO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722243159; x=1753779159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XwjfPtNKP3xj4mYiGTP+Pjdqb0DSUXkzIDtfWZSx5QA=;
  b=INfunyKOqj1WWg27mReLGCPfe7Wv4HZXExHtDnx+XvlcbdELytJ7gjU9
   wh8GJcnjoKI0BF6LCXkVvphqp3KPNEXGlhfPxCNxgD2D9ZzywznCs1vY5
   Pryi3IcG1o+2Adn/eh4NAfNWjKcE3CXP08jZwRQusmdnZEvQKN/NEl+XR
   OBMBpHKHUGE+DSxFZK/I8dqQ0OtbW2VcTe5pPSqJ3ll6DuYlAT8pajMIs
   CLq4Bldq2FL3t44DsjkqQjIVkwsnmCi9Xfv2lli6BpliEjY7MA2ozz21u
   ZK72/ReGqaHuU9pvpMunU5o+aohgS8K487LvOMbQQ7+C7hfxqLLOgvck0
   Q==;
X-CSE-ConnectionGUID: B5nydi3IQhmO2OeaSmX5tQ==
X-CSE-MsgGUID: +B7ZFFYDQ32vmI8xXN3q1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="42509103"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="42509103"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:52:37 -0700
X-CSE-ConnectionGUID: ZcRyANHnRy6FpAOfB4xM8A==
X-CSE-MsgGUID: hu2FAmAjT9aEMieTgGdTKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="54708625"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:52:32 -0700
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
Subject: [PATCH v5 09/12] drm/i915/spi: add intel_spi_region map
Date: Mon, 29 Jul 2024 11:43:23 +0300
Message-Id: <20240729084326.2278014-10-alexander.usyskin@intel.com>
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
index 4b90e42b0f86..200139531d26 100644
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



Return-Path: <linux-spi+bounces-4041-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D61DD93F034
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 10:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF9D1F22E13
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348FA328B6;
	Mon, 29 Jul 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P56PLtM6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1013C80F
	for <linux-spi@vger.kernel.org>; Mon, 29 Jul 2024 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243113; cv=none; b=tjvssVUmZHdkvg60YAvZXxScZUPMWw6xw8TrBpV5+VxrnoHxIYn2jS2oCxAQ92FfY4xQoY/OVwhZ/Oztbw8atMHYzMhBB0VEnIvgG9M9OAf4KxDbOhHCH8+0mwfMlO/30lt1sgaqT6DVuPXJ0O4MPxLtILbyHUsWh1Z6Yz13+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243113; c=relaxed/simple;
	bh=+mpMnKJ8YinzWX+MU7QkIZSHMER2aij/iiX0Pbith30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DSHFkg6WKDC40xZXYNvGI/VD8WK3MKyRN3Jjb60IhozTgV54DRc62vIwqHndBHewtFDBLkNNfnEkO7/73ACtd6cW/BFx7X4toLaCqb439ZJ8RYoATVU3fePShppEpTN4S6/Qcy4JrCjPVsSnwWnQiTjbiBdQ0/VHSLcFoCuHac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P56PLtM6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722243111; x=1753779111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+mpMnKJ8YinzWX+MU7QkIZSHMER2aij/iiX0Pbith30=;
  b=P56PLtM6ktDL44QSAjm4cGCZnjDkYGzUvilzOb+cSqLOOYuPSusXV+Rg
   jFnwgOQ0sMPTTFcF2liJ4xaD372ll3/WW9le32wbz2YAiANFKTALpEPZL
   kWqj7TOwUX2qHSYIH+RexrkCxoi8b4sarw2mdlEEY8D7YZDWC/fl+J3ro
   AKmhRjIKUU3BjP9CPMr2Uoct3xo70JOJp6238QcMU2mDcP129Mlu/hihh
   xKizeisHTg47eXcOVuDaYeoJVHozDW5bd47imBB86tF2omXaVq9HCVMWU
   qyRItWX1NjqiHtzn51b4+u8lT4fhlcICSKhlQ28Y74bEZg9qjUQbWsOZP
   A==;
X-CSE-ConnectionGUID: Jqz167fxSiKkQX4GuxGY1Q==
X-CSE-MsgGUID: DOXH42OeTiGbYUBIAQT9fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="42508911"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="42508911"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:51:51 -0700
X-CSE-ConnectionGUID: 20w/hUGlSlOivuolmjXNEA==
X-CSE-MsgGUID: RsHoJI6QTsOmIAUzKucpUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="54708125"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:51:44 -0700
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
Subject: [PATCH v5 00/12] spi: add driver for Intel discrete graphics
Date: Mon, 29 Jul 2024 11:43:14 +0300
Message-Id: <20240729084326.2278014-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add driver for access to Intel discrete graphics card
internal SPI device.
Expose device on auxiliary bus by i915 and Xe drivers and
provide spi driver to register this device with MTD framework.

This is a rewrite of "drm/i915/spi: spi access for discrete graphics"
series with connection to the Xe driver and splitting
the spi driver part to separate module in spi subsystem.

This series intended to be pushed through drm-xe-next.

V5: depend solely on AUXILIARY_BUS, not on COMPILE_TEST
    disable spi driver on virtual function in Xe, no spi device there

V4: fix white-spaces
    add check for discrete graphics missed in i915 intel_spi_fini

V3: rebase over drm-xe-next to enable CI run

V2: fix review comments
    fix signatures order
    depend spi presence in Xe on special flag,
     as not all new discrete cards have such spi

Alexander Usyskin (6):
  spi: add driver for intel graphics on-die spi device
  spi: intel-dg: align 64bit read and write
  spi: intel-dg: wake card on operations
  drm/i915/spi: add support for access mode
  drm/xe/spi: add on-die spi device
  drm/xe/spi: add support for access mode

Tomas Winkler (6):
  spi: intel-dg: implement region enumeration
  spi: intel-dg: implement spi access functions
  spi: intel-dg: spi register with mtd
  spi: intel-dg: implement mtd access handlers
  drm/i915/spi: add spi device for discrete graphics
  drm/i915/spi: add intel_spi_region map

 MAINTAINERS                           |   7 +
 drivers/gpu/drm/i915/Makefile         |   4 +
 drivers/gpu/drm/i915/i915_driver.c    |   6 +
 drivers/gpu/drm/i915/i915_drv.h       |   4 +
 drivers/gpu/drm/i915/i915_reg.h       |   1 +
 drivers/gpu/drm/i915/spi/intel_spi.c  | 101 +++
 drivers/gpu/drm/i915/spi/intel_spi.h  |  15 +
 drivers/gpu/drm/xe/Makefile           |   1 +
 drivers/gpu/drm/xe/regs/xe_gsc_regs.h |   4 +
 drivers/gpu/drm/xe/xe_device.c        |   3 +
 drivers/gpu/drm/xe/xe_device_types.h  |   8 +
 drivers/gpu/drm/xe/xe_heci_gsc.c      |   5 +-
 drivers/gpu/drm/xe/xe_pci.c           |   5 +
 drivers/gpu/drm/xe/xe_spi.c           | 113 ++++
 drivers/gpu/drm/xe/xe_spi.h           |  15 +
 drivers/spi/Kconfig                   |  11 +
 drivers/spi/Makefile                  |   1 +
 drivers/spi/spi-intel-dg.c            | 863 ++++++++++++++++++++++++++
 include/linux/intel_dg_spi_aux.h      |  27 +
 19 files changed, 1190 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/spi/intel_spi.c
 create mode 100644 drivers/gpu/drm/i915/spi/intel_spi.h
 create mode 100644 drivers/gpu/drm/xe/xe_spi.c
 create mode 100644 drivers/gpu/drm/xe/xe_spi.h
 create mode 100644 drivers/spi/spi-intel-dg.c
 create mode 100644 include/linux/intel_dg_spi_aux.h

-- 
2.34.1



Return-Path: <linux-spi+bounces-4024-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207EA93E55F
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 15:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF59B21065
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2024 13:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65C146BF;
	Sun, 28 Jul 2024 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNMlYg+B"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D3647F6B
	for <linux-spi@vger.kernel.org>; Sun, 28 Jul 2024 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722172508; cv=none; b=QU5gO6fyZOvLP19Fz0Agl2mZypsc+L1gosvfABhs2aIPeSvTzEBKFT5bJK+9WYI0a7OzLyMLQZFbPHNrD7SKdCM4WNlOrFbdWFcpUWZRaXLlGEoi54zaClRhOgnEzSQxkN5J2XhwVRAMrTc1eiNPScoKryqPaons5dsbaOy7M3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722172508; c=relaxed/simple;
	bh=yF0BFL+omLvw0bPlU0/GiXco53BbONI1IwSAQvfCvc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I4cOSDh6+qYIYhXhSy1p34FrUQNGWKb0+FHeuyJSPX5sI4nJey7dNq4B9abwbgwylYwfDrmzucynQ0sr3ikIyc+zdOA4CclBuJapxgoW+klemP20j9s8r7cR0VlG0tcVr1g0Kz0xAISPx4yZtojEQv2ki3Zzcq3bV5kZAu7gbRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNMlYg+B; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722172506; x=1753708506;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yF0BFL+omLvw0bPlU0/GiXco53BbONI1IwSAQvfCvc8=;
  b=mNMlYg+B3hc3odKv/Tj857ObQJ768My1V/1rIUnc8CWtWrD0u2M0Syrh
   I+P6DjpaYmUFiXmKTTqSvewHbZrA4ScOSLZjvSaZCUrCNU3CXkxhp10PX
   e+Ia4PGqYpg3yTnFgezaythKnmPyhliTk30BgTg2pDx064ioul3eg4Xep
   h0RBIDH9JVnJPgRyWWObZpkyCDrM9EEDp3Lw7qDT8u0Yp4p5c8iUbtuln
   EJKH5yd2ieKStBfI0STfCxOwzftRBOSP+7fEW3uho0xkRKEE7NUDZNabl
   P1cWc5dRhDTaPopcNVBl4L+ziSm2jEU+g3XkKG7FWUFwX7Zi41PCWq2rQ
   A==;
X-CSE-ConnectionGUID: 7rKr2M/LSG+Q5lA2h4bBew==
X-CSE-MsgGUID: U9PKpUZVTIOF0JQ5Aj+vNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="23713372"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="23713372"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 06:15:05 -0700
X-CSE-ConnectionGUID: za7SVaYrTd6WTo7krv9YRg==
X-CSE-MsgGUID: CTvoC8EuRyah7lTL5offTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="53389147"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 06:15:00 -0700
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
Subject: [PATCH v4 00/12] spi: add driver for Intel discrete graphics
Date: Sun, 28 Jul 2024 16:06:26 +0300
Message-Id: <20240728130638.1930463-1-alexander.usyskin@intel.com>
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
 drivers/gpu/drm/xe/xe_spi.c           | 104 ++++
 drivers/gpu/drm/xe/xe_spi.h           |  15 +
 drivers/spi/Kconfig                   |  11 +
 drivers/spi/Makefile                  |   1 +
 drivers/spi/spi-intel-dg.c            | 863 ++++++++++++++++++++++++++
 include/linux/intel_dg_spi_aux.h      |  27 +
 19 files changed, 1181 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/spi/intel_spi.c
 create mode 100644 drivers/gpu/drm/i915/spi/intel_spi.h
 create mode 100644 drivers/gpu/drm/xe/xe_spi.c
 create mode 100644 drivers/gpu/drm/xe/xe_spi.h
 create mode 100644 drivers/spi/spi-intel-dg.c
 create mode 100644 include/linux/intel_dg_spi_aux.h

-- 
2.34.1



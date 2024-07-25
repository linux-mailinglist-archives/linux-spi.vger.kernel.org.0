Return-Path: <linux-spi+bounces-3991-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AED93C381
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 16:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E891C20401
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 14:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618A8199386;
	Thu, 25 Jul 2024 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMqOJLVw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FAA1EB2F
	for <linux-spi@vger.kernel.org>; Thu, 25 Jul 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916322; cv=none; b=gnf/60/sWJuB9/wTNkOMFD5SELoZ+rMRsta+uK322guIB4sy9bEW3N9GZbrz5rx8WGoEfB7nDONlmTwSCtQqmw/H5WyO1AJhsrK6IxzNZS4eeYdPa33uvGIB4ipJi+dg9tdkryPFoSpP8N1Fu27IXgNfrqFJlpxSdP3uyDedAvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916322; c=relaxed/simple;
	bh=gED3aOqN/q8cvDC2SzthwKcS2p7mJl+FIYNKfZ2WdBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LOz1FgDKHY+uoP9t6W9Lba8qP77FRdq1SlZ4jqSn/AJKZX73Su026cahLrbCp9tHBZYnNTpTrTlAp8ieXvjSazdbXGW/YSKMImcxpLu6zBBOL6MU7izWlX18C9tja3uawioj43iCjrD3KWx0lzlCcgBqoGsGRGJCRSCGfPtZ9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMqOJLVw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721916321; x=1753452321;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gED3aOqN/q8cvDC2SzthwKcS2p7mJl+FIYNKfZ2WdBI=;
  b=EMqOJLVwmWgXm3CxOvXk6RGqOogptH/xOyxlWry2O5wFjyNvCp9cGfqN
   coYeiE22St7LCLaqC+n+YX5sOnHE7aLTQgITlSBV28SfsVNytCKbrxMhd
   95khr/BRUIEr+lxEttUchS9vRwHVbde1gGHEOEssuYi7kZo+bVkAR28Oy
   piSonlXERjnTNcOyrlONPSSa6h/GfX8lxN8FSrQUiH2rjA+yOPWB4lxXX
   uWQGIVhOOvVNbzEzZuyIeDNBxbKw3PshPZ49L6IvOsQev9RmDGQrOlSEJ
   lNltwQCbnX84SRjaVzmXM/FsF7lR1+j6ewgJIbQ/bWBq2XDKl6OW8+ykJ
   w==;
X-CSE-ConnectionGUID: TvasH2MfR+63bd42XfTn/Q==
X-CSE-MsgGUID: NFCkyeekTXWHOL9gYNXboQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19504627"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19504627"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:05:19 -0700
X-CSE-ConnectionGUID: sBlQhzjXQcGAEK33hi8Fuw==
X-CSE-MsgGUID: zj6TEOOuQpWdgpdCefgisw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="53007683"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:05:13 -0700
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
Subject: [PATCH v3 00/12] spi: add driver for Intel discrete graphics
Date: Thu, 25 Jul 2024 16:56:45 +0300
Message-Id: <20240725135657.1061836-1-alexander.usyskin@intel.com>
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
 drivers/gpu/drm/i915/spi/intel_spi.c  |  97 +++
 drivers/gpu/drm/i915/spi/intel_spi.h  |  15 +
 drivers/gpu/drm/xe/Makefile           |   1 +
 drivers/gpu/drm/xe/regs/xe_gsc_regs.h |   5 +
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
 19 files changed, 1178 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/spi/intel_spi.c
 create mode 100644 drivers/gpu/drm/i915/spi/intel_spi.h
 create mode 100644 drivers/gpu/drm/xe/xe_spi.c
 create mode 100644 drivers/gpu/drm/xe/xe_spi.h
 create mode 100644 drivers/spi/spi-intel-dg.c
 create mode 100644 include/linux/intel_dg_spi_aux.h

-- 
2.34.1



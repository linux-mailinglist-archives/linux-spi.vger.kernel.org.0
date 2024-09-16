Return-Path: <linux-spi+bounces-4822-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B418597A3A1
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2024 16:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F15B28AA8
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2024 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8CC192B93;
	Mon, 16 Sep 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSIYzuOw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A8192B90
	for <linux-spi@vger.kernel.org>; Mon, 16 Sep 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495048; cv=none; b=hOSSw2UIs0cSuEDpkOXYssNarGZGsTF3tdMC2+JpQZlEOiwsdCOM4+faK30woSQ3v3CGs714WX2VObx6DZdJUZpLSxGSV1QLf3Ocos7NAuiIC21LDwptzSuQhjK+0B4ivPmDKPcBs3536QWXxb7Sh7/q21QxsJBhvjyyADcrz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495048; c=relaxed/simple;
	bh=zTwsZrDXnDC1uiYlcN1TwkwSGvKKrOj0gAFKcVZEkAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nYi/sYVnMChfzVF8iuGTW66TWmamFlCE5GRorP9kOWgerqklU6dfK7nA4t8An/UqrXHxwp9OwEsHr6PQelxb5TwHwbI1aXH+odt3VfHkYZJNCRima+2dtC6IcuAp1rrqLH0m0ENoo7u2i15GmjKu39N0KzSj6pIvEAgHBfEsyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSIYzuOw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726495047; x=1758031047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zTwsZrDXnDC1uiYlcN1TwkwSGvKKrOj0gAFKcVZEkAs=;
  b=BSIYzuOw/Pc+/yJEn0Wsd8lkIdgtxbZ0Dag+GWlqbQuJodgLJFX1vKaF
   DqLLcJ87nKT7n0LSlMKQos34GN6mf3sn776BQjhaqXsq2zHzS9XgfM5hH
   ko3Iwu0RohAqCL7OnS6rKulpd8LGkZSPts7oc/K/6OvAgGaiZaJ2Rehh0
   g4DNKnFUdLV7XXAbFs9LA6HAmzWzLOqBrHGiMQizjPFMmY1b8hNwzYFKi
   Irtwr51O8IOpRJewsoVNm8sVZ9d6gUtHd6oX9hM7MzYyzRAmy1zFletob
   QZzQx1QBZERNuNGpVc+cUCS/htBFI9apf0a30JtGk6fxa3fFz8MBzRDgM
   w==;
X-CSE-ConnectionGUID: k0I3vhEhT2ynEr78oLS/WA==
X-CSE-MsgGUID: BJ8eFy51Sv6X8Xro3pPjfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="36666756"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="36666756"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 06:57:26 -0700
X-CSE-ConnectionGUID: 8rFvBAisQHyRLlMS4ifOPg==
X-CSE-MsgGUID: F63mo3PfQhOn9+q/J4uBWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="68837268"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 06:57:22 -0700
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
Subject: [PATCH v6 00/12] spi: add driver for Intel discrete graphics
Date: Mon, 16 Sep 2024 16:49:16 +0300
Message-Id: <20240916134928.3654054-1-alexander.usyskin@intel.com>
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

V6: rebase over latest drm-xe-next, update to change in Xe APIs

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



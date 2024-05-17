Return-Path: <linux-spi+bounces-2929-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1082C8C8D01
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CEF1C22269
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFC1140E38;
	Fri, 17 May 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLDgmwVq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951213DDB7;
	Fri, 17 May 2024 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975630; cv=none; b=f2MS2wY14QKQFAnjdBRlTm/5xbYbRptE924qW+otGgI8cNBqrFSTsbJ2V/Yk99iACmRYEx+Xs3Ij9SL4s93JO7t3IHZAfncuxWl9iw20xad+6qqol6j8KYxLWe/pZcE+gHOEZWgHpCuznHwQQlRQDKUsdrGwuRNWxD0bdr1E9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975630; c=relaxed/simple;
	bh=W74Sr8/Vl4jMDBj2h37bhjcq6haC1CF9rXzNCjYjzdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sGGAAUlPTRUnis+r9ZWsn4wC0gJ+4IPNCme6DBY+K8JKkufFPOGdfo7Nv3t0itEMx3odveO8zxObaK+2H10tpxCctmvHYQnKT3BqVeqbekYP8LAO/u89N4rrHJ1lAomMgCa33tp6zHb/KQlOUDQ8jkM9vTUO0q9NA6c+Fd7AGkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLDgmwVq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715975629; x=1747511629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W74Sr8/Vl4jMDBj2h37bhjcq6haC1CF9rXzNCjYjzdU=;
  b=VLDgmwVqLL2k4LhWUCz5DCURms1YCA+GSkHfzmjHdd5sb2I49hielR5e
   9vnck9kg/zdbs6HTQXS/g/vTanjJUXU0t0BxRkSX1Xo7ZroCJ7ca93qcD
   itLSr0b0MDKk8c9aRjgk9gxbDbuQ5maGh1CI+V78EKnQinbdhsXTAKiuD
   ZaHsr/aTPaM2BXe8mfp6d2pseW3sDjiTDxQ1IkHW5S2tP0ORLHEsrcvBe
   ZGGWeZtcsv027qN/XMspmv3uqgkpcTVXNqn6XR0r1Y9fJ3Ghr5s75Y5Qq
   6SQ7dKsE4I6Ui6I2PbeCRkAsLnhR6DW+TFYqW4oZQ1sH/DOqNSe/7dy6U
   Q==;
X-CSE-ConnectionGUID: y38FtwBYTQyGMjR+b22ndw==
X-CSE-MsgGUID: D4nn1iMZT+umwNpvwm/rhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="16004897"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="16004897"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 12:53:48 -0700
X-CSE-ConnectionGUID: BEOGN0UBQVuc0qUa+8N0/A==
X-CSE-MsgGUID: zmDG+niGQOG6krsXxWrqYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="36313501"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 17 May 2024 12:53:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 09C171F1; Fri, 17 May 2024 22:53:44 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 00/10] spi: pxa2xx: Get rid of an additional layer in PCI driver
Date: Fri, 17 May 2024 22:47:34 +0300
Message-ID: <20240517195344.813032-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SPI PXA2xx main driver is a compound of a core library and
a platform driver code. Decoupling that allows to eventually
get rid of an additional layer of devices hierarchy in PCI driver.
There are also precursor cleanups.

Andy Shevchenko (10):
  spi: pxa2xx: Reorganize the SSP type retrieval
  spi: pxa2xx: Remove no more needed driver data
  spi: pxa2xx: Remove hard coded number of chip select pins
  spi: pxa2xx: Utilise temporary variable for struct device
  spi: pxa2xx: Print DMA burst size only when DMA is enabled
  spi: pxa2xx: Remove duplicate check
  spi: pxa2xx: Remove superflous check for Intel Atom SoCs
  spi: pxa2xx: Extract pxa2xx_spi_platform_*() callbacks
  spi: pxa2xx: Move platform driver to a separate file
  spi: pxa2xx: Convert PCI driver to use spi-pxa2xx code directly

 drivers/spi/Makefile              |   3 +-
 drivers/spi/spi-pxa2xx-pci.c      |  39 ++---
 drivers/spi/spi-pxa2xx-platform.c | 201 +++++++++++++++++++++++++
 drivers/spi/spi-pxa2xx.c          | 239 ++++--------------------------
 drivers/spi/spi-pxa2xx.h          |   6 +
 5 files changed, 253 insertions(+), 235 deletions(-)
 create mode 100644 drivers/spi/spi-pxa2xx-platform.c

-- 
2.43.0.rc1.1336.g36b5255a03ac



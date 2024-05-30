Return-Path: <linux-spi+bounces-3155-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B568D4ED0
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83AB9B2548D
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79825182D1D;
	Thu, 30 May 2024 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etKiYM4c"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8CC183079;
	Thu, 30 May 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081890; cv=none; b=DA7JxT9jmoGBPKq6jHosaNkxxb90V9o/pdYOeUuUP6b20eG+f1/yOc3JH2mroS++N2KQ/je6loa3aibDHFTYk1IK7rXdeEyyedQkDpu8DZNpUGYuSIzNaboknkySMpVBZeYL8bH4opxRmh0rOSI0h5kJDOdBQTfA+ilb9nO9Lvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081890; c=relaxed/simple;
	bh=ibd6Z6BaaDNn4qyxaI6l176h23D+oCNE11BOf6MbfyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNT5zaz76dfstMGXiZ9478kXdrNwQ1jHCd3VMHEOBOEfhUzi/FZ5xkA5gk3c+dAJazvm7y6ZJZWLpRxHyUswQ+NlmPBQfV9tip4SwmXlP0BJRyx+/8gollWWDqxjpIv3pQWPPXMP69HTiuI9tOdOeCmk8/M9q1bBfJAFlJGdIgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etKiYM4c; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081885; x=1748617885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ibd6Z6BaaDNn4qyxaI6l176h23D+oCNE11BOf6MbfyY=;
  b=etKiYM4cboW7jSd6dksunwBZK4XhO1VVY7hNe5EimCAESMn0ucFjRtxV
   dMsdP29xXE/LMBQIZCd5abVCsbVafI+/VW4cR+KorRiXqk+x3wAm1+Wlp
   v0soz1ygCIkk7DjUsSIS23REq0pFlibCBvpM7W5j0MBde5beLDR+s6+Co
   XzONGZaWKbRfqsfG8gVMCk0gkao5wnZKdN57uHNnPNl7HfvspMzkzDrjX
   4plS3QQ/su2W0BBNoQeQlIRnB9+O87XIjQx8MCooz+lBH1YZdPgLQwJlZ
   /23owo7rJaMlWZqYIHerZJozl9LmfAnYSmUshQDWf5o4lKdb4XDcQ0dEm
   g==;
X-CSE-ConnectionGUID: XtTkAKBlRfWTFYsubWfU8A==
X-CSE-MsgGUID: uuxrcS5hRWG8Mqx8PZeZ+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31067923"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="31067923"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:11:22 -0700
X-CSE-ConnectionGUID: 9RD+oxOAQ6aQOCklt7eYlw==
X-CSE-MsgGUID: tnEkLxLaRiqiRkIldfbTRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="73329419"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 30 May 2024 08:11:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 12EB41A3; Thu, 30 May 2024 18:11:18 +0300 (EEST)
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
Subject: [PATCH v2 00/11] spi: pxa2xx: Get rid of an additional layer in PCI driver
Date: Thu, 30 May 2024 18:09:56 +0300
Message-ID: <20240530151117.1130792-1-andriy.shevchenko@linux.intel.com>
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

In v2:
- made better handling of pxa_ssp_free() calls

Andy Shevchenko (11):
  spi: pxa2xx: Wrap pxa_ssp_request() to be device managed resource
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
 drivers/spi/spi-pxa2xx-platform.c | 214 +++++++++++++++++++++++++
 drivers/spi/spi-pxa2xx.c          | 253 +++++-------------------------
 drivers/spi/spi-pxa2xx.h          |   6 +
 5 files changed, 270 insertions(+), 245 deletions(-)
 create mode 100644 drivers/spi/spi-pxa2xx-platform.c

-- 
2.43.0.rc1.1336.g36b5255a03ac



Return-Path: <linux-spi+bounces-3182-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 704C68D6A0F
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 21:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C8A1F286DA
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 19:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7EE8063C;
	Fri, 31 May 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vz7Pu6Tv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6482978C80;
	Fri, 31 May 2024 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184852; cv=none; b=u5Dcce6yC+dxI347XZ1ggCzMkCO3G5AriPCE0W8OS5CPicB1Foe72wdWjPHo2JUhOCZpTEJ/YufRPnIDKtztqjBSM642+NImvwa4PDtib6fX/MOsduPjOdQmeoYHPiEs8q6iMxkOKT+/W6DpMXvwxI/eYeCuGEWaJe/K2xYIfws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184852; c=relaxed/simple;
	bh=ONMDe0AeAis0si41LBoi+8F/DBMmBIHYuIzcZWniouM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTn4h3PYV/eHM2R42H2KL7BOssJzaHHPuDEy/KnzK+M6biX6fBdiELscAUiYAiu1VG8/ijUcX9qUpe8WKbIA/aPmj6u52COGT6+wZShiMg6VtnNp5AoD6SZROM4Sr5lns4ZmkgvvHN3ONLlxUy7uzXXX5xJvdXTPKUCRItiEUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vz7Pu6Tv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717184851; x=1748720851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ONMDe0AeAis0si41LBoi+8F/DBMmBIHYuIzcZWniouM=;
  b=Vz7Pu6TvxtBFZNAM73M7EQomsCeJdgFT4OKq6Njtkgxj/noFv2/dFNI0
   AYTNFVavaUiapERgufJmLSRXRiNkC+bVUqEWH2haTvG52BFV8n0gF14Qi
   DwdhX6PmcSWn3hnp47FiD7mymGEXnmzDTMlfQJAOr8/8MWi6+b7I/NUqK
   fN175LlsHOg9e6/mDiGi16vOztAWxWfjY07HCRh9Xjm60hrIotxTkuhdM
   3TFZhw22LLf8cOyqsVCIDkZ4Rt0gsd6e1nqc1grSuFmN0IORFmNNBIibQ
   TbvC0ZqENVFPNt5oC2FXHy2cw5yNIqbxj+a0/C5IEXbyZxLywUFtehMkz
   A==;
X-CSE-ConnectionGUID: I4q6pGlLSkCmmjTrbtllYQ==
X-CSE-MsgGUID: PJpIFkAPReaN9b7gPw4qyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="39144636"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="39144636"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:47:29 -0700
X-CSE-ConnectionGUID: L/T6RM0KQwWWXDKRMF4JAA==
X-CSE-MsgGUID: HHuZNyPCQbuMsitkKuFmWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="67452618"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 31 May 2024 12:47:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E391E228; Fri, 31 May 2024 22:47:24 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thangaraj Samynathan <thangaraj.s@microchip.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v1 0/8] spi: Rework DMA mapped flag
Date: Fri, 31 May 2024 22:42:32 +0300
Message-ID: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first part of the series (patches 1 to 7) is an introduction
of a new helper followed by the user conversion.

This consolidates the same code and also makes patch 8 (last one)
be localised to the SPI core part.

The last patch is the main rework to get rid of a recently introduced
hack with a dummy SG list and move to the transfer-based DMA mapped
flag. 

That said, the patches 1 to 7 may be applied right away since they
have no functional change intended, while the last one needs more
testing and reviewing.

Andy Shevchenko (8):
  spi: Introduce internal spi_xfer_is_dma_mapped() helper
  spi: dw: Use new spi_xfer_is_dma_mapped() helper
  spi: ingenic: Use new spi_xfer_is_dma_mapped() helper
  spi: omap2-mcspi: Use new spi_xfer_is_dma_mapped() helper
  spi: pxa2xx: Use new spi_xfer_is_dma_mapped() helper
  spi: pci1xxxx: Use new spi_xfer_is_dma_mapped() helper
  spi: qup: Use new spi_xfer_is_dma_mapped() helper
  spi: Rework per message DMA mapped flag to be per transfer

 drivers/spi/internals.h       |  8 ++++
 drivers/spi/spi-dw-core.c     |  4 +-
 drivers/spi/spi-ingenic.c     |  4 +-
 drivers/spi/spi-omap2-mcspi.c |  8 ++--
 drivers/spi/spi-pci1xxxx.c    |  5 ++-
 drivers/spi/spi-pxa2xx.c      |  6 +--
 drivers/spi/spi-qup.c         |  9 ++---
 drivers/spi/spi.c             | 73 +++++++++++++----------------------
 include/linux/spi/spi.h       | 11 ++++--
 9 files changed, 59 insertions(+), 69 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac



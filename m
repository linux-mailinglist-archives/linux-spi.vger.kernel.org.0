Return-Path: <linux-spi+bounces-12470-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5CCD38EBA
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 14:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D47733003FF4
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 13:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443801DE3AD;
	Sat, 17 Jan 2026 13:42:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88C72622;
	Sat, 17 Jan 2026 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768657341; cv=none; b=USKtAqfKn2pRHpXTguHC2S5BXlHYiaVa87VS/sWdlvLOEcir28wr0AgxqdFgXLHe19VV1hQnwaDkxddncIsXs/8OfCNHug17rDerDGgo79HTbiSX2ddPnUNXbGhO9xHCLa8V9czH6EiDZLYL7du1aYUWGwfhqnyxyd4hOOzAgH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768657341; c=relaxed/simple;
	bh=Xt1yZwnuULu2DkCQQsx1Vhg6E3KzgfpvnKunlOH6si0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bRM2hRWBfxSws7Ka1na/FqJVJMUTU6GESO8ZO1lvvsnss7BpZIf7syAF/buaNReaOu9q+eEvN+Z2R5pvQ2QZ2vlfA48ZFkH/KqhQ9nuuaiMcRaEVVG+WmE1IbfVLaXtQBmzzZAVcV9UynbK6ZHQ1eKCE8DfN7B1VW4nJ0ngZfw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sat, 17 Jan
 2026 21:42:16 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 21:42:16 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <clg@kaod.org>, <broonie@kernel.org>, <boris.brezillon@bootlin.com>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v2 0/2] spi: aspeed: Improve handling of shared SPI controllers
Date: Sat, 17 Jan 2026 21:42:14 +0800
Message-ID: <20260117134216.595436-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series improves handling of SPI controllers that are
shared by spi-mem devices and other SPI peripherals.

The primary goal of this series is to support non-spi-mem devices in
the ASPEED FMC/SPI controller driver. It also addresses an issue in
the spi-mem framework observed when different types of SPI devices
operate concurrently on the same controller, ensuring that spi-mem
operations are properly serialized.

Changes in v2:
  - Separate transfer_one_message() function implementation into
    transfer_one() and prepare_message() in controller driver.

Chin-Ting Kuo (2):
  spi: spi-mem: Protect dirmap_create() with spi_mem_access_start/end
  spi: aspeed: Add support for non-spi-mem devices

 drivers/spi/spi-aspeed-smc.c | 134 +++++++++++++++++++++++++++++++++--
 drivers/spi/spi-mem.c        |  11 ++-
 2 files changed, 138 insertions(+), 7 deletions(-)

-- 
2.34.1



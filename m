Return-Path: <linux-spi+bounces-3183-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255258D6A12
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 21:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C211F28846
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 19:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAF017C223;
	Fri, 31 May 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wbs+uxOi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E0F7F7CA;
	Fri, 31 May 2024 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184852; cv=none; b=kcCXgMS+Bx6Kk6BLME0Mku8BKoeYCkBOU+dAE0CXW6qJhH1R88dIIPmVElpYWBSW1f/Fpwez+dMRlZ055VaDddYDGCkenXyiWN1UdkQfkckPSrD8+sVcI8JPmAPQ6+7CnJMnNGjWGiE3I7biCevDGusRes1hOdhbMXeN9mn/vR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184852; c=relaxed/simple;
	bh=Dw73VBHvLlwJ5WnmcM+Jwh7n02iOvg6za1jV+ImKLH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hV5vTllWved6q6zj9vTm0iH2IwPK8vD3gAdeN2wxPPfZDQLSWUq4CH2nC6yLC/VZNvZ7BlwjvAhSlCiQtK9H1cGbpsebBrH1ssIxGW9gtcL1DR3UlEiC5FLjiqI3oSz0xND+xFM1Yw4X+0NI9TeVAE/NIE7M6ZmnxgNLKUyoy3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wbs+uxOi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717184850; x=1748720850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dw73VBHvLlwJ5WnmcM+Jwh7n02iOvg6za1jV+ImKLH4=;
  b=Wbs+uxOizq0hZVqnUMFmfhgYbdRl7EI/V8P/p8fGzmI80CHCA5/e7uU2
   nl8l5V5d5kce2DhTTL6YYpomAx8/G6h9oUwsKrhDMcVO+S1/l3ssmOPNf
   hNQY94rqr/3BEixr9LI+PlSMQmphCZnYPFBPKGOaD5sbhwmvA8R6pa7dc
   DRNUidIjb6/Ycy14Gj0XHRRXBa/Zwjy2cZfKe4J9lDqp8l7FGrO+2yqji
   UNVeiAv3DDS/N9DzVmiio0Ob6rDY5C5LlpP0V0MH4hmiKZNVgWzO8lP+m
   xw85chE7rqN7KLzVr6iZ56wGAXS8bjGM87imyb0J9PTEsflkFUAV8KMJ4
   Q==;
X-CSE-ConnectionGUID: +9OH3lMkRpOkieA98pSbGQ==
X-CSE-MsgGUID: K/PJQZ/GQZeb2VA1CQrfvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="31273992"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="31273992"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:47:30 -0700
X-CSE-ConnectionGUID: FTqvYBkEQNiQnSDTHsQIDQ==
X-CSE-MsgGUID: F5BHzt2kRPyb0EUKNBFClg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="41179049"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 31 May 2024 12:47:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 013B7136; Fri, 31 May 2024 22:47:24 +0300 (EEST)
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
Subject: [PATCH v1 1/8] spi: Introduce internal spi_xfer_is_dma_mapped() helper
Date: Fri, 31 May 2024 22:42:33 +0300
Message-ID: <20240531194723.1761567-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
References: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are few drivers that use the same pattern to check if the transfer
is DMA mapped or not. Provide a helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/internals.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/internals.h b/drivers/spi/internals.h
index 4a28a8395552..47a87c2a6979 100644
--- a/drivers/spi/internals.h
+++ b/drivers/spi/internals.h
@@ -40,4 +40,12 @@ static inline void spi_unmap_buf(struct spi_controller *ctlr,
 }
 #endif /* CONFIG_HAS_DMA */
 
+static inline bool spi_xfer_is_dma_mapped(struct spi_controller *ctlr,
+					  struct spi_device *spi,
+					  struct spi_transfer *xfer)
+{
+	return ctlr->can_dma && ctlr->can_dma(ctlr, spi, xfer) &&
+	       ctlr->cur_msg_mapped;
+}
+
 #endif /* __LINUX_SPI_INTERNALS_H */
-- 
2.43.0.rc1.1336.g36b5255a03ac



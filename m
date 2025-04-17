Return-Path: <linux-spi+bounces-7637-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B37CA92144
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 17:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A561B60851
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D4C253F04;
	Thu, 17 Apr 2025 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irTgFLfZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB52522A1;
	Thu, 17 Apr 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903206; cv=none; b=OGqaHMEGe+J3IyA8waxTTT1yj7lI1NymepxJanY2IwCdLt1exe/O5Lck1RqCnygcX/QrQemGlb1fbCKF4hrDT5HHg+L2l1ySpIChPkXsIYHPnBp/jaZGimT0jbJQdxGKx5ELT99wppF+IdtLeaIu9QOeofJjoD53GTTBsDG/Llo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903206; c=relaxed/simple;
	bh=YNzxg2Cgltshvv/jkfeOT+fz/8OO2VlMUUBbnoXm6YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXdiKQ7UNaEWtkXN7HBu2IDYuKmPqiVUlIbJ3s0PWHcmEV/s9BfsjVLwXLbImBNOSEeVvCAPnfOJlTv8fm3dFB5XU62sWkzSKblxkEb8f8XGn6VIR/7ZclNfc6L4Cfa3NMbUnZgr6NfvqybDde5ERiu8NBBffAz8T2BnB/Mw7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irTgFLfZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744903205; x=1776439205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YNzxg2Cgltshvv/jkfeOT+fz/8OO2VlMUUBbnoXm6YE=;
  b=irTgFLfZmUxxF1yl/JgbQkkdKX2nedBOMntocv1kO/hJhwdCMz6H8RxX
   a0+CEIME9Jcb589P7Ys7xTEnT1ccT1xBbXk7/OayLlgsypEkPTJF3/Btk
   oWVKfeSHPq/UUxTeZskaAolsb7wdfHceysuVrd4Npijmxz6Va74rrOuaT
   3hVNdfShxHtwsUWdnf1XCYM8h2wXvSoznwDEzE41Mz4Z40K7/XhGsIMYb
   1mZY1fLNg0kk4hoZVWqgTzEwPW0No8d2NVMvNJUfeqTrWgS70CamJqGUL
   rHeKuDpmIBOkJ1DaEQq/U0zIaZKzx8AAyxBj9uT7SJ5qDEQPrzih/z87O
   Q==;
X-CSE-ConnectionGUID: wPJZXfGDSf2Ee374kTH7XA==
X-CSE-MsgGUID: JAKE0oURTVGFxwd77emmOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46625084"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="46625084"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:20:03 -0700
X-CSE-ConnectionGUID: ++tyDu/rQJGkQTAhSZPRtA==
X-CSE-MsgGUID: xnLGGuCDQWuzcg5sX7AnmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="130689870"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 Apr 2025 08:20:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0B7498D1; Thu, 17 Apr 2025 18:20:00 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 2/2] spi: dw: Use spi_bpw_to_bytes() helper
Date: Thu, 17 Apr 2025 18:17:53 +0300
Message-ID: <20250417151958.490174-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250417151958.490174-1-andriy.shevchenko@linux.intel.com>
References: <20250417151958.490174-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing helper to get amount of bytes (as power-of-two value)
from bits per word.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 941ecc6f59f8..b3b883cb9541 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -423,7 +423,7 @@ static int dw_spi_transfer_one(struct spi_controller *host,
 	int ret;
 
 	dws->dma_mapped = 0;
-	dws->n_bytes = roundup_pow_of_two(BITS_TO_BYTES(transfer->bits_per_word));
+	dws->n_bytes = spi_bpw_to_bytes(transfer->bits_per_word);
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_len = transfer->len / dws->n_bytes;
 	dws->rx = transfer->rx_buf;
-- 
2.47.2



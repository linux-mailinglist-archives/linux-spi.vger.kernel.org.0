Return-Path: <linux-spi+bounces-11068-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE81EC39CA7
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 10:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F86188BC45
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1CC2FFF97;
	Thu,  6 Nov 2025 09:19:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275C2F362A;
	Thu,  6 Nov 2025 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420753; cv=none; b=ChHgNJO9owTN+avUSpqxtN4ErZQr9bG1oVQ6Io+mYavlrll1D30hVUCXV+i64/lMk2Z/lQmuen9Bet/LDPqHjZc1ICsRYjFzTbDywzmmHkTOkETlnbukT3ZUkaCh5mMv3XKxaCfVuiZJSXYmWcM28fv9lL2x4xliJjykLQU9VsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420753; c=relaxed/simple;
	bh=qnmSR+xLxiNBcntYKwueudKVsowmh9H6t4W4S1QKC3Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rkQVpNf5msN+VBo0Z++hMDJh5addTNRzTdSOz21yJ4eVg46pvNHVMqV3aXM4VSVUEN8wunNJn/9R8QwZyqFawkO0OWYn3KDKlVGdJVycYYDfiCRZek418fOVCI/rQ7ZsvKTTEsgnG/n5ipeqsW8ZjHZusiy5lcWpASqxA/nF+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 6 Nov
 2025 17:19:03 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 6 Nov 2025 17:19:03 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <joel@jms.id.au>, <andrew@codeconstruct.com.au>, <clg@kaod.org>,
	<broonie@kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<BMC-SW@aspeedtech.com>
CC: kernel test robot <lkp@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2] spi: aspeed: Use devm_iounmap() to unmap devm_ioremap() memory
Date: Thu, 6 Nov 2025 17:19:03 +0800
Message-ID: <20251106091903.2800981-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Use devm_iounmap() to unmap memory mapped with devm_ioremap().
Thus ensure proper cleanup of device-managed resources.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510292356.JnTUBxCl-lkp@intel.com/
Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
V2: Refine commit message for clarity.

 drivers/spi/spi-aspeed-smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index e8bd8fe6c4e7..179c47ffbfeb 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -396,7 +396,7 @@ static int aspeed_spi_set_window(struct aspeed_spi *aspi)
 
 	for (cs = 0; cs < aspi->data->max_cs; cs++) {
 		if (aspi->chips[cs].ahb_base) {
-			iounmap(aspi->chips[cs].ahb_base);
+			devm_iounmap(dev, aspi->chips[cs].ahb_base);
 			aspi->chips[cs].ahb_base = NULL;
 		}
 	}
-- 
2.34.1



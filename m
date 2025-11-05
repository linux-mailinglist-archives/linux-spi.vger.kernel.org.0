Return-Path: <linux-spi+bounces-10999-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBFFC34985
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 09:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A8F18C85FE
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0B82E8E1C;
	Wed,  5 Nov 2025 08:50:02 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E062E7179;
	Wed,  5 Nov 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332602; cv=none; b=RU3rZDzobihS5PhCWOMRQLbb6z4lP9RYdARBqf3KdlKlIfljtv+Y5wzU5aJsa2BAVxD1rK638VVQ6VLFyiQLRbZE1qtp5AtlMkJB5efmZJTCkiCswpj2B3wGK3tjCkxpLOYBn4zSdMR1scZ+Gl5wiD117Y/uxJlhXiXF3202Lsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332602; c=relaxed/simple;
	bh=Qn2W2DGNVj5rc/D5yv3HwtMKPUUvlJR5ebMoj7wkWf8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sM11X28vJ6E5h28OIEsXjDUdSErSLUcnSLJP5NDO55azJKcocICFRpmTmpibqY6jUWzPn4De3lCtM4b0m+lNi7Hb0lfyl4nv2CSHgBHfCNmXwPaBnIhait91Lz1DhL2kLKA/JJryPZsxVzgd0IZ58gf1sScqy+xFZbDp1A/xE9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 5 Nov
 2025 16:49:52 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 5 Nov 2025 16:49:52 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <joel@jms.id.au>, <andrew@codeconstruct.com.au>, <clg@kaod.org>,
	<broonie@kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: kernel test robot <lkp@intel.com>
Subject: [PATCH] spi: aspeed: Use devm_iounmap() to unmap devm_ioremap() memory
Date: Wed, 5 Nov 2025 16:49:52 +0800
Message-ID: <20251105084952.1063489-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AHB IO memory for each chip select is mapped using
devm_ioremap(), so it should be unmapped using devm_iounmap()
to ensure proper device-managed resource cleanup.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510292356.JnTUBxCl-lkp@intel.com/
Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
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



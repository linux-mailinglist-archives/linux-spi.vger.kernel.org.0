Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B8D2BB865
	for <lists+linux-spi@lfdr.de>; Fri, 20 Nov 2020 22:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgKTVej (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Nov 2020 16:34:39 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:56967 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgKTVej (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Nov 2020 16:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605908078; x=1637444078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BVeI0aooSO+qLNmmszrCacN2qEtNqOqvzmyg0r6BJYI=;
  b=UO5ugB4ohC4p2dI/2+sgkDYZou3A8uZs9jWpldfZZzzWKD47WEqumQkv
   y1kQdKLi5ld1ZQV7Fu8oSkkdUYhJR16L8bj0EJu/6uNPGaDfyVki8o1Hk
   pP0vwFfEw0Y0HbQD1u4lDaRbktivY3EKHODQ2RtW0DpkU+YaNFXOmiMi1
   kgqOTDdJjiQjuncnCLu940iHGhcm3cwtdmovvYpcNWGl2pV+eUboxYuji
   R9n8SuvxfU9Qiz8HWADDjzjUZ91xEw96ZZQmENJkSey8tbcdSNtACwAU4
   iS54Gba4zQfA3JAOjQqPldeXI9QPfZUvVO83h3TBpq7I0jKg5JtuePzyE
   g==;
IronPort-SDR: OFnJbqeRoB8ZQ7usWXLaVbnt8OYMK6gpLBHnVeu4bpTiARpCsm5IkiRSjDC9sQjcT8b6OqiKOG
 8iET1vkgUyEtr1OurjBoQcvpmkdm08yvxD5z8LlCdHsaIkSKQBM5s4mOTdNFxtPb+V+YmfJmZJ
 rTVc5+JYQrGJGKq9SZowJY4FCnxXGMCQEMlmG1jDdMpFUMxfOrq60Ld/9eZBAVJsxTdZByMRbl
 wjfStueYc6toZ2K+Ns54/OmTr/TaOQfTsPSHaW2Nned8QOr7JLI1sXU/K4ErJqUkehd9YVPHf2
 jfs=
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="104498487"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Nov 2020 14:34:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 20 Nov 2020 14:34:38 -0700
Received: from soft-dev10.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 20 Nov 2020 14:34:37 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: dw: Fix spi registration for controllers overriding CS
Date:   Fri, 20 Nov 2020 22:34:14 +0100
Message-ID: <20201120213414.339701-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When SPI DW memory ops support was introduced, there was a check for
excluding controllers which supplied their own CS function. Even so,
the mem_ops pointer is *always* presented to the SPI core.

This causes the SPI core sanity check in spi_controller_check_ops() to
refuse registration, since a mem_ops pointer is being supplied without
an exec_op member function.

The end result is failure of the SPI DW driver on sparx5 and similar
platforms.

The fix in the core SPI DW driver is to avoid presenting the mem_ops
pointer if the exec_op function is not set.

Fixes: 6423207e57ea (spi: dw: Add memory operations support)
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/spi/spi-dw-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 2e50cc0a9291..a0794eac2094 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -875,7 +875,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		master->set_cs = dw_spi_set_cs;
 	master->transfer_one = dw_spi_transfer_one;
 	master->handle_err = dw_spi_handle_err;
-	master->mem_ops = &dws->mem_ops;
+	if (dws->mem_ops.exec_op)
+		master->mem_ops = &dws->mem_ops;
 	master->max_speed_hz = dws->max_freq;
 	master->dev.of_node = dev->of_node;
 	master->dev.fwnode = dev->fwnode;
--
2.25.1

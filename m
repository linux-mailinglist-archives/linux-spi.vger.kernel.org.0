Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6653D3D5904
	for <lists+linux-spi@lfdr.de>; Mon, 26 Jul 2021 13:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhGZLTL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Jul 2021 07:19:11 -0400
Received: from forward104j.mail.yandex.net ([5.45.198.247]:33239 "EHLO
        forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233733AbhGZLTK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Jul 2021 07:19:10 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 07:19:10 EDT
Received: from iva6-b9aa172731b6.qloud-c.yandex.net (iva6-b9aa172731b6.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:9a88:0:640:b9aa:1727])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id 72D9B4A2573;
        Mon, 26 Jul 2021 14:51:51 +0300 (MSK)
Received: from iva6-2d18925256a6.qloud-c.yandex.net (iva6-2d18925256a6.qloud-c.yandex.net [2a02:6b8:c0c:7594:0:640:2d18:9252])
        by iva6-b9aa172731b6.qloud-c.yandex.net (mxback/Yandex) with ESMTP id dTuOMM2thh-ppIiNd3o;
        Mon, 26 Jul 2021 14:51:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1627300311;
        bh=rfSCAWwyNYwSKPgVeh3VzjaujgnU1qjuOKCXl/Ts+LY=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=CTS/jNxULeOixJ771/bLF6TnKiTUC3LCnzrHrh1tGZ/eainUoF1YYTJ0kStFHvdA+
         igaAFLLVNYzQyMP8BcXPsxmYEgCNyO4LVw2VhTCUGe/MfAESGcslJOeKqPkOtBMk9I
         NBJNu5FJ3d1dS0GLiC672qDsRAqa0fqb54n88qy8=
Authentication-Results: iva6-b9aa172731b6.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva6-2d18925256a6.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id PIKatQa27D-po2SqJUI;
        Mon, 26 Jul 2021 14:51:50 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/8] spi: spi-ep93xx: Prepare clock before using it
Date:   Mon, 26 Jul 2021 14:50:46 +0300
Message-Id: <20210726115058.23729-3-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726115058.23729-1-nikita.shubin@maquefel.me>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework, otherwise the following is visible:

WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
Enabling unprepared ep93xx-spi.0
...
Hardware name: Cirrus Logic EDB9302 Evaluation Board
...
clk_core_enable
clk_core_enable_lock
ep93xx_spi_prepare_hardware
__spi_pump_messages
__spi_sync
spi_sync
spi_sync_transfer.constprop.0
regmap_spi_write
_regmap_raw_write_impl
_regmap_bus_raw_write
_regmap_update_bits
regmap_update_bits_base
cs4271_component_probe
snd_soc_component_probe
soc_probe_component
snd_soc_bind_card
edb93xx_probe
...
spi_master spi0: failed to prepare transfer hardware: -108

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/spi/spi-ep93xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index aa676559d273..5896a7b2fade 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -550,7 +550,7 @@ static int ep93xx_spi_prepare_hardware(struct spi_master *master)
 	u32 val;
 	int ret;
 
-	ret = clk_enable(espi->clk);
+	ret = clk_prepare_enable(espi->clk);
 	if (ret)
 		return ret;
 
@@ -570,7 +570,7 @@ static int ep93xx_spi_unprepare_hardware(struct spi_master *master)
 	val &= ~SSPCR1_SSE;
 	writel(val, espi->mmio + SSPCR1);
 
-	clk_disable(espi->clk);
+	clk_disable_unprepare(espi->clk);
 
 	return 0;
 }
-- 
2.26.2


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FA93E54FD
	for <lists+linux-spi@lfdr.de>; Tue, 10 Aug 2021 10:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhHJISD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Aug 2021 04:18:03 -0400
Received: from muru.com ([72.249.23.125]:40674 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238039AbhHJIR7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Aug 2021 04:17:59 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 557D98127;
        Tue, 10 Aug 2021 08:17:55 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 2/2] spi: spi-pic32: Fix issue with uninitialized dma_slave_config
Date:   Tue, 10 Aug 2021 11:17:27 +0300
Message-Id: <20210810081727.19491-2-tony@atomide.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810081727.19491-1-tony@atomide.com>
References: <20210810081727.19491-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Depending on the DMA driver being used, the struct dma_slave_config may
need to be initialized to zero for the unused data.

For example, we have three DMA drivers using src_port_window_size and
dst_port_window_size. If these are left uninitialized, it can cause DMA
failures.

For spi-pic32, this is probably not currently an issue but is still good to
fix though.

Fixes: 1bcb9f8ceb67 ("spi: spi-pic32: Add PIC32 SPI master driver")
Cc: Purna Chandra Mandal <purna.mandal@microchip.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/spi/spi-pic32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -361,6 +361,7 @@ static int pic32_spi_dma_config(struct pic32_spi *pic32s, u32 dma_width)
 	struct dma_slave_config cfg;
 	int ret;
 
+	memset(&cfg, 0, sizeof(cfg));
 	cfg.device_fc = true;
 	cfg.src_addr = pic32s->dma_base + buf_offset;
 	cfg.dst_addr = pic32s->dma_base + buf_offset;
-- 
2.32.0

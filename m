Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F0632C6FB
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbhCDAam (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345929AbhCCQRk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Mar 2021 11:17:40 -0500
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Mar 2021 08:16:42 PST
Received: from mail.blocktrron.ovh (mars.blocktrron.ovh [IPv6:2001:41d0:401:3000::cbd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34345C061756
        for <linux-spi@vger.kernel.org>; Wed,  3 Mar 2021 08:16:42 -0800 (PST)
Received: from localhost.localdomain (p200300e53f0682002d543747df09623c.dip0.t-ipconnect.de [IPv6:2003:e5:3f06:8200:2d54:3747:df09:623c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.blocktrron.ovh (Postfix) with ESMTPSA id 01B232692B;
        Wed,  3 Mar 2021 17:08:50 +0100 (CET)
From:   David Bauer <mail@david-bauer.net>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org
Subject: [PATCH 2/2] spi: ath79: remove spi-master setup and cleanup assignment
Date:   Wed,  3 Mar 2021 17:08:37 +0100
Message-Id: <20210303160837.165771-2-mail@david-bauer.net>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303160837.165771-1-mail@david-bauer.net>
References: <20210303160837.165771-1-mail@david-bauer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This removes the assignment of setup and cleanup functions for the ath79
target. Assigning the setup-method will lead to 'setup_transfer' not
being assigned in spi_bitbang_init. Because of this, performing any
TX/RX operation will lead to a kernel oops.

Also drop the redundant cleanup assignment, as it's also assigned in
spi_bitbang_init.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/spi/spi-ath79.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 436327fb58de..98ace748cd98 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -156,8 +156,6 @@ static int ath79_spi_probe(struct platform_device *pdev)
 
 	master->use_gpio_descriptors = true;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->setup = spi_bitbang_setup;
-	master->cleanup = spi_bitbang_cleanup;
 	master->flags = SPI_MASTER_GPIO_SS;
 	if (pdata) {
 		master->bus_num = pdata->bus_num;
-- 
2.30.1


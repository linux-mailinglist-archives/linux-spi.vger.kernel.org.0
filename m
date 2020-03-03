Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945D8178535
	for <lists+linux-spi@lfdr.de>; Tue,  3 Mar 2020 23:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCCWC7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Mar 2020 17:02:59 -0500
Received: from mars.blocktrron.ovh ([51.254.112.43]:59218 "EHLO
        mail.blocktrron.ovh" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgCCWC7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Mar 2020 17:02:59 -0500
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2020 17:02:58 EST
Received: from dbauer-t470.home.david-bauer.net (p200300E53F0CC600C8DE6CFB70A8F6FD.dip0.t-ipconnect.de [IPv6:2003:e5:3f0c:c600:c8de:6cfb:70a8:f6fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.blocktrron.ovh (Postfix) with ESMTPSA id BFA671E523
        for <linux-spi@vger.kernel.org>; Tue,  3 Mar 2020 22:56:28 +0100 (CET)
From:   David Bauer <mail@david-bauer.net>
To:     linux-spi@vger.kernel.org
Subject: [PATCH] spi: ath79: remove spi-master setup and cleanup assignment
Date:   Tue,  3 Mar 2020 22:56:18 +0100
Message-Id: <20200303215618.21255-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
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
index eb9a243e9526..ae6baaba8a07 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -156,8 +156,6 @@ static int ath79_spi_probe(struct platform_device *pdev)
 
 	master->use_gpio_descriptors = true;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->setup = spi_bitbang_setup;
-	master->cleanup = spi_bitbang_cleanup;
 	if (pdata) {
 		master->bus_num = pdata->bus_num;
 		master->num_chipselect = pdata->num_chipselect;
-- 
2.25.1


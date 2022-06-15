Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DF454D094
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 20:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345270AbiFOSDG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 14:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349342AbiFOSDC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 14:03:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6202496A
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 11:03:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F24661BD9
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 18:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A21BC34115;
        Wed, 15 Jun 2022 18:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655316180;
        bh=wgJbnm7UeIp8mXUcr2VlmVixaSMm2UdMBK/arXqGHTg=;
        h=From:To:Cc:Subject:Date:From;
        b=uU+VGi+ypdOBw+U6DLiX0JYfsSLZwpgSKUQ/7Swo5iavqJsKiXrXrdmeiw4oRMq7Y
         QyXY5FeOUS3tzym9gYskdgoEX4gYtNMGo0bP42RCj0CXjWKVnYgHhl0d/6i5D/Sopi
         P47Xx/g6pwR2ACSMonzqLWNJWZVXuJAUxLaKnmp5QjT+cpkRnyTFbH0toNSTwGUxiD
         xyhQMpp2tUOtNFsK3NkTiacaK9iGU+DhLe/DzITFEVM38UozlDfB5PrU8ln5glFi7t
         9KA5KgpdXlq+OzbU8Xgng85fxsdyWRyYDJho2I0mPmvRWUVBCW6p0PE8PX4i17mSYq
         26V14qKeDQuog==
From:   Mark Brown <broonie@kernel.org>
To:     Tomoya MORINAGA <tomoya.rohm@gmail.com>,
        Masayuki Ohtake <masa-korg@dsn.okisemi.com>,
        Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: topcliff-pch: Use core message validation
Date:   Wed, 15 Jun 2022 18:41:38 +0100
Message-Id: <20220615174138.4060912-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; h=from:subject; bh=wgJbnm7UeIp8mXUcr2VlmVixaSMm2UdMBK/arXqGHTg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiqhl/Q0KxFdyNG8uSnfc1wQR0Nl6l4UAcp+pJkjUP 0ye1T3GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYqoZfwAKCRAk1otyXVSH0MCZCA CB/k5LH6emX5wkWcmM1LUtC/qBC2X8xkLWUBQoTkSsxFz8L5S/2gnb4uCBv5hkXS0lSU4lvu8ytaTM Rr2fl/UNWNmXvfnVqqyv5oFmGaHzlmbke+flt+A81VeyS48mkaRGV8XWxEaWbpvXYXYJ5lNGtgSekt xSelMehdwGtz4hdm7zJC/CdvsLxC37pThej9Gw98SwnqC+O7JloAG3N+qxiItt0cYV9W32bGKhOiBG a5shbDJ+Qg/+sffYFZ9pBe4tOHJyD5iRPPA4hpPkeliSiPBtGgHkkqYeh+O78IzELRl4Qp7xzcgKgV xw6aYGRILdHKTK/9DpYKFc02dDmENA
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The topcliff-pch driver requires TX and RX buffers on all transfers, open
coding checks for this. Remove those open coded checks and instead rely on
the core functionality, which has the added bonus that it will fix up any
transfers submitted by drivers as needed rather than erroring out.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index dfaa1d79a78b..fe4bbd928c6c 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -461,29 +461,6 @@ static int pch_spi_transfer(struct spi_device *pspi, struct spi_message *pmsg)
 	int retval;
 	unsigned long flags;
 
-	spin_lock_irqsave(&data->lock, flags);
-	/* validate Tx/Rx buffers and Transfer length */
-	list_for_each_entry(transfer, &pmsg->transfers, transfer_list) {
-		if (!transfer->tx_buf && !transfer->rx_buf) {
-			dev_err(&pspi->dev,
-				"%s Tx and Rx buffer NULL\n", __func__);
-			retval = -EINVAL;
-			goto err_return_spinlock;
-		}
-
-		if (!transfer->len) {
-			dev_err(&pspi->dev, "%s Transfer length invalid\n",
-				__func__);
-			retval = -EINVAL;
-			goto err_return_spinlock;
-		}
-
-		dev_dbg(&pspi->dev,
-			"%s Tx/Rx buffer valid. Transfer length valid\n",
-			__func__);
-	}
-	spin_unlock_irqrestore(&data->lock, flags);
-
 	/* We won't process any messages if we have been asked to terminate */
 	if (data->status == STATUS_EXITING) {
 		dev_err(&pspi->dev, "%s status = STATUS_EXITING.\n", __func__);
@@ -1365,6 +1342,7 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
 	master->max_speed_hz = PCH_MAX_BAUDRATE;
+	master->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
 
 	data->board_dat = board_dat;
 	data->plat_dev = plat_dev;
-- 
2.30.2


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8447166C1E4
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jan 2023 15:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjAPOQI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Jan 2023 09:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjAPOOj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Jan 2023 09:14:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DD82ED7E;
        Mon, 16 Jan 2023 06:05:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3248060FD2;
        Mon, 16 Jan 2023 14:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5F7C433EF;
        Mon, 16 Jan 2023 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877938;
        bh=jiR9o06vTGhhfdLJwvNevFXIKBYSDNLWdr9P0n0xhW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rqN48pos5k8M4EsTU4ntzcIgGBX9unlxGHBcu4Y/gdPKPCBoQf8QjYYDllpFPHH01
         2Z3AzNE36ZALqNmq4EG2xT1U9DSaaQuagccH/RzBtTI3JarRL5dmQOvWh10dFxAMQE
         56OAFLwPPVd/wCm00P2qxKQF5cuKMnLk1CsNjfpPTEISDbT1I4OSbbosQo9VpFDGg0
         cr8/LnrbduM7G2qOKuhnowy8xIPTj0U8ap49UAgs5z+09E/2dAlyh/lcbx3cEuQECz
         ZZ7DnTy4OOYl6J7LZ0sbXisM96ZHpYQDfba92QdJzH8r0UDn6mVaTpwoO7mJkVvMO3
         rpDIZvceFsyHw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 10/16] spi: spidev: remove debug messages that access spidev->spi without locking
Date:   Mon, 16 Jan 2023 09:05:13 -0500
Message-Id: <20230116140520.116257-10-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230116140520.116257-1-sashal@kernel.org>
References: <20230116140520.116257-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 6b35b173dbc1711f8d272e3f322d2ad697015919 ]

The two debug messages in spidev_open() dereference spidev->spi without
taking the lock and without checking if it's not null. This can lead to
a crash. Drop the messages as they're not needed - the user-space will
get informed about ENOMEM with the syscall return value.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Link: https://lore.kernel.org/r/20230106100719.196243-2-brgl@bgdev.pl
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spidev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index a360dabdcb8b..74d13de15ca0 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -579,7 +579,6 @@ static int spidev_open(struct inode *inode, struct file *filp)
 	if (!spidev->tx_buffer) {
 		spidev->tx_buffer = kmalloc(bufsiz, GFP_KERNEL);
 		if (!spidev->tx_buffer) {
-			dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
 			status = -ENOMEM;
 			goto err_find_dev;
 		}
@@ -588,7 +587,6 @@ static int spidev_open(struct inode *inode, struct file *filp)
 	if (!spidev->rx_buffer) {
 		spidev->rx_buffer = kmalloc(bufsiz, GFP_KERNEL);
 		if (!spidev->rx_buffer) {
-			dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
 			status = -ENOMEM;
 			goto err_alloc_rx_buf;
 		}
-- 
2.35.1


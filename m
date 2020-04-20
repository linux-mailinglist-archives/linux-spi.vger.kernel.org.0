Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D8B1B1575
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 21:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDTTJc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 15:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727914AbgDTTJa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Apr 2020 15:09:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1B8C061A0F;
        Mon, 20 Apr 2020 12:09:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i10so13541264wrv.10;
        Mon, 20 Apr 2020 12:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZyjxQT2w1tfyUymmhQNajH9/aDxm1dT9gvQiJybw7YI=;
        b=G+XEOCZj6su1PzRZCtoH0nu5WMOzfz2daC0WPumyvY2vQ3IJQ+LjVeT794H6LNT+nV
         Gg1eJCUkFYRgZKpVb+k3zG40YGui1Nlfs2wvXKpaaPU/Bqp5hrkg6n27afo884ZOE7DW
         aEomaRd4jCRU92LEWHRhMLJqR+qjO463Q5enhyArFeXbgOWtjk4uODDJKlx4y+1OenRa
         B+BkMAvWzINLz1nvaB/cUj2uBpd4cUdzicgLVE1BRHr95/v1gWyvbVIbZSqY4AybkI+0
         L/AyVS2IcYgVUA+tYtbnJxbPrWhrSaVpycYZXelJEWvS2KdDwYzpZB0mFK3jmKSpb5td
         kZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZyjxQT2w1tfyUymmhQNajH9/aDxm1dT9gvQiJybw7YI=;
        b=RzzGSuiFeP6C1j1vxn1V8gY5OBuFUSD5w51fL1IEuKC2Lv9YIGPR3RQdrHmiVpENeF
         hZ5AIV0UmMtG5/QF6CchCQBDyqsw8aLPcwm+nKcloiq8f3PtX6j21WxpfY0LQAFIy147
         bVwL1zgqUBrWony7LlBEfgfmLdnHtqnDLbqKCqdXA6n8dCjk8/K0w25JfjiNpXJ/cbb9
         jd0xkmc6ylf3CeeV2DyEYKIiz0eKMe4kCIhVne6IhwSfzjM3DXTx19ncr/O6w5zK4WH4
         vkv9mtnKA6Zt6zA8joLVenDx0LpXznRfMkS0QbI2MhNeMiI0BqtqQuodV2YmpiqpRixB
         nn+w==
X-Gm-Message-State: AGi0PuYzhuzCFd4zGglam0Lm7jRLXfsezikgaakjvtD6rxoMczwCwvP7
        5liz1XWpKLNLtsWHcq1MxIbEAlpovoM=
X-Google-Smtp-Source: APiQypI/JiQuMFWECgwhXvwdIgWcJ/osdqQG6/N2n1+wmdAVIYTADeOeMW5EsZDRr/gaT/vSX2twqQ==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr21151345wrj.114.1587409768680;
        Mon, 20 Apr 2020 12:09:28 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y5sm621251wru.15.2020.04.20.12.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:09:28 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     Justin Chen <justinpopo6@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v3 5/9] spi: bcm-qspi: when tx/rx buffer is NULL set to 0
Date:   Mon, 20 Apr 2020 15:08:49 -0400
Message-Id: <20200420190853.45614-6-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420190853.45614-1-kdasu.kdev@gmail.com>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

Currently we set the tx/rx buffer to 0xff when NULL. This causes
problems with some spi slaves where 0xff is a valid command. Looking
at other drivers, the tx/rx buffer is usually set to 0x00 when NULL.
Following this convention solves the issue.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index c48c399dce53..e00208801c8b 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -669,7 +669,7 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
 			if (buf)
 				buf[tp.byte] = read_rxram_slot_u8(qspi, slot);
 			dev_dbg(&qspi->pdev->dev, "RD %02x\n",
-				buf ? buf[tp.byte] : 0xff);
+				buf ? buf[tp.byte] : 0x0);
 		} else {
 			u16 *buf = tp.trans->rx_buf;
 
@@ -677,7 +677,7 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
 				buf[tp.byte / 2] = read_rxram_slot_u16(qspi,
 								      slot);
 			dev_dbg(&qspi->pdev->dev, "RD %04x\n",
-				buf ? buf[tp.byte] : 0xffff);
+				buf ? buf[tp.byte / 2] : 0x0);
 		}
 
 		update_qspi_trans_byte_count(qspi, &tp,
@@ -732,13 +732,13 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
 	while (!tstatus && slot < MSPI_NUM_CDRAM) {
 		if (tp.trans->bits_per_word <= 8) {
 			const u8 *buf = tp.trans->tx_buf;
-			u8 val = buf ? buf[tp.byte] : 0xff;
+			u8 val = buf ? buf[tp.byte] : 0x00;
 
 			write_txram_slot_u8(qspi, slot, val);
 			dev_dbg(&qspi->pdev->dev, "WR %02x\n", val);
 		} else {
 			const u16 *buf = tp.trans->tx_buf;
-			u16 val = buf ? buf[tp.byte / 2] : 0xffff;
+			u16 val = buf ? buf[tp.byte / 2] : 0x0000;
 
 			write_txram_slot_u16(qspi, slot, val);
 			dev_dbg(&qspi->pdev->dev, "WR %04x\n", val);
-- 
2.17.1


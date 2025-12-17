Return-Path: <linux-spi+bounces-11989-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6E2CC98EE
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 22:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6485F30361FB
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 21:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A776830E0EB;
	Wed, 17 Dec 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUlPQmLz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AEA2EF652
	for <linux-spi@vger.kernel.org>; Wed, 17 Dec 2025 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005835; cv=none; b=iznZx52vWO2dAFIqqCa3PXoTsxRwKtX8Lc2XAQ7gx5gCkXsS5UsdFIidjJslOLSi1pXXBXKzXWpuhs8GRKGKrXhSWxX7Ez/eGAI/h3TNBgUat3Tuv9IkgartlZVpSxKLku3z9XhbjN/rk8NEOVGsUmOcY8hbmp7EwutCvh727rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005835; c=relaxed/simple;
	bh=ZfBmFTO5D1h5OgUO7iH7KujI2JTgqPh5GLEliVtSlwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPiHtypg17pkA8B9mTx7O9mW8ukINh4p9LOYSE/LYh9IXH1ULIypsTeYyt6AUy8HDNxAMna18O61JHVY4KxcD8RyCQ3ayn6QdfjHMiNH65JdW3HcEarbLBukDDgOOLvc0ib7/d7azs3mRTAch9mPnQmL7iJvGdA8sCwrf9KDTHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUlPQmLz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso2265183a12.1
        for <linux-spi@vger.kernel.org>; Wed, 17 Dec 2025 13:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766005832; x=1766610632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C15vzPpAwqBkx6cgmNEeXQyrEDHNlcUem0tiQ8xoiWs=;
        b=PUlPQmLzP5HO+i5lfUjbsM96dt4xT0USU0fEo8iYNosbhZvvDOQW0XTMspIQCZDTby
         I9XgfeVH/9cS4TAn4kdCOkkYR7ZYCVpJITOOYEpIN2RcJL3051js7BTlIgxXHQ/zPUIV
         ewwQzLOXLnkky5UNn+wJHi+l7Q/azGudFhEFUv2sMrVj4zaJ25kXeMkEpiYZtCOtBKNu
         zvpwvr7cw+94VxCOLu1a1V5i1ML1ZXzeyWKnYuJx08K9LAeL/YDVlf3wcJRzoeKz73ye
         gPQaOZE82ah/gb5yt1m56vaylVTsFu3WOUlYHWMxwmdQCfrkyCfD7FE0xLYwPhYtg7O6
         mX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766005832; x=1766610632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C15vzPpAwqBkx6cgmNEeXQyrEDHNlcUem0tiQ8xoiWs=;
        b=PDdjpjLPeeO7BkdfeuhMx2/ThPEGTlmlqcGLMkJr5/W5+ET+33Po8VoXQeDIhg4zoI
         7Z7tfyAvfghBtwiFZzVDfE8yAqWiKjnaQ4K1Xi6NcRcHAFrJasdVtU+K83O9ZmcpDK17
         oOb2mEM/0meDvXI31xuXLQDwBCaxKuVqKV6hK6pCPxdmujuntY9HXRbZLJzrSA4hrJgU
         wlQPJiJiMvOzTCEkCkx5g9e20Tz19RrFSnW6j7zSOiLgIGZP9lzGPeH+2jRRF6VsPxKC
         5J998DEyDqAc9b/uD/moc2dTRq6Cust6MWen2rBDW0L4gyit+H0nS0jy7hRV7ufq02mq
         lXog==
X-Gm-Message-State: AOJu0Yy78g0Pvt2aRj69U0FkOUg0x3RCwhQMFy5cj3x2lE9ooyiOxO8O
	L3SKvVtuwSh5vs8kqOrW/odEqGkZ8l1HjLYtGjzIdOmUioE7Pf9nv0RI
X-Gm-Gg: AY/fxX5xYfbgm+NlJ6BehTJgC3aYIs3JGIaWxbML0ZTss+MEUFHtZ9JjM6B6tS0C4BO
	8zRylRvxKwk3KHYBmyr7/HBGpJHMPrYKt6+qmjL2GtR+e+M+fgQDRUPtn6UhXfL4wfy0Hy6BWnF
	locRJljneYPSQG4CARWZ5r9jsmHxjxBx9qjy7Ppmq8xcIv+KxI9xwGCjslFNWCaFNlZKjWnzlvd
	uuhR6lw/dfKd5SKuJucR+j14HpuqzL392oOFJysGuleE/sHBBdcBJviDhBwSVMB5JRGzNtq9HzB
	Ow+1gmEdOilGu5RI+yPHAsvBUK47/0owbRFILSUFDvd+KK4QoVSOMoivCAaN4LvwADWETdHw5Ms
	MMqzLpoBuNPgudx0gF6wf2e33tcuyfB9WPe7PnUiQP7pcDXBmJfkVCS0b8efrm1uQzt+7gbx1jC
	mykue/lcZwuxrbNx6dd4BBmd2LQ7DtJEiTryym0xjAd/9jNRosiUMVk6qyYu77Yil5010=
X-Google-Smtp-Source: AGHT+IGLJvxV4/lfQaWzPz5mruD31U1GXdBlNuods7F0NlPzFex4+UNvtQtMHny5seWoUpLYGOicXw==
X-Received: by 2002:a05:6402:1bd0:b0:640:92eb:aa24 with SMTP id 4fb4d7f45d1cf-64b584ec823mr519916a12.15.1766005831799;
        Wed, 17 Dec 2025 13:10:31 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b58884fadsm491119a12.25.2025.12.17.13.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 13:10:31 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: bcm63xx-hsspi: add support for 1-2-2 read ops
Date: Wed, 17 Dec 2025 22:10:26 +0100
Message-ID: <20251217211026.173946-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for 1-2-2 read ops by separately calculating the switch from
single-bit to multi-bit, and then switching within the prepend data.

This allows us to support single-bit write followed by multi-bit write
followed by multi-bit read, and we do not need to reject 1-2-2 read
operations anymore.

Tested on BCM963268BU_P300 with custom fixup to allow 1-2-2 on the
non-SDFP capable s25fl129p1 attached (which it actually supports):

root@OpenWrt:~# cat /sys/kernel/debug/spi-nor/spi1.0/params
name            s25fl129p1
id              01 20 18 4d 01 01
size            16.0 MiB
write size      1
page size       256
address nbytes  3
flags           HAS_16BIT_SR | NO_READ_CR

opcodes
 read           0xbb
  dummy cycles  4
 erase          0xd8
 program        0x02
 8D extension   none

protocols
 read           1S-2S-2S
 write          1S-1S-1S
 register       1S-1S-1S

Reading from flash is still working as expected:

[    1.070000] parser_imagetag: rootfs: CFE image tag found at 0x0 with version 6, board type 963168VX
[    1.080000] parser_imagetag: Partition 0 is rootfs offset 100 and length 665000
[    1.090000] parser_imagetag: Partition 1 is kernel offset 665100 and length 136fa1
[    1.100000] parser_imagetag: Spare partition is offset 7b0000 and length 30000

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 64 +++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 18261cbd413b..d9e972ef2abd 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -142,6 +142,7 @@ struct bcm63xx_hsspi {
 	u32 wait_mode;
 	u32 xfer_mode;
 	u32 prepend_cnt;
+	u32 md_start;
 	u8 *prepend_buf;
 };
 
@@ -268,18 +269,20 @@ static bool bcm63xx_prepare_prepend_transfer(struct spi_controller *host,
 {
 
 	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
-	bool tx_only = false;
+	bool tx_only = false, multidata = false;
 	struct spi_transfer *t;
 
 	/*
 	 * Multiple transfers within a message may be combined into one transfer
 	 * to the controller using its prepend feature. A SPI message is prependable
 	 * only if the following are all true:
-	 *   1. One or more half duplex write transfer in single bit mode
-	 *   2. Optional full duplex read/write at the end
-	 *   3. No delay and cs_change between transfers
+	 *   1. One or more half duplex write transfers at the start
+	 *   2. Optional switch from single to dual bit within the write transfers
+	 *   3. Optional full duplex read/write at the end if all single bit
+	 *   4. No delay and cs_change between transfers
 	 */
 	bs->prepend_cnt = 0;
+	bs->md_start = 0;
 	list_for_each_entry(t, &msg->transfers, transfer_list) {
 		if ((spi_delay_to_ns(&t->delay, t) > 0) || t->cs_change) {
 			bcm63xx_prepend_printk_on_checkfail(bs,
@@ -297,31 +300,44 @@ static bool bcm63xx_prepare_prepend_transfer(struct spi_controller *host,
 				return false;
 			}
 
-			if (t->tx_nbits > SPI_NBITS_SINGLE &&
-				!list_is_last(&t->transfer_list, &msg->transfers)) {
+			if (t->tx_nbits == SPI_NBITS_SINGLE &&
+			    !list_is_last(&t->transfer_list, &msg->transfers) &&
+			    multidata) {
 				bcm63xx_prepend_printk_on_checkfail(bs,
-					 "multi-bit prepend buf not supported!\n");
+					 "single-bit after multi-bit not supported!\n");
 				return false;
 			}
 
-			if (t->tx_nbits == SPI_NBITS_SINGLE) {
-				memcpy(bs->prepend_buf + bs->prepend_cnt, t->tx_buf, t->len);
-				bs->prepend_cnt += t->len;
-			}
+			if (t->tx_nbits > SPI_NBITS_SINGLE)
+				multidata = true;
+
+			memcpy(bs->prepend_buf + bs->prepend_cnt, t->tx_buf, t->len);
+			bs->prepend_cnt += t->len;
+
+			if (t->tx_nbits == SPI_NBITS_SINGLE)
+				bs->md_start += t->len;
+
 		} else {
 			if (!list_is_last(&t->transfer_list, &msg->transfers)) {
 				bcm63xx_prepend_printk_on_checkfail(bs,
 					 "rx/tx_rx transfer not supported when it is not last one!\n");
 				return false;
 			}
+
+			if (t->rx_buf && t->rx_nbits == SPI_NBITS_SINGLE &&
+			    multidata) {
+				bcm63xx_prepend_printk_on_checkfail(bs,
+					 "single-bit after multi-bit not supported!\n");
+				return false;
+			}
 		}
 
 		if (list_is_last(&t->transfer_list, &msg->transfers)) {
 			memcpy(t_prepend, t, sizeof(struct spi_transfer));
 
-			if (tx_only && t->tx_nbits == SPI_NBITS_SINGLE) {
+			if (tx_only) {
 				/*
-				 * if the last one is also a single bit tx only transfer, merge
+				 * if the last one is also a tx only transfer, merge
 				 * all of them into one single tx transfer
 				 */
 				t_prepend->len = bs->prepend_cnt;
@@ -329,7 +345,7 @@ static bool bcm63xx_prepare_prepend_transfer(struct spi_controller *host,
 				bs->prepend_cnt = 0;
 			} else {
 				/*
-				 * if the last one is not a tx only transfer or dual tx xfer, all
+				 * if the last one is not a tx only transfer, all
 				 * the previous transfers are sent through prepend bytes and
 				 * make sure it does not exceed the max prepend len
 				 */
@@ -339,6 +355,15 @@ static bool bcm63xx_prepare_prepend_transfer(struct spi_controller *host,
 					return false;
 				}
 			}
+			/*
+			 * If switching from single-bit to multi-bit, make sure
+			 * the start offset does not exceed the maximum
+			 */
+			if (multidata && bs->md_start > HSSPI_MAX_PREPEND_LEN) {
+				bcm63xx_prepend_printk_on_checkfail(bs,
+					"exceed max multi-bit offset, abort prepending transfers!\n");
+				return false;
+			}
 		}
 	}
 
@@ -381,11 +406,11 @@ static int bcm63xx_hsspi_do_prepend_txrx(struct spi_device *spi,
 
 		if (t->rx_nbits == SPI_NBITS_DUAL) {
 			reg |= 1 << MODE_CTRL_MULTIDATA_RD_SIZE_SHIFT;
-			reg |= bs->prepend_cnt << MODE_CTRL_MULTIDATA_RD_STRT_SHIFT;
+			reg |= bs->md_start << MODE_CTRL_MULTIDATA_RD_STRT_SHIFT;
 		}
 		if (t->tx_nbits == SPI_NBITS_DUAL) {
 			reg |= 1 << MODE_CTRL_MULTIDATA_WR_SIZE_SHIFT;
-			reg |= bs->prepend_cnt << MODE_CTRL_MULTIDATA_WR_STRT_SHIFT;
+			reg |= bs->md_start << MODE_CTRL_MULTIDATA_WR_STRT_SHIFT;
 		}
 	}
 
@@ -692,13 +717,6 @@ static bool bcm63xx_hsspi_mem_supports_op(struct spi_mem *mem,
 	if (!spi_mem_default_supports_op(mem, op))
 		return false;
 
-	/* Controller doesn't support spi mem dual io mode */
-	if ((op->cmd.opcode == SPINOR_OP_READ_1_2_2) ||
-		(op->cmd.opcode == SPINOR_OP_READ_1_2_2_4B) ||
-		(op->cmd.opcode == SPINOR_OP_READ_1_2_2_DTR) ||
-		(op->cmd.opcode == SPINOR_OP_READ_1_2_2_DTR_4B))
-		return false;
-
 	return true;
 }
 
-- 
2.43.0



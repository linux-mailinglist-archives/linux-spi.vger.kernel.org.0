Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDA922460B
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 23:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGQV5A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 17:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgGQV5A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jul 2020 17:57:00 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A120C0619D2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 14:57:00 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4B7lMZ5MbbzKmgV;
        Fri, 17 Jul 2020 23:56:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id y2wVL9lcNOlI; Fri, 17 Jul 2020 23:56:55 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     broonie@kernel.org
Cc:     axboe@kernel.dk, linux-spi@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2] spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM
Date:   Fri, 17 Jul 2020 23:56:48 +0200
Message-Id: <20200717215648.20522-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -5.69 / 15.00 / 15.00
X-Rspamd-Queue-Id: DABC21780
X-Rspamd-UID: a56273
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The lantiq-ssc driver uses internally an own workqueue to wait till the
data is not only written out of the FIFO but really written to the wire.
This workqueue is flushed while the SPI subsystem is working in some
other system workqueue.

The system workqueue is marked as WQ_MEM_RECLAIM, but the workqueue in
the lantiq-ssc driver does not use WQ_MEM_RECLAIM for now. Add this flag
too to prevent this warning.

This fixes the following warning:
[    2.975956] WARNING: CPU: 1 PID: 17 at kernel/workqueue.c:2614 check_flush_dependency+0x168/0x184
[    2.984752] workqueue: WQ_MEM_RECLAIM kblockd:blk_mq_run_work_fn is flushing !WQ_MEM_RECLAIM 1e100800.spi:0x0

Fixes: 891b7c5fbf61 ("mtd_blkdevs: convert to blk-mq")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/spi/spi-lantiq-ssc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 1fd7ee53d451..a12a5d0cfebf 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -899,7 +899,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 8) |
 				     SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
 
-	spi->wq = alloc_ordered_workqueue(dev_name(dev), 0);
+	spi->wq = alloc_ordered_workqueue(dev_name(dev), WQ_MEM_RECLAIM);
 	if (!spi->wq) {
 		err = -ENOMEM;
 		goto err_clk_put;
-- 
2.20.1


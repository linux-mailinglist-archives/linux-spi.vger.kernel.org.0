Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93A52200DD
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 01:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgGNXJm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 19:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGNXJm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jul 2020 19:09:42 -0400
X-Greylist: delayed 409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jul 2020 16:09:41 PDT
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF069C061755
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2020 16:09:41 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4B5wyy00xgzKmcH;
        Wed, 15 Jul 2020 01:02:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id raF0wEBoZsqu; Wed, 15 Jul 2020 01:02:47 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     broonie@kernel.org
Cc:     axboe@kernel.dk, linux-spi@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM
Date:   Wed, 15 Jul 2020 01:02:34 +0200
Message-Id: <20200714230234.3145-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -5.69 / 15.00 / 15.00
X-Rspamd-Queue-Id: 14CD61769
X-Rspamd-UID: dec5d6
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
[    2.972635] ------------[ cut here ]------------
[    2.975956] WARNING: CPU: 1 PID: 17 at kernel/workqueue.c:2614 check_flush_dependency+0x168/0x184
[    2.984752] workqueue: WQ_MEM_RECLAIM kblockd:blk_mq_run_work_fn is flushing !WQ_MEM_RECLAIM 1e100800.spi:0x0
[    2.984759] Modules linked in:
[    2.997686] CPU: 1 PID: 17 Comm: kworker/1:0H Not tainted 5.4.51 #0
[    3.003927] Workqueue: kblockd blk_mq_run_work_fn
[    3.008610] Stack : 80662c88 83c75794 806e0000 80730000 83c1de80 806744ac 80045888 00000009
[    3.016965]         83fb6510 83d779b4 83e81e00 8007b6d4 00000001 00000001 83c75750 760d28ee
[    3.025321]         00000000 00000000 00000000 00000096 6b5f666e 00000000 5f72756e 5f776f72
[    3.033677]         00000096 808b0000 00000000 00000f57 00000000 80750000 00000000 80045888
[    3.042032]         00000009 83fb6510 83d779b4 83e81e00 00000000 00000010 00000004 80880004
[    3.050388]         ...
[    3.052828] Call Trace:
[    3.055281] [<8000f5d0>] show_stack+0x30/0x100
[    3.059754] [<8057bb14>] dump_stack+0x9c/0xd4
[    3.064096] [<8002cf1c>] __warn+0xc0/0x10c
[    3.068170] [<8002cff4>] warn_slowpath_fmt+0x8c/0xac
[    3.073137] [<80045888>] check_flush_dependency+0x168/0x184
[    3.078701] [<800459b4>] flush_workqueue+0x110/0x624
[    3.083680] [<803b50a0>] lantiq_ssc_unprepare_message+0x18/0x40
[    3.089582] [<803b2290>] spi_finalize_current_message+0x168/0x220
[    3.095674] [<803b2550>] spi_transfer_one_message+0x208/0x4cc
[    3.101418] [<803b2b4c>] __spi_pump_messages+0x338/0x540
[    3.106727] [<803b2f74>] __spi_sync+0x214/0x240
[    3.111253] [<803b2fd0>] spi_sync+0x30/0x58
[    3.115432] [<803b3f50>] spi_mem_exec_op+0x2a8/0x404
[    3.120413] [<803947e4>] spi_nor_spimem_xfer_data+0xa4/0x118
[    3.126052] [<803948cc>] spi_nor_spimem_read_data+0x74/0x80
[    3.131622] [<803959e0>] spi_nor_read+0x110/0x1d0
[    3.136324] [<8036fd44>] part_read+0x60/0xb8
[    3.140585] [<8036ce4c>] mtd_read_oob+0xe8/0x100
[    3.145198] [<8036cea0>] mtd_read+0x3c/0x54
[    3.149384] [<803772c8>] mtdblock_readsect+0x58/0x17c
[    3.154426] [<80376ca4>] mtd_queue_rq+0x408/0x5ac
[    3.159141] [<80286c44>] blk_mq_dispatch_rq_list+0x150/0x67c
[    3.164787] [<8028cdbc>] blk_mq_sched_dispatch_requests+0x1ac/0x1c8
[    3.171051] [<80284434>] __blk_mq_run_hw_queue+0x148/0x208
[    3.176543] [<80046870>] process_one_work+0x238/0x48c
[    3.181582] [<80046c2c>] worker_thread+0x168/0x5e0
[    3.186371] [<8004c404>] kthread+0x138/0x140
[    3.190641] [<8000a658>] ret_from_kernel_thread+0x14/0x1c
[    3.196092] ---[ end trace c03c86833514b76d ]---

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


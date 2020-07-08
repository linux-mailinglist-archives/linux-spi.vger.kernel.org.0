Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D4021807B
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 09:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgGHHJQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 03:09:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45653 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgGHHJP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jul 2020 03:09:15 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200708070914euoutp01e5838df2383aa2630c90e52ed3340071~ftVFl9HYD1737417374euoutp015
        for <linux-spi@vger.kernel.org>; Wed,  8 Jul 2020 07:09:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200708070914euoutp01e5838df2383aa2630c90e52ed3340071~ftVFl9HYD1737417374euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594192154;
        bh=DhyMuJGH0qTn6bnxy3z/KLVNLxOeo+CYyLoagP8wDvA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=hwquoZgI1c7gbfb+53AzwU1lIFY3eRcFpNptY8S23NR40C/HgS0paShsstY9R9d//
         FRFnVTxBQzvF774RUhEWo29eHpPv9bOROIsKxXbWsNV9PJzfRYrx1Q1+xKJfQEhpoM
         X/gqUc3dgoVOpKuFXQdyPTi1H8pLxNWbAus81TB8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200708070914eucas1p2f6755aac19b9d184872cdadc56bdf585~ftVFZWumd2996829968eucas1p2e;
        Wed,  8 Jul 2020 07:09:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C2.5C.05997.A11750F5; Wed,  8
        Jul 2020 08:09:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200708070913eucas1p221ca64347d0ca03709eeee86decfd1af~ftVFH_MmP1297012970eucas1p2i;
        Wed,  8 Jul 2020 07:09:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200708070913eusmtrp24ccd5afd1f6092b3a1cf3c4b52934ee0~ftVFHRXWI2779827798eusmtrp2i;
        Wed,  8 Jul 2020 07:09:13 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-32-5f05711a7a6c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2E.96.06017.911750F5; Wed,  8
        Jul 2020 08:09:13 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200708070913eusmtip1752d3f3d343c55eb86a3a3afd15b7c2a~ftVEsOxuk2232222322eusmtip1K;
        Wed,  8 Jul 2020 07:09:13 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Zhang Qiang <qiang.zhang@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] spi: use kthread_create_worker() helper
Date:   Wed,  8 Jul 2020 09:09:00 +0200
Message-Id: <20200708070900.30380-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWy7djP87pShazxBuvnMltsnLGe1WLqwyds
        Fpd3zWGzmHF+H5NF48eb7BZrj9xlt/j/+Curxa0Vf9kdODw2repk8+jbsorRY/2WqywenzfJ
        ARlbmQJYo7hsUlJzMstSi/TtErgymo/zF5yyrNiweRV7A+Nlwy5GTg4JAROJKevesnYxcnEI
        CaxglFixaQ4bhPOFUaLx704WCOczo8T6H8fZYFrOPTvIDJFYzijx5fVOJriW31OmMINUsQkY
        SnS97QLrEBGwlvg2YxpYnFngB6PE4zuyXYwcHMICFhKzvyiChFkEVCX6f01iArF5BWwlFnde
        ZIJYJi+xesMBsGUSArfZJI7+3swKkXCRaN15hR3CFpZ4dXwLlC0j8X/nfCaIhmZGiYfn1rJD
        OD2MEpebZjBCVFlL3Dn3iw3kCmYBTYn1u/Qhwo4SX253M4OEJQT4JG68FYS4mU9i0rbpUGFe
        iY42IYhqNYlZx9fBrT144RIzhO0h0X7wCdjrQgKxErtO72KdwCg3C2HXAkbGVYziqaXFuemp
        xUZ5qeV6xYm5xaV56XrJ+bmbGIFJ4fS/4192MO76k3SIUYCDUYmHNyORJV6INbGsuDL3EKME
        B7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBK
        NTCuWLoq9+KmN6nf7/3YN8HEKHqJe9DRlG1iJzg/HXS5PjH72ZEGZxnloEStXknG6F9VdQ/L
        evaZ7p287QXDi2YWzwneXIl5RimTopc/rzXj+hWeU7KD/3HY7robEx687amLqTni/CDrSckG
        +4I09y+zJ1b0LTKY4u7cJXMhPTvSyPDK+Qv8F8KUWIozEg21mIuKEwHo0v8DBgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t/xu7qShazxBpf/6VtsnLGe1WLqwyds
        Fpd3zWGzmHF+H5NF48eb7BZrj9xlt/j/+Curxa0Vf9kdODw2repk8+jbsorRY/2WqywenzfJ
        ARlbmQJYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
        EvQymo/zF5yyrNiweRV7A+Nlwy5GTg4JAROJc88OMncxcnEICSxllJi5/TETREJG4uS0BlYI
        W1jiz7UuNhBbSOATo8SPGVwgNpuAoUTXW4i4iICtxPz3L1hBBjEL/GGUeDTpKZDDwSEsYCEx
        +4siSA2LgKpE/69JYPN5geoXd16E2iUvsXrDAeYJjDwLGBlWMYqklhbnpucWG+kVJ+YWl+al
        6yXn525iBIbitmM/t+xg7HoXfIhRgINRiYc3I5ElXog1say4MvcQowQHs5IIr9PZ03FCvCmJ
        lVWpRfnxRaU5qcWHGE2Blk9klhJNzgfGSV5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU
        7NTUgtQimD4mDk6pBkaN2eskvJe+/XliSsKP6/OS3JecvsK3fcUPiR0Oi1K+im5LszGc/jbn
        hp7Y2tN6TiUl815v2JJfsP34mhWefSYB17TDP8yr+rZoxvTwvPtrrNwNOv+vit6Q9UxRWlA9
        7YlQvKhgvtJUnWfZTrveu5/ckzur4+0+rp26y8t3rlrtKFDQL/r7kYeNEktxRqKhFnNRcSIA
        n9I6M1sCAAA=
X-CMS-MailID: 20200708070913eucas1p221ca64347d0ca03709eeee86decfd1af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200708070913eucas1p221ca64347d0ca03709eeee86decfd1af
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200708070913eucas1p221ca64347d0ca03709eeee86decfd1af
References: <CGME20200708070913eucas1p221ca64347d0ca03709eeee86decfd1af@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since commit 4977caef05aa ("kthread: work could not be queued when worker
being destroyed") there is a warning when kworker is used without the
internal 'task' entry properly initialized. Fix this by using
a kthread_create_worker() helper instead of open-coding a kworker
initialization.

This fixes a following warning during SPI controller probe, observed on
the Samsung Exynos 5420-based Peach-Pit Chromebook with recent linux-next
kernel:

------------[ cut here ]------------
WARNING: CPU: 3 PID: 1 at kernel/kthread.c:817 kthread_queue_work+0xac/0xd4
Modules linked in:
CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc4-00017-g4977caef05aa #1193
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c011184c>] (unwind_backtrace) from [<c010d250>] (show_stack+0x10/0x14)
[<c010d250>] (show_stack) from [<c0517f64>] (dump_stack+0xbc/0xe8)
[<c0517f64>] (dump_stack) from [<c01270a8>] (__warn+0xf0/0x108)
[<c01270a8>] (__warn) from [<c0127170>] (warn_slowpath_fmt+0xb0/0xb8)
[<c0127170>] (warn_slowpath_fmt) from [<c01512a4>] (kthread_queue_work+0xac/0xd4)
[<c01512a4>] (kthread_queue_work) from [<c06c38d4>] (spi_start_queue+0x58/0x74)
[<c06c38d4>] (spi_start_queue) from [<c06c50d4>] (spi_register_controller+0x53c/0xbe8)
[<c06c50d4>] (spi_register_controller) from [<c06c57b4>] (devm_spi_register_controller+0x34/0x6c)
[<c06c57b4>] (devm_spi_register_controller) from [<c06cad60>] (s3c64xx_spi_probe+0x3e0/0x7ec)
[<c06cad60>] (s3c64xx_spi_probe) from [<c064dc8c>] (platform_drv_probe+0x6c/0xa4)
[<c064dc8c>] (platform_drv_probe) from [<c064b2c0>] (really_probe+0x200/0x48c)
[<c064b2c0>] (really_probe) from [<c064b6b4>] (driver_probe_device+0x78/0x1fc)
[<c064b6b4>] (driver_probe_device) from [<c064ba9c>] (device_driver_attach+0x58/0x60)
[<c064ba9c>] (device_driver_attach) from [<c064bb80>] (__driver_attach+0xdc/0x174)
[<c064bb80>] (__driver_attach) from [<c06490cc>] (bus_for_each_dev+0x68/0xb4)
[<c06490cc>] (bus_for_each_dev) from [<c064a400>] (bus_add_driver+0x158/0x214)
[<c064a400>] (bus_add_driver) from [<c064ca54>] (driver_register+0x78/0x110)
[<c064ca54>] (driver_register) from [<c0102378>] (do_one_initcall+0x8c/0x424)
[<c0102378>] (do_one_initcall) from [<c1001158>] (kernel_init_freeable+0x190/0x204)
[<c1001158>] (kernel_init_freeable) from [<c0ab6d44>] (kernel_init+0x8/0x118)
[<c0ab6d44>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xedd01fb0 to 0xedd01ff8)
...
irq event stamp: 173882
hardirqs last  enabled at (173881): [<c0abf294>] _raw_spin_unlock_irqrestore+0x68/0x70
hardirqs last disabled at (173882): [<c0abece0>] _raw_spin_lock_irqsave+0x1c/0x58
softirqs last  enabled at (171200): [<c027240c>] bdi_register_va+0x178/0x2fc
softirqs last disabled at (171198): [<c027239c>] bdi_register_va+0x108/0x2fc
---[ end trace 0fe37f6a9b7e6bc7 ]---

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/spi/spi.c       | 26 ++++++++++++--------------
 include/linux/spi/spi.h |  6 ++----
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 805a51b6f54c..19a03a8d6199 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1368,7 +1368,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 
 	/* If another context is idling the device then defer */
 	if (ctlr->idling) {
-		kthread_queue_work(&ctlr->kworker, &ctlr->pump_messages);
+		kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
 		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 		return;
 	}
@@ -1382,7 +1382,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 
 		/* Only do teardown in the thread */
 		if (!in_kthread) {
-			kthread_queue_work(&ctlr->kworker,
+			kthread_queue_work(ctlr->kworker,
 					   &ctlr->pump_messages);
 			spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 			return;
@@ -1616,7 +1616,7 @@ static void spi_set_thread_rt(struct spi_controller *ctlr)
 {
 	dev_info(&ctlr->dev,
 		"will run message pump with realtime priority\n");
-	sched_set_fifo(ctlr->kworker_task);
+	sched_set_fifo(ctlr->kworker->task);
 }
 
 static int spi_init_queue(struct spi_controller *ctlr)
@@ -1624,13 +1624,12 @@ static int spi_init_queue(struct spi_controller *ctlr)
 	ctlr->running = false;
 	ctlr->busy = false;
 
-	kthread_init_worker(&ctlr->kworker);
-	ctlr->kworker_task = kthread_run(kthread_worker_fn, &ctlr->kworker,
-					 "%s", dev_name(&ctlr->dev));
-	if (IS_ERR(ctlr->kworker_task)) {
-		dev_err(&ctlr->dev, "failed to create message pump task\n");
-		return PTR_ERR(ctlr->kworker_task);
+	ctlr->kworker = kthread_create_worker(0, dev_name(&ctlr->dev));
+	if (IS_ERR(ctlr->kworker)) {
+		dev_err(&ctlr->dev, "failed to create message pump kworker\n");
+		return PTR_ERR(ctlr->kworker);
 	}
+
 	kthread_init_work(&ctlr->pump_messages, spi_pump_messages);
 
 	/*
@@ -1714,7 +1713,7 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 	ctlr->cur_msg = NULL;
 	ctlr->cur_msg_prepared = false;
 	ctlr->fallback = false;
-	kthread_queue_work(&ctlr->kworker, &ctlr->pump_messages);
+	kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
 	trace_spi_message_done(mesg);
@@ -1740,7 +1739,7 @@ static int spi_start_queue(struct spi_controller *ctlr)
 	ctlr->cur_msg = NULL;
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
-	kthread_queue_work(&ctlr->kworker, &ctlr->pump_messages);
+	kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
 
 	return 0;
 }
@@ -1796,8 +1795,7 @@ static int spi_destroy_queue(struct spi_controller *ctlr)
 		return ret;
 	}
 
-	kthread_flush_worker(&ctlr->kworker);
-	kthread_stop(ctlr->kworker_task);
+	kthread_destroy_worker(ctlr->kworker);
 
 	return 0;
 }
@@ -1820,7 +1818,7 @@ static int __spi_queued_transfer(struct spi_device *spi,
 
 	list_add_tail(&msg->queue, &ctlr->queue);
 	if (!ctlr->busy && need_pump)
-		kthread_queue_work(&ctlr->kworker, &ctlr->pump_messages);
+		kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
 
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 	return 0;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 0e67a9a3a1d3..5fcf5da13fdb 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -358,8 +358,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @cleanup: frees controller-specific state
  * @can_dma: determine whether this controller supports DMA
  * @queued: whether this controller is providing an internal message queue
- * @kworker: thread struct for message pump
- * @kworker_task: pointer to task for message pump kworker thread
+ * @kworker: pointer to thread struct for message pump
  * @pump_messages: work struct for scheduling work to the message pump
  * @queue_lock: spinlock to syncronise access to message queue
  * @queue: message queue
@@ -593,8 +592,7 @@ struct spi_controller {
 	 * Over time we expect SPI drivers to be phased over to this API.
 	 */
 	bool				queued;
-	struct kthread_worker		kworker;
-	struct task_struct		*kworker_task;
+	struct kthread_worker		*kworker;
 	struct kthread_work		pump_messages;
 	spinlock_t			queue_lock;
 	struct list_head		queue;
-- 
2.17.1


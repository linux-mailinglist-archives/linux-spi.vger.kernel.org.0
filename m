Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD0021879F
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 14:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgGHMeE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 08:34:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39036 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgGHMeD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jul 2020 08:34:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200708123402euoutp0151c5fbadef5eca4a5e76cef5a363255b~fxwrH0siy0907409074euoutp01B
        for <linux-spi@vger.kernel.org>; Wed,  8 Jul 2020 12:34:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200708123402euoutp0151c5fbadef5eca4a5e76cef5a363255b~fxwrH0siy0907409074euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594211642;
        bh=98CYmnkDTVOfaOG1u5p7KAx+dV2GLzhU1PBKvT4mFRs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WQ5jST+so0NODaqZpsE0s7qiom3oys89eW0axuwCrbA61ZrrnJNQTeaJxvlEDta3W
         AzRRdbOmAaY/TsCfLSc9AdNCJqFPPcQqlVYkl1PDVe1YyUe4r6ivsPmS+qO/iOp0bI
         gTeDLQuOwiMTh1txMzkZw3FozMjqeoFHslzuF+qQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200708123401eucas1p1b8bdec909fc65380febbed545f8e8fd7~fxwq3IBOJ2809828098eucas1p16;
        Wed,  8 Jul 2020 12:34:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0A.CB.06456.93DB50F5; Wed,  8
        Jul 2020 13:34:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200708123401eucas1p1ec8fe745bb362c56f03798172a18324e~fxwqeoKcF2512225122eucas1p19;
        Wed,  8 Jul 2020 12:34:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200708123401eusmtrp118ca0952083f04dda37e754315c8b620~fxwqd-WtJ2185921859eusmtrp1A;
        Wed,  8 Jul 2020 12:34:01 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-42-5f05bd39e56c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C9.BA.06017.93DB50F5; Wed,  8
        Jul 2020 13:34:01 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200708123401eusmtip272d607a440c14d723bf338019d9f5eb9~fxwqDHNos1393713937eusmtip2C;
        Wed,  8 Jul 2020 12:34:01 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Zhang Qiang <qiang.zhang@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] spi: use kthread_create_worker() helper
Date:   Wed,  8 Jul 2020 14:33:49 +0200
Message-Id: <20200708123349.6797-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djPc7qWe1njDW4usLDYOGM9q8XUh0/Y
        LC7vmsNmMeP8PiaLxo832S3WHrnLbvH/8VdWi1sr/rI7cHhsWtXJ5tG3ZRWjx/otV1k8Pm+S
        AzK2MgWwRnHZpKTmZJalFunbJXBldFx9xlTwVrWid85e1gbGB/JdjBwcEgImEgcOmnQxcnEI
        CaxglNj48hsLhPOFUeL0lXOMEM5nRomD63aydTFygnUsuXgTqmo5o8S3r1fZ4FomXZzPCFLF
        JmAo0fW2C6xDRMBa4tuMacwgNrPAD0aJx3dkQWxhoHjLmeuMIHewCKhKHF+QCxLmFbCRmPa3
        jRFimbzE6g0HmEHmSwjcZ5OY8/IKO0TCReL3ojYoW1ji1fEtULaMxOnJPSwQDc2MEg/PrWWH
        cHoYJS43zYAaay1x59wvNpDNzAKaEut36UOEHSWePnrICAkYPokbbwUhbuaTmLRtOjNEmFei
        o00IolpNYtbxdXBrD164BFXiIdH/xQMkLCQQK3H+1ELGCYxysxBWLWBkXMUonlpanJueWmyY
        l1quV5yYW1yal66XnJ+7iRGYEk7/O/5pB+PXS0mHGAU4GJV4eCdsYI0XYk0sK67MPcQowcGs
        JMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2M
        0RqHliU5uTfWLo5+8OaDyrlFeQd6696d7j67Ptm+vFTpJE+wh0eB+LeXkmvLJ+gmfXOv2x0+
        yfd8VOjJeymT7m/97cXwhOdrsPE2oSeTvu0rS/y5J9zY5u23DaxZ0fUea4w5TjJH+53bq7Xv
        Ud/krMCILb8mqz5lP6+whUlNME3xRMXsDL8kJZbijERDLeai4kQAP1mv3AUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xe7qWe1njDQ5elbHYOGM9q8XUh0/Y
        LC7vmsNmMeP8PiaLxo832S3WHrnLbvH/8VdWi1sr/rI7cHhsWtXJ5tG3ZRWjx/otV1k8Pm+S
        AzK2MgWwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
        JehldFx9xlTwVrWid85e1gbGB/JdjJwcEgImEksu3mTpYuTiEBJYyihx9/8+NoiEjMTJaQ2s
        ELawxJ9rXWwQRZ8YJTrOTWcBSbAJGEp0ve0CaxARsJWY//4FK0gRs8AfRolHk56CdQsLWEu0
        nLnO2MXIwcEioCpxfEEuSJhXwEZi2t82RogF8hKrNxxgnsDIs4CRYRWjSGppcW56brGRXnFi
        bnFpXrpecn7uJkZgOG479nPLDsaud8GHGAU4GJV4eF9sYo0XYk0sK67MPcQowcGsJMLrdPZ0
        nBBvSmJlVWpRfnxRaU5q8SFGU6DdE5mlRJPzgbGSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZI
        ID2xJDU7NbUgtQimj4mDU6qBcZ238yr3c5eSdp7/teLjr6W9ZpH/7ma01y6TeqlSq/loVv/P
        l57FT/ZK5/xnKH7+VZ5JKSt35uf0c7/PtLEz/L61u/iiGMv9mCVaF3Yoxu0RmeLVKJeW9MEq
        a4L7hevcFradQcc+nT5w6e4OU3bLrzPMyuzF3r99ol5dxHFf+GCZ9dIQR9bY20osxRmJhlrM
        RcWJAESRfeldAgAA
X-CMS-MailID: 20200708123401eucas1p1ec8fe745bb362c56f03798172a18324e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200708123401eucas1p1ec8fe745bb362c56f03798172a18324e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200708123401eucas1p1ec8fe745bb362c56f03798172a18324e
References: <CGME20200708123401eucas1p1ec8fe745bb362c56f03798172a18324e@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use kthread_create_worker() helper to simplify the code. It uses
the kthread worker API the right way. It will eventually allow
to remove the FIXME in kthread_worker_fn() and add more consistency
checks in the future.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- changed patch description, removed stack dump
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


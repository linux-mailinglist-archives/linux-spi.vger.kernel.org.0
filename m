Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C402198DA
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jul 2020 08:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgGIGuT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 02:50:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48653 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgGIGuS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jul 2020 02:50:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200709065017euoutp01af5f03f9d1e191f4a744c9a9bd369202~gAt0uGIEl1075110751euoutp011
        for <linux-spi@vger.kernel.org>; Thu,  9 Jul 2020 06:50:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200709065017euoutp01af5f03f9d1e191f4a744c9a9bd369202~gAt0uGIEl1075110751euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594277417;
        bh=FfyyPKBkmMO5/npKc8oL3jScajCmCp+2dXiPw3GaLjs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kYCGWHCZlkOj692RlEcvQmYAJB3R7w/Z24KTnlDVIsrwjITrbwGlwO0nYWtbuS/4s
         /RqgsXrzhgoY/jA0nqny9+17+y06fNGR/vmMutHHq2rYFpptKEXxmgViPy2EYJtI86
         9LdJoxjONUMc2Mkwgls3VfWwZl4OH5tBtz84mTnI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200709065016eucas1p2cf71c2aca083e003de4e16b4bfd72dd8~gAt0fE9Fn0975609756eucas1p2X;
        Thu,  9 Jul 2020 06:50:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 99.02.06456.82EB60F5; Thu,  9
        Jul 2020 07:50:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200709065016eucas1p22ef816e6a2a6e47c008cabc5e06d6716~gAtz-DqYS0776507765eucas1p2g;
        Thu,  9 Jul 2020 06:50:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200709065016eusmtrp16d068fd54a316c46acc9740777cb3b60~gAtz_aIkK2835428354eusmtrp1Z;
        Thu,  9 Jul 2020 06:50:16 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-e4-5f06be288657
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F4.7D.06314.82EB60F5; Thu,  9
        Jul 2020 07:50:16 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200709065015eusmtip21fd653859f7d4503f867a58f63623cc5~gAtzhxwml1681816818eusmtip2m;
        Thu,  9 Jul 2020 06:50:15 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Zhang Qiang <qiang.zhang@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3] spi: use kthread_create_worker() helper
Date:   Thu,  9 Jul 2020 08:50:07 +0200
Message-Id: <20200709065007.26896-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7djP87oa+9jiDWbd0rHYOGM9q8XUh0/Y
        LC7vmsNmMeP8PiaLxo832S3WHrnLbvH/8VdWi1sr/rI7cHhsWtXJ5tG3ZRWjx/otV1k8Pm+S
        AzK2MgWwRnHZpKTmZJalFunbJXBlTF67lqVgklrFt3sVDYxNCl2MHBwSAiYSO5s1uxi5OIQE
        VjBKfD29kgXC+cIoseJZBxOE85lR4veO3+wwHR87NSDiyxklNj38xQrXce/tdaAOTg42AUOJ
        rrddbCC2iIC1xLcZ05hBbGaBH4wSj+/IggwSBoq/f+YCEmYRUJW4cmciWCuvgK3ErK8vWUBs
        CQF5idUbDjBD2PfZJPovpkPYLhJHrzSzQ9jCEq+Ob4GyZSROT+4B+0BCoJlR4uG5tewQTg+j
        xOWmGYwQVdYSd879YgM5gllAU2L9Ln2Ixxwl7swLgzD5JG68FYS4mE9i0rbpzBBhXomONiGI
        GWoSs46vg9t68MIlqCs9JJZcXAD2uJBArERLdyfTBEa5WQirFjAyrmIUTy0tzk1PLTbMSy3X
        K07MLS7NS9dLzs/dxAhMBqf/Hf+0g/HrpaRDjAIcjEo8vBM2sMYLsSaWFVfmHmKU4GBWEuF1
        Ons6Tog3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKXsUIC6YklqdmpqQWpRTBZJg5OqQZGu9tC
        Vy9ten5+qlCPVmTigjMbAvwlePT6lJefsi5gNF9xppy3cl7x7O/Fa+dU8X7dcWhB35VaDdHo
        XdMWLv6eU7SCV15Y2bghZ+27aLlHE+vvSS5fV8N4ecrFY+dnxJ9c2HeiJeBxmmjL+hYNEeba
        iZWv+je9PZJ1OuFOyTqxrY7OPyc8fMg6QYmlOCPRUIu5qDgRAKJrNlcCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t/xe7oa+9jiDb5v47XYOGM9q8XUh0/Y
        LC7vmsNmMeP8PiaLxo832S3WHrnLbvH/8VdWi1sr/rI7cHhsWtXJ5tG3ZRWjx/otV1k8Pm+S
        AzK2MgWwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
        JehlTF67lqVgklrFt3sVDYxNCl2MHBwSAiYSHzs1uhi5OIQEljJK7FzwhbWLkRMoLiNxcloD
        lC0s8edaFxtE0SdGiQ2XPjOBJNgEDCW63oIkODlEBGwl5r9/wQpSxCzwh1Hi0aSnrCAbhAWs
        Jd4/cwGpYRFQlbhyZyJYLy9Q/ayvL1kgFshLrN5wgHkCI88CRoZVjCKppcW56bnFhnrFibnF
        pXnpesn5uZsYgaG47djPzTsYL20MPsQowMGoxMP7YhNrvBBrYllxZe4hRgkOZiURXqezp+OE
        eFMSK6tSi/Lji0pzUosPMZoCLZ/ILCWanA+Mk7ySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLp
        iSWp2ampBalFMH1MHJxSDYwulxO2rE5znLxWos894uW6z2/l1zHt3Wi66WB8cd43uZNTFavL
        vx2ccX+28vl98Zfbudgl5eK1P5SXz+a4e+v/fccqowZ78113t9+fODX4k+ne+bqb4gWKMlTf
        pH66d/Nv2IEzQm1aJaydLFwVlrP0zonWM0lFfuQN0+A+Np/3854LHPkhryqVWIozEg21mIuK
        EwGWfJg5WwIAAA==
X-CMS-MailID: 20200709065016eucas1p22ef816e6a2a6e47c008cabc5e06d6716
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200709065016eucas1p22ef816e6a2a6e47c008cabc5e06d6716
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200709065016eucas1p22ef816e6a2a6e47c008cabc5e06d6716
References: <CGME20200709065016eucas1p22ef816e6a2a6e47c008cabc5e06d6716@eucas1p2.samsung.com>
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
v3:
- rebased onto latest spi-next branch
---
 drivers/spi/spi.c       | 26 ++++++++++++--------------
 include/linux/spi/spi.h |  6 ++----
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d4ba723a30da..1d7bba434225 100644
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
@@ -1618,7 +1618,7 @@ static void spi_set_thread_rt(struct spi_controller *ctlr)
 
 	dev_info(&ctlr->dev,
 		"will run message pump with realtime priority\n");
-	sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
+	sched_setscheduler(ctlr->kworker->task, SCHED_FIFO, &param);
 }
 
 static int spi_init_queue(struct spi_controller *ctlr)
@@ -1626,13 +1626,12 @@ static int spi_init_queue(struct spi_controller *ctlr)
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
@@ -1716,7 +1715,7 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 	ctlr->cur_msg = NULL;
 	ctlr->cur_msg_prepared = false;
 	ctlr->fallback = false;
-	kthread_queue_work(&ctlr->kworker, &ctlr->pump_messages);
+	kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
 	trace_spi_message_done(mesg);
@@ -1742,7 +1741,7 @@ static int spi_start_queue(struct spi_controller *ctlr)
 	ctlr->cur_msg = NULL;
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
-	kthread_queue_work(&ctlr->kworker, &ctlr->pump_messages);
+	kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
 
 	return 0;
 }
@@ -1798,8 +1797,7 @@ static int spi_destroy_queue(struct spi_controller *ctlr)
 		return ret;
 	}
 
-	kthread_flush_worker(&ctlr->kworker);
-	kthread_stop(ctlr->kworker_task);
+	kthread_destroy_worker(ctlr->kworker);
 
 	return 0;
 }
@@ -1822,7 +1820,7 @@ static int __spi_queued_transfer(struct spi_device *spi,
 
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


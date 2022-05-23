Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC55531454
	for <lists+linux-spi@lfdr.de>; Mon, 23 May 2022 18:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiEWOUt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 May 2022 10:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbiEWOUr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 May 2022 10:20:47 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718155A154
        for <linux-spi@vger.kernel.org>; Mon, 23 May 2022 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=kanlj5TL7hyZO0+VkKKM1pgI5taN89brq3sa0OlmWKk=;
        b=lO5yyArUTVigyYvT2qi2hcIwIoPnjglSIuBF0UMAOVdZcyMRD0wRwagMgSWSoKT18ZdZ9VKn/S4Ld
         Tei4VKTcPDImpFe0H8nL4trZ+gihPchqn2JcIZgMV8IACkxBHFWH59f03CywsWM6kMSwwTCmXqYbrq
         rH0pHWAZvMUGAgHni4gi2oi3cj4m7/7dEpVJTfp4yAb0RF9KdfwvivGvXkvdxsfU6cTDttLM83MNIw
         2TeugmGObTpVBubvaWmoTBr9KR4szkNTnGk4gY1hDRylXPXg/x4jTC7++fA7bDGXwS1SivaCPysBS0
         n1Us4fC/OZpFiJQJ7tKwTRD2kkHwhLQ==
X-MSG-ID: 864f16a4-daa3-11ec-b450-0050569d3a82
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH] drivers: spi: spi.c: Convert statistics to per-cpu u64_stats_t
Date:   Mon, 23 May 2022 16:20:09 +0200
Message-Id: <20220523142009.2218738-1-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This change gives a dramatic performance improvement in the hot path,
since many costly spin_lock_irqsave() calls can be avoided.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c       | 95 ++++++++++++++++++++++++-----------------
 include/linux/spi/spi.h | 80 ++++++++++++++++++++++++----------
 2 files changed, 114 insertions(+), 61 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c4dd1200fe99..edc290e67b92 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -33,6 +33,7 @@
 #include <linux/idr.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/percpu.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
@@ -111,6 +112,25 @@ static ssize_t driver_override_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(driver_override);
 
+#define spi_pcpu_stats_totalize(ret, in, field)				\
+do {									\
+	int i;								\
+	ret = 0;							\
+	for_each_possible_cpu(i) {					\
+		const struct spi_statistics *pcpu_stats;		\
+		u64 inc;						\
+		unsigned int start;					\
+		pcpu_stats = per_cpu_ptr(in, i);			\
+		do {							\
+			start = u64_stats_fetch_begin_irq(		\
+					&pcpu_stats->syncp);		\
+			inc = u64_stats_read(&pcpu_stats->field);	\
+		} while (u64_stats_fetch_retry_irq(			\
+					&pcpu_stats->syncp, start));	\
+		ret += inc;						\
+	}								\
+} while (0)
+
 #define SPI_STATISTICS_ATTRS(field, file)				\
 static ssize_t spi_controller_##field##_show(struct device *dev,	\
 					     struct device_attribute *attr, \
@@ -118,7 +138,7 @@ static ssize_t spi_controller_##field##_show(struct device *dev,	\
 {									\
 	struct spi_controller *ctlr = container_of(dev,			\
 					 struct spi_controller, dev);	\
-	return spi_statistics_##field##_show(&ctlr->statistics, buf);	\
+	return spi_statistics_##field##_show(ctlr->pcpu_statistics, buf); \
 }									\
 static struct device_attribute dev_attr_spi_controller_##field = {	\
 	.attr = { .name = file, .mode = 0444 },				\
@@ -129,7 +149,7 @@ static ssize_t spi_device_##field##_show(struct device *dev,		\
 					char *buf)			\
 {									\
 	struct spi_device *spi = to_spi_device(dev);			\
-	return spi_statistics_##field##_show(&spi->statistics, buf);	\
+	return spi_statistics_##field##_show(spi->pcpu_statistics, buf); \
 }									\
 static struct device_attribute dev_attr_spi_device_##field = {		\
 	.attr = { .name = file, .mode = 0444 },				\
@@ -140,11 +160,10 @@ static struct device_attribute dev_attr_spi_device_##field = {		\
 static ssize_t spi_statistics_##name##_show(struct spi_statistics *stat, \
 					    char *buf)			\
 {									\
-	unsigned long flags;						\
 	ssize_t len;							\
-	spin_lock_irqsave(&stat->lock, flags);				\
-	len = sysfs_emit(buf, format_string "\n", stat->field);		\
-	spin_unlock_irqrestore(&stat->lock, flags);			\
+	u64 val;							\
+	spi_pcpu_stats_totalize(val, stat, field);			\
+	len = sysfs_emit(buf, format_string "\n", val);			\
 	return len;							\
 }									\
 SPI_STATISTICS_ATTRS(name, file)
@@ -153,14 +172,14 @@ SPI_STATISTICS_ATTRS(name, file)
 	SPI_STATISTICS_SHOW_NAME(field, __stringify(field),		\
 				 field, format_string)
 
-SPI_STATISTICS_SHOW(messages, "%lu");
-SPI_STATISTICS_SHOW(transfers, "%lu");
-SPI_STATISTICS_SHOW(errors, "%lu");
-SPI_STATISTICS_SHOW(timedout, "%lu");
+SPI_STATISTICS_SHOW(messages, "%llu");
+SPI_STATISTICS_SHOW(transfers, "%llu");
+SPI_STATISTICS_SHOW(errors, "%llu");
+SPI_STATISTICS_SHOW(timedout, "%llu");
 
-SPI_STATISTICS_SHOW(spi_sync, "%lu");
-SPI_STATISTICS_SHOW(spi_sync_immediate, "%lu");
-SPI_STATISTICS_SHOW(spi_async, "%lu");
+SPI_STATISTICS_SHOW(spi_sync, "%llu");
+SPI_STATISTICS_SHOW(spi_sync_immediate, "%llu");
+SPI_STATISTICS_SHOW(spi_async, "%llu");
 
 SPI_STATISTICS_SHOW(bytes, "%llu");
 SPI_STATISTICS_SHOW(bytes_rx, "%llu");
@@ -169,7 +188,7 @@ SPI_STATISTICS_SHOW(bytes_tx, "%llu");
 #define SPI_STATISTICS_TRANSFER_BYTES_HISTO(index, number)		\
 	SPI_STATISTICS_SHOW_NAME(transfer_bytes_histo##index,		\
 				 "transfer_bytes_histo_" number,	\
-				 transfer_bytes_histo[index],  "%lu")
+				 transfer_bytes_histo[index],  "%llu")
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(0,  "0-1");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(1,  "2-3");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(2,  "4-7");
@@ -188,7 +207,7 @@ SPI_STATISTICS_TRANSFER_BYTES_HISTO(14, "16384-32767");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(15, "32768-65535");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(16, "65536+");
 
-SPI_STATISTICS_SHOW(transfers_split_maxsize, "%lu");
+SPI_STATISTICS_SHOW(transfers_split_maxsize, "%llu");
 
 static struct attribute *spi_dev_attrs[] = {
 	&dev_attr_modalias.attr,
@@ -285,30 +304,30 @@ static const struct attribute_group *spi_master_groups[] = {
 	NULL,
 };
 
-static void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
+static void spi_statistics_add_transfer_stats(struct spi_statistics *pcpu_stats,
 					      struct spi_transfer *xfer,
 					      struct spi_controller *ctlr)
 {
-	unsigned long flags;
 	int l2len = min(fls(xfer->len), SPI_STATISTICS_HISTO_SIZE) - 1;
+	struct spi_statistics *stats = this_cpu_ptr(pcpu_stats);
 
 	if (l2len < 0)
 		l2len = 0;
 
-	spin_lock_irqsave(&stats->lock, flags);
+	u64_stats_update_begin(&stats->syncp);
 
-	stats->transfers++;
-	stats->transfer_bytes_histo[l2len]++;
+	u64_stats_inc(&stats->transfers);
+	u64_stats_inc(&stats->transfer_bytes_histo[l2len]);
 
-	stats->bytes += xfer->len;
+	u64_stats_add(&stats->bytes, xfer->len);
 	if ((xfer->tx_buf) &&
 	    (xfer->tx_buf != ctlr->dummy_tx))
-		stats->bytes_tx += xfer->len;
+		u64_stats_add(&stats->bytes_tx, xfer->len);
 	if ((xfer->rx_buf) &&
 	    (xfer->rx_buf != ctlr->dummy_rx))
-		stats->bytes_rx += xfer->len;
+		u64_stats_add(&stats->bytes_rx, xfer->len);
 
-	spin_unlock_irqrestore(&stats->lock, flags);
+	u64_stats_update_end(&stats->syncp);
 }
 
 /*
@@ -543,7 +562,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 	spi->dev.release = spidev_release;
 	spi->mode = ctlr->buswidth_override_bits;
 
-	spin_lock_init(&spi->statistics.lock);
+	spi->pcpu_statistics = spi_alloc_pcpu_stats(struct spi_statistics);
 
 	device_initialize(&spi->dev);
 	return spi;
@@ -1239,8 +1258,8 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 			     struct spi_message *msg,
 			     struct spi_transfer *xfer)
 {
-	struct spi_statistics *statm = &ctlr->statistics;
-	struct spi_statistics *stats = &msg->spi->statistics;
+	struct spi_statistics *statm = ctlr->pcpu_statistics;
+	struct spi_statistics *stats = msg->spi->pcpu_statistics;
 	u32 speed_hz = xfer->speed_hz;
 	unsigned long long ms;
 
@@ -1396,8 +1415,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_transfer *xfer;
 	bool keep_cs = false;
 	int ret = 0;
-	struct spi_statistics *statm = &ctlr->statistics;
-	struct spi_statistics *stats = &msg->spi->statistics;
+	struct spi_statistics *statm = ctlr->pcpu_statistics;
+	struct spi_statistics *stats = msg->spi->pcpu_statistics;
 
 	spi_set_cs(msg->spi, true, false);
 
@@ -3042,7 +3061,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 		}
 	}
 	/* add statistics */
-	spin_lock_init(&ctlr->statistics.lock);
+	ctlr->pcpu_statistics = devm_spi_alloc_pcpu_stats(dev, struct spi_statistics);
 
 	mutex_lock(&board_lock);
 	list_add_tail(&ctlr->list, &spi_controller_list);
@@ -3380,9 +3399,9 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 	*xferp = &xfers[count - 1];
 
 	/* increment statistics counters */
-	SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics,
+	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics,
 				       transfers_split_maxsize);
-	SPI_STATISTICS_INCREMENT_FIELD(&msg->spi->statistics,
+	SPI_STATISTICS_INCREMENT_FIELD(msg->spi->pcpu_statistics,
 				       transfers_split_maxsize);
 
 	return 0;
@@ -3769,8 +3788,8 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 
 	message->spi = spi;
 
-	SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics, spi_async);
-	SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics, spi_async);
+	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_async);
+	SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics, spi_async);
 
 	trace_spi_message_submit(message);
 
@@ -3917,8 +3936,8 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	message->context = &done;
 	message->spi = spi;
 
-	SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics, spi_sync);
-	SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics, spi_sync);
+	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_sync);
+	SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics, spi_sync);
 
 	/*
 	 * If we're not using the legacy transfer method then we will
@@ -3941,9 +3960,9 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	if (status == 0) {
 		/* Push out the messages in the calling context if we can */
 		if (ctlr->transfer == spi_queued_transfer) {
-			SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics,
+			SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics,
 						       spi_sync_immediate);
-			SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics,
+			SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics,
 						       spi_sync_immediate);
 			__spi_pump_messages(ctlr, false);
 		}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 5f8c063ddff4..ea7f802f5a79 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -17,6 +17,7 @@
 
 #include <uapi/linux/spi/spi.h>
 #include <linux/acpi.h>
+#include <linux/u64_stats_sync.h>
 
 struct dma_chan;
 struct software_node;
@@ -59,37 +60,70 @@ extern struct bus_type spi_bus_type;
  *                 maxsize limit
  */
 struct spi_statistics {
-	spinlock_t		lock; /* lock for the whole structure */
+	struct u64_stats_sync	syncp;
 
-	unsigned long		messages;
-	unsigned long		transfers;
-	unsigned long		errors;
-	unsigned long		timedout;
+	u64_stats_t		messages;
+	u64_stats_t		transfers;
+	u64_stats_t		errors;
+	u64_stats_t		timedout;
 
-	unsigned long		spi_sync;
-	unsigned long		spi_sync_immediate;
-	unsigned long		spi_async;
+	u64_stats_t		spi_sync;
+	u64_stats_t		spi_sync_immediate;
+	u64_stats_t		spi_async;
 
-	unsigned long long	bytes;
-	unsigned long long	bytes_rx;
-	unsigned long long	bytes_tx;
+	u64_stats_t		bytes;
+	u64_stats_t		bytes_rx;
+	u64_stats_t		bytes_tx;
 
 #define SPI_STATISTICS_HISTO_SIZE 17
-	unsigned long transfer_bytes_histo[SPI_STATISTICS_HISTO_SIZE];
+	u64_stats_t	transfer_bytes_histo[SPI_STATISTICS_HISTO_SIZE];
 
-	unsigned long transfers_split_maxsize;
+	u64_stats_t	transfers_split_maxsize;
 };
 
-#define SPI_STATISTICS_ADD_TO_FIELD(stats, field, count)	\
-	do {							\
-		unsigned long flags;				\
-		spin_lock_irqsave(&(stats)->lock, flags);	\
-		(stats)->field += count;			\
-		spin_unlock_irqrestore(&(stats)->lock, flags);	\
+#define SPI_STATISTICS_ADD_TO_FIELD(pcpu_stats, field, count)		\
+	do {								\
+		struct spi_statistics *__lstats = this_cpu_ptr(pcpu_stats); \
+		u64_stats_update_begin(&__lstats->syncp);		\
+		u64_stats_add(&__lstats->field, count);			\
+		u64_stats_update_end(&__lstats->syncp);			\
 	} while (0)
 
-#define SPI_STATISTICS_INCREMENT_FIELD(stats, field)	\
-	SPI_STATISTICS_ADD_TO_FIELD(stats, field, 1)
+#define SPI_STATISTICS_INCREMENT_FIELD(pcpu_stats, field)		\
+	do {								\
+		struct spi_statistics *__lstats = this_cpu_ptr(pcpu_stats); \
+		u64_stats_update_begin(&__lstats->syncp);		\
+		u64_stats_inc(&__lstats->field);			\
+		u64_stats_update_end(&__lstats->syncp);			\
+	} while (0)
+
+#define devm_spi_alloc_pcpu_stats(dev, type)				\
+({									\
+	typeof(type) __percpu *pcpu_stats = devm_alloc_percpu(dev, type);\
+	if (pcpu_stats) {						\
+		int __cpu;						\
+		for_each_possible_cpu(__cpu) {				\
+			typeof(type) *stat;				\
+			stat = per_cpu_ptr(pcpu_stats, __cpu);		\
+			u64_stats_init(&stat->syncp);			\
+		}							\
+	}								\
+	pcpu_stats;							\
+})
+
+#define spi_alloc_pcpu_stats(type)					\
+({									\
+	typeof(type) __percpu *pcpu_stats = alloc_percpu_gfp(type, GFP_KERNEL);\
+	if (pcpu_stats) {						\
+		int __cpu;						\
+		for_each_possible_cpu(__cpu) {				\
+			typeof(type) *stat;				\
+			stat = per_cpu_ptr(pcpu_stats, __cpu);		\
+			u64_stats_init(&stat->syncp);			\
+		}							\
+	}								\
+	pcpu_stats;							\
+})
 
 /**
  * struct spi_delay - SPI delay information
@@ -192,7 +226,7 @@ struct spi_device {
 	struct spi_delay	cs_inactive;
 
 	/* the statistics */
-	struct spi_statistics	statistics;
+	struct spi_statistics __percpu	*pcpu_statistics;
 
 	/*
 	 * likely need more hooks for more protocol options affecting how
@@ -643,7 +677,7 @@ struct spi_controller {
 	s8			max_native_cs;
 
 	/* statistics */
-	struct spi_statistics	statistics;
+	struct spi_statistics __percpu	*pcpu_statistics;
 
 	/* DMA channels for use with core dmaengine helpers */
 	struct dma_chan		*dma_tx;
-- 
2.25.1


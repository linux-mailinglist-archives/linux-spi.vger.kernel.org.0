Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9834753263A
	for <lists+linux-spi@lfdr.de>; Tue, 24 May 2022 11:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiEXJSf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 May 2022 05:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiEXJSe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 May 2022 05:18:34 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CAD5F278
        for <linux-spi@vger.kernel.org>; Tue, 24 May 2022 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=rOuYPuBtZDGTsIiMh5TLQ4cW7+K2W46xfG8q0JlbNcA=;
        b=mLn3GF4ZtpjMOrprs8w02mWJOzQ6v59jlV9q68C6Y/F4CztlqRid3uuSMHjyy8j69B7vtOFAEW/RQ
         W2KMLpyAYt8gSGpbLrk9ACi1Y8/fufaSIHs9faR+2ry9K9jul5dLf3e5DNSCU93E6QuTOPvOVRSFm/
         7qUVWIc+WfL1o9KOLFw1itmcaVSKHKRXt6YHNQFZCBHe1Dw5+bQ/gaLrl5CeeUTbi7cpNVRVV1ujtr
         7NYkgacCuR36HelIXmzc93S65fa2mtWuo1Y02p9K6hKlhdtt8qAAB1f8YP5+K0knE2iNhBn8nba+XS
         6tu1WqmECpro+Loi49uPOORo4NizU9g==
X-MSG-ID: 77bde75d-db42-11ec-9896-0050569d2c73
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v2] drivers: spi: spi.c: Convert statistics to per-cpu u64_stats_t
Date:   Tue, 24 May 2022 11:18:08 +0200
Message-Id: <20220524091808.2269898-1-david@protonic.nl>
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

On an i.MX8MM system with a MCP2518FD CAN controller connected via SPI,
the time the driver takes to handle interrupts, or in other words the time
the IRQ line of the CAN controller stays low is mainly dominated by the
time it takes to do 3 relatively short sync SPI transfers. The effect of
this patch is a reduction of this time from 136us down to only 98us.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David Jander <david@protonic.nl>
---
v2:
 - Add measurement results to commit message
 - Remove format string in sysfs statistics macros
 - Add error checking to percpu alloc results
 - Free non-managed percpu allocation of struct spi_statistics
 - Convert 2 percpu_alloc macros to a single static function
---
 drivers/spi/spi.c       | 141 +++++++++++++++++++++++++++-------------
 include/linux/spi/spi.h |  52 ++++++++-------
 2 files changed, 125 insertions(+), 68 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c4dd1200fe99..842434d544fe 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -33,6 +33,7 @@
 #include <linux/idr.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/percpu.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
@@ -49,6 +50,7 @@ static void spidev_release(struct device *dev)
 
 	spi_controller_put(spi->controller);
 	kfree(spi->driver_override);
+	free_percpu(spi->pcpu_statistics);
 	kfree(spi);
 }
 
@@ -111,6 +114,47 @@ static ssize_t driver_override_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(driver_override);
 
+static struct spi_statistics *spi_alloc_pcpu_stats(struct device *dev)
+{
+	struct spi_statistics __percpu *pcpu_stats;
+
+	if (dev)
+		pcpu_stats = devm_alloc_percpu(dev, struct spi_statistics);
+	else
+		pcpu_stats = alloc_percpu_gfp(struct spi_statistics, GFP_KERNEL);
+
+	if (pcpu_stats) {
+		int cpu;
+
+		for_each_possible_cpu(cpu) {
+			struct spi_statistics *stat;
+
+			stat = per_cpu_ptr(pcpu_stats, cpu);
+			u64_stats_init(&stat->syncp);
+		}
+	}
+	return pcpu_stats;
+}
+
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
@@ -118,7 +161,7 @@ static ssize_t spi_controller_##field##_show(struct device *dev,	\
 {									\
 	struct spi_controller *ctlr = container_of(dev,			\
 					 struct spi_controller, dev);	\
-	return spi_statistics_##field##_show(&ctlr->statistics, buf);	\
+	return spi_statistics_##field##_show(ctlr->pcpu_statistics, buf); \
 }									\
 static struct device_attribute dev_attr_spi_controller_##field = {	\
 	.attr = { .name = file, .mode = 0444 },				\
@@ -129,47 +172,46 @@ static ssize_t spi_device_##field##_show(struct device *dev,		\
 					char *buf)			\
 {									\
 	struct spi_device *spi = to_spi_device(dev);			\
-	return spi_statistics_##field##_show(&spi->statistics, buf);	\
+	return spi_statistics_##field##_show(spi->pcpu_statistics, buf); \
 }									\
 static struct device_attribute dev_attr_spi_device_##field = {		\
 	.attr = { .name = file, .mode = 0444 },				\
 	.show = spi_device_##field##_show,				\
 }
 
-#define SPI_STATISTICS_SHOW_NAME(name, file, field, format_string)	\
+#define SPI_STATISTICS_SHOW_NAME(name, file, field)			\
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
+	len = sysfs_emit(buf, "%llu\n", val);				\
 	return len;							\
 }									\
 SPI_STATISTICS_ATTRS(name, file)
 
-#define SPI_STATISTICS_SHOW(field, format_string)			\
+#define SPI_STATISTICS_SHOW(field)					\
 	SPI_STATISTICS_SHOW_NAME(field, __stringify(field),		\
-				 field, format_string)
+				 field)
 
-SPI_STATISTICS_SHOW(messages, "%lu");
-SPI_STATISTICS_SHOW(transfers, "%lu");
-SPI_STATISTICS_SHOW(errors, "%lu");
-SPI_STATISTICS_SHOW(timedout, "%lu");
+SPI_STATISTICS_SHOW(messages);
+SPI_STATISTICS_SHOW(transfers);
+SPI_STATISTICS_SHOW(errors);
+SPI_STATISTICS_SHOW(timedout);
 
-SPI_STATISTICS_SHOW(spi_sync, "%lu");
-SPI_STATISTICS_SHOW(spi_sync_immediate, "%lu");
-SPI_STATISTICS_SHOW(spi_async, "%lu");
+SPI_STATISTICS_SHOW(spi_sync);
+SPI_STATISTICS_SHOW(spi_sync_immediate);
+SPI_STATISTICS_SHOW(spi_async);
 
-SPI_STATISTICS_SHOW(bytes, "%llu");
-SPI_STATISTICS_SHOW(bytes_rx, "%llu");
-SPI_STATISTICS_SHOW(bytes_tx, "%llu");
+SPI_STATISTICS_SHOW(bytes);
+SPI_STATISTICS_SHOW(bytes_rx);
+SPI_STATISTICS_SHOW(bytes_tx);
 
 #define SPI_STATISTICS_TRANSFER_BYTES_HISTO(index, number)		\
 	SPI_STATISTICS_SHOW_NAME(transfer_bytes_histo##index,		\
 				 "transfer_bytes_histo_" number,	\
-				 transfer_bytes_histo[index],  "%lu")
+				 transfer_bytes_histo[index])
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(0,  "0-1");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(1,  "2-3");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(2,  "4-7");
@@ -188,7 +230,7 @@ SPI_STATISTICS_TRANSFER_BYTES_HISTO(14, "16384-32767");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(15, "32768-65535");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(16, "65536+");
 
-SPI_STATISTICS_SHOW(transfers_split_maxsize, "%lu");
+SPI_STATISTICS_SHOW(transfers_split_maxsize);
 
 static struct attribute *spi_dev_attrs[] = {
 	&dev_attr_modalias.attr,
@@ -285,30 +327,30 @@ static const struct attribute_group *spi_master_groups[] = {
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
@@ -537,14 +579,19 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 		return NULL;
 	}
 
+	spi->pcpu_statistics = spi_alloc_pcpu_stats(NULL);
+	if (!spi->pcpu_statistics) {
+		kfree(spi);
+		spi_controller_put(ctlr);
+		return NULL;
+	}
+
 	spi->master = spi->controller = ctlr;
 	spi->dev.parent = &ctlr->dev;
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
 	spi->mode = ctlr->buswidth_override_bits;
 
-	spin_lock_init(&spi->statistics.lock);
-
 	device_initialize(&spi->dev);
 	return spi;
 }
@@ -1239,8 +1286,8 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 			     struct spi_message *msg,
 			     struct spi_transfer *xfer)
 {
-	struct spi_statistics *statm = &ctlr->statistics;
-	struct spi_statistics *stats = &msg->spi->statistics;
+	struct spi_statistics *statm = ctlr->pcpu_statistics;
+	struct spi_statistics *stats = msg->spi->pcpu_statistics;
 	u32 speed_hz = xfer->speed_hz;
 	unsigned long long ms;
 
@@ -1396,8 +1443,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_transfer *xfer;
 	bool keep_cs = false;
 	int ret = 0;
-	struct spi_statistics *statm = &ctlr->statistics;
-	struct spi_statistics *stats = &msg->spi->statistics;
+	struct spi_statistics *statm = ctlr->pcpu_statistics;
+	struct spi_statistics *stats = msg->spi->pcpu_statistics;
 
 	spi_set_cs(msg->spi, true, false);
 
@@ -3042,7 +3089,11 @@ int spi_register_controller(struct spi_controller *ctlr)
 		}
 	}
 	/* add statistics */
-	spin_lock_init(&ctlr->statistics.lock);
+	ctlr->pcpu_statistics = spi_alloc_pcpu_stats(dev);
+	if (!ctlr->pcpu_statistics) {
+		dev_err(dev, "Error allocating per-cpu statistics\n");
+		goto destroy_queue;
+	}
 
 	mutex_lock(&board_lock);
 	list_add_tail(&ctlr->list, &spi_controller_list);
@@ -3055,6 +3106,8 @@ int spi_register_controller(struct spi_controller *ctlr)
 	acpi_register_spi_devices(ctlr);
 	return status;
 
+destroy_queue:
+	spi_destroy_queue(ctlr);
 free_bus_id:
 	mutex_lock(&board_lock);
 	idr_remove(&spi_master_idr, ctlr->bus_num);
@@ -3380,9 +3433,9 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 	*xferp = &xfers[count - 1];
 
 	/* increment statistics counters */
-	SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics,
+	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics,
 				       transfers_split_maxsize);
-	SPI_STATISTICS_INCREMENT_FIELD(&msg->spi->statistics,
+	SPI_STATISTICS_INCREMENT_FIELD(msg->spi->pcpu_statistics,
 				       transfers_split_maxsize);
 
 	return 0;
@@ -3769,8 +3822,8 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 
 	message->spi = spi;
 
-	SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics, spi_async);
-	SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics, spi_async);
+	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_async);
+	SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics, spi_async);
 
 	trace_spi_message_submit(message);
 
@@ -3917,8 +3970,8 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	message->context = &done;
 	message->spi = spi;
 
-	SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics, spi_sync);
-	SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics, spi_sync);
+	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_sync);
+	SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics, spi_sync);
 
 	/*
 	 * If we're not using the legacy transfer method then we will
@@ -3941,9 +3994,9 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
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
index 5f8c063ddff4..29c889825a96 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -17,6 +17,7 @@
 
 #include <uapi/linux/spi/spi.h>
 #include <linux/acpi.h>
+#include <linux/u64_stats_sync.h>
 
 struct dma_chan;
 struct software_node;
@@ -59,37 +60,42 @@ extern struct bus_type spi_bus_type;
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
 
 /**
  * struct spi_delay - SPI delay information
@@ -192,7 +198,7 @@ struct spi_device {
 	struct spi_delay	cs_inactive;
 
 	/* the statistics */
-	struct spi_statistics	statistics;
+	struct spi_statistics __percpu	*pcpu_statistics;
 
 	/*
 	 * likely need more hooks for more protocol options affecting how
@@ -643,7 +649,7 @@ struct spi_controller {
 	s8			max_native_cs;
 
 	/* statistics */
-	struct spi_statistics	statistics;
+	struct spi_statistics __percpu	*pcpu_statistics;
 
 	/* DMA channels for use with core dmaengine helpers */
 	struct dma_chan		*dma_tx;
-- 
2.32.0


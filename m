Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDF77E0E16
	for <lists+linux-spi@lfdr.de>; Sat,  4 Nov 2023 07:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjKDGr2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 4 Nov 2023 02:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDGr1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 4 Nov 2023 02:47:27 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6D51B9;
        Fri,  3 Nov 2023 23:47:23 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SMp7m5zRbz4f3lVR;
        Sat,  4 Nov 2023 14:47:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id 764561A016F;
        Sat,  4 Nov 2023 14:47:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP4 (Coremail) with SMTP id gCh0CgDnfd3z6EVlglQtEw--.50758S6;
        Sat, 04 Nov 2023 14:47:20 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        broonie@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        frowand.list@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 -next 2/5] spi: mockup: Add writeable tracepoint for spi transfer
Date:   Sat,  4 Nov 2023 14:46:47 +0800
Message-Id: <20231104064650.972687-3-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
References: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnfd3z6EVlglQtEw--.50758S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWryrZF4rZF4rZF4UKr1UAwb_yoW7Jw1UpF
        yUCF45KrW8Jw429F4furW8Ary3Aa1kurW7K3sI9wnIyr1UtF1kXa1qgry5tFy8JrsrKFyU
        uFZ2kryjkr45Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxU2-B_UUUUU
X-CM-SenderInfo: x2kd0wp0ld053x6k3tpzhluzxrxghudrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

Add writeable tracepoint for transfer_one_message(), then bpf program
can be used to control read and write data from spi host, as mockup
chip's expectation.

For example:

  #include "vmlinux.h"
  #include <bpf/bpf_helpers.h>
  #include <bpf/bpf_tracing.h>

  SEC("raw_tp.w/spi_transfer_writeable")
  int BPF_PROG(spi_transfer_writeable_test, struct spi_msg_ctx *msg,
               u8 chip, unsigned int len)
  {
      if (msg->tx_nbits)
          msg->data[0] = 0x20;

      return 0;
  }

  char LICENSE[] SEC("license") = "GPL";

This will be useful for writing spi device mockup backend.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 drivers/spi/Kconfig               |  1 +
 drivers/spi/spi-mockup.c          | 52 +++++++++++++++++++++++++++++--
 include/linux/spi/spi-mockup.h    | 17 ++++++++++
 include/trace/events/spi_mockup.h | 31 ++++++++++++++++++
 4 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/spi/spi-mockup.h
 create mode 100644 include/trace/events/spi_mockup.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9169081cfecb..871e3824b8eb 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1221,6 +1221,7 @@ config SPI_TLE62X0
 config SPI_MOCKUP
 	tristate "SPI controller Testing Driver"
 	depends on OF
+	select BPF_EVENTS
 	help
 	  This enables SPI controller testing driver, which provides a way to
 	  test SPI subsystem.
diff --git a/drivers/spi/spi-mockup.c b/drivers/spi/spi-mockup.c
index 683a0fc43f0d..fcaaa61bdb38 100644
--- a/drivers/spi/spi-mockup.c
+++ b/drivers/spi/spi-mockup.c
@@ -13,6 +13,9 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/spi_mockup.h>
+
 #define MOCKUP_CHIPSELECT_MAX		8
 
 struct mockup_spi {
@@ -149,13 +152,58 @@ static struct attribute *spi_mockup_attrs[] = {
 };
 ATTRIBUTE_GROUPS(spi_mockup);
 
+static int spi_mockup_transfer_writeable(struct spi_message *msg)
+{
+	struct spi_msg_ctx *ctx;
+	struct spi_transfer *t;
+	int ret = 0;
+
+	ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	list_for_each_entry(t, &msg->transfers, transfer_list) {
+		if (t->len > SPI_BUFSIZ_MAX)
+			return -E2BIG;
+
+		memset(ctx, 0, sizeof(*ctx));
+		ctx->cs_off = t->cs_off;
+		ctx->cs_change = t->cs_change;
+		ctx->tx_nbits = t->tx_nbits;
+		ctx->rx_nbits = t->rx_nbits;
+
+		if (t->tx_nbits)
+			memcpy(ctx->data, t->tx_buf, t->len);
+
+		trace_spi_transfer_writeable(ctx, msg->spi->chip_select, t->len);
+
+		if (ctx->ret) {
+			ret = ctx->ret;
+			break;
+		}
+
+		if (t->rx_nbits)
+			memcpy(t->rx_buf, ctx->data, t->len);
+		msg->actual_length += t->len;
+	}
+
+	kfree(ctx);
+
+	return ret;
+}
+
 static int spi_mockup_transfer(struct spi_controller *ctrl,
 			       struct spi_message *msg)
 {
-	msg->status = 0;
+	int ret = 0;
+
+	if (trace_spi_transfer_writeable_enabled())
+		ret = spi_mockup_transfer_writeable(msg);
+
+	msg->status = ret;
 	spi_finalize_current_message(ctrl);
 
-	return 0;
+	return ret;
 }
 
 static int spi_mockup_probe(struct platform_device *pdev)
diff --git a/include/linux/spi/spi-mockup.h b/include/linux/spi/spi-mockup.h
new file mode 100644
index 000000000000..224894b416fb
--- /dev/null
+++ b/include/linux/spi/spi-mockup.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_SPI_MOCKUP_H
+#define __LINUX_SPI_MOCKUP_H
+
+#define SPI_BUFSIZ_MAX		0x1000
+
+struct spi_msg_ctx {
+	int ret;
+	unsigned cs_off:1;
+	unsigned cs_change:1;
+	unsigned tx_nbits:3;
+	unsigned rx_nbits:3;
+	__u8 data[SPI_BUFSIZ_MAX];
+};
+
+#endif
diff --git a/include/trace/events/spi_mockup.h b/include/trace/events/spi_mockup.h
new file mode 100644
index 000000000000..46debf26a5e3
--- /dev/null
+++ b/include/trace/events/spi_mockup.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SPI mockup controller transfer writeable tracepoint
+ *
+ * Copyright(c) 2022 Huawei Technologies Co., Ltd.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM spi_mockup
+
+#if !defined(_TRACE_SPI_MOCKUP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SPI_MOCKUP_H
+
+#include <linux/tracepoint.h>
+#include <linux/spi/spi-mockup.h>
+
+#ifndef DECLARE_TRACE_WRITABLE
+#define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
+	DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
+#endif
+
+DECLARE_TRACE_WRITABLE(spi_transfer_writeable,
+	TP_PROTO(struct spi_msg_ctx *msg, u8 chip_select, unsigned int len),
+	TP_ARGS(msg, chip_select, len),
+	sizeof(struct spi_msg_ctx)
+);
+
+#endif /* _TRACE_SPI_MOCKUP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.34.1


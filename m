Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23B32ECF47
	for <lists+linux-spi@lfdr.de>; Thu,  7 Jan 2021 12:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbhAGL5r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 06:57:47 -0500
Received: from mail.loongson.cn ([114.242.206.163]:47954 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbhAGL5q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 Jan 2021 06:57:46 -0500
Received: from localhost.localdomain (unknown [112.20.112.14])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxeL4I9_ZfddEAAA--.1869S2;
        Thu, 07 Jan 2021 19:56:57 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     Mark Brown <broonie@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, linux-spi@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yanteng Si <siyanteng@gmail.com>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH] SPI: Fix distinct pointer types warning for ARCH=MIPS
Date:   Thu,  7 Jan 2021 19:57:04 +0800
Message-Id: <20210107115704.3835282-1-siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxeL4I9_ZfddEAAA--.1869S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWUJr15CryrGr15Wr4UArb_yoW8AF4kpF
        W7tF1UGFW2qF4I9ryUAw45u3W3J397J3yUua4ak342ga4jvFZxXFnYvFyYkrs8AFsaya12
        9rW3GFs8J3WUuw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbeT5PUUUU
        U==
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix a new warning report by build for make ARCH=MIPS allmodconfig:

drivers/spi/spi-cadence-quadspi.c: In function 'cqspi_direct_read_execute':
 ./include/linux/minmax.h:18:28: warning: comparison of distinct pointer types lacks a cast
    18 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
       |                            ^~
 ./include/linux/minmax.h:32:4: note: in expansion of macro '__typecheck'
    32 |   (__typecheck(x, y) && __no_side_effects(x, y))
       |    ^~~~~~~~~~~
 ./include/linux/minmax.h:42:24: note: in expansion of macro '__safe_cmp'
    42 |  __builtin_choose_expr(__safe_cmp(x, y), \
       |                        ^~~~~~~~~~
 ./include/linux/minmax.h:58:19: note: in expansion of macro '__careful_cmp'
    58 | #define max(x, y) __careful_cmp(x, y, >)
       |                   ^~~~~~~~~~~~~
 drivers/spi/spi-cadence-quadspi.c:1153:24: note: in expansion of macro 'max'
  1153 |       msecs_to_jiffies(max(len, 500UL)))) {
       |                        ^~~

"len" is unsigned,however,"500" is unsigned long.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 06a65e9a8a60..576610ba1118 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1150,7 +1150,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 
 	dma_async_issue_pending(cqspi->rx_chan);
 	if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
-					 msecs_to_jiffies(max(len, 500UL)))) {
+					 msecs_to_jiffies(max(len, 500U)))) {
 		dmaengine_terminate_sync(cqspi->rx_chan);
 		dev_err(dev, "DMA wait_for_completion_timeout\n");
 		ret = -ETIMEDOUT;
-- 
2.27.0


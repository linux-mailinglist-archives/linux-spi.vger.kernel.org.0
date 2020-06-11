Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7855F1F6868
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgFKM5E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 08:57:04 -0400
Received: from mail.loongson.cn ([114.242.206.163]:42542 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726775AbgFKM5D (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 08:57:03 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb94VKuJek_hAAA--.1592S2;
        Thu, 11 Jun 2020 20:56:53 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v2 1/2] spi: tools: Make default_tx/rx and input_tx static
Date:   Thu, 11 Jun 2020 20:56:51 +0800
Message-Id: <1591880212-13479-1-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxb94VKuJek_hAAA--.1592S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr48tw4UArW7GFW5Jry3twb_yoW8JF47pF
        45Ar40kan7KF1Yyay7X3ZxGw15CF97X3y5Cw1DK3yFyFsYk3Z7Xa95Kry8tFWUGFZ2qFn8
        Zr1I9r43Xa10vw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Xr1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUZNV3UUUUU==
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix the following sparse warning:

./spidev_test.c:50:9: warning: symbol 'default_tx' was not declared. Should it be static?
./spidev_test.c:59:9: warning: symbol 'default_rx' was not declared. Should it be static?
./spidev_test.c:60:6: warning: symbol 'input_tx' was not declared. Should it be static?

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 tools/spi/spidev_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 56ea053f..83844f8 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -47,7 +47,7 @@ static int transfer_size;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
 
-uint8_t default_tx[] = {
+static uint8_t default_tx[] = {
 	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
 	0x40, 0x00, 0x00, 0x00, 0x00, 0x95,
 	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
@@ -56,8 +56,8 @@ uint8_t default_tx[] = {
 	0xF0, 0x0D,
 };
 
-uint8_t default_rx[ARRAY_SIZE(default_tx)] = {0, };
-char *input_tx;
+static uint8_t default_rx[ARRAY_SIZE(default_tx)] = {0, };
+static char *input_tx;
 
 static void hex_dump(const void *src, size_t length, size_t line_size,
 		     char *prefix)
-- 
2.1.0


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078681F609F
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 05:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgFKDme (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 23:42:34 -0400
Received: from mail.loongson.cn ([114.242.206.163]:40208 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbgFKDme (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jun 2020 23:42:34 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_2kkqOFenbRAAA--.1932S2;
        Thu, 11 Jun 2020 11:42:28 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 1/2] spi: tools: Make default_tx/rx and input_tx static
Date:   Thu, 11 Jun 2020 11:42:26 +0800
Message-Id: <1591846947-14252-1-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx_2kkqOFenbRAAA--.1932S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr48tw4UArW7GFW5Jry3twb_yoW8JF47pF
        45Ar40kan7KF1Yyay7X3ZxGw15CF97X3y5Cw1DK3yFyFsYk3Z7Xa95Kry8tFWUGFZ2qFn8
        Zr1I9r43Xa10vw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9l14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
        xwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4I
        xYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUj_-PDUUUU
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


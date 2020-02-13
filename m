Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F72815B86B
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2020 05:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgBMEQY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Feb 2020 23:16:24 -0500
Received: from mail.loongson.cn ([114.242.206.163]:58878 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729562AbgBMEQX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 12 Feb 2020 23:16:23 -0500
Received: from linux.HaierAP (unknown [111.18.44.203])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxP+iRzURe4DYPAA--.4S4;
        Thu, 13 Feb 2020 12:16:19 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] spi: spidev_test: Use perror() only if errno is not 0
Date:   Thu, 13 Feb 2020 12:16:07 +0800
Message-Id: <1581567368-8055-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
References: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9AxP+iRzURe4DYPAA--.4S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4kCF1xtr4xXFWfAw1UKFg_yoWDCFb_C3
        4fuFsrC3y8JryUAan5Zasaya429a15Xr97ursIqr9rKa9Yqr1UGws3Zr1ruF4jkwsxA3sx
        Wr15XrWjkr13KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbS8YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
        IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CE
        w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE
        c7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8XwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jozuAUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It is better to use perror() only if errno is not 0, it should use printf()
when errno is 0, otherwise there exists redudant ": Success".

E.g. without this patch:

$ ./spidev_test -p 1234 --input test.bin
only one of -p and --input may be selected: Success
Aborted (core dumped)

With this patch:

$ ./spidev_test -p 1234 --input test.bin
only one of -p and --input may be selected
Aborted (core dumped)

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/spi/spidev_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 5866178..27967dd 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <errno.h>
 #include <getopt.h>
 #include <fcntl.h>
 #include <time.h>
@@ -26,7 +27,11 @@
 
 static void pabort(const char *s)
 {
-	perror(s);
+	if (errno != 0)
+		perror(s);
+	else
+		printf("%s\n", s);
+
 	abort();
 }
 
-- 
1.8.3.1


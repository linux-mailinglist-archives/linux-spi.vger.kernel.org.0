Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830DD1F609E
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 05:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFKDmd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 23:42:33 -0400
Received: from mail.loongson.cn ([114.242.206.163]:40210 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbgFKDmd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jun 2020 23:42:33 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_2kkqOFenbRAAA--.1932S3;
        Thu, 11 Jun 2020 11:42:28 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 2/2] spi: tools: Fix build errors
Date:   Thu, 11 Jun 2020 11:42:27 +0800
Message-Id: <1591846947-14252-2-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1591846947-14252-1-git-send-email-zhangqing@loongson.cn>
References: <1591846947-14252-1-git-send-email-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx_2kkqOFenbRAAA--.1932S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww48XFWUuFWUtFy5ZFyrZwb_yoW8urykpF
        n3AF1xtF4YgayUG3Z3Aa1rCw15ArykCry0v3y29w18trn0y3W8JFsrKrWFqFyxCFyjva98
        Aw17Wr1jg34jyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8GwCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU3nYwUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix the following build errors:

include/linux/spi 2>&1 || true
ln -sf /home/zhangqing/spi.git2/tools/spi/../../include/uapi/linux/spi/spidev.h include/linux/spi/spidev.h
make -f /home/zhangqing/spi.git2/tools/build/Makefile.build dir=. obj=spidev_test
make[1]: Entering directory '/home/zhangqing/spi.git2/tools/spi'
  CC       spidev_test.o
spidev_test.c: In function ‘transfer’:
spidev_test.c:131:13: error: ‘SPI_TX_OCTAL’ undeclared (first use in this function)
  if (mode & SPI_TX_OCTAL)
             ^
spidev_test.c:131:13: note: each undeclared identifier is reported only once for each function it appears in
spidev_test.c:137:13: error: ‘SPI_RX_OCTAL’ undeclared (first use in this function)
  if (mode & SPI_RX_OCTAL)
             ^
spidev_test.c: In function ‘parse_opts’:
spidev_test.c:290:12: error: ‘SPI_TX_OCTAL’ undeclared (first use in this function)
    mode |= SPI_TX_OCTAL;
            ^
spidev_test.c:308:12: error: ‘SPI_RX_OCTAL’ undeclared (first use in this function)
    mode |= SPI_RX_OCTAL;
            ^
  LD       spidev_test-in.o
ld: cannot find spidev_test.o: No such file or directory
/home/zhangqing/spi.git2/tools/build/Makefile.build:144: recipe for target 'spidev_test-in.o' failed
make[1]: *** [spidev_test-in.o] Error 1
make[1]: Leaving directory '/home/zhangqing/spi.git2/tools/spi'
Makefile:39: recipe for target 'spidev_test-in.o' failed
make: *** [spidev_test-in.o] Error 2

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 include/uapi/linux/spi/spidev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/spi/spidev.h b/include/uapi/linux/spi/spidev.h
index ee0f246..8b04c62 100644
--- a/include/uapi/linux/spi/spidev.h
+++ b/include/uapi/linux/spi/spidev.h
@@ -48,6 +48,8 @@
 #define SPI_TX_QUAD		0x200
 #define SPI_RX_DUAL		0x400
 #define SPI_RX_QUAD		0x800
+#define	SPI_TX_OCTAL	        0x2000
+#define	SPI_RX_OCTAL            0x4000
 
 /*---------------------------------------------------------------------------*/
 
-- 
2.1.0


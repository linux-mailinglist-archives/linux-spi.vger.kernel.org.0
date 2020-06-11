Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F52D1F6866
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 14:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgFKM5A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 08:57:00 -0400
Received: from mail.loongson.cn ([114.242.206.163]:42540 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726781AbgFKM5A (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 08:57:00 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb94VKuJek_hAAA--.1592S3;
        Thu, 11 Jun 2020 20:56:53 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v2 2/2] spi: tools: Add macro definitions to fix build errors
Date:   Thu, 11 Jun 2020 20:56:52 +0800
Message-Id: <1591880212-13479-2-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1591880212-13479-1-git-send-email-zhangqing@loongson.cn>
References: <1591880212-13479-1-git-send-email-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxb94VKuJek_hAAA--.1592S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urW8GrWxtryDKr47tr1DWrg_yoW8CFWkpF
        nxJF1xtF4UKayUG3Z3Xa1Fkw13ArWqkrn0qryUKr1vyF15Z3W8Aa1qgF4rKryxCry2vasx
        J347Xr4UK34jyw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Xr1l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0gAwUUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add SPI_TX_OCTAL and SPI_RX_OCTAL to fix the following build errors:

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

Additionally, maybe SPI_CS_WORD and SPI_3WIRE_HIZ will be used in the future,
so add them too.

Fixes: 896fa735084e ("spi: spidev_test: Add support for Octal mode data transfers")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---

v2:
  -Modify the patch subject
  -Update the commit message
  -Add macro definitions of SPI_CS_WORD and SPI_3WIRE_HIZ

 include/uapi/linux/spi/spidev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/spi/spidev.h b/include/uapi/linux/spi/spidev.h
index ee0f246..9390615 100644
--- a/include/uapi/linux/spi/spidev.h
+++ b/include/uapi/linux/spi/spidev.h
@@ -48,6 +48,10 @@
 #define SPI_TX_QUAD		0x200
 #define SPI_RX_DUAL		0x400
 #define SPI_RX_QUAD		0x800
+#define SPI_CS_WORD             0x1000
+#define SPI_TX_OCTAL            0x2000
+#define SPI_RX_OCTAL            0x4000
+#define SPI_3WIRE_HIZ           0x8000
 
 /*---------------------------------------------------------------------------*/
 
-- 
2.1.0


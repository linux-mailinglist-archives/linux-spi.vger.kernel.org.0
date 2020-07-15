Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B16220458
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 07:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgGOF06 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 01:26:58 -0400
Received: from mail.loongson.cn ([114.242.206.163]:48595 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726928AbgGOF04 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jul 2020 01:26:56 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxCdWYkw5fPuQEAA--.6136S2;
        Wed, 15 Jul 2020 13:26:48 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] spi: omap-uwire: Use clk_prepare_enable and clk_disable_unprepare
Date:   Wed, 15 Jul 2020 13:26:46 +0800
Message-Id: <1594790807-32319-1-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9CxCdWYkw5fPuQEAA--.6136S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWxZw4rtw4rZF47CFW7Jwb_yoWDuwb_uF
        4DWrs7Gr4Y9rsak3W2gwnxA34I9r1qvFn2g34IqFWfJry2vwn8CrZ0qrsxCr1rZw4rAFnx
        Ar1kJ34akw1fGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8WwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jwCztUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert clk_enable() to clk_prepare_enable() and clk_disable() to
clk_disable_unprepare() respectively in the spi-omap-uwire.c.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---

v2:
  -Modify the commit message
  -Split into two patches

 drivers/spi/spi-omap-uwire.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index ce8dbdb..71402f7 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -443,7 +443,7 @@ static void uwire_cleanup(struct spi_device *spi)
 static void uwire_off(struct uwire_spi *uwire)
 {
 	uwire_write_reg(UWIRE_SR3, 0);
-	clk_disable(uwire->ck);
+	clk_disable_unprepare(uwire->ck);
 	spi_master_put(uwire->bitbang.master);
 }
 
@@ -475,7 +475,7 @@ static int uwire_probe(struct platform_device *pdev)
 		spi_master_put(master);
 		return status;
 	}
-	clk_enable(uwire->ck);
+	clk_prepare_enable(uwire->ck);
 
 	if (cpu_is_omap7xx())
 		uwire_idx_shift = 1;
-- 
2.1.0


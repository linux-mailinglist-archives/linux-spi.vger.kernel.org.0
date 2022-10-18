Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0DF60329C
	for <lists+linux-spi@lfdr.de>; Tue, 18 Oct 2022 20:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJRSf4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Oct 2022 14:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJRSfu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Oct 2022 14:35:50 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387C08110D
        for <linux-spi@vger.kernel.org>; Tue, 18 Oct 2022 11:35:49 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D7F3384DBA;
        Tue, 18 Oct 2022 20:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1666118146;
        bh=aDgPYe1ErMObeOUSiQUDFRPpJrVcIb30Ern97I+qBEE=;
        h=From:To:Cc:Subject:Date:From;
        b=xPa8ymcokW8qo16+AgyAAWEO2GWg/XvORJLW89N5REHvG2ROb83jILmN9iK9xdG2F
         SsbDBjfYod+nnXKDTMVEk1+3f25FcaJZmHP8pyWGGGgTh8G/F+iXpJMcr9U+EeidEj
         N8tc7WHPL7rLhXzd0YaDpsv0k1zW+GpQW61W6zOhxun81EChob3GpRaHp0tB656nAb
         Zn2SF13Hyi3ds6eC8SJFDpo8oCUpNG9/fG3N0kv0THA2A24ygIh/MD2ceVFiJanmXC
         5NVdN3WvVVQ7L/D3c22SYKM59hWxU2XbI+HNoz4EJXqsupdZN9X86bogAsRUF4ED98
         OO2NKrdjA7i2A==
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: stm32: Print summary 'callbacks suppressed' message
Date:   Tue, 18 Oct 2022 20:35:13 +0200
Message-Id: <20221018183513.206706-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The original fix "spi: stm32: Rate-limit the 'Communication suspended' message"
still leads to "stm32h7_spi_irq_thread: 1696 callbacks suppressed" spew in the
kernel log. Since this 'Communication suspended' message is a debug print, add
RATELIMIT_MSG_ON_RELEASE flag to inhibit the "callbacks suspended" part during
normal operation and only print summary at the end.

Fixes: ea8be08cc9358 ("spi: stm32: Rate-limit the 'Communication suspended' message")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Antonio Borneo <borneo.antonio@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 6fe617b445a59..3c2fa2e2f94a3 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -886,6 +886,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 		static DEFINE_RATELIMIT_STATE(rs,
 					      DEFAULT_RATELIMIT_INTERVAL * 10,
 					      1);
+		ratelimit_set_flags(&rs, RATELIMIT_MSG_ON_RELEASE);
 		if (__ratelimit(&rs))
 			dev_dbg_ratelimited(spi->dev, "Communication suspended\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
-- 
2.35.1


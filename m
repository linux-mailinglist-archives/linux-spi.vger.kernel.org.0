Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF13F3EB42C
	for <lists+linux-spi@lfdr.de>; Fri, 13 Aug 2021 12:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhHMKn1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Aug 2021 06:43:27 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47968
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239223AbhHMKn1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Aug 2021 06:43:27 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D022F4061A;
        Fri, 13 Aug 2021 10:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628851379;
        bh=6my1meBweLsHucmiSRvtuTv5eVAc6MQgpR5ufkNa+nQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=XoqV7W5jC8mUg2bkwNzNiZIK0C+xIjL0zMPY93KupTyL9vTKOXrocmJMqUiDGV0aA
         KJRktND0f9Tn6iEpwm0hROLHRgSRQhPTlb8E2P17rBRF72DNOFIgRdmK1vQpliunls
         W0fxXn2YqWkvDqeOWkHdnSazjaLtqqbJy1PiKZidmVO+pwy4TnQ9AmE1qaVyOoJDCj
         fWJVg8KxfWr2bvW5E2JLPzX5q0jJcu0ExaUqdHopNaEQ+tb4NhAPsRG5UMZcnru17J
         gUr6MTopi6JQpb7p154JBKAFQvZEO1r0hFqY4Z3NYBgeG2huupnj38tTpWQd553ewj
         IASAGM+9r9Y3w==
From:   Colin King <colin.king@canonical.com>
To:     Mark Brown <broonie@kernel.org>,
        Zhengxun Li <zhengxunli@mxic.com.tw>, linux-spi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: mxic: Fix missing { } around an if code block
Date:   Fri, 13 Aug 2021 11:42:59 +0100
Message-Id: <20210813104259.17612-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a code block that is missing the { } around it. Fix this
by adding them.

Fixes: d05aaa66ba3c ("spi: mxic: patch for octal DTR mode support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-mxic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 32e757a04f14..45889947afed 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -398,10 +398,11 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	if (op->data.nbytes) {
 		ss_ctrl |= OP_DATA_BUSW(fls(op->data.buswidth) - 1) |
 			   (op->data.dtr ? OP_DATA_DDR : 0);
-		if (op->data.dir == SPI_MEM_DATA_IN)
+		if (op->data.dir == SPI_MEM_DATA_IN) {
 			ss_ctrl |= OP_READ;
 			if (op->data.dtr)
 				ss_ctrl |= OP_DQS_EN;
+		}
 	}
 
 	writel(ss_ctrl, mxic->regs + SS_CTRL(mem->spi->chip_select));
-- 
2.31.1


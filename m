Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D473DCED4
	for <lists+linux-spi@lfdr.de>; Mon,  2 Aug 2021 05:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhHBDAh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 Aug 2021 23:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhHBDAg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 1 Aug 2021 23:00:36 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECAAC06175F;
        Sun,  1 Aug 2021 20:00:26 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id z6-20020a9d24860000b02904d14e47202cso7538604ota.4;
        Sun, 01 Aug 2021 20:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3jwA3sv7LfeA88bUhgOgpW0zu8BYSUhLdnLV59eV+k=;
        b=nN+LqWCqdJi31kINH3VCdWbNQxabUcc6kCWZM/JDlZGdJS3mNFTdb5GfvIgONTNa0Z
         O6jGoRTIdJGUOfTBi0Fev2GSzQq9XD2Hxd2bVFvGctcmz0bMext+57L+gJyk6PyYW8p7
         PVZOhhANlRCccizrYkr1uBsM4Sj5+mIT0x6yNEf/Lk1u8mTyByJOsJRtQtY+m/OtlU5z
         qvNcIO1MX0VPp29isyXQu8ZstXCqBpTWcR45/Lwkkkh8hcsytZ/vZuL15og1wIlbRlgh
         zV5bgBigCb4Wz6Z+OjO/mOJwT6Ws11MUXhhb2q3LZq3fpA/tRZCYqjrrQFq4i/s+Kg1c
         ryZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=l3jwA3sv7LfeA88bUhgOgpW0zu8BYSUhLdnLV59eV+k=;
        b=q5+WUfuMMD+u5PjxKkoGbfXt2SzmU6izHivvV3oVCzGpT6H/5ZcK0CgG5AXZ1AwK6R
         +dg1yq3T44/Ju0ttkbeM76OrNX7eFHJAtXjfNCl604L1m9Cs+okDm9FzwNbe35+J0ruH
         ncM18TB4ae0iSNVFwknWlN/B/ABLT4vwB07kXbV4n4j8e9xqRWoSJmiBPgu1wur/Cpvl
         RMOjG6UIXs+DXNNmtzUVhO/nrvWVK60+kgqIFEER34jZuPLy3m5QMfYvTOXKug1Sa96B
         /POfGP025/xDgrmq/7WbfMJbQ5y5uMNgnq+0nnfhWGqljlrhB13TTD1P0/9noM381Ndc
         M9dg==
X-Gm-Message-State: AOAM532o9/LOvYZTYhOJQlsjLedGX3lDBSL0QVC6+2NDeTGC/qlBTkK9
        10zrWqhWRqXYOS4HxSRd3U0=
X-Google-Smtp-Source: ABdhPJzuuKDnVe+pBy7XiqDsOeM4T7BN4LlDQWdk+BDgTjDdIAj9y5QYr6zeVZxiH9PNnZNAcQFH7A==
X-Received: by 2002:a05:6830:2696:: with SMTP id l22mr10773429otu.286.1627873226329;
        Sun, 01 Aug 2021 20:00:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m35sm40242ooi.38.2021.08.01.20.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 20:00:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Hess <peter.hess@ph-home.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Hsin-Yi Wang <hsinyi@google.com>
Subject: [PATCH] spi: mediatek: Fix fifo transfer
Date:   Sun,  1 Aug 2021 20:00:23 -0700
Message-Id: <20210802030023.1748777-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 3a70dd2d0503 ("spi: mediatek: fix fifo rx mode") claims that
fifo RX mode was never handled, and adds the presumably missing code
to the FIFO transfer function. However, the claim that receive data
was not handled is incorrect. It was handled as part of interrupt
handling after the transfer was complete. The code added with the above
mentioned commit reads data from the receive FIFO before the transfer
is started, which is wrong. This results in an actual transfer error
on a Hayato Chromebook.

Remove the code trying to handle receive data before the transfer is
started to fix the problem.

Fixes: 3a70dd2d0503 ("spi: mediatek: fix fifo rx mode")
Cc: Peter Hess <peter.hess@ph-home.de>
Cc: Frank Wunderlich <frank-w@public-files.de>
Cc: Tzung-Bi Shih <tzungbi@google.com>
Cc: Hsin-Yi Wang <hsinyi@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/spi/spi-mt65xx.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 68dca8ceb3ad..7914255521c3 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -426,24 +426,15 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 	mtk_spi_prepare_transfer(master, xfer);
 	mtk_spi_setup_packet(master);
 
-	cnt = xfer->len / 4;
-	if (xfer->tx_buf)
+	if (xfer->tx_buf) {
+		cnt = xfer->len / 4;
 		iowrite32_rep(mdata->base + SPI_TX_DATA_REG, xfer->tx_buf, cnt);
-
-	if (xfer->rx_buf)
-		ioread32_rep(mdata->base + SPI_RX_DATA_REG, xfer->rx_buf, cnt);
-
-	remainder = xfer->len % 4;
-	if (remainder > 0) {
-		reg_val = 0;
-		if (xfer->tx_buf) {
+		remainder = xfer->len % 4;
+		if (remainder > 0) {
+			reg_val = 0;
 			memcpy(&reg_val, xfer->tx_buf + (cnt * 4), remainder);
 			writel(reg_val, mdata->base + SPI_TX_DATA_REG);
 		}
-		if (xfer->rx_buf) {
-			reg_val = readl(mdata->base + SPI_RX_DATA_REG);
-			memcpy(xfer->rx_buf + (cnt * 4), &reg_val, remainder);
-		}
 	}
 
 	mtk_spi_enable_transfer(master);
-- 
2.25.1


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE861A6311
	for <lists+linux-spi@lfdr.de>; Mon, 13 Apr 2020 08:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgDMGap (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Apr 2020 02:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbgDMGap (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Apr 2020 02:30:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2800FC008673;
        Sun, 12 Apr 2020 23:30:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g6so4055380pgs.9;
        Sun, 12 Apr 2020 23:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b7+FE76CrAbv5/Ztny79Na77dk/ZlKbkr1Vw0gozAZk=;
        b=t3QyUVmofB/LxJYTmuH4EW8oCoXGwEFD+QkS+7y1z6JaT1weNzVFYjQv0KQYme6fKY
         GwxfggGIvPgP487KP7nrSd5sT+1T+SwEBGGt8ozgqrMaRBO6FOibksLyZSx2zgyNjZ+L
         TVnZwDg+7LaUD0qCiWAHHSkeDB9NEPk1o9c+pLeA24L72hPbDUBOxuc5Azul2Wixqlcj
         WoZNMBoUfNgX8uJ1zjTuLGmPAYqYQfJiwFBNzxb8x7UZcaIDqu+61eWzVdsZcz9IqD6S
         9o5h5H5OeXs6fZxkhICKGhm6FbskaK0+MXggudlnhAVpqxINNTI2bMjVfN4DQeLPWzku
         JeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b7+FE76CrAbv5/Ztny79Na77dk/ZlKbkr1Vw0gozAZk=;
        b=OcGfd6YLHG0Y9DEnUx9rDsxC134UdhwaX2WBuovx1eliPtmZ8xGaDeyBLJreG8eyHO
         CtHTdAgFtuYmFhDP7ZprQzJtyxvofnujVttDpvYaMWr3CPUiBpNeFZ/Ka+ePR+Y+tqI5
         73q5hTjTxsT/87R0YhjiYDESh32HzRqXk0sGBpX6nUxS/COfmfjs+7XzUmFAuG2dd9d7
         g6k2JLt6Z4jGnUJEBwJfPn0nLr3T4wqyFhMkSX+ys0Kg/y+U9hWZ4QwValxzqed16mqv
         LnTR0tpYYvbUNK8OClZONaFH4VPgkPEJXbrQI55yYwEWBEnin3l+nm8gscRwBnSsSwlb
         ryuQ==
X-Gm-Message-State: AGi0Pubs7AqJ91peT3uySaT9Hq5Qf3gi5RJsYtl074qh+niPm6m5gG8x
        EIKyxoYlWfccoFUp8aunTRs=
X-Google-Smtp-Source: APiQypIMMmaSuobJaTPNM0QJ3WTO4JlQhK7yxLHjgNC+EcZIc7aimYlP+URBewW9DSu9sa2sYUjRvQ==
X-Received: by 2002:a63:7a15:: with SMTP id v21mr16274168pgc.416.1586759444700;
        Sun, 12 Apr 2020 23:30:44 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.19])
        by smtp.gmail.com with ESMTPSA id w10sm6594286pfd.128.2020.04.12.23.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 23:30:44 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     broonie@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: sprd: adi: Use IS_ENABLED() to validate configs
Date:   Mon, 13 Apr 2020 14:30:25 +0800
Message-Id: <e38807eadd5550add8eb90dd3f8fbe2cfc39cc13.1586759322.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the Spreadtrum wachdog is loaded as a module, we still need set default
watchdog reboot mode in case the rebooting is caused by watchdog. But now
we can not set the watchdog reboot mode by using '#ifdef' to validate
the watchdog configuration, thus we can change to use IS_ENABLED() to
fix this issue.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/spi/spi-sprd-adi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 87dadb6b8ebf..88e6543648cb 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -319,7 +319,7 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 
 static void sprd_adi_set_wdt_rst_mode(struct sprd_adi *sadi)
 {
-#ifdef CONFIG_SPRD_WATCHDOG
+#if IS_ENABLED(CONFIG_SPRD_WATCHDOG)
 	u32 val;
 
 	/* Set default watchdog reboot mode */
-- 
2.17.1


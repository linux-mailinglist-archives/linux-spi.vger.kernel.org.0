Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC22F30127A
	for <lists+linux-spi@lfdr.de>; Sat, 23 Jan 2021 04:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbhAWDFM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Jan 2021 22:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbhAWDFK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Jan 2021 22:05:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B2BC06174A;
        Fri, 22 Jan 2021 19:04:29 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id rv9so10403875ejb.13;
        Fri, 22 Jan 2021 19:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Ener4CSJbezhco33AGXGSfODg8ypwK518kRv1pQb/E=;
        b=pDf1LH4FAFY99EV2ZwneV3JMXssmWnyrASNUDcGmTS30XhFdhFQ1DFRI/M/yt17zV7
         I7O8IgT/OnQtj0L6X1/4kHsC4IQyeNm04KmsDSiySUWQS76poBwYyb9aqyL3TWGqI5AB
         Ju9Qd3laDeFXV56HOpvS7wqemq/3iafa9AnTo/v/WYm1vFhajQ7TmxSDG5IQ5oeeC3ZL
         LMrO8dJ3dGJ+oP4Bb1dz4i7T5+WCOzV4qfTCZ8dmzs+uGic7TzrgxUODEJGoay6me5UQ
         uE/P9x+Csvb1waZ/mIp6TbjfJsb56rfpslf0WzjvxHd0v1BI6av2mltoa7f1bfGXaXR4
         49XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Ener4CSJbezhco33AGXGSfODg8ypwK518kRv1pQb/E=;
        b=RgdrRqxqHeer8bUMGqfpS165MoMnPmgFDuC30w1KL1x+/KmacAC4aVWq7jFOoEp+0b
         YhRJCGwwJERYjDow3YCYNxo+jooF0tqfXBPvRVCdq5F8d8ha3PUxP0qVqlxnIveIOB8B
         rUQ2Lcpw3Yb8E/U4o8E7Gwt0sZDElMtiG2AYl7bQo4H1iT2aKUup7t8eIfULA8RrRsP2
         s5forDVMY2DqYQhOF4BztJRG1YeFtIBWgKmmj8Uz+1EH0bNs6BcedZkXN9AycuV5+6jA
         yj7HINUcvj2Vie0DINszxy8yvuv+tLpJbtm7pCLdQziamFnYCdxpTOv3xxS0kYMm6uth
         U50Q==
X-Gm-Message-State: AOAM532BAlaBcVXDMBRHVATYKZgqARQAyo4bc9Ijt4DUp3JtVMS7LY8q
        6QogBWB6FdGXhuq7R4oj7tNXfTf79WQ=
X-Google-Smtp-Source: ABdhPJyf15A1qs8KWGwEOtYcIASNBXNq9IKtBmSf9+od8qZvlDpT0apdVOxMcJMRZwwLWnKtjs04Ag==
X-Received: by 2002:a17:906:e106:: with SMTP id gj6mr48316ejb.337.1611371068355;
        Fri, 22 Jan 2021 19:04:28 -0800 (PST)
Received: from localhost.localdomain ([37.166.133.137])
        by smtp.googlemail.com with ESMTPSA id f9sm6503967edm.6.2021.01.22.19.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 19:04:27 -0800 (PST)
From:   corentin noel <corentin.noel56@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        corentin noel <corentin.noel56@gmail.com>
Subject: [PATCH] spi: spi-au1550: pr_err instead of printk
Date:   Sat, 23 Jan 2021 04:03:44 +0100
Message-Id: <20210123030344.15999-1-corentin.noel56@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: corentin noel <corentin.noel56@gmail.com>
---
 drivers/spi/spi-au1550.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index dfb7196f4caf..8f92bbdf391b 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -972,8 +972,7 @@ static int __init au1550_spi_init(void)
 	if (usedma) {
 		ddma_memid = au1xxx_ddma_add_device(&au1550_spi_mem_dbdev);
 		if (!ddma_memid)
-			printk(KERN_ERR "au1550-spi: cannot add memory"
-					"dbdma device\n");
+			pr_err("au1550-spi: cannot add memory dbdma device\n");
 	}
 	return platform_driver_register(&au1550_spi_drv);
 }
-- 
2.25.1


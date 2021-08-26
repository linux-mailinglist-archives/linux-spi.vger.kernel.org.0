Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7383F844C
	for <lists+linux-spi@lfdr.de>; Thu, 26 Aug 2021 11:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbhHZJRJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Aug 2021 05:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240918AbhHZJRI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Aug 2021 05:17:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0FFC06179A;
        Thu, 26 Aug 2021 02:16:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so6148504pjb.3;
        Thu, 26 Aug 2021 02:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T16hPym+Gbg5qTCFIPoHdSKLfvoWtFjTf0ClBNpU9Uc=;
        b=UmiQHF33ws4tudVoG3QYkrvG1XBp7SxdYUF3zGbFI2I+S3QNAaXggAhXAIn6Z/jkgf
         mPN5oi691+Mi9nW7XbX14ec9JOoOgflcB3kAgpEjwT5DOYyhae3Ls+hZF+HPas1m/kD5
         FzjwQmpvvbD6apX/ojokWDsQfpvqWiisD48cjOreQdU5Ow+9DMI3oNZ6sPfPnX8EvZUR
         SCb86ZrsTiUB1bo2L8p7vC/54wTg+g3TFvafZi5WclAIzxcrCHHGScXQO2sZmxEYo7HQ
         E4Wog0zdYoZnxcLZ3cHDKMlLfwhxYaVwvKnb0pACX08w0tgZEGnXtF1XFDkiW5CNg1Dh
         YWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T16hPym+Gbg5qTCFIPoHdSKLfvoWtFjTf0ClBNpU9Uc=;
        b=rxz7VAdRVpzGv++BKunf/McdThdPkchucRRWvuJk9zkkz18iJYKJhhl5phmgIQBNXj
         YinkTtKaXnI1IgWlzBRYsYGppICGFZX4KIjkNY7IY8RBO6gbVNmpvaON34Us/vHIfEGD
         S9vQPPwvuK3Bmk1JFTyOABcNTR0spjpQoMZy8Qn4CYzrhn551kB60VgZlJjdcaq7oaK6
         EsrT1GZqnl4jCYsDh0xJNiegeFoOoHjBsinbFTok6PaMthPBQyWrOF3vmfr3cCwTLZrS
         nelS3QdGHi27xy3qaDyAw1ovDyQoRAYM0xNxy1PgKyDEpPFQ1+XWK5pEy5Ztd5FlRrbU
         gSjA==
X-Gm-Message-State: AOAM53104MZ1R98JHAnyt6rESsRFjCHU+p/xkIrM1z1/d09jS+G21Jmq
        k5A29jQLTqpOk/clLZr4lAE=
X-Google-Smtp-Source: ABdhPJwNJ4aVRcvzmYacli+y2TCes91mC51Q6wES6lTFJL1+aHwKpm+yH9s3aFwKuWFBntrn38Lrfw==
X-Received: by 2002:a17:903:2302:b0:133:f033:6eb4 with SMTP id d2-20020a170903230200b00133f0336eb4mr2754985plh.34.1629969379306;
        Thu, 26 Aug 2021 02:16:19 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j20sm2777569pgb.2.2021.08.26.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 02:16:18 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 1/4] spi: sprd: Fix the wrong WDG_LOAD_VAL
Date:   Thu, 26 Aug 2021 17:15:46 +0800
Message-Id: <20210826091549.2138125-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826091549.2138125-1-zhang.lyra@gmail.com>
References: <20210826091549.2138125-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Use 50ms as default timeout value and the time clock is 32768HZ.
The original value of WDG_LOAD_VAL is not correct, so this patch
fixes it.

Fixes: ac1775012058 ("spi: sprd: Add the support of restarting the system")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/spi/spi-sprd-adi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 07f11b17bf20..d392dc6db927 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -103,7 +103,7 @@
 #define HWRST_STATUS_WATCHDOG		0xf0
 
 /* Use default timeout 50 ms that converts to watchdog values */
-#define WDG_LOAD_VAL			((50 * 1000) / 32768)
+#define WDG_LOAD_VAL			((50 * 32768) / 1000)
 #define WDG_LOAD_MASK			GENMASK(15, 0)
 #define WDG_UNLOCK_KEY			0xe551
 
-- 
2.25.1


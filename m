Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39632223D68
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGQNzC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 09:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgGQNyi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jul 2020 09:54:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88326C0619D5
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so14960135wmj.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ptPnW5Wq5Xlmw660UEVJ/FMLrebEARvPD+hr3BMDl5Y=;
        b=vGeuCgIuXoltl82e88QMAD4qKZTTplcAZ8PaNDib7nkd+uoYiTXZeVJpFP9WyGWZ6I
         PfM3Ca8M089A3y7Gbs8ILX0PuKbmPBeDvzF6ZG9V3ukEAc/yw0+f71JUSMyM5Ffokyx7
         IdXYIamPS9sSWW3ciq7IBJGGjzRIMC8rDnqUysc+Ej2OPnL/1OMIB5dxfe/+A6fARcQK
         auUqYqUQhiAleVyWBH7QyFrx3GSYVVrxi6lr2CkcDRTPu0ZBZ+RQRF8oG/t+LG7RvNwm
         iVL5K/MEY+S9e2wv2tSgOE+UWEyObkfBCvxhkCv/36sDGFg6YatUyXNMRuzC8OaDQxDT
         93+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptPnW5Wq5Xlmw660UEVJ/FMLrebEARvPD+hr3BMDl5Y=;
        b=cOI9NGBvewnEFNsHPed1kf2Fr6YndxaJKwIBVDrvjESO5UILMN4LZi+N6mAYkSEYCm
         ImOMRcLr7gvGL+LzHFTmPaxUorJGUo9bNKXZ20qMrwK61E/mhVQHYo0I7MmCHvwo0KvK
         oUqBLMkUbLd9Wn5m6MOyHTluRMneJq95vOyzUgJ3528sCIYug44zC/d3D7vlb44lGKtm
         ZzLnvXREezzPSVyHRKHbrojn8+paygBbS69t3qGbJHR912pHA51p+nLcCQSkmNVH9lgd
         yoNp7mJGWL2cjMX51Oz4reMqdM9Z+DjiLYV/B2CWfpPCjKZOAwmmS3Lg1jdbrTfxBl87
         nEyQ==
X-Gm-Message-State: AOAM533YBNHAoeF1pwN6BqoC5uEEHr/ulNQ7P0E+k7khK61EL599WiHh
        9otbriFaZlP0AeQ+FiBQcJcIiQ==
X-Google-Smtp-Source: ABdhPJyZRQNbnf+BDafZphHh3/FOeuAD/mogS711QlQ7nFrzO3XXgtccwF7VUm3xUyVC5f35oFt8Lw==
X-Received: by 2002:a05:600c:2949:: with SMTP id n9mr8765745wmd.69.1594994077227;
        Fri, 17 Jul 2020 06:54:37 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 10/14] spi: spi-zynqmp-gqspi: Correct a couple of misspellings in kerneldoc
Date:   Fri, 17 Jul 2020 14:54:20 +0100
Message-Id: <20200717135424.2442271-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Function parameter or member 'slavecs' not described in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Function parameter or member 'slavebus' not described in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Excess function parameter 'flashcs' description in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Excess function parameter 'flashbus' description in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:902: warning: Function parameter or member 'dev' not described in 'zynqmp_qspi_suspend'
 drivers/spi/spi-zynqmp-gqspi.c:902: warning: Excess function parameter '_dev' description in 'zynqmp_qspi_suspend'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 811c97a7c8589..e17a201252557 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -197,8 +197,8 @@ static inline void zynqmp_gqspi_write(struct zynqmp_qspi *xqspi, u32 offset,
 /**
  * zynqmp_gqspi_selectslave:	For selection of slave device
  * @instanceptr:	Pointer to the zynqmp_qspi structure
- * @flashcs:	For chip select
- * @flashbus:	To check which bus is selected- upper or lower
+ * @slavecs:	For chip select
+ * @slavebus:	To check which bus is selected- upper or lower
  */
 static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
 				     u8 slavecs, u8 slavebus)
@@ -892,7 +892,7 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
 
 /**
  * zynqmp_qspi_suspend:	Suspend method for the QSPI driver
- * @_dev:	Address of the platform_device structure
+ * @dev:	Address of the platform_device structure
  *
  * This function stops the QSPI driver queue and disables the QSPI controller
  *
-- 
2.25.1


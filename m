Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C74E2FF8
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 13:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407946AbfJXLIQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 07:08:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45847 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407918AbfJXLIQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 07:08:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so20615928wrs.12
        for <linux-spi@vger.kernel.org>; Thu, 24 Oct 2019 04:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNdLDMDvs6jG6S/dKTBgsoykSCcfXzl1oiV7AyYbffQ=;
        b=r2jLmU4b9/KDjOE0xUa5KKrmE71OdJwB4T8uwA6IBwjhHduNgn7u3hEjzMjEj5IHNc
         /L8pql9f/3Zc2iBZiWRkFAnhmo4TFJFABIxS6HftxjSjEZoffcnUUgGY8Ksir3PUMFXq
         W7E5zrYbnwEeFlb60oQLi2Bx4vMLFbudkNv+yYsMIrdL8nH4TFICM6Osqj9w+S/R7yny
         TkRUzJ6fGERiFJrDuXGzOrLUlzNCKoF0GeJ1gTqvfOiVisLVyZb0+Z7vt6hUYD1AYiPj
         0lYm1iO1+X+TWBCEQ9ZptOrzgHmFGUwPfRdX7cfJLOiUgcgUybYf7AKs3qLCl4GYuFl7
         ZU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNdLDMDvs6jG6S/dKTBgsoykSCcfXzl1oiV7AyYbffQ=;
        b=E6Ebris/mPdj3Yh73MAC+3FLtaMXT88BoyogjxmtbM78sR1anMlM+YwTmpUGg5/uIE
         SKPt6+6k7aMDNS+o3OiUPWVvx1sJKL0WrLLgaeNcttKCB9L0wFwyp+3bL1IIjsG+xWRC
         3dUR5rYGDFw8dRREBG27MP0ZvdagNG/OLCDLYz3ejEkTmlPUHgt3zCp1ph2eFr/fmos0
         F7pq+AAmwYstBpVx/Hr7F6nFPVawoGeyvfokA8M6k7Pn/jc3XnxxWmKYvEvqfC4QzoDA
         j1tALlu6RB2wrBqtHE5eMrhbNHpKaza8luSQv/VcxNU5cfKPIwOzfE4ZUseWrt4zhM+0
         xxlg==
X-Gm-Message-State: APjAAAXbZdoziw3KOfKVLOpYH8o6rQhu9CCo55IDr1kDmHopIiO8rG3G
        oSE0fnVk/ZycVcNCvXBhGH0XuA==
X-Google-Smtp-Source: APXvYqzjBo/OCHJnpmJJiSaj4DlevP1G0F4C3ywvg8NSNVPYctcCqiKMHrYJxKi4upgIbDZEFIG3Dg==
X-Received: by 2002:adf:9044:: with SMTP id h62mr1492116wrh.91.1571915294389;
        Thu, 24 Oct 2019 04:08:14 -0700 (PDT)
Received: from salem.gmr.ssr.upm.es (salem.gmr.ssr.upm.es. [138.4.36.7])
        by smtp.gmail.com with ESMTPSA id 26sm2420473wmi.17.2019.10.24.04.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 04:08:13 -0700 (PDT)
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        Mark Brown <broonie@kernel.org>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Subject: [PATCH] spi: xilinx: Add DT support for selecting transfer word width
Date:   Thu, 24 Oct 2019 13:07:56 +0200
Message-Id: <20191024110757.25820-3-alvaro.gamez@hazent.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024110757.25820-1-alvaro.gamez@hazent.com>
References: <20191024110757.25820-1-alvaro.gamez@hazent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This core supports either 8, 16 or 32 bits as word width. This value is only
settable on instantiation, and thus we need to support any of them by means
of the device tree.

Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
---
 drivers/spi/spi-xilinx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 92ea22fedb33..46bb103ef30e 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -380,7 +380,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	struct xilinx_spi *xspi;
 	struct xspi_platform_data *pdata;
 	struct resource *res;
-	int ret, num_cs = 0, bits_per_word = 8;
+	int ret, num_cs = 0, bits_per_word;
 	struct spi_master *master;
 	u32 tmp;
 	u8 i;
@@ -392,6 +392,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	} else {
 		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
 					  &num_cs);
+		ret = of_property_read_u32(pdev->dev.of_node,
+					   "xlnx,num-transfer-bits",
+					   &bits_per_word);
+		if (ret)
+			bits_per_word = 8;
 	}
 
 	if (!num_cs) {
-- 
2.23.0


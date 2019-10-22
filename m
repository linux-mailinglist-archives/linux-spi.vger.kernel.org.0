Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89231E002F
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2019 11:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfJVJAQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Oct 2019 05:00:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35207 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbfJVJAQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Oct 2019 05:00:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id 14so8680884wmu.0
        for <linux-spi@vger.kernel.org>; Tue, 22 Oct 2019 02:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptNpwO+zbKDZ0k/JpOwWU2PoOloIncPqLZ/QdUgOYQw=;
        b=N3ud6M4NxbQbbsElahebyy3pf1gPYvthiLy1RHWHl2FLPel50qeAZMgr5/T/CWHzWX
         JSydAsRdXhSoiZpzTV6wn3dKBnZQVP8C/xHCjD+ryORDYBTDXUJRJEWDQ3kAAYfhcgOt
         G0H8gUKV0qQBJ5qlrvmkdFETN0u0Vbc/w1LF6HNuscZfFemq3Zt/cTLrWF+ZcaIErbkw
         NF1gJPqzjnafxuulOLgi32S7CMKsUFWxQwr+TFJwrSXI74SvauwBykfbmd/imIq3ZAxo
         4+xCv1jIo5bVY/mcwqf2Oeaxmu2viTVv9ap2lQ1DU2BueRVpiX9MCeD9juY7o4Htzwj4
         zH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptNpwO+zbKDZ0k/JpOwWU2PoOloIncPqLZ/QdUgOYQw=;
        b=eaR33PxXXSwbNz7rXmMLz6ClpD2ScIWgZ5zHPBD5yBvUquXhOHfilp5/6lUH5QoxJT
         6Yt0OgVPvnKEd1fFCTwz4W3qdaBTfefeYrv7yA+7rIU2FIwcNVY6W1VmjEnAmWRPZuGM
         kPF0kYpuKNUnrKwlsAEh5FqP7DxJUeA6xv97XB93HTm2SFXDB6SsD20VuVR7DAizXtXU
         oDbIpJLev7ZSyCaZRkO6tjMjtid8bN1RAd5e5lJnQnYKRWgbIZu1KHK9FOnb0C7DwDvr
         m0yGuTf+VwHAIHU0rYg7aivEYGqPJvOTjU1py5lDzU4c3vQP6p9Bvw37i/btq9OrzPya
         2o3g==
X-Gm-Message-State: APjAAAW74LY1q8+ETN/cb0gA4Di2QUc/3nnoiuZI2OnMU62EKbJpwBLT
        4FHqesJJmlrHObtRQkYiqZPjnA==
X-Google-Smtp-Source: APXvYqx1/m0/F9pkRW2ERqzzkCaTYjgUnDCwixI2G224/5pwx7H/jWAhlx3/coaRaSQa7Vj4VxT4pQ==
X-Received: by 2002:a1c:20d8:: with SMTP id g207mr1970264wmg.79.1571734812973;
        Tue, 22 Oct 2019 02:00:12 -0700 (PDT)
Received: from salem.gmr.ssr.upm.es (salem.gmr.ssr.upm.es. [138.4.36.7])
        by smtp.gmail.com with ESMTPSA id u11sm15717994wmd.32.2019.10.22.02.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 02:00:12 -0700 (PDT)
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org
Cc:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Subject: [PATCH] spi: xilinx: Add DT support for selecting transfer word width
Date:   Tue, 22 Oct 2019 11:00:07 +0200
Message-Id: <20191022090007.15147-1-alvaro.gamez@hazent.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

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


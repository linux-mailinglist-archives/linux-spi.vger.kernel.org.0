Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 343BAC1A66
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2019 05:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfI3DqO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 29 Sep 2019 23:46:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35210 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3DqO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 29 Sep 2019 23:46:14 -0400
Received: by mail-io1-f66.google.com with SMTP id q10so34551005iop.2;
        Sun, 29 Sep 2019 20:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CSb8gKQFW+56QuRhWd4MVB/962Fvkd5QK+eXub6cDmE=;
        b=MxIuKg6cc7vmVBU35srXcQltSjWfzAQElpoZgAlV4IAegsPDx906fw8dUzLriT4baK
         fBI64z8uZ5KseshsQzqi5BVxbpb6LulT2mykTJq/pUGdaGaks60BJexhUMeSfNyaRrSw
         jfZjzE0QCgGBSOYA5ovK/1GcPySgrArlnITUbkIzeObOLmetAQSgfIuEmD3QDkMSGBgo
         vEJ/PmjTcPWD8rCJc/XKg+rTU7wVeK/VTlmL6KxFvwOwenU6A7VjSjSUIUuRLyY4DrMN
         cYq+KCSyF9sfI4q5YOSUdQ0T1s5RpFvx8+sTAS78lMKQQqGwvVqM05jR/nbSHSEltzPy
         JHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CSb8gKQFW+56QuRhWd4MVB/962Fvkd5QK+eXub6cDmE=;
        b=bNFNL53TYUcz8nZsGgBlk1ntXRHaszBkoC9NrxFaR2ySpC2T71F+IlYFFeTyhVcLUW
         F9WAID6IG3m1OQEoyR0Hdnz5xkY22u1wVHTx4QWpil9NKsfyBmzVhoAlGmKRvgt1nso3
         2XJXPzoemp9nWy/y8GTqhFO+OofhRcwJdijhsRitU6J8z5xb0wHCwplFwRGZjRZI9uP7
         /+81BUj3Dhsz4jPbMTT9LrFVvqszsTkzTReqyp6sKnxMKhpfhUQwSX9fRF++E5EBEc3C
         X8uCSxmhI2UraYuwaASHqGk+nvpVTkUaNNaaz9J8HNMi0dq7N1xua7AT65rICXDfBvkO
         Sdnw==
X-Gm-Message-State: APjAAAWroOwvHW6SHGBmhWef7X7KS1ypb0sPG9ZHVxp4GIygokLX/WFb
        1azxubBLqnwY/4ic3z+D784=
X-Google-Smtp-Source: APXvYqzx55nalXFB8YovlLh9qfXLKQ5njGsXu/sw9z0VR74i+3mZlYSj//BvPzrbGIA2nI5KDHHqbw==
X-Received: by 2002:a92:844b:: with SMTP id l72mr17962867ild.275.1569815173041;
        Sun, 29 Sep 2019 20:46:13 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id w16sm5283677ilc.62.2019.09.29.20.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 20:46:12 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: lpspi: fix memory leak in fsl_lpspi_probe
Date:   Sun, 29 Sep 2019 22:46:01 -0500
Message-Id: <20190930034602.1467-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In fsl_lpspi_probe an SPI controller is allocated either via
spi_alloc_slave or spi_alloc_master. In all but one error cases this
controller is put by going to error handling code. This commit fixes the
case when pm_runtime_get_sync fails and it should go to the error
handling path.

Fixes: 944c01a889d9 ("spi: lpspi: enable runtime pm for lpspi")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index d08e9324140e..3528ed5eea9b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -938,7 +938,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(fsl_lpspi->dev);
 	if (ret < 0) {
 		dev_err(fsl_lpspi->dev, "failed to enable clock\n");
-		return ret;
+		goto out_controller_put;
 	}
 
 	temp = readl(fsl_lpspi->base + IMX7ULP_PARAM);
-- 
2.17.1


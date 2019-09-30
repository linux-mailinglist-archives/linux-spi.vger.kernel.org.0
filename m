Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE16C1A60
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2019 05:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfI3Djj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 29 Sep 2019 23:39:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33485 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfI3Djj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 29 Sep 2019 23:39:39 -0400
Received: by mail-io1-f67.google.com with SMTP id z19so34541045ior.0;
        Sun, 29 Sep 2019 20:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GKn1wKgW/OZ5vAeprIpMZ6UWBk4gaIVL5/4achb09lA=;
        b=hQO5OGW4OvsIpFhZJlDWH6Y1pLyUhU59qcu4DVBEWOw2brn8C+H5/ZdPHzaYmN2u2h
         ACOuEkQtbR4AVXOjV7sQ7TpDWvqfXijU8xmhHreE7Ju/NIJB9Lcvaa+gKXjXBdhx3XWL
         DBe2D3iY1VavwTA7H/22CZli+19Qi550doLVW0pT7gVazUl9bHBCBYyqiGHRV7H45yMh
         41anjhEFFLBPwkiLudf41BXyq1vGI7WqHayC1wLHnBgSg2Lvw4ARUlaPnVaeU07mK55k
         0PKOc2qHwD9wQpTZ3zofrA1ZIkxN0dkmbu15utAzrOB8zX6a4yrzsmsgmK2bgLHkgKX0
         2SKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GKn1wKgW/OZ5vAeprIpMZ6UWBk4gaIVL5/4achb09lA=;
        b=m/ffVLe4RWfxpBpbJkLBStNqqF8Wdvkwl9tQsPjVCXxz4BnD7USPyx7Cfjgt8K8xFv
         eWwcoZl+Gc0PGHTtTmRTXxcRuDBIXNKK7ciDvMOVyT1+jxdaJ+gozTOjQUCCeF8wr2m3
         KBqg/vOmMh7dMWrq5O+zyLAUqGKAByHI8dA1kSqeOTJrLl7DnfIUbmI9KNeWF54rSX5h
         hLXDin1OW56tkZyPHLaETS4YF1iBJh8oafKl+vRM7XfN/+VREXoCPUFlzJTykT5H2WuF
         H+C4WtIAV2Wi77Q4DL+fPYaiCAAEbBWyZ4u0UQ00Lav0WHGiG2J0ouQ4S3aFkwnXChHK
         OFUQ==
X-Gm-Message-State: APjAAAU/wmeoXv8AvHUE9u847Bmjn4yUYRpHJiaGZ5XbEUXVi2zHz5Tk
        4bd6CojGor0iR+1E3K56dK0=
X-Google-Smtp-Source: APXvYqwGaysazbAVxYT5N7BfNobiY+S92WrMXhSUPP874xbFJFdyP/8io/4Xtw25WAjv4gmlX7eeNQ==
X-Received: by 2002:a6b:3bc5:: with SMTP id i188mr19917038ioa.113.1569814778317;
        Sun, 29 Sep 2019 20:39:38 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id q66sm5335776ili.69.2019.09.29.20.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 20:39:37 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: gpio: prevent memroy leak in spi_gpio_probe
Date:   Sun, 29 Sep 2019 22:39:27 -0500
Message-Id: <20190930033928.32312-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In spi_gpio_probe an SPI master is allocated via spi_alloc_master, but
this controller should be released if devm_add_action_or_reset fails,
otherwise memory leaks. This commit adds Fixes: spi_contriller_put in
case of failure for devm_add_action_or_reset.

Fixes: 8b797490b4db ("spi: gpio: Make sure spi_master_put() is called in every error path")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/spi/spi-gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 1d3e23ec20a6..f9c5bbb74714 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -371,8 +371,10 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	status = devm_add_action_or_reset(&pdev->dev, spi_gpio_put, master);
-	if (status)
+	if (status) {
+		spi_master_put(master);
 		return status;
+	}
 
 	if (of_id)
 		status = spi_gpio_probe_dt(pdev, master);
-- 
2.17.1


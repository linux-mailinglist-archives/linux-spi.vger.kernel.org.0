Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 516F6C2750
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2019 22:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfI3Uw5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Sep 2019 16:52:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39209 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfI3Uw4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Sep 2019 16:52:56 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so42048611ioc.6;
        Mon, 30 Sep 2019 13:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HjzHBo6jT8sEvFe44LiFogaEnhJkNVFYB6XfDK7uqQ0=;
        b=A5mKEowmZmV++Op18zcmJR3/GH2ctiZffg/i22VkQ7tFE1c7sw8wb4oksQ6pjn3XGV
         5NNGCwG3fx94axiNRlb/VLkqyNoXfylZgasulxkQJrbm9qKbbQCkBjlrh0iMKg2P3r0F
         GeQwWcGXonOk1I4Yb+8/dLT2Tvc5iIEdRRsB4vdCrnG7/yKwQMcuJ1uYRFcTqE87ZqX9
         VK2VLqGyvoS8iYb/I0DuzebaEOcC8Mycb9iqKQqRkq/SPUpntj0ZppnWmgakX5zSZtJ3
         bLO+GoHmL8/1sqO/MLLtTUgjW07uDgE3N0nEeY8ZfwQBHvtkQ0xP8HGVt7kUjg3BeV0g
         mpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HjzHBo6jT8sEvFe44LiFogaEnhJkNVFYB6XfDK7uqQ0=;
        b=NcI6YA1affjO3DXITMbGWBoAJI+AaU4e5kWYImGuBfffek5czLnqy/Ceu5MCi63IBe
         AcXkrEDgDsTdcG/AmZK07jIhvLcSlcC87yMO8SabBmOelJye0QYXfcfYyZjes7vn4UBL
         EjKXJ/xjvqtE0IEYFlzAvxO7ttBmOAA7gyU+3LQpXrQ65PAmUBYPcrhoYVlFl8VnZYN/
         st0Aq1rjca5R8P5bYPt+awTT686f/fh9LOMnHa34SZpZRVH3LkqWx4pGZO10XvHzBseV
         FDRiJ3XGzvuiGUKs7dqtHrVxYdG2j1IcFLCnJWhOycAawxjn3d4pJ9hMpZV31epot0AT
         MhkQ==
X-Gm-Message-State: APjAAAVVkEMWOS4X5aP1Y5lokmSB24Y+ZsgkzNWCChNsQkqy3E/VCcY9
        Gv7MS/mz1JFYqknhMgjElwc=
X-Google-Smtp-Source: APXvYqzn/RTz90DQPs3v6GoRB75cFXIoD+MRJM6af30g7CqSFxkRz2+0cOy/I6rraDzMF6BGC8+FQw==
X-Received: by 2002:a92:b612:: with SMTP id s18mr19955089ili.37.1569876776114;
        Mon, 30 Sep 2019 13:52:56 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id g4sm6979666iof.56.2019.09.30.13.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 13:52:55 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: gpio: prevent memory leak in spi_gpio_probe
Date:   Mon, 30 Sep 2019 15:52:40 -0500
Message-Id: <20190930205241.5483-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <dcd26f62-e384-bf6d-2e7d-63c0d0f7da11@web.de>
References: <dcd26f62-e384-bf6d-2e7d-63c0d0f7da11@web.de>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In spi_gpio_probe an SPI master is allocated via spi_alloc_master, but
this controller should be released if devm_add_action_or_reset fails,
otherwise memory leaks. In order to avoid leak spi_contriller_put must
be called in case of failure for devm_add_action_or_reset.

Fixes: 8b797490b4db ("spi: gpio: Make sure spi_master_put() is called in every error path")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	-- fix a typo in title and update the description
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


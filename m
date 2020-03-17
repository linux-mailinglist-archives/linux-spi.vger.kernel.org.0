Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A5D187BF8
	for <lists+linux-spi@lfdr.de>; Tue, 17 Mar 2020 10:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgCQJZD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 05:25:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38433 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgCQJZD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 05:25:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id n13so14726098lfh.5
        for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2020 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FCJPc/6BfRkBai/2PNeti8ekKImacml1sIXA0KsfmLA=;
        b=GXhQe+FXLYKRvUGPuJkVC1Vkxx/u7+SGGENiBF3pKU2kgvX60VU/A1TZPLALvOGA5q
         tfRphB+s+gY+RJsLpvu9AhZmj8O8eW9zIG7mUUVEyeoDDj4HVh0iYDjVN+SEtx8i67/U
         J+9cUTzyAL2JOU3sKW4xo/ryubMdK3c0xn39AVhVqYJ7a9mOYVBWm2lv/vPvBgBujs+l
         aOaUPtoURIdYymxnmFlteKHBn0h4rHNbXuu3GTkJyPZqXf+xBOk1dvYnYyYY3b+DeXn/
         zOUSoQgB7+s+Fm8aNewsCkz1mM4HaSsxdinq04YOF6pi/aj59FetYMvCQ2+0q5+ejmOe
         IYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FCJPc/6BfRkBai/2PNeti8ekKImacml1sIXA0KsfmLA=;
        b=rP39OQcFX09DXB32DFcqoMSDupywrYUK85ww7yoFnGR2STz3sU2hv7ZOuuRnY2epwB
         MgObO0Ya4nddFDbQFXKbwrUElukbp8eQDZbJYBg2bLPcMkOxRfGUHKAYc6X0jUroOp60
         LjcJKlKr6uDShk5wFl6KA3ShlmQ2Z4OtqI6EbtX5AtcBL6mRQ4X13JhFSmFdwIBwvj+7
         JeSZTlRwZAOwn2lL5WYQqZw653Yox17mWhSQ2Vp7CrhzLsAWOiEA0R4DMZ9/WhhJj71c
         YJgkkmVrLRu0Y2kyrgTxvdxNadLKrIqXAceb3+vfK8IGS3jx5ZkcKv31HiUE/iacQEew
         mc/Q==
X-Gm-Message-State: ANhLgQ3rFlMo1hxRAmZMvegdtQICY8r774SosYuASk8xQLG4QcavSYGZ
        EvCSnFcanuyc8kRYhEaQXDLXcw==
X-Google-Smtp-Source: ADFU+vsrcLu7/cdqQJKGEDFbbFHekNJ0Pxw9uDDDx9ktzJX4j2Z54gL6So+HRNKqy/wrfKLc7ZC0Mg==
X-Received: by 2002:ac2:4145:: with SMTP id c5mr2248546lfi.19.1584437100395;
        Tue, 17 Mar 2020 02:25:00 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id o23sm1849429ljh.101.2020.03.17.02.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 02:24:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] spi: mxs: Drop GPIO includes
Date:   Tue, 17 Mar 2020 10:24:57 +0100
Message-Id: <20200317092457.264055-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver is not using any symbols from the GPIO .h files
so drop them.

It was however implicitly using <linux/pinctrl/consumer.h>
so include that instead.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-mxs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index dce85ee07cd0..918918a9e049 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -22,7 +22,6 @@
 #include <linux/ioport.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -32,7 +31,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/completion.h>
-#include <linux/gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
-- 
2.24.1


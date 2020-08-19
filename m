Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC22249E0D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgHSMei (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgHSMdq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:33:46 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B84C061757
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 05:33:46 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id o2so11111847qvk.6
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kQdyoaOPXlrSc5FhSdIhoot6NFE5B/ivUZJdRymmhPM=;
        b=mw04zpRe+ahlhPqR1lTewDa2OFzfgiS88BuWnT1WsZ01fxEao9mVMTQUfaaWZz0PMk
         f9L4NmXsJ4oKIacsqiK27uTQZxEdJVjS57lkSCIvRWuZGgKJrbLuQIJ5SFlAL1NrHRqv
         f7YzS9mZX7nHSu/pby3gpzusldiEIYrPzpUMxtlC9yxCZd292U2ectQInmxQrcuomNkb
         gus7VT2VrWReHn0o8Y9Ycx363rtzOtGkTC47ixm/hRHJSEfnaEH1tQsjVOlSCDT+Ihe9
         mJE5k4VgXQFMUKIjbgj7hXtcTPTMn9rgPGJ5/4cKAZFkI/uHZ0Z4hqmcOANX4ttPTLo9
         wUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kQdyoaOPXlrSc5FhSdIhoot6NFE5B/ivUZJdRymmhPM=;
        b=ne3Se06Spefk1BDgck4oDUNKocKuJahB8GXRuisfyGf7ybBeGXXzGXXtdq500rHvpN
         prJ3ooifBbtGb33Ubb9maaqxqW+hSISGCqGr2us1eGcNWhqlzBflgDRtQ00zc/w+dMLH
         Wj2F6fTJKzsM2BmCxMhpBvGc3CfNkttvVT1l+3X+lmiYge5hAe0I1aZP0agl6UCZPm2W
         Z/lcnJjAJaRAdmLrWfd4skW3aRni+d/K6lxZ/8NvL9FKKQUdwD2BB/QTerF/YvuwxoiK
         mxXuMeaeKBA2jG5oQACFs+JBSEPtDj1kAYqi+czOxwoKTgbZUlOYsXB6uj88t0sufH1k
         y9Hg==
X-Gm-Message-State: AOAM531sZy9F810GqFHSa5gZDXjhrLW/SCrGy8m3ivdIjfYWuiror6Lv
        LljcD4es4xo4XOUI5PXOWrs=
X-Google-Smtp-Source: ABdhPJyB7LZzQ4ZalpJwC5j8gAZKvj/u2pHPmXKqo08qaWWU3KgR9eUe1C8fj1IiD8Ly+lrOzxMZYQ==
X-Received: by 2002:a0c:d981:: with SMTP id y1mr24099027qvj.124.1597840425603;
        Wed, 19 Aug 2020 05:33:45 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:4fb::1000])
        by smtp.gmail.com with ESMTPSA id t8sm27625889qtc.50.2020.08.19.05.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 05:33:44 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] spi: imx: Remove unneeded probe message
Date:   Wed, 19 Aug 2020 09:33:30 -0300
Message-Id: <20200819123330.22880-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no point in printing a plain "probed" message on successful probe.

Just remove it and make the kernel log a bit less noisy.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Rebase against current linux-next tree.

 drivers/spi/spi-imx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 96ef297760fc..197f60632072 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1710,8 +1710,6 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_runtime_pm_put;
 	}
 
-	dev_info(&pdev->dev, "probed\n");
-
 	pm_runtime_mark_last_busy(spi_imx->dev);
 	pm_runtime_put_autosuspend(spi_imx->dev);
 
-- 
2.17.1


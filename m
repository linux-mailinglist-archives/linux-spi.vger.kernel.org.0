Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D317D1EB53F
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 07:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgFBF0L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 01:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFBF0K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 01:26:10 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C208AC061A0E;
        Mon,  1 Jun 2020 22:26:09 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d7so9546375ioq.5;
        Mon, 01 Jun 2020 22:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eLZuld5pvjUjHTyC9j66F5S+wq2+0vGChjS9TT4ZwMo=;
        b=EMv27LpMIUtFKLVi6M3Rxvn6I4xQRfZl4upqBVY+UXu+dtv4EEGPR0VL7Nk2OqskKy
         phBh+CZXrsqf+kuoTNTp6O41xH+DCyZiDYShq3CCGfKhKs7okGBtMBxpO1JRBCDViUjP
         aGDUHpExpZ2wgQAu8R7E20+tnbYuuKRBGSRM3E2KRDhSfg+UJfXea1TQd3P+7HtbTLKv
         xcsGeDcXljCkBZhjwOP7FhsdVMOF7c0OzDCKysCQ70B/ZyI9gHQ+9hm3PWzKYsyFpVWw
         DNy2vxXCtZ0ZwLwJxY1TYK38OeBn9esfEauXCpWfW2JJKpuahQzHgIJa7iZ81ZzG/Wfl
         m8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eLZuld5pvjUjHTyC9j66F5S+wq2+0vGChjS9TT4ZwMo=;
        b=Ay7fMCzockYfOJnqOp6pRUmTAsjboo1Is9Z7ITYheIIZNTmPGTPgoTinPh5BP3uDNi
         RXXyVGE2UtpdU9XCdR3FIUvMQfosL1zBJkXZ41c89Z7Q2qEQNB2seU3YESt/6VDAE54u
         kXzyrIWxT7x493pairB4q3db50aCUixE1URrei+I3Sr/CYhcsS9u9R4kHuQWErUtl9lo
         HBmgxAh81ZIUb2+ySbSJ1cLXfWGeLpqmQCrRx1w1pthj8Qeh6mK4bmcD9SPgBrd2mlDS
         3x5HO8Il173EahEKs6Di2UGFGD3TaS8hJMzx6fwLXSS9r9OmVN0jR/qSmqtzWxRsGRJe
         SkjQ==
X-Gm-Message-State: AOAM532nmUqKaHOEUwlqjgtmLtTc38ecBbcNJc6VxoLWchtHAWrcoHGV
        rLBVdnEgt4oZK1Z6kfKWHsg=
X-Google-Smtp-Source: ABdhPJwBOGEwnwn8n+mXhBsecMitZVSOH2/twetB8hNZ/aJD7OWvpM+OfsPFJ0CtrHtkLqNx+/+CkA==
X-Received: by 2002:a02:908b:: with SMTP id x11mr23046437jaf.41.1591075569100;
        Mon, 01 Jun 2020 22:26:09 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id d11sm647818iod.11.2020.06.01.22.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 22:26:08 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] spi: tegra20-slink: add missing pm_runtime_put
Date:   Tue,  2 Jun 2020 00:26:02 -0500
Message-Id: <20200602052602.91374-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Call to pm_runtime_get_sync increments counter even in case of
failure leading to incorrect ref count.
Call pm_runtime_put if pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/spi/spi-tegra20-slink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 7f4d932dade7..0675b36d647b 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1192,6 +1192,7 @@ static int tegra_slink_resume(struct device *dev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "pm runtime failed, e = %d\n", ret);
+		pm_runtime_put(dev);
 		return ret;
 	}
 	tegra_slink_writel(tspi, tspi->command_reg, SLINK_COMMAND);
-- 
2.17.1


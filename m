Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BE71EB4A4
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 06:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgFBEk6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 00:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFBEk6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 00:40:58 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CB2C061A0E;
        Mon,  1 Jun 2020 21:40:56 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d7so9467584ioq.5;
        Mon, 01 Jun 2020 21:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lgXeopS4rXAhOaW6ojxV14zwgm7+wVhyDRRur+u16mo=;
        b=LzfmUpAa5RQLblGpcefo25+/lbne+hqvfzKmVMT0MxkkTzzhaJh3sn5qn2XQ2/y9DP
         L77swLDMc3wtpHmmXNbO3xrfLP526qBENk8p5XbTpSf0hOvSgdcsrxZDiI4C/3faRyPy
         t/Y7zA8je7JLHbPra/M/dL0cWlBCiQIOMVUlJPaARDJ1T6kh5WjiORLaCIYk203sV/YM
         E9kbNzNiiz9wUHS/uEn0neecuwFXhTtEwZUOOHgQehJakeIc7ARGK6IYG2+kiqUky3Rv
         53cPkqUo3JZzVCNVwAY8L+naiB9rDXw+SOlb3CuaqWIFH78M76JUpgDfA4XN9ap5kQKt
         JHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lgXeopS4rXAhOaW6ojxV14zwgm7+wVhyDRRur+u16mo=;
        b=sMPxwL8QEZhoeqzASQN2kIdOAqvjILVAxoJ8Hq4kn3Vhex4xMAcwxSlHs/gLJ3GNaJ
         1m/OEMaoa2gntAhn3zjFucc33HjzYP2o9dndi2Sq46SbcHH/20/KNphj93W7NEnEGCKb
         EhpU4lrkzfcyO6VtzwJ2G4X0gRCQ1rYyg5Z/U4l4zpZjWd6XFOUMbPwO2PZkPcNB4/hM
         26sKqSKQNv6KthSC7BSdI2al1ps2CKpEwnd9ojJkS1wp/n5EewDpTzxYBsjPCxytWXzI
         uT52MC0njPGrOx+ba7eigZLP2R/uC/TH5SPyR64b/2Y+eno9ieGOZF/WOLyYKa/1oIRO
         i4NQ==
X-Gm-Message-State: AOAM5337F5xESJ9I2gYFiCABB+/KJQUjDIyX46ztUpQs8ToARTcdZte0
        3vCXXoISUQ34YZwpsWNP3h5WIQi4flWe1A==
X-Google-Smtp-Source: ABdhPJx9gqtedMNOQIz2FZKyCCeg/Z12Y42fQViRruIdOa6l1yDiABgPGmf59KzIikWDf+ZLfQW81g==
X-Received: by 2002:a02:23c1:: with SMTP id u184mr22804511jau.11.1591072855938;
        Mon, 01 Jun 2020 21:40:55 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id t18sm887267ili.24.2020.06.01.21.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:40:55 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] spi: tegra20-sflash: call pm_runtime_put in case of pm_runtime_get failure
Date:   Mon,  1 Jun 2020 23:40:49 -0500
Message-Id: <20200602044049.17378-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The counter is incremented via pm_runtime_get even in failure case.
To correct the counter call pm_runtime_put in case of failure, too.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/spi/spi-tegra20-sflash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 514429379206..33c34f9c2021 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -552,6 +552,7 @@ static int tegra_sflash_resume(struct device *dev)
 
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
+		pm_runtime_put(dev);
 		dev_err(dev, "pm runtime failed, e = %d\n", ret);
 		return ret;
 	}
-- 
2.17.1


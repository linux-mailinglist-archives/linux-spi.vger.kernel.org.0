Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBD332CB15
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 04:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhCDDol (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 22:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbhCDDoY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Mar 2021 22:44:24 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A091CC0613E6
        for <linux-spi@vger.kernel.org>; Wed,  3 Mar 2021 19:42:29 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id c19so5660944pjq.3
        for <linux-spi@vger.kernel.org>; Wed, 03 Mar 2021 19:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5evIgUHLH3iE2TL4J3188f+WN89LXupcPiWpSn3upRg=;
        b=krHS8jj2QXNypospcYRERtT0+swfUgztdkYoHNFA4VXLWuLUzq1MJ2lTyCbONQ9lm3
         SW3+pEdHNibO6/v+AT+N1GXAJ3vlyfPvJBuznRg8PgvdmrSRvXHM1bbvOrgxmVS5NFTB
         fsk65ZMoYfpHFyxr+mc6JuuJoVsUtoeBzr4GpksP3Esx/CZGRBiGwBID782USqdyJ15n
         SqDOhFLlS4h7sR6YIdE+UcuCjTzzbET6pA1nFw+OzZp8yejsYPff5nNC4DloJ5AXxa9+
         SyP2ksaKSvomzTQB22fRNsD3Qqy3qjWN90i7tG0rDH1dBA9CYj4+3a1nAU5Z5VRw5NV4
         4SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5evIgUHLH3iE2TL4J3188f+WN89LXupcPiWpSn3upRg=;
        b=ElB7F8W/52SqiZE6HUv5FhTaEQpl+VHQxHE9y8LtDBkTv14NAKx73AlC6IU7rZwHg/
         9K89qywPINmBngkrlygAyDW2R+LvH3qhAlvm39Yjox4wP9ECBiPHfQpoK8k5VVoaT6sb
         /XLuqVaB7Ws3qqBKNsWwhry1D2lsCiBG4/gUTS9ebuPXcPuppefE73vSkK440xl4+w0+
         FIcXgH/w7sl0XZHD0MycExO7CF4VW+hDkJIu0D0YwoFU/CPj83Ghtdc9VrXtP/hw8Qma
         s+QXvp5QjX95Lz8sUaljSVZSo6fQ6cCS6e886WErCHmc4kNS4/pBTiSGwnyu+CMLnzeY
         KAhA==
X-Gm-Message-State: AOAM533yBpq996igD8Jq9sO4PP0lAMMuxwUXC8Ftzy2d6JC7nlpQwVKZ
        /4fChir7XajjCRIEKk3KS4v7dw==
X-Google-Smtp-Source: ABdhPJyE5bFbeBfYEWSJ+gwpOI0+z1XD9msbhoODqnXnZy8LX7goajm/FKghGMdptdJQWuIweGqeRA==
X-Received: by 2002:a17:903:2491:b029:e4:16d6:e0a4 with SMTP id p17-20020a1709032491b02900e416d6e0a4mr2197194plw.64.1614829349158;
        Wed, 03 Mar 2021 19:42:29 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id h17sm2403989pfc.211.2021.03.03.19.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:42:28 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] spidev: Add Pensando CPLD compatible
Date:   Wed,  3 Mar 2021 19:41:37 -0800
Message-Id: <20210304034141.7062-5-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304034141.7062-1-brad@pensando.io>
References: <20210304034141.7062-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Pensando Elba SoC platforms have a SPI connected CPLD
for platform management.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 8cb4d923aeaa..8b285852ce82 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -683,6 +683,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "dh,dhcom-board" },
 	{ .compatible = "menlo,m53cpld" },
 	{ .compatible = "cisco,spi-petra" },
+	{ .compatible = "pensando,cpld" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.17.1


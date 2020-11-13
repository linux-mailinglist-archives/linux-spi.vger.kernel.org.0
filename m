Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E428D2B2350
	for <lists+linux-spi@lfdr.de>; Fri, 13 Nov 2020 19:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgKMSHW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Nov 2020 13:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMSHV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Nov 2020 13:07:21 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BAFC0613D1;
        Fri, 13 Nov 2020 10:07:21 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 7so7328625qtp.1;
        Fri, 13 Nov 2020 10:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UiYli1Q+z8sZkBWqV/LnEwc0aoY7+hNwPEu1PnwhqqE=;
        b=ka4ckJ4pD2erS7Nx9bYqwNF/ixcY2zKY6/yiCKe3NWQG84LfxCxkMcFzBaqOsnwvjm
         imOfeSvTt3/VPD6AdlldSyo+eyzGjjoYdd3mUZXhQaH+ZnN8IDHkyZKovi9yqO56sTW9
         xqRAL+K96hnvku1lJBKV1HF17IC1bOz7t44BBmcBgx9P22CsTPRHQme59xTYZuZi/+za
         PxaeAGoeXbfqT7JkkhROKIeIO8retUaFiJ8WNA2FACH1OO/daAbzr33irYD9pCJlNeum
         UDRk63EkweNs1tINJqdJUtP68YK+HhLsPgQqYrtlRqnbcsnWXtw4uKeSNCWyGRHR3gxg
         y9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UiYli1Q+z8sZkBWqV/LnEwc0aoY7+hNwPEu1PnwhqqE=;
        b=ePKo+zg9Q4/oFmy7sZ1LExhBNqmD2Io1uke1ywyt1HBKpnVLxzSk+KNa9Awu1KqKWX
         r3vn/sZDRSfbD3oHvznJ8tPEw5OSmLvEEjpEsNTCEYkQQgnGqfppdbKqroPEqck7ULYB
         HPRfY5ZabNrh1jI4UszhfVB3wGUU2Frux7MFW+9WO6hSxqk34nM5eCizDOfGBIjFacIi
         +zrVir197UXsWRpb3HxuZZfJbEE2J+9jXenHqKvqHIQP12wqeQsOtdlTr4HtshFeULVO
         ++hQ/FP///eVeXtxEWUqMZugOyWEbSNB5hFHcBGBVgZJrt9VrV+HUCcO7JcDcHVcUzcF
         XCzA==
X-Gm-Message-State: AOAM530JFnT/lYIwdHuGv55TwdZGL7lM+5+NnYAg1AqE9NbEAGc9Q9wx
        qlGyNLGCB/3J1HqhbYR96yE=
X-Google-Smtp-Source: ABdhPJxM9fT1NPhHe9V0A+4eHxiSUPy0vPs02C2qBNpvQPfC/Ck8b6cVIztEujDySlcbSa6hnFlw/Q==
X-Received: by 2002:ac8:7189:: with SMTP id w9mr3133068qto.288.1605290840747;
        Fri, 13 Nov 2020 10:07:20 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id q11sm6932398qtp.47.2020.11.13.10.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 10:07:19 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lukas Wunner <lukas@wunner.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] spi: bcm2835aux: Restore err assignment in bcm2835aux_spi_probe
Date:   Fri, 13 Nov 2020 11:07:02 -0700
Message-Id: <20201113180701.455541-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Clang warns:

drivers/spi/spi-bcm2835aux.c:532:50: warning: variable 'err' is
uninitialized when used here [-Wuninitialized]
                dev_err(&pdev->dev, "could not get clk: %d\n", err);
                                                               ^~~
./include/linux/dev_printk.h:112:32: note: expanded from macro 'dev_err'
        _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                      ^~~~~~~~~~~
drivers/spi/spi-bcm2835aux.c:495:9: note: initialize the variable 'err'
to silence this warning
        int err;
               ^
                = 0
1 warning generated.

Restore the assignment so that the error value can be used in the
dev_err statement and there is no uninitialized memory being leaked.

Fixes: e13ee6cc4781 ("spi: bcm2835aux: Fix use-after-free on unbind")
Link: https://github.com/ClangBuiltLinux/linux/issues/1199
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/spi/spi-bcm2835aux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index fd58547110e6..1a26865c42f8 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -529,8 +529,9 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 
 	bs->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(bs->clk)) {
+		err = PTR_ERR(bs->clk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", err);
-		return PTR_ERR(bs->clk);
+		return err;
 	}
 
 	bs->irq = platform_get_irq(pdev, 0);

base-commit: c371dcf51cef4ae53d00090a148d004b113217f0
-- 
2.29.2


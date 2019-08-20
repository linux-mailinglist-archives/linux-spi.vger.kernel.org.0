Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E3395FA6
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfHTNOd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 09:14:33 -0400
Received: from mail-ed1-f97.google.com ([209.85.208.97]:36945 "EHLO
        mail-ed1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729968AbfHTNO3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 09:14:29 -0400
Received: by mail-ed1-f97.google.com with SMTP id f22so6269569edt.4
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 06:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=Jvs/5Gee1kn4JJmTEB9HM25N3Obz/vQVwFpMESoM06k=;
        b=KDm8y8J0guSg8fe8WAj1NFbKTFa5X+Nz4epi+7CjCItcbjBidO3E9BYU8AnBMNe1Cx
         XZxwb8eYcvfKACWmsy18U4pundeLTd+OjK4HdNPl221NwJyx0zc4aJaXg+1Q2AfLpoCK
         LOYeBkjEetcNByVIktb7EIIfLGzc3tUXgF1rVQOpl6syAwEt9Kq4+HKFHWa9EiTOU0VY
         WY4evElbqEVu6xgY+IofFXKdQKGbRSwzkhDlIWwL8+2mxbCFEKxiJzmA4vDovL8X28G2
         MDbUEzzV8CEM9xfRP2Wbq+6qP9g2pwthgWBJZtRQgiAD82Fqe0L38FpK1RJb3g0uP0E1
         ZTwQ==
X-Gm-Message-State: APjAAAWhPs2onVgRbPMmE09YXRwsyicKYnd/EM3JAaOJmWR+Gco63BlZ
        Yd9AD26iVRm8+aHny8hjFGTiwRaR7NqRK/1BF1sQa3WEdnIRQIrnbQNfqN+S/2T0WQ==
X-Google-Smtp-Source: APXvYqz6SX0fWFvUnVQDlsSPm5HA0r967nYYNe6jseMyH41gjZAUVlwAXfOgsA0EI+8yYHQOqcVZg/JaBPJN
X-Received: by 2002:aa7:c897:: with SMTP id p23mr30319194eds.220.1566306867764;
        Tue, 20 Aug 2019 06:14:27 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id g20sm78692ejm.35.2019.08.20.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:14:27 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03xz-0002Lr-CL; Tue, 20 Aug 2019 13:14:27 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D5ACA2742ABD; Tue, 20 Aug 2019 14:14:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Remove pointless assignment of master->transfer to NULL" to the spi tree
In-Reply-To: <20190818180115.31114-9-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820131426.D5ACA2742ABD@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 14:14:26 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Remove pointless assignment of master->transfer to NULL

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From bee44359169ecf293a0bd2351ada186a0864a94a Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 18 Aug 2019 21:01:09 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Remove pointless assignment of
 master->transfer to NULL

Introduced in commit 9298bc727385 ("spi: spi-fsl-dspi: Remove
spi-bitbang") for less than obvious reasons, this assignment is
confusing and serves no purpose.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190818180115.31114-9-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c5d99f4d5e3d..753584c4065c 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1006,7 +1006,6 @@ static int dspi_probe(struct platform_device *pdev)
 	dspi->pdev = pdev;
 	dspi->master = master;
 
-	master->transfer = NULL;
 	master->setup = dspi_setup;
 	master->transfer_one_message = dspi_transfer_one_message;
 	master->dev.of_node = pdev->dev.of_node;
-- 
2.20.1


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A61595F9F
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfHTNOa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 09:14:30 -0400
Received: from mail-ed1-f100.google.com ([209.85.208.100]:38280 "EHLO
        mail-ed1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729970AbfHTNOa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 09:14:30 -0400
Received: by mail-ed1-f100.google.com with SMTP id r12so6274810edo.5
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 06:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=kZN1xGhe7NRh5ocVdefS5+GR42RBFAUM2s+vxBnEibM=;
        b=HBpdZixp5uq8BoqqErRqXGlH835F5TCP+jPnZjxBl2BbDJBL8EuRot8yJEUtVwFArm
         Vzl8GQD/Jx4vwkKWQCSqb5UFyL0wFpgLI9M8cA0zkwXoS15E3CONhlltLOlO3ziaZeA0
         wLq4COfppeNaIlN0/9yiwsiLuhbLCF33Ysp98gUevXse6YKk0S37WlgXbNdbnfZvhloS
         hHn6i23fD11taLHTkLV1Aqa5UyEurI2aOyKbo/yDPODsVE/dKKrFbnVl7HEyxR9SKQwj
         N9nKV2IrajohpGFWK8k6Bqamz9KsYR7mM4dG7xhbjcQWAbmWiXOPo6YBnQ/DjEIrhuF2
         h35g==
X-Gm-Message-State: APjAAAVVaD2VjZIyrOZ8euxeC4CVO1bLihr6Gwhk5jb8wk3Rc+AADF2/
        ykmq7O0f1izDZEHPNAj3B7sydvkg/Nv0mb/ZMVoqwGHxOy+WlhuOqZaOPjC411Iy/w==
X-Google-Smtp-Source: APXvYqxwhg/wMr94TT9htLzvpBKClDRroAuXmumW9TaewpGSV0PrmW2xiI6MPRcwczeb2NHnOZX/tDHldEks
X-Received: by 2002:aa7:c5ca:: with SMTP id h10mr31221928eds.48.1566306867812;
        Tue, 20 Aug 2019 06:14:27 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id l18sm23184edw.10.2019.08.20.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:14:27 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03xz-0002Lx-HW; Tue, 20 Aug 2019 13:14:27 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0E7C4274314C; Tue, 20 Aug 2019 14:14:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Remove unused initialization of 'ret' in dspi_probe" to the spi tree
In-Reply-To: <20190818180115.31114-8-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820131427.0E7C4274314C@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 14:14:27 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Remove unused initialization of 'ret' in dspi_probe

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

From 9b536d3647ee1348860657c239d247364e4374ec Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 18 Aug 2019 21:01:08 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Remove unused initialization of 'ret' in
 dspi_probe

There is no code path for reaching 'return ret;' without it first being
assigned to an error code. Therefore the initialization with 0 is
pointless.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190818180115.31114-8-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c07525a9fd34..c5d99f4d5e3d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -996,7 +996,7 @@ static int dspi_probe(struct platform_device *pdev)
 	const struct regmap_config *regmap_config;
 	void __iomem *base;
 	struct fsl_dspi_platform_data *pdata;
-	int ret = 0, cs_num, bus_num;
+	int ret, cs_num, bus_num;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
 	if (!master)
-- 
2.20.1


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264FB392BA2
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 12:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbhE0KWv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 May 2021 06:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbhE0KWu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 May 2021 06:22:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AFCC061574;
        Thu, 27 May 2021 03:21:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v13-20020a17090abb8db029015f9f7d7290so5224926pjr.0;
        Thu, 27 May 2021 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M9vjB2pQJwpAIYbq+Dq4Bd8NFKd209BgSoVio/gkh5Q=;
        b=U1aPrbrXYsfBQ5AMy7Pyq2dLOhOEElyFR5vP/1SAcUJppXtBkdX12LnwNXArNAvwdj
         /iwiIKZC7Lx5RfZNYoF5o7Kuz2FSVsz+mGvx/Z1WFtG2WSjjslDpfYRv2sLUjDGmZWg2
         y17Ka7kru1ShEkvWEkg6KhCjQy4F3uPYneaqliX0IjJLtGgscW3TrQdv8o/INys55NIH
         RE3M8iYitG3Lt9dZu46w8fkppZ6m16FykrL7LqaBgbkzmQL4ZriIXSY8DnRFuKzJHPyj
         GXPmIpjq7yN49iNBQNNuueSZrrn4jVtDY2XHtekhZrIfwaYiAhyDWAjwZ1gqSBLJ70bL
         S0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M9vjB2pQJwpAIYbq+Dq4Bd8NFKd209BgSoVio/gkh5Q=;
        b=cdsdhd0OijATSVR07NpCn+nmCq+w4UOqbFwVoQfByU4KKCNkCmD9MyERAVwA8AWsER
         eonhxRupNPhrOXFZT65CBzsRd6S1lyv/Iq6hCbVVyJbU6WE8PZgOSSiYxihnyEhzrWWf
         x2ecTINnyim+b6nnsz9htuFOUyi7nvGv1X9nAGEtQ9Ie44nysB0dTrIJ9ZAh/lyT3n2L
         LIfnSLISJa64VRpnKq+tNksKox1Y7NsVRkUhImx7UMgoetYYDQqzfY9n2YuGknPdGmQr
         3emff9CNbwkwg+KpDZqpYM2xpiGQb2RYtamsqi6lgFGYyxoSgEhjR6hVsuQclxF3cE+Z
         EM9A==
X-Gm-Message-State: AOAM531MH2qRDIhLc9LQJchGHlViT5JTrwidBJSrVyXUGN935itZvHTs
        qBWZDjuzHdVhDqZXvoSx6uE=
X-Google-Smtp-Source: ABdhPJwo6uAZzIJYKnrRee/oae2aKfU0LEq3jXIL3+2GAMuVbDpAUtzDAZXtgXLoowqraNwEszsZ1A==
X-Received: by 2002:a17:90a:9105:: with SMTP id k5mr2994174pjo.48.1622110876010;
        Thu, 27 May 2021 03:21:16 -0700 (PDT)
Received: from localhost.members.linode.com ([2400:8902::f03c:92ff:fe55:8c1e])
        by smtp.gmail.com with ESMTPSA id 15sm1659315pjt.17.2021.05.27.03.21.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 03:21:15 -0700 (PDT)
From:   zpershuai <zpershuai@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     zpershuai <zpershuai@gmail.com>
Subject: [PATCH] spi: spi-zynq-qspi: Fix some wrong goto jumps & missing error code
Date:   Thu, 27 May 2021 18:20:57 +0800
Message-Id: <1622110857-21812-1-git-send-email-zpershuai@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In zynq_qspi_probe function, when enable the device clock is done,
the return of all the functions should goto the clk_dis_all label.

If num_cs is not right then this should return a negative error
code but currently it returns success.

Signed-off-by: zpershuai <zpershuai@gmail.com>
---
 drivers/spi/spi-zynq-qspi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 5a3d81c31d04..9262c6418463 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -678,14 +678,14 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
-		goto remove_master;
+		goto clk_dis_all;
 	}
 	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynq_qspi_irq,
 			       0, pdev->name, xqspi);
 	if (ret != 0) {
 		ret = -ENXIO;
 		dev_err(&pdev->dev, "request_irq failed\n");
-		goto remove_master;
+		goto clk_dis_all;
 	}
 
 	ret = of_property_read_u32(np, "num-cs",
@@ -693,8 +693,9 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		ctlr->num_chipselect = 1;
 	} else if (num_cs > ZYNQ_QSPI_MAX_NUM_CS) {
+		ret = -EINVAL;
 		dev_err(&pdev->dev, "only 2 chip selects are available\n");
-		goto remove_master;
+		goto clk_dis_all;
 	} else {
 		ctlr->num_chipselect = num_cs;
 	}
-- 
2.17.1


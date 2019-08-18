Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B54915FA
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 11:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfHRJv2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 05:51:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36376 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRJv2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 05:51:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id w2so5435264pfi.3
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fPFwCZoR+0RfxABah+OM05It7kpLvC0foG3il7KX154=;
        b=Zj7X6NrLuEUJqmZRqJ5jLUufow80BiJ4nT/gAmJ32eCfAj4hrkYoA7VfdC7+9hNWkA
         gLGdnC8bU5FErbKMKjvLer9grsQYgcFpKMwvOO6qWsQpxgjvopot4QYNDZ8LXEViMWBs
         foPKXvDqTTXOul+cohKI9Il5Vr0ExIk34v/Zn0+X/+7kP1AWh2QxkdIvttb5FW0XFqz9
         1n6oyWkrT5yTvEIRqM9By42Ndmr9J311fw7auUizjKAuTunSIDSfkax2wpldoAM/LuQg
         dhdeVqD0zJ+HZ13ndw/7bcpWcX4HfrWaOHsFOmYLF9h+9U3s8exeC7HvMnTcUOsbKS45
         lC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fPFwCZoR+0RfxABah+OM05It7kpLvC0foG3il7KX154=;
        b=txpqaU7knbCyOafdCp7Qgsu5AYEQyJLCpx5i9g23Hq4d2Q3igN068tgNmfRWC/jF5H
         ZbIHjB159ViCn9a3Lh7AeXhmlVmSk76sr87KFlw8KkCxMpUTKuoQ1gZreWNUPt+voyph
         1WEmYv4LQPyKLR9aYXBR5pUvunI7fNgbjPRaPKpKb8PKVn5m4y+KNOC2vEnxMUfgD+Ro
         F8myXDx5PKFGUvPiOax3k4pYUccpt1yjVdkbm5cgm2NPhwQ6pt+6uqpyPYJAwBKcMkFx
         mB/m4pZJWmr/0GpUPHBKW0EUIAa/iDQvpZ03tNxMOFSKkdwuSlV9MIYMptumZySJlUEN
         XN7g==
X-Gm-Message-State: APjAAAWgl78r+cNCwIYgM7r4ZOMkLirjUTBDTLgRcBuXbZjE+GFKkm5y
        ADvoAdykNp89vqZhQONQPErgxw==
X-Google-Smtp-Source: APXvYqyCBVPN67Etp2d4Z4UMUzanossGvxZde/BprjcHVcrqXWrltSRca87GAVuKDet9K5vh+P84EQ==
X-Received: by 2002:a63:4522:: with SMTP id s34mr15011368pga.362.1566121887112;
        Sun, 18 Aug 2019 02:51:27 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id v145sm13203521pfc.31.2019.08.18.02.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 02:51:26 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] spi: zynq-qspi: Fix missing spi_unregister_controller when unload module
Date:   Sun, 18 Aug 2019 17:51:13 +0800
Message-Id: <20190818095113.2397-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use devm_spi_register_controller to fix missing spi_unregister_controller
when unload module.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/spi/spi-zynq-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 3155e2cabb1e..4a5326ccf65a 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -694,7 +694,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	ctlr->setup = zynq_qspi_setup_op;
 	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
 	ctlr->dev.of_node = np;
-	ret = spi_register_controller(ctlr);
+	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_master failed\n");
 		goto clk_dis_all;
-- 
2.20.1


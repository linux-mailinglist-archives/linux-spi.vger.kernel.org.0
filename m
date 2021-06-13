Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A163A56B1
	for <lists+linux-spi@lfdr.de>; Sun, 13 Jun 2021 07:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhFMFcj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 13 Jun 2021 01:32:39 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:45895 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFMFci (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 13 Jun 2021 01:32:38 -0400
Received: by mail-pg1-f180.google.com with SMTP id q15so5961721pgg.12;
        Sat, 12 Jun 2021 22:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e9wgkbzyfzIDSr2mxBQKx6UIoHjiY2DxbVr5qjZ/ndQ=;
        b=vHJYnC5k2pNMcAka9+8PsEV+JyHpNrO1Q+mca4ikgwPyM7J8kx4lxeRPtqW9GZpK3Q
         whTSpSpNpB8Pk4/Gvp/A0pGwknW5N6z4PX4GwTt35nMnkbpbWJcqASxvvOV3LqelFXwX
         Yv4prjK1qW0UN21MJtRc1mV7KNYDfeK631XncDCWQKxz1GCQD2W5HS00NqV85nG2Lj/p
         twILRHztLdECx9SFbU1OZM+DLe37FoOKBW6qJKPe10t34PakAGF546XTAWkn5mb6T3DC
         gFz5/R3sIR2MaHwdxwJeoQRYChFeQkayEvgXePxTQcb/INfK9byZ+O3u/JqE2GXRNFbP
         1HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e9wgkbzyfzIDSr2mxBQKx6UIoHjiY2DxbVr5qjZ/ndQ=;
        b=PjEIb3QczHUQ28PIVvcpOcY9idl8FM/BHDFvrmxeNRDY9CHmPITEwZrHHl6jzfranJ
         0Ql5f4hq79tQODvjnEvYYD//P1kaZEkc0PWu6PqYtmskp6XVPgtnByScSfzSZW7h4HD0
         EvC20AEg5h1kdE51E8/aVye6HDIrzQ6sF3iezWm6DnaAgW5ckwQ1qgGBEGGvArJ+LzCB
         kTnUhr9Fbqu2Kr8DOooMMMqyoE/PUNzYR0Ioij8xFKS3E24lzxlyGnva2UMIV6fn/0MW
         vwD5hXz7vQU+UzFF7/HhcPDQ9yiFfikTDpk2TEkoPAOIGhGqa76Ue+0aZoBtcpgvh9Bk
         ad1A==
X-Gm-Message-State: AOAM531dKT30V7vfsEwMuV/OsNV+OUAknV5PMbegrsJoIsLhx0oTv7dc
        Z53DWWSFedFS/VplJVh4/io=
X-Google-Smtp-Source: ABdhPJwa1Ill6bdxHT7ix4aev3b0DeJ4kB2NxTJRs3GR1xv0JqLnWXqYaOVRXpUeqq3RSx2rpNMaxw==
X-Received: by 2002:a62:8491:0:b029:2e9:c618:fa32 with SMTP id k139-20020a6284910000b02902e9c618fa32mr15861684pfd.15.1623562178265;
        Sat, 12 Jun 2021 22:29:38 -0700 (PDT)
Received: from localhost.members.linode.com ([2400:8902::f03c:92ff:fe55:8c1e])
        by smtp.gmail.com with ESMTPSA id a9sm8810533pfo.69.2021.06.12.22.29.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jun 2021 22:29:37 -0700 (PDT)
From:   zpershuai <zpershuai@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     zpershuai <zpershuai@gmail.com>
Subject: [PATCH v2 2/2] spi: meson-spicc: fix a wrong goto jump for avoiding memory leak.
Date:   Sun, 13 Jun 2021 13:29:32 +0800
Message-Id: <1623562172-22056-1-git-send-email-zpershuai@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In meson_spifc_probe function, when enable the device pclk clock is
error, it should use clk_disable_unprepare to release the core clock.

Signed-off-by: zpershuai <zpershuai@gmail.com>
---
 drivers/spi/spi-meson-spicc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index d675334..b2c4621 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -725,7 +725,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(spicc->pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "pclk clock enable failed\n");
-		goto out_master;
+		goto out_core_clk;
 	}
 
 	device_reset_optional(&pdev->dev);
@@ -764,9 +764,11 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	return 0;
 
 out_clk:
-	clk_disable_unprepare(spicc->core);
 	clk_disable_unprepare(spicc->pclk);
 
+out_core_clk:
+	clk_disable_unprepare(spicc->core);
+
 out_master:
 	spi_master_put(master);
 
-- 
2.7.4


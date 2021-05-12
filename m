Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC637B954
	for <lists+linux-spi@lfdr.de>; Wed, 12 May 2021 11:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhELJgz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 May 2021 05:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhELJgy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 May 2021 05:36:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE95C061574;
        Wed, 12 May 2021 02:35:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g24so13214699pji.4;
        Wed, 12 May 2021 02:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+DNGDumTIkNC+0BsMICVPR49/upzOcBt01+SOrhLdME=;
        b=DlPfjNTz1AUpI7H0Ekkta2lKCbbanPuAqM3KDZ7wGxEJJ9nFp6idx/o9CKDzPjkI6A
         e3pZyoeauaU9PDch8uLFQY5Mne96rsWiULfiIxehFZIcPpURL4DydX15wRTzuwjpJwdn
         USlxq58JPKSnI7m1foZLHyh+IKimYoQttxiWK5U/MGHI/yAUtwXS4FK+rvlAqdNL7lSq
         KSv6kIWfVb6P2MxemaV+LMpJ4fveOjrmWn/SqiA+CEox5k1xcT+jq1MuFOpjx3nmb0Hs
         Qm0ljr+b6MA8nHZq7+YWbHsZk7QH4ha3LECgsmU1L1jcqy0oJXPEk9DaADO+yrpmTbRj
         1Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+DNGDumTIkNC+0BsMICVPR49/upzOcBt01+SOrhLdME=;
        b=hnCldp/P2ju/zONpPKCcOZ30eAkKi87HMpb3FrbLWXayQo/deXm9qgyn/6yOy5wTj9
         /08/wMt9GB7JeNlhwJ4kN90RtGjO4ytqD7J8AqIROJxShhdVfwJO6CO7H864d2gvq+HZ
         Pwr2tJhqCCyKRUgfSE5FNoKvfIoc4L82A7fDvlZBeZUEeCXu5HDF6CszH8khjib/3ZTQ
         LeanogEXMUChR5ePxs2WV+7jUshnePYPvUXbfBAbPkBU2WhAVX36gSwGOVNtvbCkqYMA
         fMDQRDB/clDJRQnvhBseFw04SDOd2pWFn8m5a+R4yZV6X7EVCLHKztKIeoyJQZcj84sR
         DIAA==
X-Gm-Message-State: AOAM5320qNNwgEd9v7Wvb5h8LX9TFF4VWqvvirg/G+2fGWPgpqcUqtml
        5EVXL77l8zo6yhTSaZoOAFw=
X-Google-Smtp-Source: ABdhPJwr3Rds4nAEyDvnvtjwkn3mI78LQe0RYr6Sd+KwArIHHCc3193bZ4zqJ41BOzUybjI9mRNuVg==
X-Received: by 2002:a17:90a:1389:: with SMTP id i9mr36221660pja.232.1620812145711;
        Wed, 12 May 2021 02:35:45 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id p1sm15051048pfp.137.2021.05.12.02.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 02:35:45 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] spi: sprd: Add missing MODULE_DEVICE_TABLE
Date:   Wed, 12 May 2021 17:35:34 +0800
Message-Id: <20210512093534.243040-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

MODULE_DEVICE_TABLE is used to extract the device information out of the
driver and builds a table when being compiled. If using this macro,
kernel can find the driver if available when the device is plugged in,
and then loads that driver and initializes the device.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/spi/spi-sprd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index b41a75749b49..28e70db9bbba 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -1068,6 +1068,7 @@ static const struct of_device_id sprd_spi_of_match[] = {
 	{ .compatible = "sprd,sc9860-spi", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, sprd_spi_of_match);
 
 static struct platform_driver sprd_spi_driver = {
 	.driver = {
-- 
2.25.1


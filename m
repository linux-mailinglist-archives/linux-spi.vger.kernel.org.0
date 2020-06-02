Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A2A1EB570
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 07:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgFBFq1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 01:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgFBFq1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 01:46:27 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31D1C061A0E;
        Mon,  1 Jun 2020 22:46:26 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p20so9492067iop.11;
        Mon, 01 Jun 2020 22:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lutq7pfNwoE3dFJvq2H2xCXJlg/5j6WZ5IvheFzWD5Y=;
        b=HHHp+KOGpluSJ4ldGS2XV9PQZ4jwGXeWWCdKIz84HiDM3IRbuzQS2hbQRmu8BS7bnV
         DBunZ62iOoHCrgkkdjWdUedx1KpR1SEQ+2O7dvOyhPXuiJ9AaEabM+K2HuV/++qH3zgW
         W1t9GqJs+l4OD/KVfcOlII/Wzs/wSDXpV6C444V6aWs0+3v7MJcpXXttvMFS+OdDYq6D
         JrpWC/veejjHfUwPgV5yCDvLuMG5DXMXIwg+PADruBTUv78dyTO5njBy99dgs0+J3aXM
         5KzYPcZO0mbIRp7RuBtbT/7ZJGQw0q34LslDiuchvE8WZad3cnHA0HafIB6PUO22iXhZ
         pOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lutq7pfNwoE3dFJvq2H2xCXJlg/5j6WZ5IvheFzWD5Y=;
        b=DiPu37QFKfAQV4Xl5ijjfXmutEywYQd0sLiXVUr5XWX+XO+MvI6beppxXtlaPDT3/u
         wDld4v2cYSXKsJ/nveWFXJ2o/RQFbdDSuxLl6YCygcnyfMsEpiPcv4d92Hdg+5HgESn3
         fUDpJPzM4swllwvVSIh0WlyHpHf8QiHF4kYfynIJIv/Dn3BJ+sgXBRgbg2sTWMWWWCxw
         pCPoJMjS48iby4RtzgIDpuAXAHzf1JaYEUZcnt6gGAV6gVxCHfzrJJChdrH8WS3h4xDH
         XYS8sstHLBraHK7JPZYr5rrJuN9VuyeRBq8PlMkuMPrW9jhmQTZuFA9o7BRDHrtJiEAD
         SYtQ==
X-Gm-Message-State: AOAM53174vFZmpaE3r6c7eXf0WyzS4ZHn2lh7ROps+pbEr9D+KTJlht/
        04feEfd5UPQ8Nx96Sq5GlJQ=
X-Google-Smtp-Source: ABdhPJywelZne4Hp0ikvocBtxPokepjYb73VP2Gyh+hkTI3sSnVc/z7hrXdXVG9d3V7bCczxHVD4Wg==
X-Received: by 2002:a05:6638:512:: with SMTP id i18mr5988934jar.74.1591076786111;
        Mon, 01 Jun 2020 22:46:26 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id a17sm894947ild.31.2020.06.01.22.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 22:46:25 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] spi: img-spfi: add missing pm_runtime_pu
Date:   Tue,  2 Jun 2020 00:46:19 -0500
Message-Id: <20200602054619.4352-1-navid.emamdoost@gmail.com>
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
 drivers/spi/spi-img-spfi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 8543f5ed1099..c3d0452ac78a 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -785,8 +785,10 @@ static int img_spfi_resume(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret)
+	if (ret) {
+		pm_runtime_put(dev);
 		return ret;
+	}
 	spfi_reset(spfi);
 	pm_runtime_put(dev);
 
-- 
2.17.1


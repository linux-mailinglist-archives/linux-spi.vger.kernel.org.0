Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B714D1EB534
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 07:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgFBFY4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 01:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgFBFYL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 01:24:11 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBABC061A0E;
        Mon,  1 Jun 2020 22:24:11 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id d1so11671119ila.8;
        Mon, 01 Jun 2020 22:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0UBYZ9vT+P4liUXzHGb51XmUJt+xAS+zePK7rl2i4/E=;
        b=Jw8/Cj6lr48k/N35XU05hYas1NM3/oL3UmVQAI0rjwc5i2vb7FtJiRajUdSmuwrNpV
         /VvKabQH0H3WgtfokgAdrIf/17roHavjyLAeraCEziJ5FsjUh/ZlJ8yc3UdIo5KNR1LC
         fbqN6BoN4nBPXsqZnrzbL5JdfSHPMGV0HBC6qCNyn0x53uTBERcz7AtTktdFkwee9Ey8
         9nhiHzL3Ucw82UJeAXTwrGPDOiqCeCV/UbW17GwJIPHpTVlFxuHDYf6a/vFlwPed4yTK
         eSAYappQGlAYxHEdTjS6FB+83yoRYg/DfTuvLK2WTSep9fzmRipoLXGOe4Fm5VS3XLl7
         2rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0UBYZ9vT+P4liUXzHGb51XmUJt+xAS+zePK7rl2i4/E=;
        b=MC+ftsUWuD2SSYe0BXaBPtsruT3vUqRMMPwsGtuW85rHRnhzk++O9pq96c7Rf9R+29
         NmCIPnysSd3RUptgNc2DEUVbeay1AJRcJ4vsO4cQT+Q1EClCTEyUj2CJtG25LHkDu3kz
         rA/4y3vkZJTpNTgFb6x4+gAm4u3wAnXsO3TolpSNiUyt/GXcW8ItMJY8heR9pzbKjofY
         dHB/cVG0ykhiwcCcANNbwOXVRuN3jhTvB0TGwWtyw0KASLi7Z1Z2QvDaBLhukacdc0c0
         9ht4VWEJ/2kJQD8qkHBZdyZqeDGSVPyTIQZTEDqvqMYWeQ/D/aRErXjQbB7C31Y6flsK
         PTOA==
X-Gm-Message-State: AOAM530o7YVvMVfU4DLfClk3O008/yD8L47dcvmMu5T3zoa1bykwOvz9
        pi5TRwjitVjx2+K+9RXkBbs=
X-Google-Smtp-Source: ABdhPJy6nC6FkDM3WVT7AQFqv+ro6xBB/sJG4VAzoJKxEB61XIjczNyDwEifywEk3F2RfUrH8YBwyA==
X-Received: by 2002:a92:190:: with SMTP id 138mr16797887ilb.5.1591075451000;
        Mon, 01 Jun 2020 22:24:11 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id r17sm909656ilc.33.2020.06.01.22.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 22:24:10 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] spi: tegra20-slink: add missing pm_runtime_put if pm_runtime_get_sync fails
Date:   Tue,  2 Jun 2020 00:24:04 -0500
Message-Id: <20200602052404.81041-1-navid.emamdoost@gmail.com>
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
 drivers/spi/spi-tegra20-slink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 7f4d932dade7..9509b7cb14e4 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -756,6 +756,7 @@ static int tegra_slink_setup(struct spi_device *spi)
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
+		pm_runtime_put(tspi->dev);
 		return ret;
 	}
 
-- 
2.17.1


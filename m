Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3A0264F67
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgIJPf2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Sep 2020 11:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731309AbgIJPdt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Sep 2020 11:33:49 -0400
Received: from mail-oi1-x262.google.com (mail-oi1-x262.google.com [IPv6:2607:f8b0:4864:20::262])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186A8C06136F
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2020 08:26:19 -0700 (PDT)
Received: by mail-oi1-x262.google.com with SMTP id x14so6280010oic.9
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2020 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pf2v6K7fWr+bHCgGUrV3kke5q6+ZGtBMsavuxBjru5M=;
        b=SfjaHdsV2lxdGQvWKc7EZuSFskirebpOlxOzXblt3pwchrHV6C4K5BhXP0Gyhrblhy
         6Ox39WJo6pbiXDZEsDnFEqqe1G5RvOK4XY+7AeKH55DNxvUUYoTPEzZ0fQNbH9n6nX1J
         7wtyz9RrLUfN1MJ3ldJ7dUzPrBnOA4tGN2klg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pf2v6K7fWr+bHCgGUrV3kke5q6+ZGtBMsavuxBjru5M=;
        b=mDzTWHdivPjOS12+tXV4MIQ7WXmsFVOckLt3XcXT2D2m/IdXq4egHmAotN7cxgMSZ8
         39YqL7PeontOUpRe1DYYyZDJlzhQrvtyYWXACXj//UUVAPMH/airO8PB/0MtNtyP4/iE
         VDB2rxZZa7JUutoBgQzgsuhvGTKWSA8MkxOKYHBTDMODnFxzI67GbIV7hMo47SnG6s/J
         WfUemi2+vb3Z5NLqdFitgDZc/Buz+mhwMsU91ueX+6o2fjCW1/ypghajHEofvIiOi5H2
         7F7Sv4vLtav7alZFTSDT1vpbFZI3+WFPUUMIvx0qL2zO2yT2wGSjsei0LunJn6cZxXSP
         v6Rg==
X-Gm-Message-State: AOAM533kFR/GrmpFUAoKVqGNyP8QBMKGJxfseO7oh4UUcxI7Jh7feY8V
        WmNxi2v4dL/D1HYRlO0258vpguppYJphK5Qf1fQp7P3N9+Xf
X-Google-Smtp-Source: ABdhPJzTjwr55nx7RvuWPGr4A0Ppz+2wny0SQ9PbuZXKywFz6zRzamwR7UTzBzOpwY39BqVvHM2+KO4l8h9d
X-Received: by 2002:aca:5752:: with SMTP id l79mr349595oib.86.1599751578361;
        Thu, 10 Sep 2020 08:26:18 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id h4sm943004oom.19.2020.09.10.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:26:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Ray Jui <ray.jui@broadcom.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 3/4] spi: bcm-qspi: Fix probe regression on iProc platforms
Date:   Thu, 10 Sep 2020 08:25:38 -0700
Message-Id: <20200910152539.45584-3-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910152539.45584-1-ray.jui@broadcom.com>
References: <20200910152539.45584-1-ray.jui@broadcom.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

iProc chips have QSPI controller that does not have the MSPI_REV
offset. Reading from that offset will cause a bus error. Fix it by
having MSPI_REV query disabled in the generic compatible string.

Fixes: 3a01f04d74ef ("spi: bcm-qspi: Handle lack of MSPI_REV offset")
Link: https://lore.kernel.org/linux-arm-kernel/20200909211857.4144718-1-f.fainelli@gmail.com/T/#u
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index c5209b42b0d2..b78d47a4403c 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1300,7 +1300,7 @@ static const struct of_device_id bcm_qspi_of_match[] = {
 	},
 	{
 		.compatible = "brcm,spi-bcm-qspi",
-		.data = &bcm_qspi_rev_data,
+		.data = &bcm_qspi_no_rev_data,
 	},
 	{
 		.compatible = "brcm,spi-bcm7216-qspi",
-- 
2.17.1


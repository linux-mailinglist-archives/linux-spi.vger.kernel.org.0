Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EBB245724
	for <lists+linux-spi@lfdr.de>; Sun, 16 Aug 2020 11:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgHPJqt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 16 Aug 2020 05:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgHPJqr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 16 Aug 2020 05:46:47 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBA6C061786
        for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2020 02:46:47 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m20so10012707eds.2
        for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2020 02:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LCfFp07XS1q66wli8dcYhD0t73DqdefUks6gneqjAA=;
        b=UA/hgnQeK9lY/pSTvTGxC99ILLbpn/aj9S9YjxIs8gr9wnHy9R2yPiDBdo2q75Ub+1
         E0flgbUB7kL5QJqezq37LMawpiDuUqo0nW07YFgpehC9R7NPdidV2HQvDKo3XnPTQKZz
         /05jsRaskiK+wsDVhF0SL2YPE6Ym6H0KVQrP87ojHaddF8Tlcpj4M+skSHKiy1ujXe5e
         bK+3b8gp3cLwlMTnLbnn1U2lR7vWDGFFc1jpeWvs3n04ZA1KPJg8KgtCuZ/qXWrwRcY/
         /zVXpKCiDGfevKHeyhNjufmxAlDpd+mswJqU+sEBHiUyhNZFk8IoVxmlOuvmowT1kz6k
         vLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LCfFp07XS1q66wli8dcYhD0t73DqdefUks6gneqjAA=;
        b=MzrTeTff1+Es6UzAi965NiPvj+o+qEaf0m9GkxxyCNNoW2YFRHXy2tir5x8aCzUQ7y
         4wElE6fD5cVsuC8/kceCNKHElUZpSvJHgx+tdWbB37bjsjYJIc8x5NgJQStM4W80nfrz
         kLRAUgAiimO2hHVvtlcHN0ZDvJ/AK34XRdZZX/qVkvpzeVUZwtuzS7sHsNRIR9BFeISA
         MUqh6Bwiqvl0MY8jAuwTZjXb2fJEhAkyC+TWYlP3cksjTipJD4JSY0JXqKWvzGbpH5dl
         REXIl2Ydw/XdLJiaaGGcADQRrbpDUOADWH8RmBShK5ahRHL9SC0k+TDoMTZgzWj2t5fB
         8mBA==
X-Gm-Message-State: AOAM533jBSWMSX5jZHycC9avKN+XDV+HnBIFicdsmc+xpqXWH1yV93YC
        +qaiYVdKv8CW4JO4Nj65jQnYvaYnI0lraw==
X-Google-Smtp-Source: ABdhPJzcAo03qxPk5Fj1T5jheKHjvhXmeZBwMoh7uTkLshi/WLRqXnulWz+GnNHOTS/Hz4DBcFvB1g==
X-Received: by 2002:a05:6402:7c7:: with SMTP id u7mr7947534edy.283.1597571205225;
        Sun, 16 Aug 2020 02:46:45 -0700 (PDT)
Received: from dfj.4.4.4.4 (host-95-248-210-252.retail.telecomitalia.it. [95.248.210.252])
        by smtp.gmail.com with ESMTPSA id a18sm11785421ejt.69.2020.08.16.02.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 02:46:44 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH] spi: spi-fsl-dspi: set ColdFire to DMA mode
Date:   Sun, 16 Aug 2020 11:46:35 +0200
Message-Id: <20200816094635.1830006-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Set DMA transfer mode for ColdFire.

After recent fixes to fsl edma engine, this mode can be used
also for ColdFire, and from some raw mtd r/w tests it definitely
improves the transfer rate, so keeping it selected.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 drivers/spi/spi-fsl-dspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 91c6affe139c..5b9a285d84a7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -189,7 +189,7 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.fifo_size		= 4,
 	},
 	[MCF5441X] = {
-		.trans_mode		= DSPI_EOQ_MODE,
+		.trans_mode		= DSPI_DMA_MODE,
 		.max_clock_factor	= 8,
 		.fifo_size		= 16,
 	},
-- 
2.28.0


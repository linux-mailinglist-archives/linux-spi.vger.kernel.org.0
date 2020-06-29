Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E266C20D3EB
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jun 2020 21:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgF2TDM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jun 2020 15:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbgF2TCo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Jun 2020 15:02:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62A4C031C5F;
        Mon, 29 Jun 2020 10:44:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k71so4851994pje.0;
        Mon, 29 Jun 2020 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ox2bp8o+TF5jpMJL0F738/9PgDh+WT2ICnFMbHF+GOY=;
        b=gs7Innka1y06TBBUVyhL/C00DbERcI10B+ps3KeCAgIXtC39WtcBMUUJ/UsO0R1BOh
         0L1w6RIVz9K4qGcLhYw0cH3FiiFuT25+hS2okchiVoMEQE5dxy6BaXpjy/DWh9j5hvYm
         kQgs6PA4ACYrO+dFQ5KzffHT6t0Fx7mi2ldKZg80p5MthTuMdR5rLNRCMNnVKRj/k02h
         dxO4NZt9JJcN2G7XR6fbGqeGSAu8fvQkQ/33xKkiZlHqD+XvNGJM7Yt0SDpqykh/Vzvm
         lG/WUM2pfBNIjuQJpvsABZlCvJbtlnez/3fE7o1I5RyL6ltcsZN4sRG+CYiXyZ7Kr9H1
         Gf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ox2bp8o+TF5jpMJL0F738/9PgDh+WT2ICnFMbHF+GOY=;
        b=t4/iUCGGrcx7jKsxW7D81eefi6edmxktj6wYfqmJAAtKwzRtCmvR5wZOAecxRX+onZ
         N3KjW+u0VDuv+zHdJ3tlFLufzE7PAEVPre5cIA6RoWQRin8a+8bOX66q7HQfE1EM8Vlb
         2MaZnCahg+0uF9bK3qVI0DBT1gDCnAZNzIrIWXiunww/5un+uieaedYG5p1VHW0trhw9
         pEKPtPI8dDOVCOdYLOrku1hPA4rbeYxSnZe58390Lq1KhCLQH05ZYe0UNY8WHa8UHjO9
         uC5eViuKfmRtZ1ZSadhgg/uKH2ontN19WkFYMhNQTnOLaaI3arxvmbT2Jpn/Tx3PXKu2
         LUEA==
X-Gm-Message-State: AOAM530Z6jmcSoX17NUswtaF9t3BrlFHHfqFm3mvJZkZ/eRKhPx+lUgt
        /APgsThbeBl7Ug+tj7PFENA4WDNI4Pjnzg==
X-Google-Smtp-Source: ABdhPJwHKSKSwIDwDkhpYFyqgispmjSNJD7CTqszxiLJAeClYxpTkeBJZ9re2etxNwn2vqxO2SwPGw==
X-Received: by 2002:a17:902:8685:: with SMTP id g5mr14428252plo.270.1593452669332;
        Mon, 29 Jun 2020 10:44:29 -0700 (PDT)
Received: from localhost.localdomain (softbank060117076056.bbtec.net. [60.117.76.56])
        by smtp.googlemail.com with ESMTPSA id m9sm359137pgq.61.2020.06.29.10.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 10:44:27 -0700 (PDT)
From:   Daisuke Yamane <yamane07ynct@gmail.com>
Cc:     Daisuke Yamane <yamane07ynct@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: a3700: fix hang caused by a3700_spi_transfer_one_fifo()
Date:   Tue, 30 Jun 2020 02:44:21 +0900
Message-Id: <20200629174421.25784-1-yamane07ynct@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

transfer_one() must call spi_finalize_current_transfer() before
returning to inform current transfer has finished. Otherwise spi driver
doesn't issue next transfer, and hang.
However a3700_spi_transfer_one_fifo() doesn't call it if waiting for
"wfifo empty" or "xfer ready" has timed out.
Thus, this patch corrects error handling of them.

Signed-off-by: Daisuke Yamane <yamane07ynct@gmail.com>
---
 drivers/spi/spi-armada-3700.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index fcde419e480c..1eb2c64386c3 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -698,13 +698,15 @@ static int a3700_spi_transfer_one_fifo(struct spi_master *master,
 			if (!a3700_spi_transfer_wait(spi,
 						     A3700_SPI_WFIFO_EMPTY)) {
 				dev_err(&spi->dev, "wait wfifo empty timed out\n");
-				return -ETIMEDOUT;
+				ret = -ETIMEDOUT;
+				goto error;
 			}
 		}
 
 		if (!a3700_spi_transfer_wait(spi, A3700_SPI_XFER_RDY)) {
 			dev_err(&spi->dev, "wait xfer ready timed out\n");
-			return -ETIMEDOUT;
+			ret = -ETIMEDOUT;
+			goto error;
 		}
 
 		val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
-- 
2.17.1


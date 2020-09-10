Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3A22645DC
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgIJMSL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Sep 2020 08:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730244AbgIJMQl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Sep 2020 08:16:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71533C061573
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2020 05:15:42 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gr14so8406622ejb.1
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2020 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EcGpkm7/FY3QxPUTpsYpbHVm9xeHO72nNiuHi9sWWsY=;
        b=nZpSVPBHLsVUFdze9QPZdScLMo2ymZQHG0Jynd78pk0C7epWmKPBLyRVlZgWfUtwLM
         SMYVEfBt474JPjDO+3ulEn8LcnCbQ77rYgz4PCBBgQn44IIcNuAhL0B5RNU1QcM0USoX
         kM2H0zuNWBOK2fej/x4GijWZm/gS0y4mTsg+RUzLEKg6IRuM9Fydg7k3IFh5wpxNa91h
         llSVNnZb4P6NZSdzfzw0uzMiqP1bqLGEH3dr0argCn9ceOFrRDxBsAhc2oqwlwAPXkQS
         B1xV43VAyakszARJC5nzDxG36O1fkeZxZeIvRVaUsvuqRX8vGtuEWdsbB9OQkOvZvJmv
         vCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EcGpkm7/FY3QxPUTpsYpbHVm9xeHO72nNiuHi9sWWsY=;
        b=Vv57POu30mAr7cYsJVbp2rNgkjSSZF2hdrMGBj9TqnyrI6jn44vKXh7IdMxb4pQw4+
         l0M7LIEaZLLkwNefeEr1W2OK1i4FW7+xxipmCzXBx1YlJqNxatbiyPcNFUqIHs0NHuY9
         QcQz/zw8884pUhKVvQYpu3MN8qf7MMY55BQePPdfVbgxjFVoM9JyiYtXjdxZ0K1Xg08w
         P+yeYhIE6FJljN3Vwm1EpWg17m2gmEwrEPVwmYJAfyPg/i/Ly5Io0NIegJ5NGDyfpcNJ
         UDgivb4qG/id6Mlq5nsQt0s5cBrA5VpsNcvFBj5bCIGqMpDqpFGdWCQRfFWLCBFUYKNH
         NGrA==
X-Gm-Message-State: AOAM5306kZSnI23RNKa8pvntbUgLTVHrSVxNfkkzojgtt3wG0W0HxGas
        c8xYral7OlFWInCMf7fPAMFTHzx8ZBQ=
X-Google-Smtp-Source: ABdhPJxdNUgQZgJaDE3SSabQ8+m5bRFZ/FyhWtky5Fey45+fUNEwpbg/8eomjTDB/R5smqb54dfHVg==
X-Received: by 2002:a17:906:7f15:: with SMTP id d21mr8684226ejr.470.1599740141118;
        Thu, 10 Sep 2020 05:15:41 -0700 (PDT)
Received: from localhost.localdomain ([188.25.217.212])
        by smtp.gmail.com with ESMTPSA id j15sm6961075eds.33.2020.09.10.05.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:15:40 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, qiang.zhao@nxp.com
Subject: [PATCH] spi: spi-fsl-dspi: use XSPI mode instead of DMA for DPAA2 SoCs
Date:   Thu, 10 Sep 2020 15:15:32 +0300
Message-Id: <20200910121532.1138596-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi device tree lacks DMA
channels for DSPI, so naturally, the driver fails to probe:

[ 2.945302] fsl-dspi 2100000.spi: rx dma channel not available
[ 2.951134] fsl-dspi 2100000.spi: can't get dma channels

In retrospect, this should have been obvious, because LS2080A, LS2085A
LS2088A and LX2160A don't appear to have an eDMA module at all. Looking
again at their datasheets, the CTARE register (which is specific to XSPI
functionality) seems to be documented, so switch them to XSPI mode
instead.

Fixes: 0feaf8f5afe0 ("spi: spi-fsl-dspi: Convert the instantiations that support it to DMA")
Reported-by: Qiang Zhao <qiang.zhao@nxp.com>
Tested-by: Qiang Zhao <qiang.zhao@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 91c6affe139c..283f2468a2f4 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -174,17 +174,17 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.fifo_size		= 16,
 	},
 	[LS2080A] = {
-		.trans_mode		= DSPI_DMA_MODE,
+		.trans_mode		= DSPI_XSPI_MODE,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
-		.trans_mode		= DSPI_DMA_MODE,
+		.trans_mode		= DSPI_XSPI_MODE,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
 	[LX2160A] = {
-		.trans_mode		= DSPI_DMA_MODE,
+		.trans_mode		= DSPI_XSPI_MODE,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
-- 
2.25.1


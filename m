Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74089175158
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 01:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgCBAUb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 Mar 2020 19:20:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33313 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgCBAUR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 1 Mar 2020 19:20:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id x7so10373971wrr.0;
        Sun, 01 Mar 2020 16:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OpaKrDoeUk2RJ12slgA8fUGlWxUuM6afstpoyn/uPGg=;
        b=NBkqHx1vHzaqb/+7HdnVMCM71Jo6uxThzQyLbrk9qz3EyFh5XxqpgqM73XK6V8+GpQ
         wqsO/0uuA/o0f5JsHHjmtEp7EPF5IFQyki128BnDF144jNBNseLuu/mh1IGv2f+VbAiP
         pOlTJ2SFnxZZPPLZ3qINphuZkD8fEAEhHmovTyJpdChpa6s2UqVTBKGjUJEp5xwDLnom
         rid9758M40svjaxPzgn+bAk9PURGm9dsTU3iWpzzsiFc7DTTE30Fpu0xeQtcSbiSPwoB
         AB3qDScJM0l0dsnK0xxvE3Zo4kpDxQVN2NpCfnxvb5cXS/FtMLblHzb78ZSv+YBtFnve
         Vd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OpaKrDoeUk2RJ12slgA8fUGlWxUuM6afstpoyn/uPGg=;
        b=S64yafSf9jGdNXEeyglqQpCnovZm26WuZHETMqy1WvzCZmPrRZo4hobRH6kSRlV9FR
         8bfPe0VowS8+EmMibuKQPYOdiXpaLYDTOGOR1a1fJsmqmPFIVRToZ6/zSwtRIYsMjTK2
         tbT46CGFuQRXsajhmthSdeYuNWTUaYEDelusL6Pzhlx5vB4G6mWjUsIpWRRGTPEuuKvi
         u92Kxo2LIULuaCHQKfJfSjT70Zpi/u1nHCzV+mqcEoI9zqs2R1HT7hZER4evHPVTMr7l
         3YHwH08eBhzv+M68uthharZ+dWnjhFunOuD/NqwIvPSJAIFLSJOIij26rCkyQ55J9Ih1
         GvCA==
X-Gm-Message-State: APjAAAWkjlVySKhWsxMcsFBbCOenz/JMO2LVtyxZ7zvwnLuSsn+WViIJ
        3/EfVnQI3miOlJz+6Dygf5U=
X-Google-Smtp-Source: APXvYqxxhdIQTQNMdIrAMRWM1vH31jBETpsphfpExLQu3aTIpTz9KwOzVl6OMEpRvwMM8nLF1O1Xpw==
X-Received: by 2002:adf:94a3:: with SMTP id 32mr19680451wrr.276.1583108415535;
        Sun, 01 Mar 2020 16:20:15 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id k16sm25428417wrd.17.2020.03.01.16.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 16:20:15 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] spi: spi-fsl-dspi: Convert the instantiations that support it to DMA
Date:   Mon,  2 Mar 2020 02:19:58 +0200
Message-Id: <20200302001958.11105-7-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302001958.11105-1-olteanv@gmail.com>
References: <20200302001958.11105-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The A-011218 eDMA/DSPI erratum affects most of the older Layerscape SoCs
with DSPI, and its workaround is a bit intrusive.

After this patch, there are no users of TCFQ mode that don't also
support XSPI (previously there was LS2085A).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c26a42f8ecbc..c357c3247232 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -147,42 +147,49 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.fifo_size		= 4,
 	},
 	[LS1021A] = {
+		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS1012A] = {
+		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1043A] = {
+		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1046A] = {
+		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS2080A] = {
-		.trans_mode		= DSPI_TCFQ_MODE,
+		.trans_mode		= DSPI_DMA_MODE,
+		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
-		.trans_mode		= DSPI_TCFQ_MODE,
+		.trans_mode		= DSPI_DMA_MODE,
+		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
 	[LX2160A] = {
-		.trans_mode		= DSPI_TCFQ_MODE,
+		.trans_mode		= DSPI_DMA_MODE,
+		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
-- 
2.17.1


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAC0179B7A
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 23:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbgCDWCA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 17:02:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54471 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbgCDWB7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 17:01:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id i9so3968960wml.4;
        Wed, 04 Mar 2020 14:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tbrGXbWRpy/l2/7oLIwLNa4WBlvWltJML3PwKwgo/0o=;
        b=ZzHqVzMbOlyn1V0pd5cImIvacsrGY/H3mm1GdObbyoaZH/wkx9eW1GTcbW2oG59UdN
         ClDeWHK0mKmpxm+Gv77vMfcrnkkgoBsthgyAN+CRUXcvUy7e7wNkFfZO+1QI6a3Mn88A
         KkPzBUNPpGgdC21ICTNuT/HreTiTPlXUBT+6cCb2AEyyLr0YFQ8jg/ZzGyl7VsLuoPZe
         NFmafk/eVh9nYLeixU5ayRsTzCfpUZDn1d+eWTVKBr7PTm5PLYVM1azi9HdsRiruaZ4S
         V6tpPZWymTdQHkkxqk0gk3bMfQs3DtQ57aNQ3Xq2JFZ2E/DDugrJK7OU0JaeQ1hYAGXy
         DQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tbrGXbWRpy/l2/7oLIwLNa4WBlvWltJML3PwKwgo/0o=;
        b=n2HiITAqqJN777W8R/6Z+isUhLR/MgjPnpsrpory8/6sayVmci2c4Ql19RAmQjD1l/
         ieFgjYMcZa2peaatWFQk+Nsy1kq/mSuj3apWzxI7D8V+Z4Ti4YQ0oivDVuX5U9MtSsl4
         pCecsy1YOk7mWICZgNCz1GTA7wA6I5X4j6zn90hpkUf3WaeHljQnqhzMQ4CH76DiJdlI
         wpD2gLvJxy5zNR4g6ZnBeKfAo7kyf3lS3gHmSNMbstSph32F5LB/9pbPwc8dvzN48mRy
         tD/lpivVJDJFlxESq5P8eL2MbhwQedpkEHxBrx7c2vKnPxCYhaWrgP+2/xxVXb1oQd+F
         U2xw==
X-Gm-Message-State: ANhLgQ1vaDSPwpJG88dDwOHKn6uXtdfO46kLgwZhjygtm9OPuKvS418b
        mf1lhzqfcLU5056GBvvlPC4=
X-Google-Smtp-Source: ADFU+vsURZWvmrg+hw9xumHakHLWoIGiz5Co3zRLa5HB2HfY2M3uC69dY5ErqS23ZhDxCF04PDCC1A==
X-Received: by 2002:a1c:a381:: with SMTP id m123mr5397487wme.158.1583359317069;
        Wed, 04 Mar 2020 14:01:57 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z2sm36776402wrq.95.2020.03.04.14.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:01:56 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: [PATCH 02/12] spi: spi-fsl-dspi: Remove unused chip->void_write_data
Date:   Thu,  5 Mar 2020 00:00:34 +0200
Message-Id: <20200304220044.11193-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This variable has been present since the initial submission of the
driver, and held, for some reason, the value of zero, to be sent on the
wire in the case there wasn't any TX buffer for the current transfer.

Since quite a while now, however, it isn't doing anything at all.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 896d7a0f45b0..63ec1d634d08 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -110,7 +110,6 @@
 
 struct chip_data {
 	u32			ctar_val;
-	u16			void_write_data;
 };
 
 enum dspi_trans_mode {
@@ -235,7 +234,6 @@ struct fsl_dspi {
 	const void				*tx;
 	void					*rx;
 	void					*rx_end;
-	u16					void_write_data;
 	u16					tx_cmd;
 	u8					bits_per_word;
 	u8					bytes_per_word;
@@ -795,8 +793,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				dspi->tx_cmd |= SPI_PUSHR_CMD_CONT;
 		}
 
-		dspi->void_write_data = dspi->cur_chip->void_write_data;
-
 		dspi->tx = transfer->tx_buf;
 		dspi->rx = transfer->rx_buf;
 		dspi->rx_end = dspi->rx + transfer->len;
@@ -897,8 +893,6 @@ static int dspi_setup(struct spi_device *spi)
 		sck_cs_delay = pdata->sck_cs_delay;
 	}
 
-	chip->void_write_data = 0;
-
 	clkrate = clk_get_rate(dspi->clk);
 	hz_to_spi_baud(&pbr, &br, spi->max_speed_hz, clkrate);
 
-- 
2.17.1


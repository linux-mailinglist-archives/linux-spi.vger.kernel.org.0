Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07AFB18573E
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 02:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgCOBeZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Mar 2020 21:34:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38353 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgCOBeZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Mar 2020 21:34:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id t13so7882694wmi.3;
        Sat, 14 Mar 2020 18:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W4LsChYiYRCfil6DjkYr2p/X2niUsvURlPsrKK9vuOs=;
        b=mMwz6uwyECazDiJCgbOUHKlUEAMtQg38/g8Xqg6k2LoiSVVVtZOOsgSya5j7XcIH9w
         iMAPxKZjs03JXneZ9diWGvngfP7GIfFYVuL10HYcGY18z4749N7UlgdbhwjzLmuKuc7J
         RBJ4PI8kUSp15b1pBT9Kaj83C8rF95WKh6ZXOnlET7I3PpKUl8F3vLPK039Hp0C6tMK0
         ZHmYR7isWCkR+IlSZNxGDqzsFgTsSewABn1yNSes9aSqqYCjqNqO0VVny5CYiuXh/9dW
         2SPJvOWX1drqOcChY8n/FV4YN3Qt6xArmBkRY0tmEkNqLFGistf4v/WBG+JAfy7fvLJ0
         KejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W4LsChYiYRCfil6DjkYr2p/X2niUsvURlPsrKK9vuOs=;
        b=IRe3u+PP5EZBy4BHaCxh/Wg8g/cOqq2TjHFpdm4NvHi4NDXOEdCy1NoqEH0+DTeAvM
         nmuz8GasvZlAmWcmEemd5mCa4Eo7OuJfc3k8CiCpBegIPvZTg7VTFcgPCjqQxWKnxPbu
         ERgLezibL4CW6AP+PyrippgP+RlK30JZhsOppwEc2gjcHfgORGbSwcFuzNIiNkDptU8T
         KQ/KawdBkwES7RpcxJ8ydLOAuYRfe9ZwLioJnR1bEl7pelldDB38L55TAnueXpwg9b5c
         et9Lc6ZNNWM+TkZI+wreIuq37N6QyKJoIU8vnWT1bRmY+Gscs4cOhV525MFbJZuK7Z9X
         qeZg==
X-Gm-Message-State: ANhLgQ2bs/wvq5iG/b2jyASZKdjgGdkLSiBACVvibBNZdzuCv7mvtsai
        /P78/YWg9Njg6Yuf8JzPWBnj0ps9q9U=
X-Google-Smtp-Source: ADFU+vvceGKe918gmUtPax/Kpa0CuJ0cxHQlIzPaPbiI7CPBUaRWpfSTLBN2KPObAmrLXkH/4FDSfw==
X-Received: by 2002:a1c:9802:: with SMTP id a2mr18615176wme.117.1584225846132;
        Sat, 14 Mar 2020 15:44:06 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id 133sm23690732wmd.5.2020.03.14.15.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 15:44:05 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 07/12] spi: spi-fsl-dspi: Avoid NULL pointer in dspi_slave_abort for non-DMA mode
Date:   Sun, 15 Mar 2020 00:43:35 +0200
Message-Id: <20200314224340.1544-8-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314224340.1544-1-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The driver does not create the dspi->dma structure unless operating in
DSPI_DMA_MODE, so it makes sense to check for that.

Fixes: f4b323905d8b ("spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v4:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 78c891e441cd..a8aef5690c5d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1201,8 +1201,10 @@ static int dspi_slave_abort(struct spi_master *master)
 	 * Terminate all pending DMA transactions for the SPI working
 	 * in SLAVE mode.
 	 */
-	dmaengine_terminate_sync(dspi->dma->chan_rx);
-	dmaengine_terminate_sync(dspi->dma->chan_tx);
+	if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
+		dmaengine_terminate_sync(dspi->dma->chan_rx);
+		dmaengine_terminate_sync(dspi->dma->chan_tx);
+	}
 
 	/* Clear the internal DSPI RX and TX FIFO buffers */
 	regmap_update_bits(dspi->regmap, SPI_MCR,
-- 
2.17.1


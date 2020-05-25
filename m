Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC301E0562
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 05:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbgEYDlu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 May 2020 23:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388397AbgEYDlu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 May 2020 23:41:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F6FC05BD43;
        Sun, 24 May 2020 20:41:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d10so8128056pgn.4;
        Sun, 24 May 2020 20:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eu+Ho/X9r7MZN52F/RomcQQtgjiQ+X/m9AkGhdRXtC0=;
        b=PmqbvbjfQbPp8aCgYV4adtOizlxzzoYkkP3BmW00smgp2fP0Bgb6gdyaUQ4hSIboyv
         v17woXHMmCbO+WITpNoew3ZTtwk+GINDY8hwKAcYqbhKR5mfY5n8Sx6wOC3DKlVsJ254
         LC94GQMZAP7XMrauRY3joLeFA5EyYlu3MTIORwdh5K6lKQ4XbdESZQCBS+FTPbumlf4A
         WElSv97Cre7PEAgs33dgrOqpa7Caw6r+g2WUAH+gf6a6dTsV05j64XII4l4nOrXjlXB5
         lVAnOeQ9wLz5J4uOpLCjlTipqGfMETbFE4vqCnbX2n8GsVykhRXpzBRU8Xuzqeu9NO5H
         w0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eu+Ho/X9r7MZN52F/RomcQQtgjiQ+X/m9AkGhdRXtC0=;
        b=kciVcyo6R/errJzOSD3k5B6E1NqdfC2Wv7xo1WrvNL2JTNHO0uZQk2xWBMIT3amg8v
         itxZJxbhvSXZ1wO1LtsLoFqeQsE0LhUDx3RjURQkCDB7ePZ3NT89jSCHvG2M45koCnPC
         v4iwlMekVYx10W5Ly8nt4oCh57VPcVwX0mW638fKH8eqgTsbJ/uiG28wJcs+uOePMIs3
         n/pDZ9PESdlizYCYOj/OQR10dG0VXBHKDgEgqkBiQnj0ahhKqFVCYaiuLL/bVJ+Jmi0a
         vrcxB5ZClh85CIGFdudoujLJ2f+4u/jCq0CV1mRoiCSjDS6fIkpNZia9o4D9k0DvCp+h
         EM4Q==
X-Gm-Message-State: AOAM533UwijgiZdDcHhBVgxbZmUYniLRkYp5sjdDdbn/AFFlrhstz/se
        qXd2FAkCHj0mV2wnRUKfUsk=
X-Google-Smtp-Source: ABdhPJxIuHMaJzv5SBEYVh6aGCYw3zkHcCsCQujjuOk1hJAg5OSAvXpvA0RjBvenltA1HqrMvGbYhQ==
X-Received: by 2002:a65:41c8:: with SMTP id b8mr23889318pgq.265.1590378108951;
        Sun, 24 May 2020 20:41:48 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id 7sm11981695pfc.203.2020.05.24.20.41.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 20:41:48 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 8/8] spi: flags 'SPI_CONTROLLER_MUST_RX' and 'SPI_CONTROLLER_MUST_TX' can't be coexit with 'SPI_3WIRE' mode
Date:   Mon, 25 May 2020 11:41:02 +0800
Message-Id: <1590378062-7965-9-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590378062-7965-1-git-send-email-dillon.minfei@gmail.com>
References: <broonie@kernel.org>
 <1590378062-7965-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

since chip spi driver need get the transfer direction by 'tx_buf' and
'rx_buf' of 'struct spi_transfer' in 'SPI_3WIRE' mode.

so, we need bypass 'SPI_CONTROLLER_MUST_RX' and 'SPI_CONTROLLER_MUST_TX'
feature in 'SPI_3WIRE' mode

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 drivers/spi/spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c92c894..f884411 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1023,7 +1023,8 @@ static int spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	void *tmp;
 	unsigned int max_tx, max_rx;
 
-	if (ctlr->flags & (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX)) {
+	if ((ctlr->flags & (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX))
+		&& !(msg->spi->mode & SPI_3WIRE)) {
 		max_tx = 0;
 		max_rx = 0;
 
-- 
2.7.4


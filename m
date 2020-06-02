Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21281EB748
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgFBIYZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 04:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFBIYY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 04:24:24 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25B5C061A0E;
        Tue,  2 Jun 2020 01:24:24 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y18so1063162plr.4;
        Tue, 02 Jun 2020 01:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECy7FTiTgIpO2AdNggf1345sikb4bPD3wr71bWuBW/0=;
        b=luJA3xFmhS6zTnRHeCag7eMVdQbNEbZRmqXvVFHMFzEEFtTGM5LsCcFlo7UyQmuLFY
         wKM2DX3T27VCim9dTsvMa4a9iVdXuHCmoX0VUHZdzPuP8ZYlz/KjHeHFC1mvwBLcvFtJ
         SJI7br0LHA+Y9+RkoNewS8ovCsazOSaBcxP3JoA0fq0EfxNuAfFvGf9dpYOzQKMPoiSx
         DLSo2jg6kHACrS6qJfjslf+YWyNlqRU2a7iSSvenK0LGZTGJfBKihOgJa0FwOICvBscY
         eyIm93v5AAmxetVMhWc7Dszc6hsNyXh08d5wOda4QbMhStJP7y3bh5fCaY1zUJKrSpTN
         e9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECy7FTiTgIpO2AdNggf1345sikb4bPD3wr71bWuBW/0=;
        b=IgMLXGq473+2wZqbRjelk5vi/3cikvgBS5rIZPVQ9xqBoBbcjygHYREGfXemjl6kQp
         s7OLYtMmJyk0fJUI+L0vDlS+maBEHj55cn1cPmtl0GZGbpClJWrgyfytEF25k2e4Impd
         /umsGej55rL32jlr526A2xP/mFDSSxlm617sxLoEmUzqCmeAGL3gJTk8G7VjPnCHwAMh
         DxxeX0w1+wbDIvcYq835QudD0kbxSSpuHPjVPN7MymZujOb9VIgBpfaYW+uWhHo8bmYl
         2G8vqeSXFA8aiseW2uQQtw88eeOXDmA5tISCJ2xyADFq8LwRwpr40r4AIPPAo2Y/Tbvb
         vAEQ==
X-Gm-Message-State: AOAM531+bcuMrgIXbM/xuv/C9089pVi6a2RSsbQ4GizLUnMGTBkC4lUo
        PcxgbGpEeczr9Z9V34FFNBA=
X-Google-Smtp-Source: ABdhPJxWYN0hDT/k70SlMxDxvhGNkStvzjpJzggiqd/Q6gXA7lIPszcrx6zivRH10MyL3pmNIR9m1A==
X-Received: by 2002:a17:90a:376e:: with SMTP id u101mr4097724pjb.126.1591086264238;
        Tue, 02 Jun 2020 01:24:24 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r7sm1553477pgu.61.2020.06.02.01.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 01:24:23 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] spi: sprd: switch the sequence of setting WDG_LOAD_LOW and _HIGH
Date:   Tue,  2 Jun 2020 16:24:15 +0800
Message-Id: <20200602082415.5848-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Lingling Xu <ling_ling.xu@unisoc.com>

The watchdog counter consists of WDG_LOAD_LOW and WDG_LOAD_HIGH,
which would be loaded to watchdog counter once writing WDG_LOAD_LOW.

Fixes: ac1775012058 ("spi: sprd: Add the support of restarting the system")
Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/spi/spi-sprd-adi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 87dadb6b8ebf..8e84e25a8f7a 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -389,9 +389,9 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
 
 	/* Load the watchdog timeout value, 50ms is always enough. */
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_HIGH, 0);
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_LOW,
 		       WDG_LOAD_VAL & WDG_LOAD_MASK);
-	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_HIGH, 0);
 
 	/* Start the watchdog to reset system */
 	sprd_adi_read(sadi, sadi->slave_pbase + REG_WDG_CTRL, &val);
-- 
2.20.1


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1994C1AFD6F
	for <lists+linux-spi@lfdr.de>; Sun, 19 Apr 2020 21:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgDST0h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Apr 2020 15:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDST0g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Apr 2020 15:26:36 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A39C061A0C;
        Sun, 19 Apr 2020 12:26:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id a23so3126781plm.1;
        Sun, 19 Apr 2020 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jF5s6mIDV3imWHwN3gxECUXiGCch+faubGbjA6qiFuo=;
        b=oBL/SZaBziPfCR+/RiflZh5tbx20Lkqd8hCTCbitOf+xvRP40ZII8x0TesBR0tR804
         XnWXNdpq6E2VGwX6eqamCPKGDiutZUaVbr4a2fJAXkd+vCK0m2YKhYiR9WW/A5hfIMPa
         aZtrDRypsrAcPXK3tS0o/8mlyFpq7FXAnIzAFrny1aKDwxeDXuIGxn3qGgqvTkHBiIfD
         Ut3pBdzqPxPVb418ZqKpeuh9sfUeEQXklX3Wa02C/9AUpTzdzAV/zsYJT0U7vBUJW9W5
         os4iW9aH1qG++dmHSwtKkJAIRnSqwLA5oOP8iNVTasSKLyWrbzhYG4HSZHiNk0A5zPF/
         HFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jF5s6mIDV3imWHwN3gxECUXiGCch+faubGbjA6qiFuo=;
        b=rBUlfFeERlPRY68Ri7wm9fb8Bmy/r0+zwN07ccs4rHepUjuAYaZBj+3ClPfixISHUp
         mhPn3J9txsMgDhh/DwtY4n/vIptvZyxrnRFhg+y2Qmv04cSA1xlkyQ7YzjrQWOoCi1fg
         5JE92gcUBpCCBNnCqbqUQECwJfXU/7r0NJzG1FPN9mKOikmlSMgnXgBKYREHFfKWVHlM
         frQWSkuID9hhmnel9Yzo74DUpOiWML6N0H4dYE/qJ+dCBqULTajSg+mkWx9wGlxEeDos
         0SKVAyJi83P9DajsP1VLRTjOyAYM+aRcaCbNYBk1YMu9FJOkB8XLIoigs+h070u126SR
         vsng==
X-Gm-Message-State: AGi0Pubi+qbf901/c5Z0x3vAvuVdB5bSlC6p7vN6YuTMcxr4kJXil/D+
        4wwTxKSZN+JRtUAdblf5T2Q=
X-Google-Smtp-Source: APiQypK5Hvda3HaVIjWCJOln6ENB3/UodqlwkoVylZ+275OJYustW/KkT0XdPcf8rk249LHf0IW9/A==
X-Received: by 2002:a17:90a:ac08:: with SMTP id o8mr10451386pjq.72.1587324394927;
        Sun, 19 Apr 2020 12:26:34 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x16sm22724383pfm.146.2020.04.19.12.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:26:34 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v2 6/9] spi: bcm-qspi: Make PM suspend/resume work with SCMI clock management
Date:   Sun, 19 Apr 2020 15:23:35 -0400
Message-Id: <20200419192339.32023-7-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419192339.32023-1-kdasu.kdev@gmail.com>
References: <20200419192339.32023-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SCMI only passes clk_prepare_enable() and clk_disable_unprepare(), made
changes to suspend/resume ops to use the appropriate calls so that PM
works for ARM and ARM64 platforms.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index e00208801c8b..a3936ae5a860 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1455,7 +1455,7 @@ static int __maybe_unused bcm_qspi_suspend(struct device *dev)
 			bcm_qspi_read(qspi, BSPI, BSPI_STRAP_OVERRIDE_CTRL);
 
 	spi_master_suspend(qspi->master);
-	clk_disable(qspi->clk);
+	clk_disable_unprepare(qspi->clk);
 	bcm_qspi_hw_uninit(qspi);
 
 	return 0;
@@ -1473,7 +1473,7 @@ static int __maybe_unused bcm_qspi_resume(struct device *dev)
 		qspi->soc_intc->bcm_qspi_int_set(qspi->soc_intc, MSPI_DONE,
 						 true);
 
-	ret = clk_enable(qspi->clk);
+	ret = clk_prepare_enable(qspi->clk);
 	if (!ret)
 		spi_master_resume(qspi->master);
 
-- 
2.17.1


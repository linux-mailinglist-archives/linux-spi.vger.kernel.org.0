Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AC92EEA10
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 01:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbhAGX75 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 18:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbhAGX75 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Jan 2021 18:59:57 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF441C0612F6
        for <linux-spi@vger.kernel.org>; Thu,  7 Jan 2021 15:59:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l23so5152944pjg.1
        for <linux-spi@vger.kernel.org>; Thu, 07 Jan 2021 15:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1zT4HWOZj8+DNGvXT+tQbujMnSkK9ZiyjWReVuMf2E8=;
        b=eDHF8SwHkQ93Gv+k2sh6Li/bNUnwyQVO+OLN8WfEw0lgaafcE78E16ZyJJYqxRIJNc
         VXyPGjl3TzteoFFqsToaR1ZJnsvjxyJ/Le/OaQ01ea0FekLNj8ZiEvbUwoYF4e4buHUz
         9F1bYF+4RmiuTnjsSAkPeES1PLZ5aQr8hi/ciuFezL48tq2JISgX1ftAtZ9Qyc4zqqxm
         /PU12vtOV1SsfybUCNWgoe387JnpV5hWWn4dhQoncSOGrhr2pnFOWVuPbCKgCLPwIUS9
         EAS2Gn95SJtBm0MRDomS7yzpbZ5zbvTkTQANS53jSS2zbn4f0s/OrsfGTQ7YPQ3DrIZF
         jonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1zT4HWOZj8+DNGvXT+tQbujMnSkK9ZiyjWReVuMf2E8=;
        b=TBpvEoy7TN7BS/B+14tM71w11JQv0g9sFZqczsj2f+ZhAuwEwV4OKlAF+jbR8Wkw5G
         I8vHowgvo0TitodlyA7LV6+dpvsHZlyXKUSqzpJfOe8awbznw7dRQdfpCy34vInbnWF2
         vUIZyz/TpeJ3hoTi6COlzMxr1VGm6eXk5DHYYhqIwgtECB2CcsCc+L2l28vaWtnn+QeK
         vDlEWoTfwm4hHMBwWjDLmpk6PRbpHzHCgf7FOpMdJWcAhJ5LNKI9RcOoAMl6UFu179Ax
         /zCKN4jE/lI8DUtR/7Ae0q62net78eprPz2yDx6YOL1SSttcjv3kue3+l3JWM0I8NjAl
         rGHA==
X-Gm-Message-State: AOAM530vqBArvVex3bf6YtTPj5GvUwJJEzUlKIgLRwyUCP5WA+VTHocq
        vdH61PaGZaQJukXk2tF/e+E=
X-Google-Smtp-Source: ABdhPJxMZjfgFn+blSTgxtMCQPjl7EHjF4IiZVYspJNDnRqtGydpf+fVNJLW3TGRpNthvi5Tye72Pg==
X-Received: by 2002:a17:90a:a012:: with SMTP id q18mr842727pjp.223.1610063956619;
        Thu, 07 Jan 2021 15:59:16 -0800 (PST)
Received: from x2.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id bf3sm6448195pjb.45.2021.01.07.15.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 15:59:15 -0800 (PST)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org
Subject: [1/3] spi: bcm2835: Call the dedicated transfer completion function.
Date:   Thu,  7 Jan 2021 23:58:30 +0000
Message-Id: <633c3d5c350dde4d14ce2120c32698c25b95d302.1610062884.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210107235832.839221-1-plr.vincent@gmail.com>
References: <20210107235832.839221-1-plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi_finalize_current_transfer currently only calls "complete", so no
functional change is expected.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
 drivers/spi/spi-bcm2835.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 197485f2c2b2..dbadbc4638e9 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -386,7 +386,7 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 		/* Transfer complete - reset SPI HW */
 		bcm2835_spi_reset_hw(bs);
 		/* wake up the framework */
-		complete(&bs->ctlr->xfer_completion);
+		spi_finalize_current_transfer(bs->ctlr);
 	}
 
 	return IRQ_HANDLED;
@@ -608,7 +608,7 @@ static void bcm2835_spi_dma_rx_done(void *data)
 	bcm2835_spi_reset_hw(bs);
 
 	/* and mark as completed */;
-	complete(&ctlr->xfer_completion);
+	spi_finalize_current_transfer(ctlr);
 }
 
 /**
@@ -640,7 +640,7 @@ static void bcm2835_spi_dma_tx_done(void *data)
 
 	bcm2835_spi_undo_prologue(bs);
 	bcm2835_spi_reset_hw(bs);
-	complete(&ctlr->xfer_completion);
+	spi_finalize_current_transfer(ctlr);
 }
 
 /**
-- 
2.30.0


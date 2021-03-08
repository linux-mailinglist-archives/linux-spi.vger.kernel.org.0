Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D9D33115B
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 15:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhCHOzm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 09:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhCHOzh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Mar 2021 09:55:37 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B467AC061760
        for <linux-spi@vger.kernel.org>; Mon,  8 Mar 2021 06:55:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bm21so20929688ejb.4
        for <linux-spi@vger.kernel.org>; Mon, 08 Mar 2021 06:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dk38R2BEd68k0sRStLee7izJxfsp+PQHJm3HaMXnM6A=;
        b=ahfVV+tRIbM8ON7yRS/IM1epTuYYGywi+Koj8gByhh6/R1lwaQ5Pw36i8kwDwuLGiH
         Zhe3ULECmQI4x2Sv26GgkMNikMu0NKpw9wH/+bEzk9cOyPTDEJKDaQl48hmfleXFxiY/
         HqKi1fbZREQRxRXLrf4wLVdw9j2H0zT4YyInNGcWX1HheMd0lgaCLgW2a2l5Drgv8cGg
         DwQ+8QSmU8dYKHDNmufkE+jrJQhYzVnFrjZ3CjYxEDkivdQcf1O2c0NidPpdwQ+5kded
         1c8KcAXjYGVsyacm6BcVE9r1A0mYP6ZegtHntXkWZgsJCilpA7j0s0D/ER+03VaYFGxt
         aIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dk38R2BEd68k0sRStLee7izJxfsp+PQHJm3HaMXnM6A=;
        b=WqT6+0PjhGrI5qonrz5Z7ahOfupHjo2ZaimvXc6NczLHiMgGLwocUaMLOe8ua6M1r5
         OIvR10CBQZv3SA8yotwYcSRP505X84XlR9NrxNb/7Rw3V7ZB3wH1htlWCLH085Jy8ROM
         4jsb28g/vCuuSzN5RJ6r3nkJmX6BhyHdlNVu8NsPPLqC4EZO88cJd6Cv1PgbLbH+NMhQ
         x8/dVYBho2TvFdnr0rrjygJS/9v+4OwqlGxEWjUYBG6PyF65JKexlYRXSDzwdbjtxAh/
         UgRWZoKC112rXoLSDJPphcz2wO7YWxxviSgLKvrNRQcjrPdSptEK9kSlcfiRB+jMDuKp
         /wYg==
X-Gm-Message-State: AOAM533mYEnCx/a689ANIT1x2HaRtsF0mR6VMWBQNf9gV69CyIjp959A
        iM8FT49t4Ok1bhM25RNP381Pu2j462vUSPx+
X-Google-Smtp-Source: ABdhPJz1X+Yvv3Gf60Ux6dslZLHmcGo2s75ffNy+pTDMIK2LHvMuhKrswzHu65RuNVsJWclcjcnmIQ==
X-Received: by 2002:a17:906:7150:: with SMTP id z16mr15048608ejj.103.1615215335290;
        Mon, 08 Mar 2021 06:55:35 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id bt14sm7411234edb.92.2021.03.08.06.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:55:34 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 07/10] spi: spi-falcon: remove check for 'delay_usecs'
Date:   Mon,  8 Mar 2021 16:54:59 +0200
Message-Id: <20210308145502.1075689-8-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308145502.1075689-1-aardelean@deviqon.com>
References: <20210308145502.1075689-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 'delay_usecs' field is being removed from the spi_transfer struct.
This change removes it from the SPI Falcon driver.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/spi/spi-falcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index d3336a63f462..a7d4dffac66b 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -377,7 +377,7 @@ static int falcon_sflash_xfer_one(struct spi_master *master,
 
 		m->actual_length += t->len;
 
-		WARN_ON(t->delay_usecs || t->delay.value || t->cs_change);
+		WARN_ON(t->delay.value || t->cs_change);
 		spi_flags = 0;
 	}
 
-- 
2.29.2


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9262EEA12
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 01:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbhAHAAD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 19:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbhAHAAD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Jan 2021 19:00:03 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB26C0612F9
        for <linux-spi@vger.kernel.org>; Thu,  7 Jan 2021 15:59:23 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 30so6452062pgr.6
        for <linux-spi@vger.kernel.org>; Thu, 07 Jan 2021 15:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oJVh/my9+9Gu7+k7keDLqkZNyRGli6f9+DmOVRImkkY=;
        b=CWZJyXyJQbF9Na1Pzs4NcHk2oB3TaHSm2tHAKLDv9bNLnngpjSwEi6m7CG/CPflpZC
         tVzwSakepZZWnoIW1sALg3ZjoZ4BF7lKyKdoPTkzVAmSgLcwe8CoymbdqiBC8kC7iErB
         yQbpAVE6WXn8ON0w9sUuMcxh1BxlTZJaQm/Z0Ztb/wAIBHpVP4hqX3lGrTUq4kS40+FS
         oHplBwspj//AOKKcPQQR/qdRYc+Tiv6VaRx2LIaapwvsHzzQHJZCR8GNCzklAsc49YD6
         +B8yn/7/oHcRA364M4w4gZ3nn6BzaIsGMAQpMdqkPqPsTYbRPUBSdGjap6RNx0soylYm
         thAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oJVh/my9+9Gu7+k7keDLqkZNyRGli6f9+DmOVRImkkY=;
        b=ofm9WPFjaHnsFK1Xh6R5ORga/cGIYyEFh4qUE6j/6DgZ9oriAjMZddLmY9FBKtxz8B
         8whjNO+ZMinanvA3SBPEZVs+wM03HNHYIjwiTIiYJI1fgvMgCWHIp4e/pFdZTFs8lJEK
         +3FokWYJR8SHaGsnQHZu8cAwnM81+RHptBi4l8M9EJfoVf1hl/F8v7VMmQtCLqfi2sRf
         fvOFJOBvrpCEKrHLG/3NCOQMSbyGzWNLLxxxKY8K7mwpujevkYeDztVEzKOYr6BuLO62
         zqJuI21/YOOQZ6eHIZS8C6OvJlmg/sG0yBgLEHlYNhpTZpD7lnod6UwvjtWFfLVwFj5z
         CA0Q==
X-Gm-Message-State: AOAM533a5ETzvwCO6QX5SDImh/6E+VBS9jzVNjyHZsHXnmMVChGLckTq
        lbtdua5JkqpIX6ZUHecvEqI=
X-Google-Smtp-Source: ABdhPJz3du2kRkADciN7SImnBCQ6L07nS036HGi6RwOFEunY/bLqZLsRFbrNvPFqaexZ/qjIuPzXlQ==
X-Received: by 2002:a63:f19:: with SMTP id e25mr4200495pgl.220.1610063962848;
        Thu, 07 Jan 2021 15:59:22 -0800 (PST)
Received: from x2.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id bf3sm6448195pjb.45.2021.01.07.15.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 15:59:22 -0800 (PST)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org
Subject: [3/3] spi: rockchip: Call the dedicated transfer completion function.
Date:   Thu,  7 Jan 2021 23:58:32 +0000
Message-Id: <f3e1cf19a7dcdd77adc0a719adf46449b84ccadd.1610062884.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <633c3d5c350dde4d14ce2120c32698c25b95d302.1610062884.git.plr.vincent@gmail.com>
References: <633c3d5c350dde4d14ce2120c32698c25b95d302.1610062884.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi_finalize_current_transfer currently only calls "complete", so no
functional change is expected.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
 drivers/spi/spi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 09d8e92400eb..936ef54e0903 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -566,7 +566,7 @@ static int rockchip_spi_slave_abort(struct spi_controller *ctlr)
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
 	rs->slave_abort = true;
-	complete(&ctlr->xfer_completion);
+	spi_finalize_current_transfer(ctlr);
 
 	return 0;
 }
-- 
2.30.0


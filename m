Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34711BB20B
	for <lists+linux-spi@lfdr.de>; Tue, 28 Apr 2020 01:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgD0XdF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Apr 2020 19:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD0XdD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Apr 2020 19:33:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2698DC03C1A7
        for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2020 16:33:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g2so7600239plo.3
        for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2020 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psE/TVWQ8r0hHEn8TaByg+EQGlqN2iYLLSNjuoRCa9k=;
        b=b8SHhWvZTnoeLLp7IhgorcpvGtX2VBtc6vtxpVWuQoeDabjj0nAmuP6/TiuQUuiRNh
         etINFZ53Wf2AxOzz/nSnynJ4yALdIG4FmtD9L7neNUYUJq9Z2xbTJRF74DW8l6RrICQy
         4m3riY6RULFDgxpguilcjn9XbHCWm0rHcTDJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psE/TVWQ8r0hHEn8TaByg+EQGlqN2iYLLSNjuoRCa9k=;
        b=t561mfVGVEHkQi1NRDDM43nG5ij0UfdHVjdYI5BJaHk/d0KpsQHLVfUKCndEbL4Ra0
         11Of+7QnTeCIiWhcyuMaCFjhQSdd7rhLVXg2/xEJm1ByZ8rfH3kapgnTpbuAdgYCAza/
         KOWMIZJyFW2Jez2pMLhYRKkrMdMCdKBQ87bVe/zIchJTOo6DTrlrqknF0D7q/9uf/Y6+
         uip7qA6B1xM356jVCMlVFYkx7Tmjmpnuo04tn8Bwy7zPYlgEcD/xDKTcykzgHzSB03Ta
         nNS2Oh2/SxpENXMKBh4g5/fynhj0wsDAdpkQQYOefC/1z/4ssOQlqqPZUm8f78VthtWW
         t56A==
X-Gm-Message-State: AGi0Pua/D5sQ9hdpqLwSdLSjlrmHsouUddWr+dsOqiXIhdlnsu99Iqzt
        +eT1/KhVaYjD4PIW5x2iBQuSsQ==
X-Google-Smtp-Source: APiQypIltu09rqzr9JI0Ay36qw8wC98n1LszdiP6AYWaeNG61gnrxNMq7cNJFmvmNXJIZr8u6f1mqQ==
X-Received: by 2002:a17:902:a98a:: with SMTP id bh10mr24753613plb.340.1588030381558;
        Mon, 27 Apr 2020 16:33:01 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:1c5a:73fa:6d5a:5a3c])
        by smtp.gmail.com with ESMTPSA id u15sm308980pjm.47.2020.04.27.16.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Apr 2020 16:33:00 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Shobhit Srivastava <shobhit.srivastava@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: pxa2xx: Apply CS clk quirk to BXT
Date:   Mon, 27 Apr 2020 16:32:48 -0700
Message-Id: <20200427163238.1.Ib1faaabe236e37ea73be9b8dcc6aa034cb3c8804@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

With a couple allies at Intel, and much badgering, I got confirmation
from Intel that at least BXT suffers from the same SPI chip-select
issue as Cannonlake (and beyond). The issue being that after going
through runtime suspend/resume, toggling the chip-select line without
also sending data does nothing.

Add the quirk to BXT to briefly toggle dynamic clock gating off and
on, forcing the fabric to wake up enough to notice the CS register
change.

Signed-off-by: Evan Green <evgreen@chromium.org>
Cc: Shobhit Srivastava <shobhit.srivastava@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

I don't actually have a BXT (Broxton/Apollolake?) system to test this.
To be honest I suspect the issue is there in older generations as well,
but I couldn't get Intel to confirm that, so this seemed like the
only safe change.
---
 drivers/spi/spi-pxa2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 73d2a65d0b6ef..20dcbd35611a7 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -150,6 +150,7 @@ static const struct lpss_config lpss_platforms[] = {
 		.tx_threshold_hi = 48,
 		.cs_sel_shift = 8,
 		.cs_sel_mask = 3 << 8,
+		.cs_clk_stays_gated = true,
 	},
 	{	/* LPSS_CNL_SSP */
 		.offset = 0x200,
-- 
2.24.1


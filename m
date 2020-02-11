Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7138159C3E
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 23:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgBKWe0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 17:34:26 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35625 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBKWe0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Feb 2020 17:34:26 -0500
Received: by mail-pf1-f202.google.com with SMTP id q1so125580pfg.2
        for <linux-spi@vger.kernel.org>; Tue, 11 Feb 2020 14:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tCp39nGmh6jfHffZt6h0GnEI2p4k3vAcc1eu6SXs2AA=;
        b=EZ9WVyoWLXE02i7Y/3ZJ4Tadn7u6Jh16ATWGwkj4iIcfHwD6Q5PrJgiyF1fLolo1kf
         G8+VB/3TXt0o6s5jORy1pmkNdIgEo2rudsmW28fXSpBvk2bDJXn5wor3+PopK+lhGOpT
         fGINzh3d/4wTeGBHoleb+loZ5Zvh1hNd5icRXHQJAlq3JL2gqYaiiK1gHegOUUBdr2H4
         /M7q3pkkn3WrdTSSc51R32H1A0VnyC+yTWtXSOyHl3gB3BmUwN7q5a0Ta4lLoEMHgYDT
         ODjfkXMYEV9NwI0CJ/++R2ZzKrhzUtAMmPyX62TafJ0zLyLAjT5y37KT6uzcF1zN8T6+
         EHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tCp39nGmh6jfHffZt6h0GnEI2p4k3vAcc1eu6SXs2AA=;
        b=hM8HCADkwsskdnVXiwsUWCZL7SyCgYXT51s15OupDJvDfZYFitRZkp9KL/C34qzNmG
         7+hnbq+wU+rEjNVEkryQ7cKbGNXG5WW7Q1z0FbYbR4gk5V+g3+JJV2RO2bCJJxfpoCj2
         Uw7Azk7e3kxPCWeKXcjzINWQarLynKYeuUGhz1UV5Rgx0pApLOmZwrtdT0dubL9ACSLx
         v95+WBLdLWLMJkDTsUHpwWL/g4wyXSX7ShxycY18bX6lHJbcxyic9RFBeIJAoSbApLEp
         L6S5ohmM9S6A37tfRsuh8B5drIkv0C04uqmA/PKl22vvMOCV1Bkdh/KlTY6wLBRpNvOO
         vNEg==
X-Gm-Message-State: APjAAAWf+VPg4u2dZJyXC9OsCaMceA5BsL/ejMVsQpzqMeBYvtbMli+q
        wGZ8z1SaZyLrQ1rOQLLG4bpS9VMeSGTK
X-Google-Smtp-Source: APXvYqzL+9Pb948p0Oh4VuEriyt9PtxXSCFN9TUUDh3yeG1rALRrce/dUGXJG8xbwe+qbGzOAhmWir/vouDB
X-Received: by 2002:a63:2266:: with SMTP id t38mr9426357pgm.145.1581460465371;
 Tue, 11 Feb 2020 14:34:25 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:34:00 -0800
Message-Id: <20200211223400.107604-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: 
From:   Rajat Jain <rajatja@google.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>, rajatja@google.com,
        rajatxjain@gmail.com, evgreen@google.com,
        shobhit.srivastava@intel.com, porselvan.muthukrishnan@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Evan Green <evgreen@chromium.org>

Date: Wed, 29 Jan 2020 13:54:16 -0800
Subject: [PATCH] spi: pxa2xx: Add CS control clock quirk

In some circumstances on Intel LPSS controllers, toggling the LPSS
CS control register doesn't actually cause the CS line to toggle.
This seems to be failure of dynamic clock gating that occurs after
going through a suspend/resume transition, where the controller
is sent through a reset transition. This ruins SPI transactions
that either rely on delay_usecs, or toggle the CS line without
sending data.

Whenever CS is toggled, momentarily set the clock gating register
to "Force On" to poke the controller into acting on CS.

Signed-off-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/spi/spi-pxa2xx.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 4c7a71f0fb3e..2e318158fca9 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -70,6 +70,10 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 #define LPSS_CAPS_CS_EN_SHIFT			9
 #define LPSS_CAPS_CS_EN_MASK			(0xf << LPSS_CAPS_CS_EN_SHIFT)
 
+#define LPSS_PRIV_CLOCK_GATE 0x38
+#define LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK 0x3
+#define LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON 0x3
+
 struct lpss_config {
 	/* LPSS offset from drv_data->ioaddr */
 	unsigned offset;
@@ -86,6 +90,8 @@ struct lpss_config {
 	unsigned cs_sel_shift;
 	unsigned cs_sel_mask;
 	unsigned cs_num;
+	/* Quirks */
+	unsigned cs_clk_stays_gated : 1;
 };
 
 /* Keep these sorted with enum pxa_ssp_type */
@@ -156,6 +162,7 @@ static const struct lpss_config lpss_platforms[] = {
 		.tx_threshold_hi = 56,
 		.cs_sel_shift = 8,
 		.cs_sel_mask = 3 << 8,
+		.cs_clk_stays_gated = true,
 	},
 };
 
@@ -383,6 +390,22 @@ static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
 	else
 		value |= LPSS_CS_CONTROL_CS_HIGH;
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
+	if (config->cs_clk_stays_gated) {
+		u32 clkgate;
+
+		/*
+		 * Changing CS alone when dynamic clock gating is on won't
+		 * actually flip CS at that time. This ruins SPI transfers
+		 * that specify delays, or have no data. Toggle the clock mode
+		 * to force on briefly to poke the CS pin to move.
+		 */
+		clkgate = __lpss_ssp_read_priv(drv_data, LPSS_PRIV_CLOCK_GATE);
+		value = (clkgate & ~LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK) |
+			LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON;
+
+		__lpss_ssp_write_priv(drv_data, LPSS_PRIV_CLOCK_GATE, value);
+		__lpss_ssp_write_priv(drv_data, LPSS_PRIV_CLOCK_GATE, clkgate);
+	}
 }
 
 static void cs_assert(struct spi_device *spi)
-- 
2.25.0.225.g125e21ebc7-goog


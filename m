Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1658159C57
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 23:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgBKWhH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 17:37:07 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:55582 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgBKWhG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Feb 2020 17:37:06 -0500
Received: by mail-ua1-f73.google.com with SMTP id 71so35932uae.22
        for <linux-spi@vger.kernel.org>; Tue, 11 Feb 2020 14:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tn5KLhV2UflAg8SWktUj0z7+eGphwmGyKjf8wzfFF6c=;
        b=urSRtZifT/QzvZKFDFC7/ZnQJbkvRzX80g/fbmNyhIMIZj/8ubezc0r7GhuCo3gyv2
         5ww+otf5kKowLgPCCt/07eDrHteSifb/OmAcx9VEH+SCpMf4mazjoPz8mIyQDDp9xC2W
         OmllTh9rDMxYl40+vl9RFvRlxrztbrK27yD4zEun0wkFGcnBmxp34adEaVDFaA0SvSTD
         rPgT9lIp3j/H/DOH9dz+6/gxhd0q2AaqM5u3r1s1UOK3E9YzIz3y+p+At9GTNI+X7PUl
         DJSJfY+VIAAsd6sDTaA3U2UpygMsRQuGNH81kkq4Lkp/Eu+SK+PtWsex4eRPzgJztDyp
         PxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tn5KLhV2UflAg8SWktUj0z7+eGphwmGyKjf8wzfFF6c=;
        b=Q1UdzGBDTagN/Czc1ul5eIJEtOALSf0iN78NJcas1yFE+xHnMMzSYhBPbCejKSDdKI
         tCXB5gXZF/x+4PwsONDF1uq+3g6w+Q6D0EmjxRR6qQLgsEogjT1Gbi7Z6gS5p84T33v8
         8mGHaAUf5WZ330J7hlC1xtnoBP3nHNF+ZNbsFf5OIVUQn80H0CZCKZ+VJrzy5k4IDyVH
         aeDYJUpqmN6HTsZFPKmDc7t3ZaDEm+FNN+EWpcM7mdg28XyPvdaO1Mx4MZImb6s6LASi
         XYyooqgp5VsJZ6o87anrtc1N9gf1YPjmQcLnjlbssLyncbbh/nSVu3If3bGDGBE2K+3d
         A+OQ==
X-Gm-Message-State: APjAAAXsHDQgn1TZmSty1LN+uWsyuvjNJ0eaIshtknsw6g9W+vAwuHo3
        Qf1hOJ3ItmHvSFEfu5x9lLnts1Y1+luR
X-Google-Smtp-Source: APXvYqyijGY6ooh56SzAuJ6qMrGW2ziMqaiWvXL+KvmMIdnSvi6OHZKuQczrNVVXElDF4HtcbvOaNYXHgan8
X-Received: by 2002:ab0:6902:: with SMTP id b2mr5251519uas.32.1581460624477;
 Tue, 11 Feb 2020 14:37:04 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:37:00 -0800
Message-Id: <20200211223700.110252-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH] spi: pxa2xx: Add CS control clock quirk
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


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D72DD179B70
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 23:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388519AbgCDWCF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 17:02:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52882 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388483AbgCDWCF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Mar 2020 17:02:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so3980248wmc.2;
        Wed, 04 Mar 2020 14:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nkiYqUAkmiXxeyN81XVT4hSDfBwraAVi9gV6dSwD7GM=;
        b=q6JSMBlI+xbBgMot4dKJxrT1oUdxs9NICXa9iBiuZ9ASxIsFU4g5ip1YQxRZNphK+S
         MKWlglmp7e2GgaTPSQjnm8hHW8wT6of505FKASCGjuZEo1zjBuu6isTQz0XcaWYqSzch
         jTh+0V7wLmbir6ikKy+0MxJBKp3eo58KK5eZimYNfzTA1+6nNlqUWN9FqaP2adZFKUF+
         zmxjB3raaf6ettmiOc+r2AVshHy7GxXPqXjYddK7z5eMJGXlOX2XJ0oWqMH9xmcVl/1E
         JSveXx2KkyoiKnsUcQ0ugidWtwb8z01OTY/58lJMQV3Lgxl1HYle0YKkypXo40xfRG5D
         2uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nkiYqUAkmiXxeyN81XVT4hSDfBwraAVi9gV6dSwD7GM=;
        b=cNSlleAroKrCLDUiPI6D2XDAssXSnEiJV4ztSx+Z2Jt9TGUen10CXutqAax/3zUG2I
         NlhhMQvTltMvYufIvEagM/dlqePPswQ9dZ82MR4cNl4RGBGH+awyKN7yngh7znfnkBaK
         iuGpbHVgiLFuJOD4u+sKSyBXfewIh9y6OwhAyChxyhOf8AsBQ/N3kst3r43H3W+1ukI4
         Sgm/MVNVNXyc4yQupURkW689ULaLkArd26+E+kGK+mxvU6fsogsI0svVxjYOU088YH1O
         Ve9RDn0F3MPjX35w8Y+bFg65aisKxUUUgR9113ROGkUJ4N2oYcZXUCwBSuaDU0RCPaOs
         PbJg==
X-Gm-Message-State: ANhLgQ2zPLHyWTy0RVeXCCSzm8jFkbULpki4uZgHcZhc81kJmcZhOTan
        EMU/Wf9+hEFKjEoUPTWCN8c=
X-Google-Smtp-Source: ADFU+vueCayus65JGhI+30MtpzmINBq5kYwMX301JByOCP0ITm7VFOvyWt05vSIQP4SY4EcIgcbsPQ==
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr713240wme.127.1583359321331;
        Wed, 04 Mar 2020 14:02:01 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z2sm36776402wrq.95.2020.03.04.14.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:02:00 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: [PATCH 06/12] spi: spi-fsl-dspi: Implement .max_message_size method for EOQ mode
Date:   Thu,  5 Mar 2020 00:00:38 +0200
Message-Id: <20200304220044.11193-7-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

When it gets set, End Of Queue Flag halts the DSPI controller and forces
the chip select signal to deassert.

This operating mode is not ideal, but it is used for the DSPI
instantiations where there is no other notification from the controller
that the data in the FIFO has finished transmission. So in practice, it
means that transmitting buffers larger than the FIFO size will yield
unpredictable results.

The only controller that operates in EOQ mode is MCF5441X (Coldfire). I
would say that the way EOQ is used (and documented in the reference
manual, too) on this chip is incorrect, and I would personally migrate
it to TCFQ, but that's notably worse in terms of performance (it can
only use 1 entry of the 16-deep FIFO) and if this limitation didn't
bother any Coldfire DSPI user so far, it's likely that we just need to
throw an error for larger buffers to make sure that callers are aware
their transfers are getting truncated/split.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index f37090ad7ad1..158cb48c0f4a 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1084,6 +1084,22 @@ static int dspi_slave_abort(struct spi_master *master)
 	return 0;
 }
 
+/*
+ * EOQ mode will inevitably deassert its PCS signal on last word in a queue
+ * (hardware limitation), so we need to inform the spi_device that larger
+ * buffers than the FIFO size are going to have the chip select randomly
+ * toggling, so it has a chance to adapt its message sizes.
+ */
+static size_t dspi_max_message_size(struct spi_device *spi)
+{
+	struct fsl_dspi *dspi = spi_controller_get_devdata(spi->controller);
+
+	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
+		return dspi->devtype_data->fifo_size;
+
+	return SIZE_MAX;
+}
+
 static int dspi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1105,6 +1121,7 @@ static int dspi_probe(struct platform_device *pdev)
 
 	ctlr->setup = dspi_setup;
 	ctlr->transfer_one_message = dspi_transfer_one_message;
+	ctlr->max_message_size = dspi_max_message_size;
 	ctlr->dev.of_node = pdev->dev.of_node;
 
 	ctlr->cleanup = dspi_cleanup;
-- 
2.17.1


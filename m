Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 192A118575B
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 02:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgCOBfq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Mar 2020 21:35:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42214 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgCOBfp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Mar 2020 21:35:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id b21so6937247edy.9;
        Sat, 14 Mar 2020 18:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FHEa/0MhybiTV6M1eLx+ql9TZNVB4VsBUDo2Iy66e9w=;
        b=dX3pHktetchEsEcqrTMseBKgDEbB8h/wp7Qu4l0ORNQ9n20/+3E21BxEW07QY29/gm
         zrqCbTCBYqtWRLj5qUt0zaPetDrr/TquV3ceA9doCsL7T2gZU6s+kQtZo7raofORPUeN
         TvQGI4KiMgglz4Ae5lMpqzL1T4cpdZ5Qmx9zYwa0EYHCTi8J3OUGvOLIH8RM43uazfLh
         TAHnzXPG5pXtR1+qP+oaH+vUi8EDdKLUGdROPAdYxWgvGEPaBNPw4zTw4YN9uex36zrY
         M8nAmWPmEZfr3njWZs+Xl9A4e1wAvSriLxG5mZKG4lBjbrv1wnxtwWT3wYuc9c4Ylv93
         +SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FHEa/0MhybiTV6M1eLx+ql9TZNVB4VsBUDo2Iy66e9w=;
        b=HfmxWa70gM8ORPXtztjUayEIRnktJfM/4YuBSKnJW6+hcOcs6Wd5ihGKkWkz0IE53k
         r5uvuMKpDkwc6jkDIxuW11jbXIlqaFbPjb4c7Nb6U98H74E0TvXPgCuhSX8f2FNGVEO7
         /QsQ6CqhvQDeCvnqqA8hkQI0XrLJtfSyr6q9xEGlWZIbqTl0+ne0htBOKSwQ59R3uLEp
         9cgzVWrHIOCjGfJVcmvyeJYmRP4k0oXLPk9BphltrlBCeL+ZAqieGBEDcfs6aYz8oIIL
         RqijSmbSe0dl9mHucR9r0phzxl5nNvp7GgaGVrOlpoHayJ8fD8cpIob5jeAMDcRc1p1z
         qO7Q==
X-Gm-Message-State: ANhLgQ0q7dm+/P261fuyKGpMM6VYF602F+ZHXvmtTWaPUeJD25FW+QnI
        2bTQFKhhucPjopeKKWdXPdOu+sTXyfI=
X-Google-Smtp-Source: ADFU+vvGqefJTl5dI11r4MrJ1NyEWWsbP92rkqouOMCOP4/IJxsegR70E0Fhrutde3amv8krRBJ5EQ==
X-Received: by 2002:a5d:4488:: with SMTP id j8mr3462175wrq.306.1584225847484;
        Sat, 14 Mar 2020 15:44:07 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id 133sm23690732wmd.5.2020.03.14.15.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 15:44:07 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 08/12] spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code path
Date:   Sun, 15 Mar 2020 00:43:36 +0200
Message-Id: <20200314224340.1544-9-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314224340.1544-1-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Interrupts are not necessary for DMA functionality, since the completion
event is provided by the DMA driver.

But if the driver fails to request the IRQ defined in the device tree,
it will call dspi_poll which would make the driver hang waiting for data
to become available in the RX FIFO.

Fixes: c55be3059159 ("spi: spi-fsl-dspi: Use poll mode in case the platform IRQ is missing")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v4:
Patch is new.

 drivers/spi/spi-fsl-dspi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index a8aef5690c5d..eab4929330e1 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -974,13 +974,15 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			goto out;
 		}
 
-		if (!dspi->irq) {
-			do {
-				status = dspi_poll(dspi);
-			} while (status == -EINPROGRESS);
-		} else if (trans_mode != DSPI_DMA_MODE) {
-			wait_for_completion(&dspi->xfer_done);
-			reinit_completion(&dspi->xfer_done);
+		if (trans_mode != DSPI_DMA_MODE) {
+			if (dspi->irq) {
+				wait_for_completion(&dspi->xfer_done);
+				reinit_completion(&dspi->xfer_done);
+			} else {
+				do {
+					status = dspi_poll(dspi);
+				} while (status == -EINPROGRESS);
+			}
 		}
 
 		spi_transfer_delay_exec(transfer);
-- 
2.17.1


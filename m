Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56813A66EB
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2019 12:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfICK5Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Sep 2019 06:57:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38372 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbfICK5X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Sep 2019 06:57:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id l11so8144665wrx.5;
        Tue, 03 Sep 2019 03:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=itJJvwat1ZzdUKCW7HBECx8xflq282h9g6c0CkxJ03Q=;
        b=uHkbm2fi4XultRlk6FjQPFKo3sR9RbTFlJElLA8Uz1rnZjqLwSWsTvf8qCHclyoUPE
         VHmlFjmwmOsqjGbiu5EG3H1B+Rb40x5q7MuyMKtDVNgFzUF9kePyT2+euFV+cLupGFcJ
         wcASy+eJpfXTA4quApjhjNRFrWjAgkg749J0NXxresQZUb1l7KcJ+qipZo6e8Z4cMq+9
         sRAHYfgMDtnhZ9csYslCkFcg+HNVHuuxFLzuak+LxMFLzS/MHpeKSm/mKITmR2e5MgR9
         s4domngpc87p1co6hqNDXCq2m9JMyyAb5VzTYUtSlrU3yXe91iPHJleiyz8l2uxoLpVz
         VTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=itJJvwat1ZzdUKCW7HBECx8xflq282h9g6c0CkxJ03Q=;
        b=ZuWSsOFH/BfDjXFo2aByWc1bXsTQHp/OdIuURwGJzR5DBUi2wz75OF12slJJLeTB95
         EgNvYLYJ5BJYniTcRcKN2VI6Cp0GFrhkPKLcym4n2Q9TuIOXX4++mgDK6HZc5EZgs3O2
         d8gizqt5ZTR1RX9PFSN+IzVxdq/jlBwGizBqg+iHbTUCVEhjFKRhH2XAH6J/L+1Jh7/7
         3XVrqrm1GV4kNUCfRUTEPAJ2zdZeMaprCCjth/Rt9+Tzcp5MGCmZGt+AJngKtRIbvfh8
         GYxht/egM6ZSGR9IIv4pPeaS+krhBuzM9RbGQ7GIlDhULiUFpBgUlEh/5RWwGxyGqySv
         q1hA==
X-Gm-Message-State: APjAAAXs5XivCPS5DCcefe6GVKCtaYZqP2mXWNxDxxF+6kVXDUHgiKzW
        AQUfxVQKKycmPmtfDx+Lxj4=
X-Google-Smtp-Source: APXvYqxTSETBqUn2trqP/0D4rt67cUkegxIBjW0deREiAzLj7zwworFS45VMj+Jf3/dasIJxaRayNw==
X-Received: by 2002:adf:ef44:: with SMTP id c4mr20998859wrp.216.1567508241709;
        Tue, 03 Sep 2019 03:57:21 -0700 (PDT)
Received: from localhost.localdomain ([86.126.25.232])
        by smtp.gmail.com with ESMTPSA id o12sm973493wmh.43.2019.09.03.03.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 03:57:21 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH] spi: spi-fsl-dspi: Fix race condition in TCFQ/EOQ interrupt
Date:   Tue,  3 Sep 2019 13:57:08 +0300
Message-Id: <20190903105708.32273-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When the driver is working in TCFQ/EOQ mode (i.e. interacts with the SPI
controller's FIFOs directly) the following sequence of operations
happens:

- The first byte of the tx buffer gets pushed to the TX FIFO (dspi->len
  gets decremented). This triggers the train of interrupts that handle
  the rest of the bytes.

- The dspi_interrupt handles a TX confirmation event. It reads the newly
  available byte from the RX FIFO, checks the dspi->len exit condition,
  and if there's more to be done, it kicks off the next interrupt in the
  train by writing the next byte to the TX FIFO.

Now the problem is that the wait queue is woken up one byte too early,
because dspi->len becomes 0 as soon as the byte has been pushed into the
TX FIFO. Its interrupt has not yet been processed and the RX byte has
not been put from the FIFO into the buffer.

Depending on the timing of the wait queue wakeup vs the handling of the
last dspi_interrupt, it can happen that the main SPI message pump thread
has already returned back into the spi_device driver. When the rx buffer
is on stack (which it can be, because in this mode, the DSPI doesn't do
DMA), the last interrupt will perform a memory write into an rx buffer
that has been freed. This manifests as stack corruption.

The solution is to only wake up the wait queue when dspi_rxtx says so,
i.e. after it has processed the last TX confirmation interrupt and
collected the last RX byte.

Fixes: c55be3059159 ("spi: spi-fsl-dspi: Use poll mode in case the platform IRQ is missing")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 77db43f1290f..bec758e978fb 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -710,9 +710,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)))
 		return IRQ_NONE;
 
-	dspi_rxtx(dspi);
-
-	if (!dspi->len) {
+	if (dspi_rxtx(dspi) == 0) {
 		dspi->waitflags = 1;
 		wake_up_interruptible(&dspi->waitq);
 	}
-- 
2.17.1


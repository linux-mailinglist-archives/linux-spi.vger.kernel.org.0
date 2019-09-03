Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7B3A650C
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2019 11:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfICJVv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Sep 2019 05:21:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38311 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfICJVu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Sep 2019 05:21:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id d10so4237139pgo.5
        for <linux-spi@vger.kernel.org>; Tue, 03 Sep 2019 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TyYF4HJF77AIuVV1Bjov7W0KtMIkm8+Fv+VcPqtMV64=;
        b=XEijOfV/WbGDpLAQk2+XGBJiepAPdqtCOrHF517ZvFuaWU5t3wYJEbs7q/oQqEOxBx
         G3v6tid6q2J3wKqfITkITB69Tkzu2r1V8eej9fogpm30SqQFWpysnvAheM5OmBgHcx7y
         C2dTIBq6Vw5jIbNUrC3awjJg4HM1qUY1znsbW0EULTUNP4vi7WaW5amw2c6b3lbbZb/I
         KSv0b11y6Yq7iEgajviatEcm+3p8bqVMo2MXSJW22hMlLRMAyktuVNApC+6Oj32FOkj5
         hw3Qp2n0g4ZIfpfASrYhveIek5pMJTeBfcQQzgKa6aWiiYp32BCF/NERj//9K7rosEvY
         kNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TyYF4HJF77AIuVV1Bjov7W0KtMIkm8+Fv+VcPqtMV64=;
        b=cC5RG+VKNpi86SqOk+UPhEfWNaE2zwFiFE6ALLqqa/n+tcpFru/mILPMb1SOImgKJ4
         O/ojsZWJeVcW+I/AuL8nzX88ncFIuMAnCl3Ywx07HnpR9D1O8intB0QfCJ+Kv4FvGR3i
         Tivh668+FzmsXGCKnA8yCXnZMYZzKk+HmqjOJ/FNRBDJBr7jw+h3jYC+odQFjVdBcGIK
         gewxhe49UD4BKuGIScS6eIaCb7O/3RmQtehN3GmPabA3DXmMKuLGvylXIXIlbj6BGzUi
         2Ddi9Ooqts8Q0TB+ONJnZFuQ9w+iL0emu9pHuAzBAaqIESLgYAmO43DDWT16ERVD8RY/
         r2hw==
X-Gm-Message-State: APjAAAXNQgSbW5YJivg4QSUEToo0c/XSqYFg089QhB+GmnUK3kAMPYSt
        xAY+uLKhJVdbfKj3ht+gLwjkLZ2vMks=
X-Google-Smtp-Source: APXvYqxgeN+ULUqjSbBQLImzjcCzYTcyLICC938B9LYcc5RwYOh7wRYWEdWwCZMckBC/lKFNyB6gjQ==
X-Received: by 2002:aa7:8bc2:: with SMTP id s2mr16529135pfd.13.1567502509789;
        Tue, 03 Sep 2019 02:21:49 -0700 (PDT)
Received: from localhost ([121.95.100.191])
        by smtp.gmail.com with ESMTPSA id c6sm11889180pgd.66.2019.09.03.02.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Sep 2019 02:21:49 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-spi@vger.kernel.org
Cc:     ard.biesheuvel@linaro.org, jaswinder.singh@linaro.org,
        masahisa.kojima@linaro.org
Subject: [PATCH] spi: spi-synquacer: fix set_cs handling
Date:   Tue,  3 Sep 2019 18:21:18 +0900
Message-Id: <20190903092118.4818-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.14.2
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DMSTOP register must be updated when the slave is
selected/desected.
RXFIFO needs to be cleaned to safely deselect the device.

Fixes: b0823ee35cf9b ("spi: Add spi driver for Socionext SynQuacer platform")
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/spi/spi-synquacer.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index f99abd85c50a..3905d1e1dea6 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -454,22 +454,12 @@ static int synquacer_spi_transfer_one(struct spi_master *master,
 	}
 
 	if (xfer->rx_buf) {
-		u32 buf[SYNQUACER_HSSPI_FIFO_DEPTH];
-
 		val = SYNQUACER_HSSPI_RXE_FIFO_MORE_THAN_THRESHOLD |
 		      SYNQUACER_HSSPI_RXE_SLAVE_RELEASED;
 		writel(val, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
 		status = wait_for_completion_timeout(&sspi->transfer_done,
 			msecs_to_jiffies(SYNQUACER_HSSPI_TRANSFER_TMOUT_MSEC));
 		writel(0, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
-
-		/* stop RX and clean RXFIFO */
-		val = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
-		val |= SYNQUACER_HSSPI_DMSTOP_STOP;
-		writel(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
-		sspi->rx_buf = buf;
-		sspi->rx_words = SYNQUACER_HSSPI_FIFO_DEPTH;
-		read_fifo(sspi);
 	}
 
 	if (status < 0) {
@@ -485,12 +475,35 @@ static void synquacer_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct synquacer_spi *sspi = spi_master_get_devdata(spi->master);
 	u32 val;
+	bool selected;
 
 	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
 	val &= ~(SYNQUACER_HSSPI_DMPSEL_CS_MASK <<
 		 SYNQUACER_HSSPI_DMPSEL_CS_SHIFT);
 	val |= spi->chip_select << SYNQUACER_HSSPI_DMPSEL_CS_SHIFT;
-	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+
+	if (spi->mode & SPI_CS_HIGH)
+		selected = enable;
+	else
+		selected = !enable;
+
+	if (selected) {
+		val &= ~SYNQUACER_HSSPI_DMSTOP_STOP;
+		writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+	} else {
+		u32 buf[SYNQUACER_HSSPI_FIFO_DEPTH];
+
+		/*
+		 * Stop transaction and cleanup RXFIFO to safely deselect
+		 * the device.
+		 */
+		val |= SYNQUACER_HSSPI_DMSTOP_STOP;
+		writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+
+		sspi->rx_buf = buf;
+		sspi->rx_words = SYNQUACER_HSSPI_FIFO_DEPTH;
+		read_fifo(sspi);
+	}
 }
 
 static int synquacer_spi_wait_status_update(struct synquacer_spi *sspi,
-- 
2.14.2


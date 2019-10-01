Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A68C4202
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 22:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfJAUwc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 16:52:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40633 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJAUwc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 16:52:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so17108143wru.7;
        Tue, 01 Oct 2019 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YdRHcVFToHIZbvkxUNJPK19pypp2Z2yOIgvmAjENZz0=;
        b=CZBkuUYHqE3ivHd6F1I66DMYJ2YMY706bvqkad/lOPVvMwKUwiUoZ/zRolnJbuFgsd
         vsdgeiGloPIWskOjaWPQL/Lw0HcGMwMcDXGhRlMkw3txfz6ZXdtdIG3MTM2GXlzEnbC4
         fM8+iq9dYFXk96hlc+oW8gN6C/mUv3ocKDFjeq0jxuvEtg3wfKIjGWPYbiTj09p0uwuo
         8GmsMwEskqskeuMFqVtIeqW0PoAF6X4Df1trUbLTin6GfCsfS9zTjDNPaupyK2pin9Ey
         5Cn/WMXDFYE0Wg5jUSSFbfd1OfosGjodmpSN9LNxozr1Q/L2NlDTUfnUtsUm67AgRzRV
         GgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YdRHcVFToHIZbvkxUNJPK19pypp2Z2yOIgvmAjENZz0=;
        b=k2B86yBpSCXKOtNlwH0CaiKI0y5mDnV70J6wxEYfpKmjRW3oXfcZFk3jzBRof+y9do
         jnfLxHqmM7WYBL7DVBbdWxuW2Uf2rjxSodKALDzOO2G3VZrX7Mrn0k4gHy4SV3pxz+Vv
         +OISrnEA4ebHKG3fcz7YTFmynPrFGPN6jGSHn8E+PT8wTMjZbN+A7JaOaTlDhm7yyD1i
         PN2P1UwyR2XBoxl+7gHL/ZeczsmJBEJK6x/kZ2Iz5Vlt4fIAmFZtpTIqGrA8lYwlMAdY
         UxN1Weku7ftZ5AFmDwL3uLzO29ulSTUiIOllr6n1zdKrznkS++Ya6WbcYiIWtiyuAFbh
         4vtQ==
X-Gm-Message-State: APjAAAUxBtIaZ590ABtud0URGxGN17Kt1O1XMaDt5WPfXgd5Nxjs6Ofw
        qnRpoTnfai/YVxYYoV+Yg5o=
X-Google-Smtp-Source: APXvYqxkB68UDBZMJnWyKXg3gFOPUhWrTyeISJjqxdeI58U/o4a7897AxfLSCcjzW1MLdXsAVJ7VYA==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr18999590wrv.350.1569963147806;
        Tue, 01 Oct 2019 13:52:27 -0700 (PDT)
Received: from localhost.localdomain ([86.124.196.40])
        by smtp.gmail.com with ESMTPSA id y13sm26680057wrg.8.2019.10.01.13.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 13:52:27 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH] spi: spi-fsl-dspi: Always use the TCFQ devices in poll mode
Date:   Tue,  1 Oct 2019 23:52:16 +0300
Message-Id: <20191001205216.32115-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

With this patch, the "interrupts" property from the device tree bindings
is ignored, even if present, if the driver runs in TCFQ mode.

Switching to using the DSPI in poll mode has several distinct
benefits:

- With interrupts, the DSPI driver in TCFQ mode raises an IRQ after each
  transmitted word. There is more time wasted for the "waitq" event than
  for actual I/O. And the DSPI IRQ count can easily get the largest in
  /proc/interrupts on Freescale boards with attached SPI devices.

- The SPI I/O time is both lower, and more consistently so. Attached to
  some Freescale devices are either PTP switches, or SPI RTCs. For
  reading time off of a SPI slave device, it is important that all SPI
  transfers take a deterministic time to complete.

- In poll mode there is much less time spent by the CPU in hardirq
  context, which helps with the response latency of the system, and at
  the same time there is more control over when interrupts must be
  disabled (to get a precise timestamp measurement, which will come in a
  future patch): win-win.

On the LS1021A-TSN board, where the SPI device is a SJA1105 PTP switch
(with a bits_per_word=8 driver), I created a "benchmark" where I
periodically transferred a 12-byte message once per second, for 120
seconds. I then recorded the time before putting the first byte in the
TX FIFO, and the time after reading the last byte from the RX FIFO. That
is the transfer delay in nanoseconds.

Interrupt mode:

  delay: min 125120 max 168320 mean 150286 std dev 17675.3

Poll mode:

  delay: min 69440 max 119040 mean 70312.9 std dev 8065.34

Both the mean latency and the standard deviation are more than 50% lower
in poll mode than in interrupt mode, and the 'max' in poll mode is lower
than the 'min' in interrupt mode. This is with an 'ondemand' governor on
an otherwise idle system - therefore running mostly at 600 MHz out of a
max of 1200 MHz.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index bec758e978fb..7bb018eb67d0 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -707,7 +707,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 	regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
-	if (!(spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)))
+	if (!(spi_sr & SPI_SR_EOQF))
 		return IRQ_NONE;
 
 	if (dspi_rxtx(dspi) == 0) {
@@ -1114,6 +1114,9 @@ static int dspi_probe(struct platform_device *pdev)
 
 	dspi_init(dspi);
 
+	if (dspi->devtype_data->trans_mode == DSPI_TCFQ_MODE)
+		goto poll_mode;
+
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq <= 0) {
 		dev_info(&pdev->dev,
-- 
2.17.1


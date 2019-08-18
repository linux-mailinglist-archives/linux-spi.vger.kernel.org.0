Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C07591894
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfHRSB0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37227 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfHRSB0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so6359024wrt.4
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ARaiad/v4h9z7C6bz5/z4DmGPKh06OX6JHvtSq/Dxe0=;
        b=VQ8M9sVQnPiE6Gm2oJzWhEeqGtjg9dFeclFnADIL5iM8v0KwnmxFVlyG7b/ERkh1WU
         KeiFlpuexzl0ADSqUfFuufupA9fC7H0c31zLu8lFLMDKa5d8mrmP5wJqSY+WBAxmPPwK
         U+3A77tLb88EsYHM8FFrR5kGzZLC8c6njMLpa9662ceXPXAIq+yIYb2YtdNcYdUA/P/W
         4Ry3oXqlo+uR9GDe5NAtavb3l/reaNgLv1w7Mualx8HahxEmSikWV+RjOBsCvV3+1cXE
         RBtO+mRr3K3WnRM7Mi9+uii+kSdA/nOrNjmzqmgK7IAxPpOlCWjzlTquGfJSH0TLZjj/
         U5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ARaiad/v4h9z7C6bz5/z4DmGPKh06OX6JHvtSq/Dxe0=;
        b=t9Snlw84QBhjilWorWJR17g31kPj7CbBYA5rY5lXojnXebDq24jKlwYqp0lCq1VDO6
         l+v3ffgDTlomo3+1kldw6xS7URka5kQgZPIkIp0bfDKZa8FX+gLV9MJn793UrnfCKSBa
         xGNzlTR5QIGYwxVSNatFotlToy48bhuzWvzUia5iD0InugaF2vBD1AGXGQAb2Chck9ai
         SORxlDFZQoiXd6G73GWIiqBXNubkSbSIQkqDYZkP0Ga4yov9q6xeogU8L+YGk/5eaexL
         J5AjRf2+ESSQ9dplMxfNhzzekLjycY4jqt9APSUlBpwtRDY77bhZGNEWEGLeME4SJWWI
         nqOw==
X-Gm-Message-State: APjAAAUIOmE+AGoEyRtqVPcQjRkGnonNnEnIXVqapUh43cAaEyVlghq0
        2aXXd55Mp15crS/XlX4Af+g=
X-Google-Smtp-Source: APXvYqyo87IiGQVdtDgfDWBITjJA9hLNMVgtqSPfYm0pXKn+vtnCscbWOmuNJeh4quw3Q0i5YD3iOA==
X-Received: by 2002:adf:e78c:: with SMTP id n12mr21916743wrm.83.1566151284221;
        Sun, 18 Aug 2019 11:01:24 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:23 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 04/14] spi: spi-fsl-dspi: Demistify magic value in SPI_SR_CLEAR
Date:   Sun, 18 Aug 2019 21:01:05 +0300
Message-Id: <20190818180115.31114-5-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds the field definitions for the SPI_SR register. The SPI
status register is write-1-to-clear and this value is written at init
time.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 179a9818619f..923ee414d1ae 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -57,7 +57,19 @@
 #define SPI_SR				0x2c
 #define SPI_SR_TCFQF			BIT(31)
 #define SPI_SR_EOQF			BIT(28)
-#define SPI_SR_CLEAR			0x9aaf0000
+#define SPI_SR_TFUF			BIT(27)
+#define SPI_SR_TFFF			BIT(25)
+#define SPI_SR_CMDTCF			BIT(23)
+#define SPI_SR_SPEF			BIT(21)
+#define SPI_SR_RFOF			BIT(19)
+#define SPI_SR_TFIWF			BIT(18)
+#define SPI_SR_RFDF			BIT(17)
+#define SPI_SR_CMDFFF			BIT(16)
+#define SPI_SR_CLEAR			(SPI_SR_TCFQF | SPI_SR_EOQF | \
+					SPI_SR_TFUF | SPI_SR_TFFF | \
+					SPI_SR_CMDTCF | SPI_SR_SPEF | \
+					SPI_SR_RFOF | SPI_SR_TFIWF | \
+					SPI_SR_RFDF | SPI_SR_CMDFFF)
 
 #define SPI_RSER_TFFFE			BIT(25)
 #define SPI_RSER_TFFFD			BIT(24)
-- 
2.17.1


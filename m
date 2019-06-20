Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B38B4C963
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2019 10:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfFTIYt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jun 2019 04:24:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38885 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfFTIYt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jun 2019 04:24:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id v11so1185674pgl.5
        for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2019 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pJbc/qPdW8lHkXoqwLBQ/OGgKBVvW4RHSru8Vl1YTxM=;
        b=aueYmegw+YtRYaq+XY3qMWQtnZ0Dd02weIkX2OouxCS835+ZnJrQvL5vSwvdrRts75
         eT2iItxzI3keaKhPIpeaVD3fUBSk+g4LkwHbvRNy5BJaaonBVRcZiQaYxfeTLvSdvCEK
         xd2b61Fo7TYA0eu9T+jeCf8m+kIvkpksodjTGvqPD2Dm2qXWSyLGxuMrRGGjkjjaOV7W
         C9Xu2cYGsi3nwHy1aUMmGmmA/MhEcCmSUoI7dALOZuEzV0edCNxguFIKyxxRfmrdUGvV
         roAQG9P6Oyst7mqZgi3UFRqmyfQCImFOFcVE5GBQMof9dT86mqg3FcBqzlOtCFbSUoB6
         DNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pJbc/qPdW8lHkXoqwLBQ/OGgKBVvW4RHSru8Vl1YTxM=;
        b=cQpgkALsr4mqYJchx/8Ds/X6C3V6obLUTGrYKMg+5U2bkMSNCLwmEZZz0Rtmlz0Ncm
         NjI9Y0BXm42rmUI0EyLZFgMJyrmNTPURhrjbGmsqQhinWth82vmk02Bt+pZevNYSVhtf
         ynENXyMCHyru8nr3lR3ludJqHW/PHZ3tXQb35Wq7rn6jXGTo0EPDdjl5youYmiyUn4lM
         7Gdg+dVOyA/9JfL8vR8XSkz/KZDUJ7Mg8zwGl8Ue5UkUUJEWp7mEkSkS/9k6NUfZUbZW
         zrc7YNcZIDPvGGWCA7E5Hnq32m2E3LXvSxj21L3v7A9E8n3BLLb6LKcWSwxgz55vahI/
         iaoQ==
X-Gm-Message-State: APjAAAWZfzh8OliNTqsoFtg5Id6Kxxuhxa//GvJeF/7WXmpRzljE/b3b
        d2eSCPwprDPDA/msZB4XgscfUg==
X-Google-Smtp-Source: APXvYqxPXvQ/oakAEjYnC3bpGtfZ0h3MK0ELuibEeGve8yBg7ZZoUQ3APcSnN5cxSjAT9UydCU6WEg==
X-Received: by 2002:a63:d755:: with SMTP id w21mr11905352pgi.311.1561019088436;
        Thu, 20 Jun 2019 01:24:48 -0700 (PDT)
Received: from localhost ([121.95.100.191])
        by smtp.gmail.com with ESMTPSA id k3sm3569597pju.27.2019.06.20.01.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 01:24:47 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     lkp@intel.com, linux-spi@vger.kernel.org
Cc:     kbuild-all@01.org, broonie@kernel.org, jaswinder.singh@linaro.org,
        ard.biesheuvel@linaro.org,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2] spi: spi-synquacer: Fixed build on architectures missing readsl/writesl series
Date:   Thu, 20 Jun 2019 17:24:26 +0900
Message-Id: <20190620082426.14530-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.14.2
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

kbuild test reported that alpha and some of the architectures
are missing readsl/writesl series.
Use more portable ioread32_rep()/iowrite32_rep() series.

Fixes: b0823ee35cf9b ("spi: Add spi driver for Socionext SynQuacer platform")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
Changes since v1:
        # Instead of updating Kconfig, use more portable
          ioread32_rep()/iowrite32_rep() series.

 drivers/spi/spi-synquacer.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index c8c8d9cdd4b3..f99abd85c50a 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -150,14 +150,16 @@ static int read_fifo(struct synquacer_spi *sspi)
 	case 8: {
 		u8 *buf = sspi->rx_buf;
 
-		readsb(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
+		ioread8_rep(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO,
+			    buf, len);
 		sspi->rx_buf = buf + len;
 		break;
 	}
 	case 16: {
 		u16 *buf = sspi->rx_buf;
 
-		readsw(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
+		ioread16_rep(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO,
+			     buf, len);
 		sspi->rx_buf = buf + len;
 		break;
 	}
@@ -166,7 +168,8 @@ static int read_fifo(struct synquacer_spi *sspi)
 	case 32: {
 		u32 *buf = sspi->rx_buf;
 
-		readsl(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
+		ioread32_rep(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO,
+			     buf, len);
 		sspi->rx_buf = buf + len;
 		break;
 	}
@@ -191,14 +194,16 @@ static int write_fifo(struct synquacer_spi *sspi)
 	case 8: {
 		const u8 *buf = sspi->tx_buf;
 
-		writesb(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
+		iowrite8_rep(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO,
+			     buf, len);
 		sspi->tx_buf = buf + len;
 		break;
 	}
 	case 16: {
 		const u16 *buf = sspi->tx_buf;
 
-		writesw(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
+		iowrite16_rep(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO,
+			      buf, len);
 		sspi->tx_buf = buf + len;
 		break;
 	}
@@ -207,7 +212,8 @@ static int write_fifo(struct synquacer_spi *sspi)
 	case 32: {
 		const u32 *buf = sspi->tx_buf;
 
-		writesl(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
+		iowrite32_rep(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO,
+			      buf, len);
 		sspi->tx_buf = buf + len;
 		break;
 	}
-- 
2.14.2


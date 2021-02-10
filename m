Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F2F316874
	for <lists+linux-spi@lfdr.de>; Wed, 10 Feb 2021 14:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhBJNz5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Feb 2021 08:55:57 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:47809 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhBJNzv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Feb 2021 08:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612965349; x=1644501349;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QoGiBbZ+H0/iM6M5m4nJViWNCG0mv/KdSdvAG9Hr1BM=;
  b=nZ8hFnislJI3NI3uJFGk7yu5QeU52FZwTKUQu6USnbsc/qPgnkivBckZ
   LY5HwOL2uEphnYqBP7nO5vO1yztbUC50YVKc+5jyXSqXnFCc53IBdhPgH
   4Htcqfq9P7e4hoKXh7M1kLUUigm8eR+bEWCujn4e2K3IxLjQfXT841N/Y
   wNFxPioUgJyG24aHW4wCTN9O/2j0b0ixs4q/1hpKPvQEBO0JU6IfrtKjd
   3d80cZQpxAlsdcl9dM+t24AFH45XE7RjkiVz2p04HyDG2Vfs5fBRULaZb
   cbKqv2xUzA+3rmJceikJdmeLenaS27wiWPog3iWQvPH2Pqyt1OxDDnDNf
   g==;
IronPort-SDR: W2WbqYcSfJDFqrcArai3glmpA/MwOKEZAx8AGbilpVjLCgxQj/S4O37HC9xhQMHCIlxvtoQlVf
 3/oGutRKyuj7J6S9uma28oNzuOgxtNP6v0ten4C4vV7DKEoV8f3dNm5tFkwJj8CNAT3Kr979qw
 hL5tQjGMzRoxnXJuyFJ/IEtYidEJmHmoBFyjl9mTBIL6cmFOCRwpErzUkxw4siVp+G8mlybG6c
 9Zou1Bs9VIQKankkgE7P2q9Z9sbWlLtPytngG7l06jSvBYXdIFeKISN9HRVrHovMfIgYhyJMDl
 8Dw=
X-IronPort-AV: E=Sophos;i="5.81,168,1610434800"; 
   d="scan'208";a="103297451"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 06:54:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 06:54:34 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 10 Feb 2021 06:54:32 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] spi: atmel-quadspi: Disable the QSPI IP at suspend()
Date:   Wed, 10 Feb 2021 15:54:28 +0200
Message-ID: <20210210135428.204134-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It is safer to disable the QSPI IP at suspend, in order to avoid
possible impact of glitches on the internal FSMs. This is a theoretical
fix, there were no problems seen as of now. Tested on sama5d2 and
sam9x60 versions of the IP.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 10bc5390ab91..95d4fa32c299 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -657,6 +657,7 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 
+	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
 	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
 
-- 
2.25.1


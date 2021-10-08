Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AA4427264
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 22:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbhJHUiP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 16:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242708AbhJHUiN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Oct 2021 16:38:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED68C061570;
        Fri,  8 Oct 2021 13:36:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n2so6849364plk.12;
        Fri, 08 Oct 2021 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wd5gu8136YyHYuJsg3JhOa0wfqoSN4X2AQow/TSvsRk=;
        b=HJbsDYD1vPF39XxaS1wQnkzZ4QA5z9idg5s+nLKYNjFMrck/CEIUCP9R2Zcsc24ob+
         VX8LhrXfxDhdmwLLFrdT6b3/VBKBUcMM5/MS7xw87Jdq8sVfOtm5rueKiC7vsSZfbKMr
         cC9ykYFQJilz+GhcdQQrA9CvcPCUdWVLT4sNaCP3CPD4XsBnY+2KzjUCTgypHH7OEhpr
         CVpVAkSjF5mVsXPGblCcs/Lyp4SZRT0vDQXWPP9nQYu/kaZZOmH9dOV+J6Uztqji2gLK
         N06B3Ggf5mLZPQkWUPz9aFpBvZNTo7fKd/QsFEHSPmuVnQIU2Wn+RsPbPfpcGDAyoB+y
         vw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wd5gu8136YyHYuJsg3JhOa0wfqoSN4X2AQow/TSvsRk=;
        b=g2XE30fVabG/NTmsiNBLIQo8o2Hxen++0d6A+7XK6GWfWqkLLpHw/FxJDdasYn7der
         LveoS0n4ctfcTUVr0Um1jdBCoIRkTw7x7DWoKW+QgHjlcXShW5bwnu1kIrxDIO5UN9zb
         EdVT/xUMVCWCaItSouwDlPsIYAXyhQ6JS7W7ode3ipkYciaiuTIKWsE8p3vwbe53cxxU
         CHoYW8J9fOhQUDDskG/lurHbfpNo84NCQBrKyYwtPJcKSSQ3CwLLG041haAi+sge8BwU
         /697HkzfGENjAJWapDg5pitCxAmqZh0ypzXasws+1bM0YxITgxAinSFCeixQn4IaDxsT
         JcyA==
X-Gm-Message-State: AOAM530cGynxL9QzfETGenFSpSlcD2Ww3bAC/9qLNqG37y7kDU33ViHH
        F8glRIgf7kd+xvCFXHXR908=
X-Google-Smtp-Source: ABdhPJzNurZfwfRCaCUrbPGCTSEG6+OBEm/OT1vbVhNjPBshuhUAu1EzpUlB6ltQyAIxd4ugiQl7fQ==
X-Received: by 2002:a17:90b:3797:: with SMTP id mz23mr14027574pjb.216.1633725377709;
        Fri, 08 Oct 2021 13:36:17 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q6sm117615pjd.26.2021.10.08.13.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 13:36:17 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        yendapally.reddy@broadcom.com, Kamal Dasu <kdasu@broadcom.com>
Subject: [PATCH 3/3] spi: bcm-qspi: add support for 3-wire mode for half duplex transfer
Date:   Fri,  8 Oct 2021 16:36:03 -0400
Message-Id: <20211008203603.40915-4-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008203603.40915-1-kdasu.kdev@gmail.com>
References: <20211008203603.40915-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Kamal Dasu <kdasu@broadcom.com>

This change configures the MSPI controller to use 3-wire interface when
a slave device devictree nodes indicates this via the optional property.

Signed-off-by: Kamal Dasu <kdasu@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index c7c467f15e63..6cb2019cc8fc 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -103,6 +103,7 @@
 #define MSPI_MASTER_BIT			BIT(7)
 
 #define MSPI_NUM_CDRAM				16
+#define MSPI_CDRAM_OUTP				BIT(8)
 #define MSPI_CDRAM_CONT_BIT			BIT(7)
 #define MSPI_CDRAM_BITSE_BIT			BIT(6)
 #define MSPI_CDRAM_DT_BIT			BIT(5)
@@ -122,6 +123,8 @@
 #define MSPI_SPCR3_DAM_8BYTE			0
 #define MSPI_SPCR3_DAM_16BYTE			(BIT(2) | BIT(4))
 #define MSPI_SPCR3_DAM_32BYTE			(BIT(3) | BIT(5))
+#define MSPI_SPCR3_HALFDUPLEX			BIT(6)
+#define MSPI_SPCR3_HDOUTTYPE			BIT(7)
 #define MSPI_SPCR3_DATA_REG_SZ			BIT(8)
 #define MSPI_SPCR3_CPHARX			BIT(9)
 
@@ -613,6 +616,9 @@ static void bcm_qspi_hw_set_parms(struct bcm_qspi *qspi,
 		/* enable fastbr */
 		spcr |=	MSPI_SPCR3_FASTBR;
 
+		if (xp->mode & SPI_3WIRE)
+			spcr |= MSPI_SPCR3_HALFDUPLEX |  MSPI_SPCR3_HDOUTTYPE;
+
 		if (bcm_qspi_has_sysclk_108(qspi)) {
 			/* SYSCLK_108 */
 			spcr |= MSPI_SPCR3_SYSCLKSEL_108;
@@ -940,6 +946,10 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
 		mspi_cdram |= ((tp.trans->bits_per_word <= 8) ? 0 :
 			       MSPI_CDRAM_BITSE_BIT);
 
+		/* set 3wrire halfduplex mode data from master to slave */
+		if ((spi->mode & SPI_3WIRE) && tp.trans->tx_buf)
+			mspi_cdram |= MSPI_CDRAM_OUTP;
+
 		if (has_bspi(qspi))
 			mspi_cdram &= ~1;
 		else
@@ -1480,7 +1490,8 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	qspi->master = master;
 
 	master->bus_num = -1;
-	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_RX_DUAL | SPI_RX_QUAD;
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_RX_DUAL | SPI_RX_QUAD |
+				SPI_3WIRE;
 	master->setup = bcm_qspi_setup;
 	master->transfer_one = bcm_qspi_transfer_one;
 	master->mem_ops = &bcm_qspi_mem_ops;
-- 
2.17.1


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884151ACEF9
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 19:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbgDPRoD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 13:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391931AbgDPRn6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 13:43:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765EAC061A0C;
        Thu, 16 Apr 2020 10:43:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so5855448wma.4;
        Thu, 16 Apr 2020 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6hizQ9MDGHiTOD5MNnBXvIh1bEhJWtJMbrkJ0+RAhQw=;
        b=vLBQGd6K1Gb+dgqEiU4e6EXjgP2FduFXCjYVdLb8N7HwpdX9d8EsNT1tyFW4sZFGkr
         MYogMHjFFkiF9GlWIxRpSJ4QSd+jARn4WKMyfaFspWKYEebDxF8S71ZcLAs8/N+IEtmx
         4/DROzndmb4nFulcAU7JoI+U3V2Jppkdr0SGtQ6Id+mGiq9Sfka4mQ7EYumoRXOphbw4
         UV75XXknppFxyp7t+83DNVQ8CwWGzvGSQwH3GKUGouzpNtpFEC+G1CSzdfxja7jnKB0g
         Qr6XwTiP3LsBSkrCaOi24hctRPmNzlj+Wa/4N5IU5AWWdIer/ND8qMtLO5ZbZsHgtRwH
         MyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6hizQ9MDGHiTOD5MNnBXvIh1bEhJWtJMbrkJ0+RAhQw=;
        b=A0YW128FTpXSuoe3dGis1MZCyoi2AjPYEX4NUY1f1Xx1l8cczdWSzUjSUUY2QHrkiw
         1AFWoUOjL9zAgeHZ0UebrOwh0ZXW2sO99jjf7vvDVgP1rbv5VJRDqLO5C0AOA+pLZS+5
         Js7JSyIVeisu5dCXkXRa8NQC82QBBpn3rUJgLm4d4hyYB6aOTynyhU9u82+rsjraKwOP
         tNFf3qjB4rC+QeiQmvpTMBN1jvUh5FL8H8jtwOQyH7xNMNKxNkVW3inCYdzZqfNjIohb
         3Tquok4uqMq4SOiufmciM3seg0RzdenYsSOYErhtlhLa47BzgW+ojwYNCz+XT9bFxtI+
         qSfA==
X-Gm-Message-State: AGi0PubFgEhKMXI5xYa8eLXC18Fb+HExt5YVJADD1JCjsL66EEqCS/67
        bKbnfHlAdoQY4g1eur359fU=
X-Google-Smtp-Source: APiQypJtA63SceSyBnECHaUA/PGqm3c/BBAkdkj36st7u2lNisEb+Ln9BVI75JKxjT6SuBDXqbgfIQ==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr5876000wmk.158.1587059037289;
        Thu, 16 Apr 2020 10:43:57 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p7sm28736296wrf.31.2020.04.16.10.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 10:43:56 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch 9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists only on legacy controllers
Date:   Thu, 16 Apr 2020 13:43:09 -0400
Message-Id: <20200416174309.34044-9-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416174309.34044-1-kdasu.kdev@gmail.com>
References: <20200416174309.34044-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Set MASTER bit on the MSPI_SPCR0_MSB only for legacy MSPI and HIF_MSPI
controllers.

refs #SWLINUX-5186

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 99f2cfcbb50c..681d09085175 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -576,11 +576,17 @@ static void bcm_qspi_hw_set_parms(struct bcm_qspi *qspi,
 	spcr = clamp_val(spbr, bcm_qspi_spbr_min(qspi), QSPI_SPBR_MAX);
 	bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_LSB, spcr);
 
-	spcr = MSPI_MASTER_BIT;
+	if (!qspi->mspi_maj_rev)
+		/* legacy controller */
+		spcr = MSPI_MASTER_BIT;
+	else
+		spcr = 0;
+
 	/* for 16 bit the data should be zero */
 	if (xp->bits_per_word != 16)
 		spcr |= xp->bits_per_word << 2;
 	spcr |= xp->mode & 3;
+
 	bcm_qspi_write(qspi, MSPI, MSPI_SPCR0_MSB, spcr);
 
 	if (bcm_qspi_has_fastbr(qspi)) {
-- 
2.17.1


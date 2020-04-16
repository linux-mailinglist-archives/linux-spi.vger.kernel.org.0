Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5ED41ACEEF
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 19:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbgDPRni (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 13:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732294AbgDPRng (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 13:43:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B05C061A0C;
        Thu, 16 Apr 2020 10:43:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z6so5891792wml.2;
        Thu, 16 Apr 2020 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mO+e6MGsJdi3QsmX2S9FqCiq+qKAo+MDQiNuazkChc4=;
        b=ACw1AfFVrYxHZjAjNkgGEIRJzdWedZKZWp7j0/MHwMHMF7oUMra814vvcczskNG32r
         FyBZxUAhxZWLtCJ828biJxlsQ+BovEBz0XE2Hk3VtGrE0YFSBEeFL0wQqcVKudJmyCe+
         hsIsUSXg4WlXzJJMSqBV4VscdvIliYzAkGxxWxKSXOQPoFx4Hh/R/e6zFDspuEFgzuG5
         BBNTH4ws6ftAns2If1uZP53FdcgNZP553fC9yr2IcBekT4NtJF88pelN8NkdCLfXSKR9
         ulo17fZTOwxH1qgVcW8rrDFynQktjtDnT4Y66LO0h1jPFtZ9oHO/W18s5RltksVxmiOn
         MZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mO+e6MGsJdi3QsmX2S9FqCiq+qKAo+MDQiNuazkChc4=;
        b=BS5xm/IYh8D/ZemHBKTzTd1zcrvkhoZAc/Flu8pwMNPKlZyvJI4s5VaX8qfCHIZBYs
         WuBAVRTl9UHaoWz5tE6i1Bic/3aygwVWLd8lmzzn4kgmSZEIu6jIW+cmfLAPQD9qOGAi
         MG1zSt+dV5u3C/+zu32h0DkJPeoeO6Lxd2CIdN6bfSOWKBL1bUHy3DvI36Y/cnerkin3
         gKlpYDoWcMYldh0KUHJgvaXbSnbM3Si/8VNfs02iA3JyDSIWcDKQVib1JZGKRtdWioyS
         aDUYbNWFtOm5aTW5jzTGF1GfNSZODwWMjBYjwYbK7niTZYb9vI5hqd6VwNTPRmKkgYzA
         pZKg==
X-Gm-Message-State: AGi0PuZkxyN501glzhrQ+mLlgVG+OpAFHz1zh4eKStys+VopjQqlJjAm
        6ioftdQIU+iYeFyC0fW8vmuVXIlpvFE=
X-Google-Smtp-Source: APiQypLDdovKOE9yjlS65QI5XaW2j50gsfOO1hlwgjy9IF38K1hiwjin3Epsi4NVuBsfLaJwmNVMKg==
X-Received: by 2002:a1c:2b43:: with SMTP id r64mr6157823wmr.77.1587059014461;
        Thu, 16 Apr 2020 10:43:34 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p7sm28736296wrf.31.2020.04.16.10.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 10:43:34 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch 4/9] spi: bcm-qspi: Drive MSPI peripheral SSb pin on cs_change
Date:   Thu, 16 Apr 2020 13:43:04 -0400
Message-Id: <20200416174309.34044-4-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416174309.34044-1-kdasu.kdev@gmail.com>
References: <20200416174309.34044-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

As per the spi core implementation for MSPI devices when the transfer is
the last one in the message, the chip may stay selected until the next
transfer. On multi-device SPI busses with nothing blocking messages going
to other devices, this is just a performance hint; starting a message to
another device deselects this one. But in other cases, this can be used
to ensure correctness. Some devices need protocol transactions to be built
from a series of spi_message submissions, where the content of one message
is determined by the results of previous messages and where the whole
transaction ends when the chipselect goes intactive.

On CS change after completing the last serial transfer, the MSPI driver
drives SSb pin CDRAM register correctly according comments in core spi.h
as shown below:

case 1) EOM =1, cs_change =0: SSb inactive
case 2) EOM =1, cs_change =1: SSb active
case 3) EOM =0, cs_change =0: SSb active
case 4) EOM =0, cs_change =1: SSb inactive

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index d901dcb10d06..c48c399dce53 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -615,19 +615,15 @@ static int update_qspi_trans_byte_count(struct bcm_qspi *qspi,
 		if (qt->trans->cs_change &&
 		    (flags & TRANS_STATUS_BREAK_CS_CHANGE))
 			ret |= TRANS_STATUS_BREAK_CS_CHANGE;
-		if (ret)
-			goto done;
 
-		dev_dbg(&qspi->pdev->dev, "advance msg exit\n");
 		if (bcm_qspi_mspi_transfer_is_last(qspi, qt))
-			ret = TRANS_STATUS_BREAK_EOM;
+			ret |= TRANS_STATUS_BREAK_EOM;
 		else
-			ret = TRANS_STATUS_BREAK_NO_BYTES;
+			ret |= TRANS_STATUS_BREAK_NO_BYTES;
 
 		qt->trans = NULL;
 	}
 
-done:
 	dev_dbg(&qspi->pdev->dev, "trans %p len %d byte %d ret %x\n",
 		qt->trans, qt->trans ? qt->trans->len : 0, qt->byte, ret);
 	return ret;
@@ -774,7 +770,16 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
 	bcm_qspi_write(qspi, MSPI, MSPI_NEWQP, 0);
 	bcm_qspi_write(qspi, MSPI, MSPI_ENDQP, slot - 1);
 
-	if (tstatus & TRANS_STATUS_BREAK_DESELECT) {
+	/*
+	 *  case 1) EOM =1, cs_change =0: SSb inactive
+	 *  case 2) EOM =1, cs_change =1: SSb stay active
+	 *  case 3) EOM =0, cs_change =0: SSb stay active
+	 *  case 4) EOM =0, cs_change =1: SSb inactive
+	 */
+	if (((tstatus & TRANS_STATUS_BREAK_DESELECT)
+	     == TRANS_STATUS_BREAK_CS_CHANGE) ||
+	    ((tstatus & TRANS_STATUS_BREAK_DESELECT)
+	     == TRANS_STATUS_BREAK_EOM)) {
 		mspi_cdram = read_cdram_slot(qspi, slot - 1) &
 			~MSPI_CDRAM_CONT_BIT;
 		write_cdram_slot(qspi, slot - 1, mspi_cdram);
-- 
2.17.1


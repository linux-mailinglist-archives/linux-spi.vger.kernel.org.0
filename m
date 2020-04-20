Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19D31B1577
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 21:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgDTTJd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 15:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727873AbgDTTJ2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Apr 2020 15:09:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E3EC061A0C;
        Mon, 20 Apr 2020 12:09:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so11536868wrb.8;
        Mon, 20 Apr 2020 12:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mO+e6MGsJdi3QsmX2S9FqCiq+qKAo+MDQiNuazkChc4=;
        b=lj/Yowy3mR+wzrP1hv/Lipx2wxOFCvJx7zwCePnxQBgh3cINmba7Ci9nAWmE4X7A7O
         3EnBYGEylOQ2eudOMBV10N2DOuTIqyuwLHneQNPgHx0PIh0dxMST2wDLDhtGKepq11vT
         a8ZT07xbcZQh7/B8rct2AdxLGG8IOi8puKbTicodJzksTd46gCwKtduoKCKWoif0bu64
         AI2wiprTJYA4KeXwAVp25Xhl/y/Vp2hlwjzGKvOU4F8y+yrvdOH00nkApEnDeiYNuiiX
         Y+/P9KeN8qsgsgNchrAEqfaIAYJvmhN0JIV2cjbcCvfo4iFBQRtVC1e3BlPT7b/JGHSN
         Y0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mO+e6MGsJdi3QsmX2S9FqCiq+qKAo+MDQiNuazkChc4=;
        b=jp08pZKHtzh1PiQsRUIk1t7WYoYFwwmtZTbGQDycaxO/MzoKKUCvPoztq8dztmF7uO
         jY335f1SWXO+8Hq7bf7bLYmgNaAZlBeY/Joun5mobHbYvqLgRZB8O4+ysNurqIZonHjw
         sfTUE475epyiYuYpvrY0gSRjuoidgSoZ9ChSCYiqbEcxFkVZLRBfpsNTPdSTMCCX/tIY
         5r1jUkOWDRoViWzIckR+zpvjFHmftGcpQLdhhpqnaWcdfBUdxaa80z0KAQPDtSEa7spX
         WtuJYWVGlVWxqrNuoQ8DSr3Ssq76jdjxpHsc3aBljNovRTbHR2bpgeJU1fo0Ddvc1AxV
         Z5UQ==
X-Gm-Message-State: AGi0PuYYV+0eJgD/5cDImxFMCxooY621ru0GH90t+KWwqfpWX9ditsUQ
        ffqp59fR4uBs+7dJu50NRl0cy4OsqlU=
X-Google-Smtp-Source: APiQypLMnJWMh92m5YsJHf9BqBjCmjXxO84KbIg7LOknPhc0h3h1ured9ATaL62NfwsOoyvx68JZ3A==
X-Received: by 2002:adf:bc05:: with SMTP id s5mr19880920wrg.70.1587409766670;
        Mon, 20 Apr 2020 12:09:26 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y5sm621251wru.15.2020.04.20.12.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:09:26 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v3 4/9] spi: bcm-qspi: Drive MSPI peripheral SSb pin on cs_change
Date:   Mon, 20 Apr 2020 15:08:48 -0400
Message-Id: <20200420190853.45614-5-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420190853.45614-1-kdasu.kdev@gmail.com>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
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


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0D81AFD6B
	for <lists+linux-spi@lfdr.de>; Sun, 19 Apr 2020 21:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDST03 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Apr 2020 15:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDST01 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Apr 2020 15:26:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB371C061A0C;
        Sun, 19 Apr 2020 12:26:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r4so3957104pgg.4;
        Sun, 19 Apr 2020 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mO+e6MGsJdi3QsmX2S9FqCiq+qKAo+MDQiNuazkChc4=;
        b=fw3l2qNlf44VEhmVx7MhxDvqReIgHU52YVRwGv+5pVVJpSv258YjV8z3/SYaKKDUud
         Yk9KDiYve5F1+AE9cbaGrMf1YZGLtFNRSZva/rdAdNBBuc43NYguJoo60bNobK1mN39Z
         fFdocztkjPl0qhHvPwwGHLsc3xl+VPJavWGH7wRdExLMEc020YXYt6dVMzqZCvvqVJhp
         SBOP6hgj4Rct9M9BqhJGJ9c588HFDZbAYuIMICREe9P0bIkQ4M1GtiKdo33vX+VvBDFj
         6+EhsU1OjN9PnRU2T8gWC+4JG8ZhSwe2x4f9EvIS/kE7iRD4wBVxWvI8v3KgT1i4RW3T
         hSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mO+e6MGsJdi3QsmX2S9FqCiq+qKAo+MDQiNuazkChc4=;
        b=Pjb8cQe9XfvXZmk4fHF6FFHMHFurA7hFic29sxntSxW3lc889L0w6zhXe7PcI5LfUy
         OS57FKeY9AitA7bdXHQmYzjAXSbHRq6tY/YzEN7FbqdYlE+fXkt3T21gnZECbC8ULXup
         3J/um5j7A+LRh7yC9I41cgo2nZJVjg3EndEPW9cCm4XrTNkY1BqBOrUFV/iIbHd0lOZV
         DgM1F4Sz3fLUYHQasZpvyB1t8e02ZorIj3yUpm1PTLYtZs/G/fX85GHJKCIPSsRjEI/v
         jIczXiq9rzzp/Pn0D3PrE9lccxgxpo0ZEZB9bXsafMVG/o/3q1HjqSEj92+ZaRs/d9+s
         iFDQ==
X-Gm-Message-State: AGi0PubL4TIEj4sfCJP+sUVbSE8FXlfiXvAjRQ/kQukLFUa4MfUZaV/V
        H/Pq4lRqIgxak1yj88VSCRj6K6IFRDA=
X-Google-Smtp-Source: APiQypJqnXNdK+cO2RqrlldcDAy0D1YMT9HhJG3cGb/+R/qsvC7Wi0ekii6019cAkXE6rGK+6y/YfA==
X-Received: by 2002:aa7:9839:: with SMTP id q25mr13036550pfl.311.1587324387262;
        Sun, 19 Apr 2020 12:26:27 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x16sm22724383pfm.146.2020.04.19.12.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:26:26 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v2 4/9] spi: bcm-qspi: Drive MSPI peripheral SSb pin on cs_change
Date:   Sun, 19 Apr 2020 15:23:33 -0400
Message-Id: <20200419192339.32023-5-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419192339.32023-1-kdasu.kdev@gmail.com>
References: <20200419192339.32023-1-kdasu.kdev@gmail.com>
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


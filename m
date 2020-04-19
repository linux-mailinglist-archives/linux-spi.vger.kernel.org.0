Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC31AFD6D
	for <lists+linux-spi@lfdr.de>; Sun, 19 Apr 2020 21:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgDST0d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Apr 2020 15:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDST0c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Apr 2020 15:26:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC4C061A0C;
        Sun, 19 Apr 2020 12:26:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g6so3940316pgs.9;
        Sun, 19 Apr 2020 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZyjxQT2w1tfyUymmhQNajH9/aDxm1dT9gvQiJybw7YI=;
        b=SbNR+P3+DzUaYoMTXySguBEbHaoi7SjpqNp5dYAr3yiGKfJL4gvu/P/IXx2ODmQtHk
         pIUIQ69qeNi17uHyLJZPdbqHymXPzlk7MZAXM6huy1FClnOaW4en3tmUrizjOOqS318c
         tTfSEA/3HJuZUffpMdWzQ/XDubaAVpPzPNB0f93746/MczPL14OwrYwX4jLjN8NA7YLX
         JZg4nNqN7Uqhb9XgvzJsKfFkKbS2a+w0htvWcqzCG657zCkUdStuYO65OQHR99MBv9Fz
         D1cAdkDq+n+NF01Gyl6WCPANyz1tgzm2IRbkZhntx2Tdhwqm4LG1UJdrOFUgYjAO8y6R
         0wfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZyjxQT2w1tfyUymmhQNajH9/aDxm1dT9gvQiJybw7YI=;
        b=fIvREhUY1RayoYHV0Qm3jAo2XSdpMuqDyj49bq00iBU9gZXDmPvh5tdYBgQW4pYo6Q
         HM4D2NQkeNWuwISCyZmW99swfc+Z3yUWrcmpGiVFG13fsykV+8VRiOL7UJjvtlihMRv+
         70T8eUIVaoNJkOhZIH3Bp7elqcTtfP/qP4oKpN8pguHIRmAYY5rnCC4sBWDipngYuNBQ
         YKH392Oy9tKcbzrT8BQ5OhKOln2ux6GE7SRTXdWcMk2NDJ345oqeVfjweD3E2sBH6tXm
         UHashSFeniUPM71D9AqE1pK9up6HbtUQXZGvVSonCnsYw8PorIa9rJnymuQMTOFHpBEU
         +RrQ==
X-Gm-Message-State: AGi0PuaPmIVzGncQrD9YleZSN7N1uCIZC3oqqcTXPMJmscAtPs159CBN
        +Ev/+LgxfZpSVrthTX8hwOI=
X-Google-Smtp-Source: APiQypKsdOTntybjWMD089prmwm7q76XargHK9vFToamg6AnCEAsLZsfFjVNZMNyoOwnxbTtMHv/Lg==
X-Received: by 2002:a62:3784:: with SMTP id e126mr13474412pfa.303.1587324392241;
        Sun, 19 Apr 2020 12:26:32 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x16sm22724383pfm.146.2020.04.19.12.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:26:31 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     Justin Chen <justinpopo6@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v2 5/9] spi: bcm-qspi: when tx/rx buffer is NULL set to 0
Date:   Sun, 19 Apr 2020 15:23:34 -0400
Message-Id: <20200419192339.32023-6-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419192339.32023-1-kdasu.kdev@gmail.com>
References: <20200419192339.32023-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

Currently we set the tx/rx buffer to 0xff when NULL. This causes
problems with some spi slaves where 0xff is a valid command. Looking
at other drivers, the tx/rx buffer is usually set to 0x00 when NULL.
Following this convention solves the issue.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index c48c399dce53..e00208801c8b 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -669,7 +669,7 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
 			if (buf)
 				buf[tp.byte] = read_rxram_slot_u8(qspi, slot);
 			dev_dbg(&qspi->pdev->dev, "RD %02x\n",
-				buf ? buf[tp.byte] : 0xff);
+				buf ? buf[tp.byte] : 0x0);
 		} else {
 			u16 *buf = tp.trans->rx_buf;
 
@@ -677,7 +677,7 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
 				buf[tp.byte / 2] = read_rxram_slot_u16(qspi,
 								      slot);
 			dev_dbg(&qspi->pdev->dev, "RD %04x\n",
-				buf ? buf[tp.byte] : 0xffff);
+				buf ? buf[tp.byte / 2] : 0x0);
 		}
 
 		update_qspi_trans_byte_count(qspi, &tp,
@@ -732,13 +732,13 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
 	while (!tstatus && slot < MSPI_NUM_CDRAM) {
 		if (tp.trans->bits_per_word <= 8) {
 			const u8 *buf = tp.trans->tx_buf;
-			u8 val = buf ? buf[tp.byte] : 0xff;
+			u8 val = buf ? buf[tp.byte] : 0x00;
 
 			write_txram_slot_u8(qspi, slot, val);
 			dev_dbg(&qspi->pdev->dev, "WR %02x\n", val);
 		} else {
 			const u16 *buf = tp.trans->tx_buf;
-			u16 val = buf ? buf[tp.byte / 2] : 0xffff;
+			u16 val = buf ? buf[tp.byte / 2] : 0x0000;
 
 			write_txram_slot_u16(qspi, slot, val);
 			dev_dbg(&qspi->pdev->dev, "WR %04x\n", val);
-- 
2.17.1


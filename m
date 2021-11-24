Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6224645CD4B
	for <lists+linux-spi@lfdr.de>; Wed, 24 Nov 2021 20:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351368AbhKXThg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Nov 2021 14:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351313AbhKXThd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Nov 2021 14:37:33 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CD1C061746;
        Wed, 24 Nov 2021 11:34:23 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so5871981pja.1;
        Wed, 24 Nov 2021 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZySSFNusVCfTCDqVWM0tDtO+ilZSsG/wNc1lY4qig1w=;
        b=FMBFUBfVphB9EvMdBWD8hfgfkvJDjSRTCGsLa+v8OLu8TC+7gNabg3KZyQPeruBi8s
         3gUw/tbfcRpwcD2eqUoArdzuO+evjIYYAkFsZhei2smonbgPFuKh4gsLDMb1LH+JM6n7
         E+iIQMlOv5yN6hzdmBmJhi4saHesBS0gDBWNAqJL5hp7zv9ixKehVjzOeffWldQxmnK3
         0YuT0R2sryqOKHUR2vvxKIXNoSHZfGIEeNTp6fGuNUTlt3h/hgDCCbQuvJ/b9BjOiYX+
         ajjSTT5tnNEDZ56OCY1OCGeFIgAqzgmq4Os3NO5nnKNxGi0mID/JKYj5jKgyz2TfMsih
         3D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZySSFNusVCfTCDqVWM0tDtO+ilZSsG/wNc1lY4qig1w=;
        b=Tft+asCT5kF8GY0L0GV8L8rOeFZ63aPZ3C0DC8BmefcdpeFtT9xCBkP8Mr54lquzk7
         JTpaLqyEtAKra4dog+1PsvbiAW0Ok/Yo3df4SFfviZW/TGTeCIWUHrhQwp/shrU9AhfT
         I2oI2PCQhG1Uf5rs1r80E2mZrZO7z912r4bxcloZiKgvWbXpZDic7hydYVPHD4VEC2P4
         45M9L8WApMR72UpqNyB2H/CAcrpXIMXxCY7GEDZeiRasVW/PrdZibBmidMTjm7AXgbMX
         ALAmoF7Hhsyxw7CLB37FB0gKqLUA9o+JAwdIJ9rFYSmwCh5CUmcDZ+z86uHiNkqWG6Ma
         TzBQ==
X-Gm-Message-State: AOAM532P7sygafkgF+6wJwuDvzgyn+G5C7QQxB/CmRQ6uJE5I83JJcrI
        d+LBlbHlJOHnQvqwbLWi7nI=
X-Google-Smtp-Source: ABdhPJyP+ZTpmbKC52WJKWQkUCUZCffEU9I8lKvfk5rhSYOcD1vqfyzCixN+EWfUPXOBtkIti9t44A==
X-Received: by 2002:a17:90b:4f45:: with SMTP id pj5mr12237416pjb.70.1637782462653;
        Wed, 24 Nov 2021 11:34:22 -0800 (PST)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id v38sm349510pgl.38.2021.11.24.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:34:22 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        yendapally.reddy@broadcom.com, Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 2/2] spi: bcm-qspi: set transfer parameter only if they change
Date:   Wed, 24 Nov 2021 14:33:53 -0500
Message-Id: <20211124193353.32311-3-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211124193353.32311-1-kdasu.kdev@gmail.com>
References: <20211124193353.32311-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Check if the transfer parameters have changed from previous settings
before applying new parameters.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 38e6e2cb62ca..c9a769b8594b 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -598,12 +598,24 @@ static void bcm_qspi_chip_select(struct bcm_qspi *qspi, int cs)
 	qspi->curr_cs = cs;
 }
 
+static bool bcmspi_parms_did_change(const struct bcm_qspi_parms * const cur,
+				    const struct bcm_qspi_parms * const prev)
+{
+	return (cur->speed_hz != prev->speed_hz) ||
+		(cur->mode != prev->mode) ||
+		(cur->bits_per_word != prev->bits_per_word);
+}
+
+
 /* MSPI helpers */
 static void bcm_qspi_hw_set_parms(struct bcm_qspi *qspi,
 				  const struct bcm_qspi_parms *xp)
 {
 	u32 spcr, spbr = 0;
 
+	if (!bcmspi_parms_did_change(xp, &qspi->last_parms))
+		return;
+
 	if (!qspi->mspi_maj_rev)
 		/* legacy controller */
 		spcr = MSPI_MASTER_BIT;
-- 
2.17.1


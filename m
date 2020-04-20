Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC51B156E
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 21:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgDTTJk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 15:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728022AbgDTTJj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Apr 2020 15:09:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8F0C061A0C;
        Mon, 20 Apr 2020 12:09:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d17so13538878wrg.11;
        Mon, 20 Apr 2020 12:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pMhdquAr/HzwmzyKmiKytwMMb3XOVcxGDwBpxb4EVIg=;
        b=hYuN6zysHNYcwwxQGzpo9119HGSST2EZyKQOVX+aYFlmAyUyJEVYJsDF4z+TXPld/M
         k1aNILU9rvMgcfkNJz65/RdrQUOwZvF1PhkxO1qEUWzCDB5c6g8M9sKJoFmINh9Zxi2m
         4NQY7cpT9lYejThY7YkiTitFdqt4z3LDerfseEIiDgcRcof8FlRAOOqdjr+y2//8lyu6
         eL+MTW9Xe703kSnHY8m1zGqGeGxtJQMqqW5DC3+gf9FJuiUKlW6jGx95ZuNjhFP8iDe2
         IQwDvA7mLApN39aBCanhDaxLh+0LER2kyFEio8bLeXiXngzpKob4wjdmDofS3s/y9fFW
         f4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pMhdquAr/HzwmzyKmiKytwMMb3XOVcxGDwBpxb4EVIg=;
        b=LTCeMIAQ2kmGGy9ui5aY/Xi2suWo1hw3fBo4p+94dEMjOAMixgZKQ0sdgr9LFPTc+J
         +TLG/swPJv4Rg9gVDcjGDPfrsTIsVP9Tx1bZAPo0xHHGhtlVrpWcQyG0/Fvabz0SGBAE
         JQsjZgDfMsI7jevKWyCWekZP/wgou4/KPIMNV+rcaA7rwzDQ9Iam8js8m5kVKGI9BWgN
         sWY+ybjxwsCLNcRJczC2l07vtXNytNDFxPmEEBYEnkIpM2GHeGlS+xh+DIm62M/Py8O+
         ab/N0s0ntUaF48aS3ciyeiLXATF7vHw07dYNUEd96cDt4Cqb2/8pra7gwKldgWA0flTo
         0wnw==
X-Gm-Message-State: AGi0PuZg5EC5gSr0N+OM43Siz9nmGZjXX8SGxumELuTf0UwtxXkzpzfu
        Uqg1qd4ha8c2cbBbZL7TA4Y=
X-Google-Smtp-Source: APiQypLQvSn0BosVRuMhVoCRqWBE5h7XjuUYVu/ikcSJ6qJtVhmmUeri08ztEGOkX+C6ICTmM5iSpw==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr22168182wrn.56.1587409777141;
        Mon, 20 Apr 2020 12:09:37 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y5sm621251wru.15.2020.04.20.12.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:09:36 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v3 9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists only on legacy controllers
Date:   Mon, 20 Apr 2020 15:08:53 -0400
Message-Id: <20200420190853.45614-10-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420190853.45614-1-kdasu.kdev@gmail.com>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Set MASTER bit on the MSPI_SPCR0_MSB only for legacy MSPI and HIF_MSPI
controllers.

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


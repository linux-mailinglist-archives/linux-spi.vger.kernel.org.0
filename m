Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44F0232726
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jul 2020 23:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgG2Vu0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jul 2020 17:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2VuZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jul 2020 17:50:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DF3C061794
        for <linux-spi@vger.kernel.org>; Wed, 29 Jul 2020 14:50:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f5so26679889ljj.10
        for <linux-spi@vger.kernel.org>; Wed, 29 Jul 2020 14:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABsiYs0xtuCZ6hmXzQfLGo3rLtmdSeGHh35xe8wn6Rs=;
        b=u04DHoZ38wDI2FD7GTuIgjow7521smerbPKc25OViIMHrGmECaq1sGrhYP1aE0jE02
         dmfkSB97CtI/1yB6iaWc645e87z3Z0aNzadxKbBVlG6H1Gf0PXcWxFXDFwYVGdszNIF4
         Qhrt2ufxhSBCcYnuCJG60VR1qqm3BAtpEc+RdVgIeLjgH/rbLnJglksioSrg4Vkx3vCK
         ic3W44gDXZuZ/Kgfiv6r031u3AOZvCqdnDY1F6G5KO9Vuvd52W+9gjpJsX3Op8zS4RY1
         4BUOZJNXYpmzz0rDg1g9mhfrZrfYGJf8RNHZ5URyPFOdpA+v4HW1mcWZqGP146jMIRp2
         K/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABsiYs0xtuCZ6hmXzQfLGo3rLtmdSeGHh35xe8wn6Rs=;
        b=PN+gXHAc7573rN+vVSvhbqqOUyj3dejHURd1sz/ms+aqS8MiksxL+v/9KIxW3v7ChK
         AG2W5+I1lpb7n622RektURDKZP+vxFwmtFf3fOpUYQywaHqrjqksYdNzPfyF8tgKIi+5
         BIjC4ahgIr8JiH/kCkNHmtV1qlPh9y7rfFONA3F0YPU5KTOUPVzQ9ljSVMYYAAsw3SFJ
         AlelsBF8b2YnfpAhEyvFBctW4JgP1hQOjXNi/fIsxpl/BKwqS7cZc6He4Dwir4GYVnWJ
         a+giLTDswG7jKhTahWUKQGGMYuZgpFfkYsl/DSSF/0x+9eItS+nBIXvrwXbXH92EjiZj
         AHUA==
X-Gm-Message-State: AOAM533Nmp59hq/Hd/gobA+8O04Prp3110+FNzl4O706jHASnfnqEAwb
        Y+WFldDYA9e6BjqxYatZW4IRmPvlRO93QQ==
X-Google-Smtp-Source: ABdhPJwblNZ+VNYuRVGoVSX9EVmZP+AcbK8QtgjkOkqwCT9vhrRrytv9fRkA5t3rsUQ+ScLCciysLA==
X-Received: by 2002:a2e:b306:: with SMTP id o6mr145133lja.361.1596059423830;
        Wed, 29 Jul 2020 14:50:23 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id l26sm721262lfj.22.2020.07.29.14.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 14:50:22 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Anatolij Gustschin <agust@denx.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] spi: mpc512x-psc: Use the framework .set_cs()
Date:   Wed, 29 Jul 2020 23:48:16 +0200
Message-Id: <20200729214817.478834-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The mpc512x-psc is rolling its own chip select control code,
but the SPI master framework can handle this. It was also
evaluating the CS status for each transfer but the CS change
should be per-message not per-transfer.

Switch to use the core .set_cs() to control the chip select.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-mpc512x-psc.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index ea1b07953d38..35313a77f977 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -89,7 +89,7 @@ static int mpc512x_psc_spi_transfer_setup(struct spi_device *spi,
 	return 0;
 }
 
-static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
+static void mpc512x_psc_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct mpc512x_psc_spi_cs *cs = spi->controller_state;
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
@@ -98,6 +98,12 @@ static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 	int speed;
 	u16 bclkdiv;
 
+	if (!enable) {
+		if (mps->cs_control && gpio_is_valid(spi->cs_gpio))
+			mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
+		return;
+	}
+
 	sicr = in_be32(psc_addr(mps, sicr));
 
 	/* Set clock phase and polarity */
@@ -132,15 +138,6 @@ static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 1 : 0);
 }
 
-static void mpc512x_psc_spi_deactivate_cs(struct spi_device *spi)
-{
-	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
-
-	if (mps->cs_control && gpio_is_valid(spi->cs_gpio))
-		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
-
-}
-
 /* extract and scale size field in txsz or rxsz */
 #define MPC512x_PSC_FIFO_SZ(sz) ((sz & 0x7ff) << 2);
 
@@ -290,40 +287,28 @@ static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
 				    struct spi_message *m)
 {
 	struct spi_device *spi;
-	unsigned cs_change;
 	int status;
 	struct spi_transfer *t;
 
 	spi = m->spi;
-	cs_change = 1;
 	status = 0;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		status = mpc512x_psc_spi_transfer_setup(spi, t);
 		if (status < 0)
 			break;
 
-		if (cs_change)
-			mpc512x_psc_spi_activate_cs(spi);
-		cs_change = t->cs_change;
-
 		status = mpc512x_psc_spi_transfer_rxtx(spi, t);
 		if (status)
 			break;
 		m->actual_length += t->len;
 
 		spi_transfer_delay_exec(t);
-
-		if (cs_change)
-			mpc512x_psc_spi_deactivate_cs(spi);
 	}
 
 	m->status = status;
 	if (m->complete)
 		m->complete(m->context);
 
-	if (status || !cs_change)
-		mpc512x_psc_spi_deactivate_cs(spi);
-
 	mpc512x_psc_spi_transfer_setup(spi, NULL);
 
 	spi_finalize_current_message(master);
@@ -513,6 +498,7 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	master->prepare_transfer_hardware = mpc512x_psc_spi_prep_xfer_hw;
 	master->transfer_one_message = mpc512x_psc_spi_msg_xfer;
 	master->unprepare_transfer_hardware = mpc512x_psc_spi_unprep_xfer_hw;
+	master->set_cs = mpc512x_psc_spi_set_cs;
 	master->cleanup = mpc512x_psc_spi_cleanup;
 	master->dev.of_node = dev->of_node;
 
-- 
2.26.2


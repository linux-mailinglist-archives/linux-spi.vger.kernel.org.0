Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB3B58817B
	for <lists+linux-spi@lfdr.de>; Tue,  2 Aug 2022 19:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiHBR7k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Aug 2022 13:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbiHBR7Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Aug 2022 13:59:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7298D50074
        for <linux-spi@vger.kernel.org>; Tue,  2 Aug 2022 10:59:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q30so14396713wra.11
        for <linux-spi@vger.kernel.org>; Tue, 02 Aug 2022 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sl9Z98LrR1HGqesJuJI9JTYA1Pp0siEP1pFEoTfJVN4=;
        b=BraroAuIQqADk1cnPCUB+aLh71k99p66yNBjBE+daWZAXJlSqonJQiZ0FlH0EOzoWp
         qty7Gm9qCLCWysfVI6MKR3XEewBIan5xCzCgYM1vIWkV0Xhihh1EqDMYCmA3yG0OvsSP
         Vesref23GBooU7Y2ju9GiSMdXRzuYjwBDnOzRYUAs4cCxLUpB6XRzTiWq4DCt+s+pvUt
         ZNNPNHDsVuSMY4oojQy4b1QjHXc8NAZbRnObtruXL7xw1g+ckQ0/k+N7YRV2qcLZBsnj
         5RRCUZvQgrpfIR75YsbOKLcogkxtn5cKFehPjzxmzCaaXnianjUUOqYVHWgBfcQXrZ2B
         jZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sl9Z98LrR1HGqesJuJI9JTYA1Pp0siEP1pFEoTfJVN4=;
        b=GNiUyN62CxDsXp3aEA3w36tTxFHxPOqJKyr46bJYZswejtapSx4Gdix3GL96pBAp0/
         poMfh0TTyEfuNxAgH1TP0ccw84mcyqTgyjIE9Rx0M0MfUZO//r0DBPkyXEN0Cm/5MVVd
         TlSwepK4bqYTOFKi3QEZ7WabLkgew6WrOji9Vyek9YSGUQWaDkj0EHC2Vgou/hzukbDe
         VEZCXd8K9DeKryT8x/HZ9/7M2HG+MI8LQ0hzKf7Fwv0sKN+2BL8j6FRmlhjSN1eqiufa
         WPKBVy2a9E9pfpBbMynkMOtqvuUOtHV4znX5zxBdxYu50SpHzk/VLoO2R4NqyzqPp2Tj
         imiA==
X-Gm-Message-State: ACgBeo3Qsr/4G4Zn4MfQPF4z2K6Vt65ojYd9Pv/q6LGsBj9ZaRJ+vkp3
        HQs9VWaZa/LnXYKv07h3L48+Xg==
X-Google-Smtp-Source: AA6agR66+Jqszo7T/0P1VL5IUVzXM9piN1M4GBE4tIZBTx475dA6PJNPHMkQlN3ie5uOahqE3xClRQ==
X-Received: by 2002:a05:6000:230:b0:21e:cf23:499f with SMTP id l16-20020a056000023000b0021ecf23499fmr14072388wrz.29.1659463146015;
        Tue, 02 Aug 2022 10:59:06 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003a3187a2d4csm23318222wmi.22.2022.08.02.10.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:59:05 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH 07/11] spi: dw: update NDF while writing in enhanced spi mode
Date:   Tue,  2 Aug 2022 18:57:51 +0100
Message-Id: <20220802175755.6530-8-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the transfer of Transmit only mode is using dual/quad/octal SPI then
NDF needs to be updated with the number of data frames.
If the Transmit FIFO goes empty in-between, DWC_ssi masks the serial
clock and wait for rest of the data until the programmed amount of
frames are transferred successfully.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 9d499bdf2ce6..8cb30540ad5b 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -344,7 +344,9 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
 	if (cfg->tmode == DW_SPI_CTRLR0_TMOD_EPROMREAD ||
-	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO)
+	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO ||
+	    (cfg->tmode == DW_SPI_CTRLR0_TMOD_TO &&
+	     (dws->caps & DW_SPI_CAP_EXT_SPI) && cfg->spi_frf))
 		dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf ? cfg->ndf - 1 : 0);
 
 	/* Note DW APB SSI clock divider doesn't support odd numbers */
@@ -760,6 +762,8 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		cfg.ndf = op->data.nbytes;
 	} else {
 		cfg.tmode = DW_SPI_CTRLR0_TMOD_TO;
+		if (enhanced_spi)
+			cfg.ndf = op->data.nbytes;
 	}
 
 	dw_spi_enable_chip(dws, 0);
-- 
2.30.2


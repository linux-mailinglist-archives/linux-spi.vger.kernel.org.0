Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60BD64A680
	for <lists+linux-spi@lfdr.de>; Mon, 12 Dec 2022 19:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiLLSIl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Dec 2022 13:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiLLSIL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Dec 2022 13:08:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D97F5F7A
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:44 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay40so6225507wmb.2
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJpkfVk+rL7x2b/nU0sS6OBZ4oN2z+03SLnndpdgjrU=;
        b=coay2wl1/s4NDUzaAH2FelFujb/pQqhfoq0CyZRpTKnSSwiKcrzDD+0bA4jNeymiZq
         G6f/dJWF/DY2krfbefg0qOwxesLZjGG9xa095p/CHtnx54LwSN/fhQvceSupQdQjrTDu
         n9E3MRzbuQI1d3G16erMlXsPmD/wqVgbaDynUY2jXO9sWteacVm0Jm0htSHkQqurCeEL
         lbZiNQLFjqXhS98gCH2lw+ifkT5cVUP6awQdApA5uARg4sBrrqBSR03Fq6a2eRVB2vkg
         X3tUGPhyuNH5knqXkzt3HFg3bzQJ8dgYnSZu5Hp8LcAu7q9DqCXjL5fSNOF1q99kpYSi
         CuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJpkfVk+rL7x2b/nU0sS6OBZ4oN2z+03SLnndpdgjrU=;
        b=JjbfadHeO1fk4D9n1iDRHnASQ5NhXDF2EnMNhNGlQNQDdR1eW9QlMvItBR7VMgCVp2
         WfXDlYXY1Wkp1rUCXk2mmr3E5VKj1KPEJsSoGwqnX1CgaC2bV1EfT2ZljxZ/PK6P8it4
         BMsCRpUdyQaJ3HZry4iin0TryWXsMAte88uvrzejO6hNBzvjX+uSmWZ1EeAtnKx852B9
         vd5P/X27WLAa46+a9o/911kwE3INbdTpOtgTYiM8YH5rEZHU7W5kBoT7N8vI7d51/i1a
         CU7vXQWDv4REf0lp7Bp/qPNkQO7rLyl9GUTqDidWLbt3is1p+rB4F2zLM9tCic1Xlgoo
         pACA==
X-Gm-Message-State: ANoB5pkqSziccGS38JyKaUXxI8gbxsoARXbVrODXVW2yi59UoIVyMvlm
        6NlMFmQok5I+xwhkJhw9R5RtKw==
X-Google-Smtp-Source: AA0mqf5cAskf49A0ST3HZiQkCFRj43GVuLuMuTT6xeW8YU6CvinMbu6M9kKaMkfbKpgF9qujMnRkLw==
X-Received: by 2002:a7b:c5c4:0:b0:3d1:f234:12cc with SMTP id n4-20020a7bc5c4000000b003d1f23412ccmr12919514wmk.33.1670868463449;
        Mon, 12 Dec 2022 10:07:43 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:43 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 02/15] spi: dw: update NDF while using enhanced spi mode
Date:   Mon, 12 Dec 2022 18:07:19 +0000
Message-Id: <20221212180732.79167-3-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
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
 drivers/spi/spi-dw-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 77c23772bb3d9..8c47a4d14b666 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -346,7 +346,9 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
 	if (cfg->tmode == DW_SPI_CTRLR0_TMOD_EPROMREAD ||
-	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO)
+	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO ||
+	    (cfg->tmode == DW_SPI_CTRLR0_TMOD_TO &&
+	     cfg->spi_frf != DW_SPI_CTRLR0_SPI_FRF_STD_SPI))
 		dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf ? cfg->ndf - 1 : 0);
 
 	/* Note DW APB SSI clock divider doesn't support odd numbers */
-- 
2.30.2


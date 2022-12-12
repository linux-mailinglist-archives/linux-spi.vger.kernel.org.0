Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CDA64A695
	for <lists+linux-spi@lfdr.de>; Mon, 12 Dec 2022 19:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiLLSJG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Dec 2022 13:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiLLSIS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Dec 2022 13:08:18 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7369F2728
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:48 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so5945836wmh.0
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rbzmysLo8UW53GKP6EF+15VfNqhz3A+mC6FctnQIOA=;
        b=gI2UE7AismxqoIKynMFVv4fJQTIarPf1JhZ2jt3s+S8eY2SboNYAkPEtv5xZM/hLMp
         RT2hjAWlFKl8SmBbkImJgUalzAdDnu6Ygzwaw2KLTqgi7O5NzRbiVWsnrl2NkAKeo94D
         Z2fG4eKLJsBeJ5U3DZWrEgs+rmvVmKQ8yMnvtVIpCeR/vMZA7afzxpBis/mm0DyLJH/5
         hivFHl/yLjHdKuOxOh8TpFBCj++NcXwWo9IqFc9Ovcvi4uSt1JuHq5L1/5/hrY/9j5wK
         4Po4rJKbT6vvANrzNQ5SvcapGFVLVK72tooGeoEL/+Uk+szlAfvd/5YYesICfsc1j0fu
         Wt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rbzmysLo8UW53GKP6EF+15VfNqhz3A+mC6FctnQIOA=;
        b=YA28uXSVWjuI2Y+8DwShwq6r1DY/Q0XZTCytAhvKWYwGlZsgbGqw3JU+tGqnD5sFRA
         KcPCIKgRI6m15ong6u7OEj8+v+JLmQf2z4ufnp76ipK6oxdRakGvTBest4pNHBGy3DMy
         JOyXpi0fu7Y1vLsOp6aQsJMNI8U1il736Nx5YeeoS16E8Lhh+3mOhaTgY1G5LObeiYAX
         dhRXAbHArRGRJ2vwNNRukmVCApK094xRsfUuLmcjYG54Q3QrR23idqbPF0zCXqS/nmo+
         3cF1Xi+yJdcrRXuWRRW7SoavB5ziTFZqsPWOBKq2Wd+4UkqMuPcl5kDZYf69XPB4xGfr
         8Chg==
X-Gm-Message-State: ANoB5pnux3+jZ6i5CNkKMXDP97l7f1Rdc8/6zQC97cVrqITwcCyRcquo
        VfMXnECW5TDntHFSsJzChPgtbA==
X-Google-Smtp-Source: AA0mqf69G02dnbEggUXKEcvznXMXC3hHUQQD/NllSrd1eNaagBS4QYElw7nwJkrsHdJNx/3L8eo+fw==
X-Received: by 2002:a05:600c:5386:b0:3c6:e63d:b893 with SMTP id hg6-20020a05600c538600b003c6e63db893mr13164832wmb.2.1670868467143;
        Mon, 12 Dec 2022 10:07:47 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:46 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 06/15] spi: dw: Introduce dual/quad/octal spi
Date:   Mon, 12 Dec 2022 18:07:23 +0000
Message-Id: <20221212180732.79167-7-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the spi transfer is using dual/quad/octal spi mode, then we need to
update the SPI_CTRLR0 register. The SPI_CTRLR0 register will be updated
in dw_spi_update_config() via the values in dw_spi_cfg.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---

Note: DW_SPI_SPI_CTRLR0_INST_L_INST_L16 will not work yet as
spi_mem_default_supports_op() checks for op->cmd.nbytes != 1.

 drivers/spi/spi-dw-core.c | 46 +++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-dw.h      |  9 ++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 89438ae2df17d..06169aa3f37bf 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -836,10 +836,56 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 {
 	struct spi_controller *ctlr = mem->spi->controller;
 	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
+	struct dw_spi_cfg cfg;
+
+	switch (op->data.buswidth) {
+	case 2:
+		cfg.spi_frf = DW_SPI_CTRLR0_SPI_FRF_DUAL_SPI;
+		break;
+	case 4:
+		cfg.spi_frf = DW_SPI_CTRLR0_SPI_FRF_QUAD_SPI;
+		break;
+	case 8:
+		cfg.spi_frf = DW_SPI_CTRLR0_SPI_FRF_OCT_SPI;
+		break;
+	default:
+		return dw_spi_exec_mem_op(mem, op);
+	}
 
 	/* Collect cmd and addr into a single buffer */
 	dw_spi_init_enh_mem_buf(dws, op);
 
+	cfg.dfs = 8;
+	cfg.freq = clamp(mem->spi->max_speed_hz, 0U, dws->max_mem_freq);
+	cfg.ndf = op->data.nbytes;
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		cfg.tmode = DW_SPI_CTRLR0_TMOD_RO;
+	else
+		cfg.tmode = DW_SPI_CTRLR0_TMOD_TO;
+	if (op->data.buswidth == op->addr.buswidth &&
+	    op->data.buswidth == op->cmd.buswidth)
+		cfg.trans_t = DW_SPI_SPI_CTRLR0_TRANS_TYPE_TT2;
+	else if (op->data.buswidth == op->addr.buswidth)
+		cfg.trans_t = DW_SPI_SPI_CTRLR0_TRANS_TYPE_TT1;
+	else
+		cfg.trans_t = DW_SPI_SPI_CTRLR0_TRANS_TYPE_TT0;
+
+	cfg.addr_l = clamp(op->addr.nbytes * 2, 0, 0xf);
+	if (op->cmd.nbytes > 1)
+		cfg.inst_l = DW_SPI_SPI_CTRLR0_INST_L_INST_L16;
+	else if (op->cmd.nbytes == 1)
+		cfg.inst_l = DW_SPI_SPI_CTRLR0_INST_L_INST_L8;
+	else
+		cfg.inst_l = DW_SPI_SPI_CTRLR0_INST_L_INST_L0;
+
+	cfg.wait_c = (op->dummy.nbytes * (BITS_PER_BYTE / op->dummy.buswidth));
+
+	dw_spi_enable_chip(dws, 0);
+
+	dw_spi_update_config(dws, mem->spi, &cfg);
+
+	dw_spi_enable_chip(dws, 1);
+
 	return 0;
 }
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 327d037bdb10e..494b830ad1026 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -101,6 +101,9 @@
 #define DW_HSSI_CTRLR0_SPI_FRF_MASK		GENMASK(23, 22)
 #define DW_PSSI_CTRLR0_SPI_FRF_MASK		GENMASK(22, 21)
 #define DW_SPI_CTRLR0_SPI_FRF_STD_SPI		0x0
+#define DW_SPI_CTRLR0_SPI_FRF_DUAL_SPI		0x1
+#define DW_SPI_CTRLR0_SPI_FRF_QUAD_SPI		0x2
+#define DW_SPI_CTRLR0_SPI_FRF_OCT_SPI		0x3
 
 /* Bit fields in CTRLR1 */
 #define DW_SPI_NDF_MASK				GENMASK(15, 0)
@@ -132,7 +135,13 @@
 #define DW_SPI_SPI_CTRLR0_CLK_STRETCH_EN	BIT(30)
 #define DW_SPI_SPI_CTRLR0_WAIT_CYCLE_MASK	GENMASK(15, 11)
 #define DW_SPI_SPI_CTRLR0_INST_L_MASK		GENMASK(9, 8)
+#define DW_SPI_SPI_CTRLR0_INST_L_INST_L0	0x0
+#define DW_SPI_SPI_CTRLR0_INST_L_INST_L8	0x2
+#define DW_SPI_SPI_CTRLR0_INST_L_INST_L16	0x3
 #define DW_SPI_SPI_CTRLR0_ADDR_L_MASK		GENMASK(5, 2)
+#define DW_SPI_SPI_CTRLR0_TRANS_TYPE_TT0	0x0
+#define DW_SPI_SPI_CTRLR0_TRANS_TYPE_TT1	0x1
+#define DW_SPI_SPI_CTRLR0_TRANS_TYPE_TT2	0x2
 
 /* Mem/DMA operations helpers */
 #define DW_SPI_WAIT_RETRIES			5
-- 
2.30.2


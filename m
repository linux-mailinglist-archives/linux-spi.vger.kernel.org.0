Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF35B588178
	for <lists+linux-spi@lfdr.de>; Tue,  2 Aug 2022 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiHBR7f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Aug 2022 13:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbiHBR7I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Aug 2022 13:59:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F3550707
        for <linux-spi@vger.kernel.org>; Tue,  2 Aug 2022 10:59:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso3505563wme.0
        for <linux-spi@vger.kernel.org>; Tue, 02 Aug 2022 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E4UV8naDvq3qTPSo5The0YIEVHRxQNXYLDteElqpqxc=;
        b=JEDdNc+SdwY9H7WGJA/h7gfZJT/8n7093kHisyTqxAECd0XnvlBbQZPIby2t91lvs5
         LwH14ohei4NP0alduv/V0qZNQS4aFVRdknb/bzMN/PJw7g6OqHbHN45n7QV9eMFVulDN
         lvoMfjg9Est6l4Za5WJgVpfPqmIKkkDI6g+PnCExjWG667VSPxy9SQbJsrh+Rs18O0vj
         mU4AU/FbZJx0qYraQEtsdCA1xbB/0QUP1aSHd2S5YBzRaeLqseMTUJd3veDbC1ct/5Me
         MMb7VTgOaHgYubha4E0KnM8S1fU3RKhvIwoZfMSHCfmAjC44SmnSiNeEDxneVkMRsyPR
         rCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4UV8naDvq3qTPSo5The0YIEVHRxQNXYLDteElqpqxc=;
        b=Z+pP3f/jrrW2C5wajr8KrCioM2ECx9x2nPZG/KRlewX9YS9QPqjrR03Z0b76qnU+Km
         KNMuMGyNSRPbNha0YxV53L4Ezov0PfttkL7hVK8fB4zLNfABoWVhMSD1nDc5T0aowjw5
         1g4JBFdr9qmBpmrQn/nsPARbbqXdZ/yG5KnmySCQdpPOlo+yPs/CyRo7/bMGLV01N2M1
         fhfsGubPAps1OFPI2KzDI6Mjx3ufGgic3PU0FRUXQpFHD3lB0WbTRWLoLD9qUI1caw7Q
         te5tz+Sv/oj94N1r4exRGm0OQi/8vXHHkeP0MiGioZROy0QAdXcKwGuREjSaaaYpSS0b
         Uhhg==
X-Gm-Message-State: ACgBeo2hCYbCvvYHWBvrlekaeo/VvmrXTFHwlUMWHfuHxCsGGQqVI3nL
        2fDIM/+GcuW412OOnxCyVjUShQ==
X-Google-Smtp-Source: AA6agR5oi5bh7J5T4XlHOaXxcqmZnSljMBeaUPSklXYLtjxO0JSI4hGEjQ3l7B3fG9zxrUDs2BCG4g==
X-Received: by 2002:a7b:cbc4:0:b0:3a3:745d:ae5e with SMTP id n4-20020a7bcbc4000000b003a3745dae5emr411727wmi.12.1659463139006;
        Tue, 02 Aug 2022 10:58:59 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003a3187a2d4csm23318222wmi.22.2022.08.02.10.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:58:58 -0700 (PDT)
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
Subject: [PATCH 06/11] spi: dw: update SPI_CTRLR0 register
Date:   Tue,  2 Aug 2022 18:57:50 +0100
Message-Id: <20220802175755.6530-7-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
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

If the controller supports enhanced SPI modes then update the register
or reset the register if the transfer is not using dual/quad/octal mode.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 8e624620864f..9d499bdf2ce6 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -676,6 +676,32 @@ static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
 	dw_spi_enable_chip(dws, 1);
 }
 
+static void update_spi_ctrl0(struct dw_spi *dws, const struct spi_mem_op *op, bool enable)
+{
+	u32 spi_ctrlr0;
+
+	spi_ctrlr0 = dw_readl(dws, DW_HSSI_SPI_CTRLR0);
+	if (enable) {
+		spi_ctrlr0 |= FIELD_PREP(DW_HSSI_SPI_CTRLR0_WAIT_CYCLE_MASK,
+					 op->dummy.nbytes * BITS_PER_BYTE);
+		/* 8 bit instruction length */
+		spi_ctrlr0 |= FIELD_PREP(DW_HSSI_SPI_CTRLR0_INST_L_MASK,
+					 DW_HSSI_SPI_CTRLR0_INST_L8);
+		/* 32 bit address length */
+		spi_ctrlr0 |= FIELD_PREP(DW_HSSI_SPI_CTRLR0_ADDR_L_MASK,
+					 DW_HSSI_SPI_CTRLR0_ADDR_L32);
+		/* Enable clock stretching */
+		spi_ctrlr0 |= DW_HSSI_SPI_CTRLR0_CLK_STRETCH_EN;
+	} else {
+		spi_ctrlr0 &= ~DW_HSSI_SPI_CTRLR0_WAIT_CYCLE_MASK;
+		spi_ctrlr0 &= ~DW_HSSI_SPI_CTRLR0_INST_L_MASK;
+		spi_ctrlr0 &= ~DW_HSSI_SPI_CTRLR0_ADDR_L_MASK;
+		spi_ctrlr0 &= ~DW_HSSI_SPI_CTRLR0_CLK_STRETCH_EN;
+	}
+
+	dw_writel(dws, DW_HSSI_SPI_CTRLR0, spi_ctrlr0);
+}
+
 /*
  * The SPI memory operation implementation below is the best choice for the
  * devices, which are selected by the native chip-select lane. It's
@@ -738,6 +764,9 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	dw_spi_enable_chip(dws, 0);
 
+	if (dws->caps & DW_SPI_CAP_EXT_SPI)
+		update_spi_ctrl0(dws, op, enhanced_spi);
+
 	dw_spi_update_config(dws, mem->spi, &cfg);
 
 	dw_spi_mask_intr(dws, 0xff);
-- 
2.30.2


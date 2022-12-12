Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04FC64A68F
	for <lists+linux-spi@lfdr.de>; Mon, 12 Dec 2022 19:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiLLSJC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Dec 2022 13:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiLLSIQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Dec 2022 13:08:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413FC633E
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:47 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay40so6225612wmb.2
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsoM+2FQBABifbzzxTm/pfwezHeQcE6N/+8ll5MsoOw=;
        b=Md4f76Y0GJL7Vusa6Dqcb75nScdp9KXiro9C6IUfaV5m/P2cv0FNSMcyKuhcRr9moJ
         RKXVyj6Hga4nhoIZG59Dtp5eKMln5OP8+USKZMHuyNledotanueS+ZWKILZAhsj/CCdL
         5WYRPvL4/mJ0CvhHGl1xk/5snCv/sMCEhprJflSP47TnRgbSPRMqxT9NbsMc0O2igNen
         esg7TeKa5T6GqfZvtqwbE359U4TGNMSb6l3StEnxQOQxu2B7YOyT5EiU9lJsQCj4nDhQ
         YFWvQ3t1dcwlmLXT9/+476ETjI/b84lPxPOpS8EZriHQWkwOZqTh2UXMiouAce0ox7Mj
         E09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsoM+2FQBABifbzzxTm/pfwezHeQcE6N/+8ll5MsoOw=;
        b=2hTlllssyzXoGEMKJrEnJ4J2p/BLtwfXfmLkx33ntKsK1Sz3gzNdvIYbOBHpKm5BA0
         APjA4OI21WQzBIvc2zIUh6hsPwnBcAzADNamSMpWRXRR/mhs25dwSWAuOnZZWxeEIXiC
         yS9DyI+V0u1ofnuWurnlQas6WHrlg+dES965jofimfedrnf0Cww7UvfnGuD44A7N6ajH
         aUaR48689kwX6ecxgFuBkbwLm4kmSgi4zRT+fNjgwDlzUmjY0p7WiIC/Wu4ARF4YaQTJ
         qR+vxVQkdLQLBLji0zDPEKZ9ccsPSJMP8dqD4AjHSfJ171wPBD7me2qQg9EUChgFnTo8
         ranQ==
X-Gm-Message-State: ANoB5pk16nAgS4pxLJHtMdkMbRLkv4Ig2ey9O0iMw69jEGU4OoC1S+a0
        XTjCjmlxJaLJ122Gt/C7j19xPw==
X-Google-Smtp-Source: AA0mqf58t5AAEzi2mt41RHcVRzC+q6XS9ky+fMUt4rgRNTY0Dq23Pd0YT8xJH5fSQPmdLlJ73IBW4g==
X-Received: by 2002:a05:600c:3c95:b0:3d0:4af1:a36e with SMTP id bg21-20020a05600c3c9500b003d04af1a36emr13112831wmb.26.1670868466182;
        Mon, 12 Dec 2022 10:07:46 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:45 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 05/15] spi: dw: Introduce enhanced mem_op
Date:   Mon, 12 Dec 2022 18:07:22 +0000
Message-Id: <20221212180732.79167-6-sudip.mukherjee@sifive.com>
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

If the DW_SPI_CAP_EMODE capability is enabled then dw_spi_exec_enh_mem_op()
will be used as the new enhanced mem_op. Lets initialize the buffer and
get the pointers to receive and transmit data buffers.
The DW_SPI_CAP_EMODE capability will be enabled in a later patch.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 53 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 49fad58ceb94a..89438ae2df17d 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -798,6 +798,51 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	return ret;
 }
 
+static void dw_spi_init_enh_mem_buf(struct dw_spi *dws, const struct spi_mem_op *op)
+{
+	unsigned int i, j;
+	u8 *out;
+
+	out = dws->buf;
+	for (i = 0; i < DW_SPI_BUF_SIZE; ++i)
+		out[i] = 0;
+
+	for (i = 0, j = op->cmd.nbytes; i < op->cmd.nbytes; ++i, --j)
+		out[i] = DW_SPI_GET_BYTE(op->cmd.opcode, op->cmd.nbytes - j);
+
+	for (j = op->addr.nbytes, i = dws->reg_io_width; j > 0; ++i, --j)
+		out[i] = DW_SPI_GET_BYTE(op->addr.val, op->addr.nbytes - j);
+
+	dws->n_bytes = 1;
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		dws->rx = op->data.buf.in;
+		dws->rx_len = op->data.nbytes;
+		dws->tx = NULL;
+		dws->tx_len = 0;
+	} else if (op->data.dir == SPI_MEM_DATA_OUT) {
+		dws->tx_len = op->data.nbytes;
+		dws->tx = (void *)op->data.buf.out;
+		dws->rx = NULL;
+		dws->rx_len = 0;
+	} else {
+		dws->rx = NULL;
+		dws->rx_len = 0;
+		dws->tx = NULL;
+		dws->tx_len = 0;
+	}
+}
+
+static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
+
+	/* Collect cmd and addr into a single buffer */
+	dw_spi_init_enh_mem_buf(dws, op);
+
+	return 0;
+}
+
 /*
  * Initialize the default memory operations if a glue layer hasn't specified
  * custom ones. Direct mapping operations will be preserved anyway since DW SPI
@@ -812,11 +857,13 @@ static void dw_spi_init_mem_ops(struct dw_spi *dws)
 	if (!dws->mem_ops.exec_op && !(dws->caps & DW_SPI_CAP_CS_OVERRIDE) &&
 	    !dws->set_cs) {
 		dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
-		if (dws->caps & DW_SPI_CAP_EMODE)
+		if (dws->caps & DW_SPI_CAP_EMODE) {
+			dws->mem_ops.exec_op = dw_spi_exec_enh_mem_op;
 			dws->mem_ops.supports_op = dw_spi_supports_enh_mem_op;
-		else
+		} else {
+			dws->mem_ops.exec_op = dw_spi_exec_mem_op;
 			dws->mem_ops.supports_op = dw_spi_supports_mem_op;
-		dws->mem_ops.exec_op = dw_spi_exec_mem_op;
+		}
 		if (!dws->max_mem_freq)
 			dws->max_mem_freq = dws->max_freq;
 	}
-- 
2.30.2


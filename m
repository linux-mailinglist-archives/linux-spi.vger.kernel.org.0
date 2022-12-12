Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591E564A689
	for <lists+linux-spi@lfdr.de>; Mon, 12 Dec 2022 19:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiLLSIu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Dec 2022 13:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiLLSIP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Dec 2022 13:08:15 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C2F62C0
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:46 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so5918826wmb.2
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nw+ztXnGHyYMBnK3u6yi+RJj9VVFK1mXZxrwwWAC58Q=;
        b=EvYV9N3cBCbuzunyGyGBwPjVCAOQTwLKBpRwnztfxX/N0iezAJEtIytpW67I/MdrQD
         KNrYxyvS+4vv6nkIbCMWvJ+SEsNj1uFJMDG7rIqyqU4Zs5kpglFNYR5483GCntPab2kD
         VGpvXxQVl8pOTKbQDFxYVqmGi0wY2DYroI4eJQLdkR52cG5Pcx1pTz1+86O7zjBE8xiD
         Fyw4SHZVm15O1EX5AsP+NiX/AdMPTfdXmyb5R0gnbOUcgsYt/JbAT7uRrg3u7Iwo51Jh
         ZJHhhILurAA0Q79eBpGlPWuBqe73HU228C3hThXTIxoldWacfOTBBDXGzlXzunqbl9iN
         Djsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nw+ztXnGHyYMBnK3u6yi+RJj9VVFK1mXZxrwwWAC58Q=;
        b=p6n9uxgiAAarvH12bK5tdVp6/9kKEVLld1CHB1HL4FK2vaaqeuHP6yWcIn+5yYV0Uh
         fu4w7hw/DpYKJyo7DCT9vJ7pnkL0fPzQIhTZ3CzlDFav4b24DDQFK3zpm9mKCNZffTWc
         nTc9T7CMmV4cEjpidxpqov4pEAhOAWYLdbxzVwUUFtMOPAbP1j+zWGp8eQhZ1u0WLiMs
         FNwja5a0IiZGfEWbI460KjND76hocUYebd/uxOQ8B8E4MTY1EA+FpiLBVXv9p8SQb304
         CgkmxZS2pRRocKG5n/OjBFFYp+JUJTtk8yiWsrFZRXuQ83RcoQQAfpOpEAyqBZzKHedR
         dSTA==
X-Gm-Message-State: ANoB5pnFhzqITQu2rZZEtsO/JpnZmPK6RQkMptHvxyHjh3STWSxWcxyQ
        XT4XJBzYU0yjk0Uphf2hHNUpsA==
X-Google-Smtp-Source: AA0mqf5KMcfn7iP1eT6WO0H/6cWI/GBnzosK+colz6z78tS3vV/u6E7QlnAPi4MFVqa+WDaCiLR39A==
X-Received: by 2002:a05:600c:3512:b0:3d1:fcb4:4074 with SMTP id h18-20020a05600c351200b003d1fcb44074mr16382196wmq.22.1670868465259;
        Mon, 12 Dec 2022 10:07:45 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:44 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 04/15] spi: dw: add check for support of enhanced spi
Date:   Mon, 12 Dec 2022 18:07:21 +0000
Message-Id: <20221212180732.79167-5-sudip.mukherjee@sifive.com>
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

Before doing the mem op, spi controller will be queried about the
buswidths it supports. Add the dual/quad/octal if the controller
has the DW_SPI_CAP_EMODE capability.
The DW_SPI_CAP_EMODE capability will be enabled in a later patch.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 25 ++++++++++++++++++++++++-
 drivers/spi/spi-dw.h      |  1 +
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index d59401f16c47a..49fad58ceb94a 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -510,6 +510,26 @@ static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 	return 0;
 }
 
+static bool dw_spi_supports_enh_mem_op(struct spi_mem *mem,
+				       const struct spi_mem_op *op)
+{
+	if (op->addr.nbytes != 0 && op->addr.buswidth != 1 &&
+	    op->addr.buswidth != op->data.buswidth)
+		return false;
+
+	if (op->cmd.buswidth != 1 && op->cmd.buswidth != op->addr.buswidth &&
+	    op->cmd.buswidth != op->data.buswidth)
+		return false;
+
+	if (op->dummy.nbytes != 0 && op->data.dir == SPI_MEM_DATA_OUT)
+		return false;
+
+	if (op->dummy.nbytes != 0 && op->dummy.nbytes / op->dummy.buswidth > 4)
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
 static bool dw_spi_supports_mem_op(struct spi_mem *mem,
 				   const struct spi_mem_op *op)
 {
@@ -792,7 +812,10 @@ static void dw_spi_init_mem_ops(struct dw_spi *dws)
 	if (!dws->mem_ops.exec_op && !(dws->caps & DW_SPI_CAP_CS_OVERRIDE) &&
 	    !dws->set_cs) {
 		dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
-		dws->mem_ops.supports_op = dw_spi_supports_mem_op;
+		if (dws->caps & DW_SPI_CAP_EMODE)
+			dws->mem_ops.supports_op = dw_spi_supports_enh_mem_op;
+		else
+			dws->mem_ops.supports_op = dw_spi_supports_mem_op;
 		dws->mem_ops.exec_op = dw_spi_exec_mem_op;
 		if (!dws->max_mem_freq)
 			dws->max_mem_freq = dws->max_freq;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index f29d89d05f34b..327d037bdb10e 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -34,6 +34,7 @@
 /* DW SPI controller capabilities */
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
 #define DW_SPI_CAP_DFS32		BIT(1)
+#define DW_SPI_CAP_EMODE		BIT(2)
 
 /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
 #define DW_SPI_CTRLR0			0x00
-- 
2.30.2


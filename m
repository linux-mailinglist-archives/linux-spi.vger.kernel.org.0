Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2818264A690
	for <lists+linux-spi@lfdr.de>; Mon, 12 Dec 2022 19:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiLLSJD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Dec 2022 13:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiLLSIR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Dec 2022 13:08:17 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73164FC5
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:49 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r7-20020a1c4407000000b003d1e906ca23so4745825wma.3
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kO55louo2HU6Sz7zwFvdEDjc7T0J+jmAh9v7bF4ReTE=;
        b=nU9H0esTBqDujvdLtNHyu/dMXGGMrSAn3OF57Layi0xTvRNyVA22Hy5ZCKvHE+oZEh
         5hTu9CilC7hGUBqb8qEyU510YD8ghPDvFvHSAJ4NfmhN5Ucb7DdR6RYtz7h6p83j8Bg5
         CW22vgN/WIZz8gAmG9WW8eBQKa9Km4zUzyLX+6tSNoyo1pd+0VZxlRt3ETB+dVvCvQgz
         XuijsrsipVnfKfuYO4vYBlx3L5xoe5pXV7nSOyO9QzMWC26wTCkWXOJkg6eLxOWlWja6
         TjpakmpAtCqlSyG2HWUI4k8bkcpPVjB4nRA9qVV41qKXcC4ijX4HG8zjRdwS9asF2jRu
         Iorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kO55louo2HU6Sz7zwFvdEDjc7T0J+jmAh9v7bF4ReTE=;
        b=rLjOxOa4V4ys91l1hpO2mypFISSn4mKp1l852GQfTXtB/i4hqNWpssmt8SMNCP/7HZ
         wMqkGWxqp5kDLqIrAo/FxqxpfFq4ADaYOFrhlFHoqZjA4pkLI7Z8Db4yhALiMCH5QXRX
         nEfCA68lPfrG5yWpc/zhBaFO9V7WMLBl3JQLmvJoOUroCERbGo7F1pJJcIF5sooqh5kZ
         xhDyrHvJBEFZVd0KVLY15l93fnvY/jmf7f94RcnRbX8OLAwtMx+40fCFQSOIbnrqcHat
         W7vURUsF3vJRwygWm7uUrSEWjTF2kMyBrK2ggKrgoz3TXx17P6oaGxHtSYZCCDqS+kVM
         apEg==
X-Gm-Message-State: ANoB5pndSW/ZVZ/xPPWXLBoY86gJ7ZqdAMFTS8Wa0V9pt6qnQlg3/RFN
        RfwqRRJt61Lm9i1yjCweXPbP6w==
X-Google-Smtp-Source: AA0mqf576dfQVybxuLIfbCOlA5k+I0iAUAm+7frqEKemXUaCX04SdUwv/iSXFNwFmmufYzP3aoyNxA==
X-Received: by 2002:a05:600c:350a:b0:3cf:fc0b:335a with SMTP id h10-20020a05600c350a00b003cffc0b335amr12998821wmq.40.1670868468043;
        Mon, 12 Dec 2022 10:07:48 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:47 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 07/15] spi: dw: send cmd and addr to start the spi transfer
Date:   Mon, 12 Dec 2022 18:07:24 +0000
Message-Id: <20221212180732.79167-8-sudip.mukherjee@sifive.com>
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

In enhanced spi mode, read or write will start by sending the cmd
and address (if present).

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 06169aa3f37bf..ecab0fbc847c7 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -832,6 +832,29 @@ static void dw_spi_init_enh_mem_buf(struct dw_spi *dws, const struct spi_mem_op
 	}
 }
 
+static void dw_spi_enh_write_cmd_addr(struct dw_spi *dws, const struct spi_mem_op *op)
+{
+	void *buf = dws->buf;
+	u32 txw;
+
+	/* Send cmd as 32 bit value */
+	if (buf) {
+		txw = *(u32 *)(buf);
+		dw_write_io_reg(dws, DW_SPI_DR, txw);
+		buf += dws->reg_io_width;
+		if (op->addr.nbytes) {
+			txw = *(u32 *)(buf);
+			dw_write_io_reg(dws, DW_SPI_DR, txw);
+			if (op->addr.nbytes > 4) {
+				/* address more than 32bit */
+				buf += dws->reg_io_width;
+				txw = *(u32 *)(buf);
+				dw_write_io_reg(dws, DW_SPI_DR, txw);
+			}
+		}
+	}
+}
+
 static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
@@ -886,6 +909,8 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 
 	dw_spi_enable_chip(dws, 1);
 
+	dw_spi_enh_write_cmd_addr(dws, op);
+
 	return 0;
 }
 
-- 
2.30.2


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B94588168
	for <lists+linux-spi@lfdr.de>; Tue,  2 Aug 2022 19:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiHBR62 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Aug 2022 13:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiHBR61 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Aug 2022 13:58:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6154F67E
        for <linux-spi@vger.kernel.org>; Tue,  2 Aug 2022 10:58:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c22so7579610wmr.2
        for <linux-spi@vger.kernel.org>; Tue, 02 Aug 2022 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vuo/vfkePpTgDDEhsrHOq8e5JZuKt6L4eA032kLF7mw=;
        b=PnFR54/krkQJBd9Cf9a4Xk/Fct0bWlowlgRa8ZaGY0hDslopTBk/b9JuMhEE9wm0nj
         f9CPxt4/15USCxyOb217JyqZOsQiP71VknMujxa5tmHdA9j3grppFgZSa9oqCWasMW3X
         txoksfC18gjyehYqyKNPtqZ4iYmIzSLBx9gFa9dYdLB5kX1fLLZpG/fADDodDAvQ1PtN
         SguY7LD2ouWC1j5H065nWm5J44FSj+T9zZmpase271yDX06aSD6u2v8YGIjDyfhAX4Ap
         3QM+OZJ7Wxo1toFmslEvOmVhaDxVBB0YAAsfT0YMVsS6xXy//CvoCTVYgfPLxQuA1OmZ
         tygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vuo/vfkePpTgDDEhsrHOq8e5JZuKt6L4eA032kLF7mw=;
        b=DDo+kZpGbrkRBF2muwDhJrXDAAGOXPQNKKLR2y46m+a7YSBJLL91d4utRydstn0QGG
         zCG9dNk+9UgTET7LEAsO0pyz1xI9D2PhP/1XLDMpRjHjfOYKCqO0I6+tVxuHzWPFnwuH
         ucjoJp+9taWiXkRy2VLERQlHOXHDjpIOF8/8w78ALCt+o6qeo6f/HaUubFI7KYu50tWd
         BUqgWOTxKqlpD4HFVZKR0LK6+2/qhu8YhGEB95zEnNYbx088YN5gBaFxdYExRtbAone+
         gG2flH//FSOeyWe32olsnnqu1Z5BAo84X5LEaM+210uIpjMI5yMNH6p6DVKTbOshslth
         udIw==
X-Gm-Message-State: ACgBeo2bRGnN67Qb7IVl89HG0ulP9DhP8TYDX8UVG5J7i/+X3wVucEH7
        u+P/q9VGT+kxBTyEUKCbOPLVWpwPs3OHKg==
X-Google-Smtp-Source: AA6agR7fgM/0HFHd9EIUlLwNLdq6e6BT/2vkCwL/gzJY507E1BFT1d+PE2SL6vS8x8gdqvrg6ZKFTQ==
X-Received: by 2002:a05:600c:40cf:b0:3a3:1fd6:47b7 with SMTP id m15-20020a05600c40cf00b003a31fd647b7mr406810wmh.32.1659463103860;
        Tue, 02 Aug 2022 10:58:23 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003a3187a2d4csm23318222wmi.22.2022.08.02.10.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:58:23 -0700 (PDT)
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
Subject: [PATCH 01/11] spi: dw: define capability for enhanced spi
Date:   Tue,  2 Aug 2022 18:57:45 +0100
Message-Id: <20220802175755.6530-2-sudip.mukherjee@sifive.com>
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

Some Synopsys SSI controllers support enhanced SPI which includes
Dual mode, Quad mode and Octal mode. Define the capability and mention
it in the controller supported modes.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 4 ++++
 drivers/spi/spi-dw.h      | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index f87d97ccd2d6..97e72da7c120 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -917,6 +917,10 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 
 	master->use_gpio_descriptors = true;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
+	if (dws->caps & DW_SPI_CAP_EXT_SPI)
+		master->mode_bits |= SPI_TX_DUAL | SPI_RX_DUAL |
+				SPI_TX_QUAD | SPI_RX_QUAD |
+				SPI_TX_OCTAL | SPI_RX_OCTAL;
 	if (dws->caps & DW_SPI_CAP_DFS32)
 		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	else
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 9e8eb2b52d5c..71d18e9291a3 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -32,6 +32,7 @@
 /* DW SPI controller capabilities */
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
 #define DW_SPI_CAP_DFS32		BIT(1)
+#define DW_SPI_CAP_EXT_SPI		BIT(2)
 
 /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
 #define DW_SPI_CTRLR0			0x00
-- 
2.30.2


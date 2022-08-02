Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2063F588172
	for <lists+linux-spi@lfdr.de>; Tue,  2 Aug 2022 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiHBR66 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Aug 2022 13:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbiHBR6s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Aug 2022 13:58:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5E5004C
        for <linux-spi@vger.kernel.org>; Tue,  2 Aug 2022 10:58:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m13so14870959wrq.6
        for <linux-spi@vger.kernel.org>; Tue, 02 Aug 2022 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aw1T0LbIz46FjjhEEbnLK9sG6AnjTXA0RQTg3FMEtWM=;
        b=Ll4PnsHqjC5+Apl2W8TRgizSTL+qM2QieFGnFpMfahQhwmC8gZ/Kk8LM2I1Kc53PKK
         PEdle2T8rddCGvPtKyNMr+jtvzu6O8PICLizWGr66hyw4Qr3hNenamiKSwZKdNV9aUg2
         A/wQLuDOrowXD22RcDzolkucJsDFPQFaI9v+QkSOXx2I8hQXQUd6pB9qsA6vZy9v2yyy
         RYRyq2KzCZMdr0dSDzNzfxGvT0iL1p40OZCt9/k1GQsjyyDwXZCSYFRK8xdgKqurWJGp
         R6sOn0SdphcTQHt3uz8vHh/e+vaIVipucgnYy0XwGjaw24TJZtb50jxGxI4loltUZ1RI
         +CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aw1T0LbIz46FjjhEEbnLK9sG6AnjTXA0RQTg3FMEtWM=;
        b=g/jTM5ZxUVta2XpboN+LRclmpBbRp5KlBmqdqf3XikMVrXfdjfjQkgKmRNvPon3SC0
         6CkaLBA2T2zZyJoBHNGxIZO2Q9fxOoZUC+J22hwZkMOmx5YIcSQP7/syTDpi3NHWDXb7
         mT0vghs1LQFFpB0aBOSrIQPwdLEWqDkkjvBFoseLKezCUnBXtGEpkcEfgAUxANeYCD4c
         TWf96XlTazR3+Apzhi/K1OftguJGwXNKyFx11dVhQsC+738a4hVf2N0NTWmqbcrMggTQ
         XIGaHgjh8toZfosQ3hKWpdkDURa816icjS/dSiEBQikRLvxIQFrTEkGt/58X+fhMyMr/
         E1Sg==
X-Gm-Message-State: ACgBeo0T/iQmz0Jq8JdqUHS0K66Uni5HCWSLBoy5WuYPZtL9t+qPyV/b
        0owXOBgq4Gm2J3sRr7FvphYZnw==
X-Google-Smtp-Source: AA6agR4sdG+OszyDwS/xWBJBhqDVwrVLMzLZwntiGrHw6bgHBiVdM59zNXn91whjJuu2BHpsFzgl7A==
X-Received: by 2002:adf:de05:0:b0:220:6c9e:5fd9 with SMTP id b5-20020adfde05000000b002206c9e5fd9mr3982511wrm.260.1659463124948;
        Tue, 02 Aug 2022 10:58:44 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003a3187a2d4csm23318222wmi.22.2022.08.02.10.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:58:44 -0700 (PDT)
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
Subject: [PATCH 04/11] spi: dw: use TMOD_RO to read in enhanced spi modes
Date:   Tue,  2 Aug 2022 18:57:48 +0100
Message-Id: <20220802175755.6530-5-sudip.mukherjee@sifive.com>
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

When we are using the enhanced spi modes we can not use EEPROM Read.
The Synopsys datasheet mentions EEPROM Read is not applicable in
enhanced SPI modes. We will need to use Receive only mode.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 8c84a2e991b5..8e624620864f 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -727,7 +727,10 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	cfg.dfs = 8;
 	cfg.freq = clamp(mem->spi->max_speed_hz, 0U, dws->max_mem_freq);
 	if (op->data.dir == SPI_MEM_DATA_IN) {
-		cfg.tmode = DW_SPI_CTRLR0_TMOD_EPROMREAD;
+		if (enhanced_spi)
+			cfg.tmode = DW_SPI_CTRLR0_TMOD_RO;
+		else
+			cfg.tmode = DW_SPI_CTRLR0_TMOD_EPROMREAD;
 		cfg.ndf = op->data.nbytes;
 	} else {
 		cfg.tmode = DW_SPI_CTRLR0_TMOD_TO;
-- 
2.30.2


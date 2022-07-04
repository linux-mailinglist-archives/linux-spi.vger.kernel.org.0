Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83387565674
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jul 2022 15:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiGDNG1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jul 2022 09:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiGDNG0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jul 2022 09:06:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FA5BF77
        for <linux-spi@vger.kernel.org>; Mon,  4 Jul 2022 06:06:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g11so463864lfb.11
        for <linux-spi@vger.kernel.org>; Mon, 04 Jul 2022 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxXFR2A/Ag3USOyt1g5JtxN+lXj4+CuJbOFExrxBsx8=;
        b=dsIPAzzAB5BLu4z0znbRAe5gDOdiEONnJgCr6D1Oqfvwah7/SX38NfpqBhg1LpqH8a
         jNq9dXrItwoWDFSt6Phx2H2aZ/Ex8pTnpColQKqY/JI5jC1C8KjAU6lNlYGg0mx8IZud
         OYtoLin7Ko3p7cR4iQVLowpFBNWvBKYZX/GldkV7qmld6xBV4CnljhxT9Mx4pvch2qmR
         ZwkfP1w/Led98cL/v6SvHNgLSeoKS7A3GhenxZuLDkr3Qu2jxNTyFWttkZwv8/WtoeP3
         futlahImOrCdJnHXqfi8N5gFcRsxOobn41HfDtjiqpRxzEBFf4Ao/zMBx6N+R2ll2jMt
         epnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxXFR2A/Ag3USOyt1g5JtxN+lXj4+CuJbOFExrxBsx8=;
        b=NDKrKfkkNBdAfjqqz26MW3B5YKi+EqxDbFgQ/ougTamWR3H0PTgQkLmKySe4qm15fD
         HxqJgkgFmpbal7IblmINX7dCt4y8agU0qgOH8OIHVHh8WzmTobZYm9xhLC3h25UfV3c1
         13Pib8nIaI/7DT94FaWthEox+IWjgoVURnKo/uFEkiPrvHFZkRVwqizzivDwAaguNYsQ
         B/a9AZHXOmrJ5MzCFtJJCDcjRKAS4IJ2SG6yBH125NKSfYMYDJcVNQP0Ydv9A5BhPIJd
         MNoLsqHRUqYmuyi8u3lr421Q/yIhDXd6X4aZw0RiKntFuviWorT/1S21xL7Fh28QjJwN
         hrtw==
X-Gm-Message-State: AJIora9ndNGkTtBTxRHbhN66Uo/KfmQvNjZrKO775OO8OAdkl0v1x8p2
        qK1XbJPpfS6VK2GOYep6vjdumA==
X-Google-Smtp-Source: AGRyM1upYqVora/1v2oA5cSs0dnUQ5gJMR2y82/3PByF0WNxBwiIrENqdJxD7jlXV2XiRhZi4G8Htw==
X-Received: by 2002:ac2:4c42:0:b0:482:cb18:25ac with SMTP id o2-20020ac24c42000000b00482cb1825acmr471142lfk.643.1656939983042;
        Mon, 04 Jul 2022 06:06:23 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id bt30-20020a056512261e00b0047861c163d0sm5115092lfb.37.2022.07.04.06.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 06:06:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] spi: dt-bindings: cadence: add missing 'required'
Date:   Mon,  4 Jul 2022 15:06:17 +0200
Message-Id: <20220704130618.199231-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

During the conversion the bindings lost list of required properties.

Fixes: aa7968682a2b ("spi: convert Cadence SPI bindings to YAML")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-cadence.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
index 9787be21318e..82d0ca5c00f3 100644
--- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
@@ -49,6 +49,13 @@ properties:
     enum: [ 0, 1 ]
     default: 0
 
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


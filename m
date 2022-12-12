Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8350764A6AB
	for <lists+linux-spi@lfdr.de>; Mon, 12 Dec 2022 19:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiLLSJh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Dec 2022 13:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiLLSIZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Dec 2022 13:08:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E25B6432
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:54 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i187-20020a1c3bc4000000b003d21f02fbaaso443887wma.4
        for <linux-spi@vger.kernel.org>; Mon, 12 Dec 2022 10:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKSt+dINanbC1i1CDPthK0t2BzwjJSENh1jILj1VWeU=;
        b=CP/vwL6A8mXTwGXYJ+BqrDO8jqPY0gc5EsrtR8UU4Xr/Yey/xzG/fAboGAfEJ8w3ZO
         kVAYje+2MI++GBQLVnMSaIDRenA0MD1T7zBVI2fUOHafowAARsd/MvtEM+/QNE7McZgz
         WpEIKw2FeZx1GMPWPPq3+3vKMFihI61yG0x1BUAGhUcXifoIbHFVc3ubnL9n9zSOx2c3
         PEl0fp16ZGL5e1UjUf7R9idaOmEYisVtToSGPqp8H1aeS3k6z4JXSaJKNTVmlikqMRSS
         yC2i51PO81Ovcevvk30tsXhxcKJ9WEZ/1MrZpq6ycvy+RFUouyB9Ncqu87aHxD1Q9KHB
         qhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKSt+dINanbC1i1CDPthK0t2BzwjJSENh1jILj1VWeU=;
        b=Mskhb07FNZPPk5SE59HVmjtX0aomCfx72lbTrbdiV7jWx/ujBTK/B1CmzjNiV3JlIW
         TKSEAFxctlPyxxrpif8s3KOZYfqTEELj0JBA3zMIRwOtEKNDdlcGu9kTrIjPcqWYTVoa
         1Gt8Fwm3ha/k+c4zTSk7gSDlfXtMPlQp7L7RQZuXNbcSrYh1iTkVL94fOq2BRk66WIa2
         uWBDDl4+GOaZie+GR7yG7yaZDNOpXckQSxw24f5PQeeBQ0PFHpmu6kVMicb26KP/maeS
         MVqHgZqLBUKHaJCL7tTy91CSxgyev8KWz+5wA6F5utoAmh/R9g305LL3ev60hymmyEfs
         F8UA==
X-Gm-Message-State: ANoB5plgsILF6hDXjJ2oIK8XLuqyldzXdY0nqiX1q4x8gDTiuuo8tTWl
        //6BhnQSDvNuDdoVY9XLOb7O3A==
X-Google-Smtp-Source: AA0mqf6MtJYNqYIN7i7b4qA53PDk44gOFQd0bWYqjVROn+LQhKwkZFbxs8ZDoLJ2HCrnxrAPAwf76A==
X-Received: by 2002:a05:600c:a11:b0:3d2:2a74:3a90 with SMTP id z17-20020a05600c0a1100b003d22a743a90mr2399695wmp.22.1670868474288;
        Mon, 12 Dec 2022 10:07:54 -0800 (PST)
Received: from localhost.localdomain (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10156808wma.4.2022.12.12.10.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:07:53 -0800 (PST)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 14/15] spi: dt-bindings: snps,dw-ahb-ssi: Add generic dw-ahb-ssi version
Date:   Mon, 12 Dec 2022 18:07:31 +0000
Message-Id: <20221212180732.79167-15-sudip.mukherjee@sifive.com>
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

Add new snps,dw-ahb-ssi version to the bindings.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index d33b72fabc5d8..af36df67a4c0e 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -45,6 +45,7 @@ properties:
         enum:
           - snps,dw-apb-ssi
           - snps,dwc-ssi-1.01a
+          - snps,dw-ahb-ssi
       - description: Microsemi Ocelot/Jaguar2 SoC SPI Controller
         items:
           - enum:
-- 
2.30.2


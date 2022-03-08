Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A605B4D10D9
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 08:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiCHHWa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 02:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242343AbiCHHWa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 02:22:30 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C59D3DA40;
        Mon,  7 Mar 2022 23:21:34 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 132so15685856pga.5;
        Mon, 07 Mar 2022 23:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BbGWRdfMw5O6J3ptTxpUy8/+22z3vg5V10Uqp3dSFOA=;
        b=YNXNimBuqD3nUZjCoHcH4/+4o60PEVS6D2Y+b1qxu+D3i4aPL6IZKDnBkP9SMveO+3
         sb8ptehiOLum6MtWvShEWN9RhGNUL17raScPZXIOygm6H5Vv15INAQyzK497JLFAhNM4
         LHS8eslj7QHs+5TQjIir41A+lh/Z5HKA9ybRot13q+orQZFdgH7OMZgxMck6t6YGYSWs
         iM7yLgSVfnG0twSYBQo6ZTZa5G6pkh7YCF0jgSyVtjgweL65dhZ1owm44enmfh2Uucwe
         Wg4Fap5hBEbsZ2dzpn9CUh//YzVOSZHIgprFKUQHzBFGA9mL8k6GRaD5bJVm8nnIkPE7
         ZZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BbGWRdfMw5O6J3ptTxpUy8/+22z3vg5V10Uqp3dSFOA=;
        b=CDFIbmXH4/eEi+NECy21cI0bntYD334Xn1YLt2Lnk5vmFYBJtlwnPkjf6gAFk5zhO6
         1IH1UrJnIuzNO91Ucwa105ThBcRrjl5nnSJWDsVp9jqwF2Ul96Jx7PbsqVKzGQAUVum0
         yQfosC5JE//U/gigGwd7pIwDUtQgZfJ1VbgSercxEWdEB//6ACq57KQw2Ie62Qtn/Pm6
         mnCmu0kGlukXjpgg25Dxkwr6RXAFsLYC7yywsZghP3TaAVqWOhDl44ANsBE8eAJm1wPI
         7lCiOyLjASP3/rZE2kMoan5I+8kRz2SKzItmItwp45o6sexNO7YDrlLDaclwignj9QrT
         K0ig==
X-Gm-Message-State: AOAM530WJrshP+pa80Zv52ULb0IEbq56mg0Jtw7k6Bp0FvpVWFodsFyX
        C3rhSOiOY2S99u4Fg0+D30U=
X-Google-Smtp-Source: ABdhPJyDEFDZPCLHv/dvj+Ftb/bL2ifiXiuwdDuyjRzyyGyhABbDIzwrwUmm+IVJe2dQ6RTm/1Qb9w==
X-Received: by 2002:a05:6a00:8cc:b0:4cb:b981:2676 with SMTP id s12-20020a056a0008cc00b004cbb9812676mr17059610pfu.5.1646724094084;
        Mon, 07 Mar 2022 23:21:34 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id 67-20020a630846000000b00372782a65d0sm14995206pgi.60.2022.03.07.23.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:21:33 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 2/2] dt-bindings: spi: Update clock-names property for ARM pl022
Date:   Tue,  8 Mar 2022 12:51:25 +0530
Message-Id: <20220308072125.38381-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308072125.38381-1-singh.kuldeep87k@gmail.com>
References: <20220308072125.38381-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Pl022 clock-names can be one of following:
['apb_pclk'] or ['sspclk', 'apb_pclk']

The current schema refers to second case only. Make necessary changes to
incorporate both the cases and resolve below dtc warning:
clock-names: 'apb_pclk' is not one of ['sspclk']

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v2:
- Reword commit message
- Drop SSPCLK

 Documentation/devicetree/bindings/spi/spi-pl022.yaml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index 7d36e15db5b3..6cfab948624e 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -38,11 +38,13 @@ properties:
     maxItems: 2
 
   clock-names:
-    items:
+    oneOf:
       - enum:
-          - SSPCLK
-          - sspclk
-      - const: apb_pclk
+          - apb_pclk
+      - items:
+          - enum:
+              - sspclk
+          - const: apb_pclk
 
   pl022,autosuspend-delay:
     description: delay in ms following transfer completion before the
-- 
2.25.1


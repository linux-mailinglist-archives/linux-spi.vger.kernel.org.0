Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C174D086F
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 21:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbiCGUit (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 15:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiCGUis (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 15:38:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B8C2FFE1;
        Mon,  7 Mar 2022 12:37:53 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so256595pjb.3;
        Mon, 07 Mar 2022 12:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eNTrf0BzZT/L8eS5+jreVZ/jxDAEJAl1RSsRyYXFuNM=;
        b=YXvbQmhoV+E0JW/2Ypum4lSGw84aygx2zlkkDVofLnT7OJTPxlRqgPGmedIJGEe/fo
         MLCwO1/pITjd6vf0jdzE/QkdB9T9wY5DCfOXJwFA9EJYOWMGXxaR/P9LwhsJSXySqdqZ
         VPDmN/5plUk8TUIZSeNVw2lIR/djL8a/Toe28s5XBDuYbhFDALk9WMKYLEj9HdAl2ksW
         N+7aH5zNldn24z2tjgf0u9OWh/c2PqWUhxG72ovBZHpbOcAWh+XEGOUytxk7yNOjSG/x
         PfopayIHhSOURIuel/Ynf4mhs9gRt3d6xIrkwffXxYB4DiWtGqUDG5uBDKaSN6cm4fKT
         A3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNTrf0BzZT/L8eS5+jreVZ/jxDAEJAl1RSsRyYXFuNM=;
        b=tnHhkeI3Wlbxrkud9w9GAZmW0dkYVrJdubIfodbRl6HpXgaUwGT83n5bjq3e8z5Gdn
         6zWLINhyWChNAX9CTZlvPgXsANDfwoGtI2WM0JYcObWrG1R9iy5L2cruvY5ldl5pKHSi
         SKrFjSS6xOHypiFNnAhbfOBVP5DTpX5HW2ysIXH9piQeHltKSC4cBqI+NIdZ3BrCTME5
         aIldvGMYUJdZe+qDpFf5g4Sq/hUxqUXRVAW6HRwSSvbM3RZg70L/P1XllpsmfM8632qJ
         g1WCKStpVQ5Y1ykv3cequwuWIuO9FH66gYm5wAx0cpwU+TtizShQXSE+ug4W5Lg1WQCg
         +6mg==
X-Gm-Message-State: AOAM5308/MyeZPg/H9LRxiJyiGn+MlbdyI/Ttp39j43HKLDgoz+BEIRm
        9vQaADtY/L3dQcpjIPhl2g0=
X-Google-Smtp-Source: ABdhPJxvDIqFg7AyeGcc2ehPEWWBpB/Ul5//9k7ytEFJnBWM0kfLPHj7DGwypfoxfVP11C/IFOMeKg==
X-Received: by 2002:a17:90b:1809:b0:1bf:59c:d20b with SMTP id lw9-20020a17090b180900b001bf059cd20bmr838272pjb.220.1646685473404;
        Mon, 07 Mar 2022 12:37:53 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a450900b001b9b5ca299esm206323pjg.54.2022.03.07.12.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 12:37:53 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] dt-bindings: spi: Update clock-names property for ARM pl022
Date:   Tue,  8 Mar 2022 02:07:45 +0530
Message-Id: <20220307203745.65210-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307203745.65210-1-singh.kuldeep87k@gmail.com>
References: <20220307203745.65210-1-singh.kuldeep87k@gmail.com>
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
incorporate both the cases and resolve below dtc warnings:
clock-names: 'apb_pclk' is not one of ['sspclk']

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
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


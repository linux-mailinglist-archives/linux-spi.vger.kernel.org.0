Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6F7588187
	for <lists+linux-spi@lfdr.de>; Tue,  2 Aug 2022 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbiHBSAJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Aug 2022 14:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbiHBR7i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Aug 2022 13:59:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C434451A3D
        for <linux-spi@vger.kernel.org>; Tue,  2 Aug 2022 10:59:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso895702wmq.1
        for <linux-spi@vger.kernel.org>; Tue, 02 Aug 2022 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GcoYEB+LR9XunENDegpBIP0LqpENWfoItafTlDKOv+I=;
        b=WMOKG78H365a+1ElleuamwOz5x7nE0mLG5uTbACzumPhRGmXv5sfab7nXNUXyJdJMI
         DPhDLCcfuHwwQcC7c5okRHgmuwAtp3QP27/pORFDgtfkIWXiASsO8Bq+zPe0/KGUpE1L
         +Ik6nx+dxN8mlk2tdCHFhuvYghGT2IcziEpmNxv7ur3VBpxILD5yuQ2W8muRXiC862sO
         2nbXa9dp2dof6J/8Jpiu7kUqHGJgdmNIkUiiTFpazlhkyXn5ZNo0X6mXdYgY+6l5hU3B
         c+SB1ZSOXOPDNESG7khQQgVLGRJlZO0sCCgfxrbBYfAi6H03cUSZWg6zysJrcIBhNGYJ
         iDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GcoYEB+LR9XunENDegpBIP0LqpENWfoItafTlDKOv+I=;
        b=JUtXJWYYPHiEXg91SUJD8rihasaVIvy24pWTt7lIGCtn98mRlmbDKIz/TCWAZo+JKI
         dOMADXqtWA6HkVqXzmfDgRAZtJVCi6hGyAs4Rl5tlLSQplJzcapaVSY7JUrvWyctyJOA
         edJ3qZ67XqfDq39WQR+53tovJHwbptNJOhKOmXiMw7LUEMGlUBk6kK+ujiAolNoFUkvt
         b0qkrQXH1gCs1+9qyx5x7qqf5300QASpnVppAqu6Cg0zJktR9VB+SNztcjmVDBhaXKXw
         7M4Mr/sHpTrjyQgDAZzX9LoTskwzz8mlluzL5znY4wqbsmlf8rHcM7SjZpYr/WVzzFlH
         vO8g==
X-Gm-Message-State: ACgBeo17riPSRd4imJjRvQFUAWVRmcYEBJ5XuT7DZ3sQPYVZxjlTzhnL
        nzLJbO9jMGD6b7oTjbTLuv7JhQ==
X-Google-Smtp-Source: AA6agR7FIi17LUA0EXeBzFgwdWxt0gU7tveiwLFLYacKYX2TSURwQiGl8iMhtl52FemdGm66uw4aQA==
X-Received: by 2002:a05:600c:3786:b0:3a3:19d4:293f with SMTP id o6-20020a05600c378600b003a319d4293fmr404947wmr.116.1659463167235;
        Tue, 02 Aug 2022 10:59:27 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003a3187a2d4csm23318222wmi.22.2022.08.02.10.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:59:26 -0700 (PDT)
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
Subject: [PATCH 10/11] spi: dw-apb-ssi: add generic 1.03a version
Date:   Tue,  2 Aug 2022 18:57:54 +0100
Message-Id: <20220802175755.6530-11-sudip.mukherjee@sifive.com>
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

From: Ben Dooks <ben.dooks@sifive.com>

Add new snps,dw-ssi-1.03a version to the bindings.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 37c3c272407d..35aa04a85813 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -45,6 +45,7 @@ properties:
         enum:
           - snps,dw-apb-ssi
           - snps,dwc-ssi-1.01a
+          - snps,dwc-ssi-1.03a
       - description: Microsemi Ocelot/Jaguar2 SoC SPI Controller
         items:
           - enum:
-- 
2.30.2


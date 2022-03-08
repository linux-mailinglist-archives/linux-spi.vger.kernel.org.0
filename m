Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0343A4D10D7
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 08:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbiCHHW1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 02:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiCHHW1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 02:22:27 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B235833A01;
        Mon,  7 Mar 2022 23:21:31 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id z4so15662715pgh.12;
        Mon, 07 Mar 2022 23:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=InYx5E35xCXMzdh7VhBOTrNQit1CCIS3WqKJpQjMoRE=;
        b=EfRlsqFx8/TKH2eJluF62EVChtCYp8brbzZetxdmlEtmMksT3NrvvQSKlNKRUAM2bC
         9K8WQbcg5OuzKFyeXDESpXbFrsgTYhqtr02BrgAlIc3CrZkZIMukRScFOKBG3BsqFsd/
         RL/5xqUYWSUh/g/EqrsDofUeHcqMyphqUzNMtUVSR52Ac8Sc997M7wrFBTeqM+19XQWk
         dh73wgql9J/cv9CsxdgRPnJC10xvZGwZxfgXr51Vx4HFZ/LMIkufVKv7ZeeRiWYiFPs1
         8hmk1bJsInzrvj/TEy+KeKeGvOBe6/+QsEF3aXWF1HoOfpEaGjarvzQmbY4a0iCJl3Oo
         uluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=InYx5E35xCXMzdh7VhBOTrNQit1CCIS3WqKJpQjMoRE=;
        b=1ekarVkQ1qsxq6T53qPUFCjSqHTTb3/SF82WbsDtq7ebKwmUhK5Uq6k3J4axJgPU1D
         oJnTP9HUBjrk8jfi2TPYGHp71xaNgV8EYQqRDiqh7IQ6m3W/Ztb4FjE0B9VNUegnoxgN
         +x/iunFAPiea/pM625euvjizpfyCsBnbAb5nTrUUxm/gpd7Lc5dZVjoqlCpEuyBLlrZ6
         1wl3RKBeryE31aNfkIRUCIkXbpOHwvLtjRSNQs5RX0YXQZMNIHevIEovrgNtdv70/Lwx
         +gzt4Jif8QBkKMb7Kof4qBV2thDMD/37CW5OODrL54K4flPnNBB7aQLl0MN63yh5t29e
         WdpA==
X-Gm-Message-State: AOAM5331386axlXOd2KkD2QsoCONcr8hZLLag+hCrwaJCmkl8XsWzPcG
        DUdBPxB1AnVHlc5vyrxdjJcViK807CzfBA==
X-Google-Smtp-Source: ABdhPJx78V7vzD9QytRnrvlk5rWAgb2Z2AgIMt/f75+uIp5RPc+YkixrSPDEoGLa4oYnpwtrBSoaOA==
X-Received: by 2002:a63:f816:0:b0:37f:f252:9f12 with SMTP id n22-20020a63f816000000b0037ff2529f12mr13366177pgh.318.1646724091167;
        Mon, 07 Mar 2022 23:21:31 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id 67-20020a630846000000b00372782a65d0sm14995206pgi.60.2022.03.07.23.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:21:30 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 1/2] dt-bindings: spi: Update clocks property for ARM pl022
Date:   Tue,  8 Mar 2022 12:51:24 +0530
Message-Id: <20220308072125.38381-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Add missing minItems property to clocks in ARM pl022 bindings.

This helps in resolving below warnings:
clocks: [[4]] is too short
clock-names: ['apb_pclk'] is too short

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v2:
- Keep actual warning and remove path to file
- Reword commit message a bit

 Documentation/devicetree/bindings/spi/spi-pl022.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index 6d633728fc2b..7d36e15db5b3 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -34,6 +34,7 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 1
     maxItems: 2
 
   clock-names:
-- 
2.25.1


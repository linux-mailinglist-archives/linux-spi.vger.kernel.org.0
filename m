Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260334C509F
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 22:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiBYVYa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Feb 2022 16:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbiBYVY0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Feb 2022 16:24:26 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862AA188847;
        Fri, 25 Feb 2022 13:23:48 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id lw4so13197103ejb.12;
        Fri, 25 Feb 2022 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=XMOMyaP+5tw/NTE2jwKE8j7Rm2F5qsTyT92ajHBSVzE=;
        b=IjNy65ihmU+6AEvk3BdFsxIrkof69TC3Pxon5+csXTU78W9JB1ejc+cmw81jqxkZbP
         ViMqvn7ttZp9FOPHUXH0y592rsX8cVkQyzrN2uLRYYInqTE4k0A2PvRx6c7kXj4UqrjK
         MEcLwHeO2eaMhj4ClKTqofOqdKWHBRR7w7XGD+LtCubXBUFXcHQtYSSKAU65uI2X7uWD
         EBlfSmCZ6G9OQMImiK0lVp/P4kkenpQAUrSEqyRNX0sFMly9sK2d9NqT6a8M8BH9HajS
         S3rC1U09VDscCN81zwZ607P5R8p57OjobrRXy9fS8HpMc0B8a4GWZdMS/KUL1N7QJiP4
         ai2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=XMOMyaP+5tw/NTE2jwKE8j7Rm2F5qsTyT92ajHBSVzE=;
        b=HLhngR+1dMdtTNstQDpfkBM1WHxk5/C32dUxmTf3VggTUxb4ecLrIOGP0Ozh/WPNVW
         iXYKrFm3J6iK10Ihc1LML96SQ7aWC2mpK4ZMBFqhlyvDTDRD+RzzTTQMnqX66RFwa3/z
         vX44qDQ4IZk9c7wse4jRjGnsuSAV2oCsgmKk22mCkcTNJ0C/shx+xTcRLGqMvR/DM+1R
         gfAaedksF/I+o1cSTRJXtpWnszluatoFansVTizlpOlcjSY1dxsWQ5Tqg646E6b0QcIm
         1wkpIWw1YB36GFVixsMxNMUwDbatxMvWntnYiQUd22dwQ4R6k+w/hvac8Hf9FGBqTCpx
         x/rQ==
X-Gm-Message-State: AOAM533Kb9kX7Mso8VinFOQUvB0/GZ/VSrIbVEdONDod41UQ/O13kNyF
        xFWn62w8OkJEeVgnxWaNht0=
X-Google-Smtp-Source: ABdhPJz7EKJhsLg03UN9iq/z6v8bEQ6eCSnzB0QD7Ao+asSXXmsuw5PyGkcL9GCrBqQ6giKMfyQzIQ==
X-Received: by 2002:a17:906:9b88:b0:6d0:f843:4068 with SMTP id dd8-20020a1709069b8800b006d0f8434068mr7369328ejc.678.1645824227108;
        Fri, 25 Feb 2022 13:23:47 -0800 (PST)
Received: from ?IPV6:2a01:c22:7326:e100:c9d3:3c62:2c99:d44b? (dynamic-2a01-0c22-7326-e100-c9d3-3c62-2c99-d44b.c22.pool.telefonica.de. [2a01:c22:7326:e100:c9d3:3c62:2c99:d44b])
        by smtp.googlemail.com with ESMTPSA id bd3-20020a056402206300b00410a4ac2802sm1878229edb.66.2022.02.25.13.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:23:46 -0800 (PST)
Message-ID: <ed500ab9-baa4-8f9b-fdb8-45f0ca4569cd@gmail.com>
Date:   Fri, 25 Feb 2022 22:10:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v5 1/6] dt-bindings: vendor-prefixes: Add Titan Micro
 Electronics
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
In-Reply-To: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Assign vendor prefix "titanmec", matching their domain name.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index e062a8187..6ffdec91f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1238,6 +1238,8 @@ patternProperties:
     description: Texas Instruments
   "^tianma,.*":
     description: Tianma Micro-electronics Co., Ltd.
+  "^titanmec,.*":
+    description: Shenzhen Titan Micro Electronics Co., Ltd.
   "^tlm,.*":
     description: Trusted Logic Mobility
   "^tmt,.*":
-- 
2.35.1




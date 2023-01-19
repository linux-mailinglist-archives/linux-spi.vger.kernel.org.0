Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D58C672F8F
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jan 2023 04:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjASDnD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Jan 2023 22:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjASDmQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Jan 2023 22:42:16 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9791868404
        for <linux-spi@vger.kernel.org>; Wed, 18 Jan 2023 19:39:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k13so1171966plg.0
        for <linux-spi@vger.kernel.org>; Wed, 18 Jan 2023 19:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gl+NRk1lPPWu1qLYsSSP0N9uQlgD1WldvUdBw1ctCec=;
        b=qoqKcYS8f6LMfCltLCw76kTijQXNvX8/VfSXOt8OQrO2E8WQaYIhFmesf6yohs5pCL
         CKe9/hsZiNYjWzFOxE8+B9URT7SJoH8qGUey1J4QXn0UcWxlbgMZNlEAFjewsp5T4lxS
         oKV5aeT3lsA7bO2sBGFyhsj14m/2UucKNjWqsRl+8fuy+YCWQ9zlFLvQZdrDjEoYqug4
         Ol7di2eThl9GBfTVpWJJQUHB0bMtZv6nv244CE/TRC4TFC53wNdW9mkC/kWX6d4MsdWK
         8uAfsPcBZUSepvXvgxsXuSf/zZIMFO/79KjunLxONC5XWH2tN8ihE875BDx9+hLxAtvh
         Cdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gl+NRk1lPPWu1qLYsSSP0N9uQlgD1WldvUdBw1ctCec=;
        b=i1FSekcbgJTgvEwpLmcwHPWwZArge4blgF9RMG8TMMGSruN7JuVPfMFEfTTAsj/1bx
         44xtuuQNPM1g+w6J/G2T3WqaTGsk73WTFCXyjhEQusUdF0R3xQR5vIllRgBlo3VYFY55
         34WU1waO9hT5+hz3jkqJMkG7jlbRs4isEnWMzP3lEFR3tXlw4CcexINqP4ESvcBfMbdR
         efRldjKkpvg6g/xg803sy1N+06BoT+d8eDj+2p4V4qMkwmZqmoC4ArRJLdL101OAyNyj
         JlXL+zckGFd1oLprXBZTiJblP4gZBJc9TkEKXyp9LPoKXozv9DCP7Q3r+EWnXwi2wTsN
         F5Uw==
X-Gm-Message-State: AFqh2kqmOLSwgvUoFeVjsK7/nkZzic6j8nTvIGwwpxQEgG7j3ttoxCPt
        SV81OeV0IjSXqEqoWT1lm7oepA==
X-Google-Smtp-Source: AMrXdXvbKqKaMAq7GGHotAAAqe4B4wwrXEa//ZM+fYtZneMxVJOeS6SJD7B7/df7q0hm0iWG4UMHMQ==
X-Received: by 2002:a05:6a20:8f0f:b0:ac:9d6b:c1f0 with SMTP id b15-20020a056a208f0f00b000ac9d6bc1f0mr13369763pzk.40.1674099585005;
        Wed, 18 Jan 2023 19:39:45 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:39:44 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 01/15] dt-bindings: arm: add AMD Pensando boards
Date:   Wed, 18 Jan 2023 19:39:04 -0800
Message-Id: <20230119033918.44117-2-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document the compatible for AMD Pensando Elba SoC boards.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../devicetree/bindings/arm/amd,pensando.yaml | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amd,pensando.yaml

diff --git a/Documentation/devicetree/bindings/arm/amd,pensando.yaml b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
new file mode 100644
index 000000000000..e5c2591834a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/amd,pensando.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando SoC Platforms
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+
+      - description: Boards with Pensando Elba SoC
+        items:
+          - enum:
+              - amd,pensando-elba-ortano
+          - const: amd,pensando-elba
+
+additionalProperties: true
+
+...
-- 
2.17.1


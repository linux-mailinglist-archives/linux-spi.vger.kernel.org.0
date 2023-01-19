Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F9C673047
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jan 2023 05:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjASE26 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Jan 2023 23:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjASDm3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Jan 2023 22:42:29 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624355CE7C
        for <linux-spi@vger.kernel.org>; Wed, 18 Jan 2023 19:40:43 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 78so506186pgb.8
        for <linux-spi@vger.kernel.org>; Wed, 18 Jan 2023 19:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p+7zok1V1K4O5OkPHqePWWhsaVAgAl7DE+PB8/1U13I=;
        b=gZviyRPOuk3wF04sCxc6jzGuB2n4WYyg4aHSXUEnRoy964AMHz+aAd1e7HdLp1dHJc
         7lQBzne73j4VKFyjSyjj/ZxQY7Rd+sahBT3nKsmexrLqlPZKOXwY7Hi0qKsB7jYAEy+5
         htpLfTYfoMs4c5UKHcHduuOZDlz6VkCfQLdCG+8TKSWbBjxEIPsPpmwKRmD4Cuh/I8nQ
         OCwA/o0QtxTfTnRT4ZQ7Xdw51Go63Ff9/NaCWtvoN9ZPhX++SwL7h37kpnQlh6skcZXD
         4ulgpl3rnopFdq8x/4r3Al12/Cx3VLhdSkZnlmMnyTrIr52rwX+qVprPqpKFFFR9dDwG
         55ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+7zok1V1K4O5OkPHqePWWhsaVAgAl7DE+PB8/1U13I=;
        b=yqsW/bplOjc99Lps3AeZDxtIfmbfZ2HEAZopsKZoldyFFQDjDxS076LlIRV/AJHFSq
         lNt2CImUnqeM7a2pdNXnIisPq3c3XvrKpol+fWWJg1qtl6by0VQxtomqsxfi55tvtuRr
         vENKlyIGh0rH9LFI7xNbiCx049XlhD0gB9Jrpq7R77/E1OpNh5bSXoIkOHV4x5zh4pPb
         gNKMtUYxIKjlu8YE0MQ0NxiMH+Chkysrh+59lVCM5X9bw8mh+kZFpK5U8HwcV8GYZ3aL
         4VjwVi8mwyHLTJ85qtdV1OCW870c4J7cvjCIskjm1zvir57Ci4eVCIGsYKV7xGCBb+ip
         beBQ==
X-Gm-Message-State: AFqh2kqWSnXhy2ofSqXfBjMnaL9LyHzcEY9C9lSycS8Wtdyjveij0e44
        syidwnf3q7640iPZsCRDVbCNUQ==
X-Google-Smtp-Source: AMrXdXsh5WY61OQaWz2xECsud+hiAhmWBaewp7rm9g1f9L5M1Lus4LiSgyAs84L283yWUXTTrTrgbQ==
X-Received: by 2002:aa7:8a04:0:b0:581:1c:82a3 with SMTP id m4-20020aa78a04000000b00581001c82a3mr10249142pfa.1.1674099642791;
        Wed, 18 Jan 2023 19:40:42 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:40:42 -0800 (PST)
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
Subject: [PATCH v9 08/15] arm64: Add config for AMD Pensando SoC platforms
Date:   Wed, 18 Jan 2023 19:39:11 -0800
Message-Id: <20230119033918.44117-9-blarson@amd.com>
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

Add ARCH_PENSANDO configuration option for AMD Pensando
SoC based platforms.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 arch/arm64/Kconfig.platforms | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d1970adf80ab..11d4f73cd341 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -236,6 +236,18 @@ config ARCH_NPCM
 	  General support for NPCM8xx BMC (Arbel).
 	  Nuvoton NPCM8xx BMC based on the Cortex A35.
 
+config ARCH_PENSANDO
+	bool "AMD Pensando Platforms"
+	help
+	  This enables support for the ARMv8 based AMD Pensando SoC
+	  family to include the Elba SoC.
+
+	  AMD Pensando SoCs support a range of Distributed Services
+	  Cards in PCIe format installed into servers.  The Elba
+	  SoC includes 16 A-72 CPU cores, 144 programmable P4
+	  cores for a minimal latency/jitter datapath, and network
+	  interfaces up to 200 Gb/s.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.17.1


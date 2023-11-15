Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F3F7DE34C
	for <lists+linux-spi@lfdr.de>; Wed,  1 Nov 2023 16:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjKAPPw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Nov 2023 11:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjKAPPv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Nov 2023 11:15:51 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585C210E
        for <linux-spi@vger.kernel.org>; Wed,  1 Nov 2023 08:15:48 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41cd4cc515fso49386971cf.1
        for <linux-spi@vger.kernel.org>; Wed, 01 Nov 2023 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698851746; x=1699456546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=scSvTq12ck6hKrL81KpyijuxTwLdmUzADFiheIKoCgU=;
        b=Al4PRtuD4zlZWphIhzD6z//EhVgW3NV60YaR3jACu/UQy0XM91nW2dvef2gHdBDo/Q
         G/BbQTjYJdgIHkpOnO4lEwoFs7aeStMYGviqgU+ehNiyRlNeAqBtf8c2qycnze8uQh1l
         S2YADvJIwQaP7qWrOYFcozSgLDBm1w84x0sCCe8JATI3V5AQtsT5RagyD79ZNvvbUC0Z
         M+h01PwFJ3YzrO+Ssm/FwR5EH1/+ZpCDQWcPHctCQXRf2rTCYyhJyWoXsmMNqPK99Afw
         NpfpzWnXwP5PAbWBxchN4n8IcEVJtmUny1GddR0lCPkNkSWyOyk7W8TOIePg5br2FyF+
         LGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698851746; x=1699456546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scSvTq12ck6hKrL81KpyijuxTwLdmUzADFiheIKoCgU=;
        b=wKuTAhjRnzbxMT/u8ZwenFpVEhA/5qXPLl0iZDRWWRNvJY91Rn5CtXUQnRudQ9NSOG
         w3yIQFJJuU5fjN8vVglfPVbOS3eCSVexlRA+ByvwGE9/XQ2cFYQjaLAkrxyY16CrOtCZ
         dhdaB9HOw7kKLAOM8HiRt+U3QGxMonBgaTlaZawMIyiq5yyzZkpYGuWpAC6xFecsB9Ez
         ywygWPxqCv/aQ2p4dacri+GrPuWlHeAcEEzRpzrdXEwpWdcJwXrtPF0MY6HLJKLG0VW1
         0N/z/x4RtrTysVFTAU1rG4Uxt2uG5E4amV2+gmLlENgzLoCOEttoCEhDmHIJPUNEHuhk
         9HiQ==
X-Gm-Message-State: AOJu0Yx6dtWwj6Jo3/NysWc4z/ACRsU8SNHoD9OdpTTfdw8Qf3cTOyHM
        7wZi5YkUfFw0lRve2YfQ9pXtYNvjEvIyV/av3uU=
X-Google-Smtp-Source: AGHT+IGG1RpnEwK+BTs6NWrgE9D/51hktrLMdXeYOhyejbjS26AScKHpDDXPsTpMZl3VpU8YIWQ/lA==
X-Received: by 2002:a05:622a:1aa8:b0:41e:20b5:fc58 with SMTP id s40-20020a05622a1aa800b0041e20b5fc58mr18826579qtc.47.1698851746656;
        Wed, 01 Nov 2023 08:15:46 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id dn5-20020a05622a470500b004181a8a3e2dsm1477165qtb.41.2023.11.01.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:15:46 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 0/5] Add STM32F7 SPI support
Date:   Wed,  1 Nov 2023 11:08:05 -0400
Message-ID: <20231101150811.2747455-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds support for SPI on STM32F7 processors. The STM32F7 SPI
peripheral is nearly identical to the STM32F4, with the only significant
differences being that it supports a wider range of word sizes, and the
addition of 32-bit transmit and receive FIFOs.

Ben Wolsieffer (5):
  spi: stm32: rename stm32f4_* to stm32fx_*
  spi: stm32: use callbacks for read_rx and write_tx
  dt-bindings: spi: add stm32f7-spi compatible
  spi: stm32: add STM32F7 support
  ARM: dts: stm32: add SPI support on STM32F746

 .../devicetree/bindings/spi/st,stm32-spi.yaml |   1 +
 arch/arm/boot/dts/st/stm32f746.dtsi           |  60 +++
 drivers/spi/spi-stm32.c                       | 455 ++++++++++++------
 3 files changed, 367 insertions(+), 149 deletions(-)

-- 
2.42.0


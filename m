Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5105F41AA
	for <lists+linux-spi@lfdr.de>; Tue,  4 Oct 2022 13:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJDLLn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Oct 2022 07:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJDLLe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Oct 2022 07:11:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EAEBF5F
        for <linux-spi@vger.kernel.org>; Tue,  4 Oct 2022 04:11:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a3so8514221wrt.0
        for <linux-spi@vger.kernel.org>; Tue, 04 Oct 2022 04:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=boai9yZBL2P3WLQEzqTpGDWA2OXYb+9F6V6hMQaxTO4=;
        b=qcSULwnYUWfWfK+/CWN6FhD0ft+HVrgH2MjLrCl4/8X26hGsoKUEko8BJUflng2NDg
         YHljMWVhOnnVXHF16ulV50TS+6ZoafYEpANU1bL9eErJ44mMN7W7lJmmEG4ClWAFVcDh
         Au9WjsyGbl/WoUC3PAxhpUaZkE+66Dzw5OyY+anPtH9YDecjAkmOFjNoCgrH7NKvwsDh
         uURDYlxV8qHtCBBwcCq6rQJgD9QByMBRpb5IW1nnZcAPluvzPcHdpmuQ1noJiR+eguBZ
         254qSpDQsEXjQhmFTIKiyjyWWWWAzoJdzCgfEqvlDbPPFJ/E3heb+lAsZmbNWFAs07EI
         /WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=boai9yZBL2P3WLQEzqTpGDWA2OXYb+9F6V6hMQaxTO4=;
        b=5x0C4b6XoH6I7HDkfiO/auhXCn+pZpBD8rmpYWTG8dKQRc6aX+PHW4YsUy7JKd5yPF
         9qlwrPHH0cRYfKouxE4p+8r0dMn2lN7NqRoL6E2zqylopFBz+TWFWVPaU2pFWrVv45pt
         odOSAfGukc2wMeWwbOK3EO4d0zEJc/1VRwrf11BRYm4FNgPyoJkbg1F5g0IOvHLsU+K5
         bj3YZx3aqhcnuyb4PI4+CmBV9Q6uheAc6Bv+zEVxwA7BRPrzPuxP0JIW926TZLKt6meh
         fz5t60dMSFk4VBvoDVaLKSd6u8v7A4QS0TW5JKIK2GQuank9Z8PuVAA6KaDil8auIwdI
         LeqA==
X-Gm-Message-State: ACrzQf2tNBjKANEBdjjMcOUfjo53izVMGfsmPSFK+CR+ayf1kHyo4cnM
        284oozUi81vNmX7q7I4zakpt2g==
X-Google-Smtp-Source: AMsMyM7LrjmdzE7DPjflps2//LAVEW5x/L43i+8FZTIeNnOpLfFQVgoEbCMGgNkX2uNQWe1c3HA+TA==
X-Received: by 2002:adf:c713:0:b0:22a:3670:b08d with SMTP id k19-20020adfc713000000b0022a3670b08dmr16144462wrg.175.1664881888930;
        Tue, 04 Oct 2022 04:11:28 -0700 (PDT)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id j2-20020adfd202000000b002285f73f11dsm15361698wrh.81.2022.10.04.04.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:11:28 -0700 (PDT)
Subject: [PATCH v2 0/2] spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAKsUPGMC/w3LwQqAIAwA0F+JnRvYior+Rm3VwEwcRRD+ex7f4X2gnIUVluaDzI+oXLGC2gb8Ye
 POKGs1kCHqjBnwTmjPgJu8qEnQk3MTTzOPpoeanFVGl230R23xDqGUH44k59JlAAAA
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Tue, 04 Oct 2022 13:10:35 +0200
Message-Id: <20221004-up-aml-fix-spi-v2-0-3e8ae91a1925@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Da Xue <da@libre.computer>, linux-kernel@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1664881888; l=1309;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=VwbFnbT4s6Zrq8loadTmY7dJAn4b8cAtpYSq0vCjfk8=;
 b=ALRqw7Ymk81F+EKD98wzP8n0lqz1SXA+1jpgAkhjGD0bKd/c1hNj/+juRTPx5/ijY35GLd8dETKn
 nYvLSD/PAPPoxiqap46KsYni9nHo3VvHdH69c3fyHkfj5lzvZMR1
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Between SPI transactions, all SPI pins are in HiZ state. When using the SS
signal from the SPICC controller it's not an issue because when the
transaction resumes all pins come back to the right state at the same time
as SS.

The problem is when we use CS as a GPIO. In fact, between the GPIO CS
state change and SPI pins state change from idle, you can have a missing or
spurious clock transition.

Set a bias on the clock depending on the clock polarity requested before CS
goes active, by passing a special "idle-low" and "idle-high" pinctrl state
and setting the right state at a start of a message.

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
Amjad Ouled-Ameur (2):
      spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI signal states
      spi: meson-spicc: Use pinctrl to drive CLK line when idle

 .../bindings/spi/amlogic,meson-gx-spicc.yaml       | 15 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 14 ++++++++
 drivers/spi/spi-meson-spicc.c                      | 39 +++++++++++++++++++++-
 3 files changed, 67 insertions(+), 1 deletion(-)
---
base-commit: 725737e7c21d2d25a4312c2aaa82a52bd03e3126
change-id: 20221004-up-aml-fix-spi-c2bb7e78e603

Best regards,
-- 
Amjad Ouled-Ameur <aouledameur@baylibre.com>

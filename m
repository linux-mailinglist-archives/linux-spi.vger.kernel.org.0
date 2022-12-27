Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120D3656B8F
	for <lists+linux-spi@lfdr.de>; Tue, 27 Dec 2022 15:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiL0OK2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Dec 2022 09:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiL0OKR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Dec 2022 09:10:17 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD2A640A
        for <linux-spi@vger.kernel.org>; Tue, 27 Dec 2022 06:10:16 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-476e643d1d5so68823937b3.1
        for <linux-spi@vger.kernel.org>; Tue, 27 Dec 2022 06:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vtremblay.dev; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VGbpfTzuadVKtBCpyMr1YdoPSOF+Ry95QAYchlozkbI=;
        b=H8oerytmfCIQQpNq9Vc9A2YkUAdmDS/x+4XTFyKmbdorwEiR7UDS4LvFoEBDUykS3B
         a0IwV+sdaCy3Zg7L6Ygzz6QosE7vlwnDai8fkWD2cv7hccmUcdX9J6kiEG7r+xsQ80kN
         74GLO+z7qTu+y4b9UYpyObOQAvxAasuZKcgPKIWhMUqFJpGzsqAc5ADYKw2GLRjw+R7K
         A1DEJvqHa2r/Qhybk9mF7RYMwnTeNcvYCaO0YmoZiqKG4E0LJX5Sz62s9TeWu7hQrT6O
         wWMiI1XvmuoL+Sh5gNpvdW0syju5UDDX3282rskbp0HsgnJ9A8ZKbdz8hyy1kpTuBlBP
         tFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGbpfTzuadVKtBCpyMr1YdoPSOF+Ry95QAYchlozkbI=;
        b=HjQrArpMu93DRblO7T6WsMnXjf5FU+SH+aeZTP+/A46aIHpqftt9VaElWKiaD9WFD8
         DGRn3AqY7XM//D0WMP4VhjTmLZ9Q2OkdL+vyJbUNhG22yclLz+5mvsbtaD6RLTtnPIWC
         IwzP1noERy90A1zELy0TAdsXlWgz6P5Nm5rws5d+LpiCypME78tejICdgoY210HSF7ze
         Sr26zMDRiQ8AWHAxwYZfcQAni6KA6lJplDqqkr4yNj3xc5aNm+KGqR9D+noCBj6V8ImX
         K+xCwcD9IV2HGwbaRcwEZWXVrCR0R5UW1ttmn94nmDuu1B7n8Go/nbxNbMLDKBuKTd80
         +IEA==
X-Gm-Message-State: AFqh2kpHRcjUassaRvAiquxqb8OQv8iYlDlDVHwCBAvkLOiwAn9AL+VI
        QId61WOisHXXZK9Wv05DOvV6qFFsKofXes87EnVsKg==
X-Google-Smtp-Source: AMrXdXviIAOlZZoTxD/hYT2e5bw90C8x4q8lqFR7YXMP/66T9rSdyAAu9p6P+c+Nf7GomjQ+3ODwiw==
X-Received: by 2002:a05:7500:68e:b0:eb:26e5:920a with SMTP id bv14-20020a057500068e00b000eb26e5920amr1431351gab.15.1672150215216;
        Tue, 27 Dec 2022 06:10:15 -0800 (PST)
Received: from vtremblay.. (modemcable190.194-177-173.mc.videotron.ca. [173.177.194.190])
        by smtp.gmail.com with ESMTPSA id y18-20020a05620a25d200b006fc447eebe5sm9596531qko.27.2022.12.27.06.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:10:14 -0800 (PST)
From:   Vincent Tremblay <vincent@vtremblay.dev>
Cc:     vincent@vtremblay.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Marek Vasut <marex@denx.de>,
        Samuel Holland <samuel@sholland.org>,
        "Greg.Schwendimann@infineon.com" <Greg.Schwendimann@infineon.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: trivial-devices: Add silabs,si3210
Date:   Tue, 27 Dec 2022 09:10:07 -0500
Message-Id: <20221227141011.111410-1-vincent@vtremblay.dev>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add Silicon Labs SI3210 to trivial devices.

Signed-off-by: Vincent Tremblay <vincent@vtremblay.dev>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 5a3ccbce8c23..7da40dadfe2e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -325,6 +325,8 @@ properties:
           - sgx,vz89x
             # Silicon Labs EM3581 Zigbee SoC with SPI interface
           - silabs,em3581
+            # Silicon Labs SI3210 Programmable CMOS SLIC/CODEC with SPI interface 
+          - silabs,si3210
             # Relative Humidity and Temperature Sensors
           - silabs,si7020
             # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
-- 
2.37.2


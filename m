Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D614F497A30
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jan 2022 09:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbiAXIXy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jan 2022 03:23:54 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58538
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236194AbiAXIXy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jan 2022 03:23:54 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EA5A540045
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 08:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643012632;
        bh=7zKcWROJaURhL/8HO42elhk/RcTUKxPURWmHqK9IZzA=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=hAJExfno7hXb3pnG9f2+5GMT1ttGD6C5YC06Cb4AZoXQ2b9NkyjMr5GkLRw49bATa
         PRWSVWZFuN++/lz3zbiLrMs+VCT9igGFMa7+bixk+96eDW8f7UH6m0ecFr2em9wZ16
         IA0CsMBX6kbwLUw3M3yTGXicZWpXXNMQTpSmQqVQs5/1Jx7tKBMyQsgjB6PBflpckV
         xW1X/syqBt0vC0afgF1j96sDqjrvfd0CTfxvcIgVkg2O+d0aTaKi7GoDRFZT8gmG00
         8uxdF6f5Y5yIyGc+9LleOE4+Ll5tqs4WbiLvoHf/AkmO3/6S8+iZiD59ujW4uM6ieH
         ePzvIUbIMzMTQ==
Received: by mail-wm1-f69.google.com with SMTP id f188-20020a1c1fc5000000b0034d79edde84so5566002wmf.0
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 00:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zKcWROJaURhL/8HO42elhk/RcTUKxPURWmHqK9IZzA=;
        b=wHI6r+9VI/jPAfey/H/Qm8GzSD88/krl+QUL4zFra4LcXpcPQTdDMbtplq2P60G0Ty
         ahaNsX9m2/fMqEa1mV7oewiBm21k7NwEVnzOFuC6qc/LJF3Um7YlNf9gPbC5a3hoTOPD
         QSnvA6fa+Q+QSfCsq7gSMZCoMcwqxvlN2of+Hj+HHk5NDgAEQ7g++PeKPF5MuxLL/i5/
         DpL6xGfzf7DYV18pEH/eTpSryN/CTDjzh6m9Vxv/D4Rk2d6/n8xv/siabOWK+Rq8ZKcT
         cAJNJmSml/+mcIGipuF8bex54nLPqRkmJKC0/IWjXKScusn84DS3daL6N5AEF14HkB0b
         YhrA==
X-Gm-Message-State: AOAM532rjUuOnn2pAvOt+69t4BFIs/cR0oaVDYG4yCtDKeAb0+Qijh50
        RuNKTwq6gZ5nPbe3IsVCT+dZgfvjq2fWiPv/X7jT/cTlmjfTy4KOJiNia4Ip5G1uMbVfjEDhIP/
        4H1T3nnxK6b42QTQFmApRnrP5+GP747x2BzMbeQ==
X-Received: by 2002:a1c:3b08:: with SMTP id i8mr781505wma.52.1643012632392;
        Mon, 24 Jan 2022 00:23:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZ4msI9DBdqPFRBMYAxKWHo7GfTdXh5lgJOdfR2H1wJlIwpu6wqbPgDj6zli+U2IlDQPbSPA==
X-Received: by 2002:a1c:3b08:: with SMTP id i8mr781490wma.52.1643012632243;
        Mon, 24 Jan 2022 00:23:52 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m64sm7148550wmm.31.2022.01.24.00.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 00:23:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v6 0/4] spi: dt-bindings: samsung: convert to dtschema
Date:   Mon, 24 Jan 2022 09:23:43 +0100
Message-Id: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

Changes since v5
================
1. Add new patch 3 (fix indentation in example).
2. Patch 2: reference spi-peripheral-props in else.
3. Add tags.

Changes since v4
================
1. Do not require samsung,spi-feedback-delay and fold patch 3 into patch 2.
2. Rework message in patch 4.
3. Add tags.

Changes since v3
================
1. Patch 2: correct path in exynos-usi.yaml.
2. Add patch 5.
3. Add tags.

Changes since v2
================
1. Patch 2: drop child device schema, as Rob suggested.

Changes since v1
================
1. Patch 2: describe devices matching compatible, correct issues pointed out by
   Rob, add reviewed-by tag.
2. New patches 3 and 4.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  spi: dt-bindings: samsung: convert to dtschema
  mfd: dt-bindings: google,cros-ec: reference Samsung SPI bindings
  mfd: dt-bindings: google,cros-ec: fix indentation in example
  spi: s3c64xx: allow controller-data to be optional

 .../bindings/mfd/google,cros-ec.yaml          |  31 +--
 .../bindings/soc/samsung/exynos-usi.yaml      |   2 +-
 .../spi/samsung,spi-peripheral-props.yaml     |  33 ++++
 .../devicetree/bindings/spi/samsung,spi.yaml  | 187 ++++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml    |   1 +
 .../devicetree/bindings/spi/spi-samsung.txt   | 122 ------------
 MAINTAINERS                                   |   2 +-
 drivers/spi/spi-s3c64xx.c                     |  14 +-
 8 files changed, 246 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt

-- 
2.32.0


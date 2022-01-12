Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A2048C1D0
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jan 2022 11:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbiALKAw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Jan 2022 05:00:52 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55438
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239439AbiALKAv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Jan 2022 05:00:51 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E159B3FFDE
        for <linux-spi@vger.kernel.org>; Wed, 12 Jan 2022 10:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641981650;
        bh=W175jQsAVD8hOk96CzYOc00tw1PfuOzVPDQUy/HubXs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=k9glYrqJDMl8kv5sNFpGs6wjrcIHjovV0BxJSeEXbwEbnLIyUweJG58G8RVLCK+ck
         ee1U6ffQkrMP6KhNRzvHW7vz6aqlV/B98HkMavP0JiqsD/Kcv9MbrPDhLlwt+HoGaj
         GvAL8T4X7vSN7a8eUmUZ6ZGIxJ8Pe1Ynyn8UngOlhVMMLmWkVjruMdjT+8W+Y8qIy7
         26WtZbH4Wtc4MR8GdIL0l9pMt9UlbPDSLO81UC21IsLPo4TttWg26BQ44WaIVHd9Kt
         BYptFg7ahsQB29eevU2YCmtXTlToliduMS5t4aEmdKYqRLtgvnkJBYk/3rKE9q09Di
         nl5JOANWznopQ==
Received: by mail-ed1-f71.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso1793333edd.14
        for <linux-spi@vger.kernel.org>; Wed, 12 Jan 2022 02:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W175jQsAVD8hOk96CzYOc00tw1PfuOzVPDQUy/HubXs=;
        b=N9PSwa0lBIrNnSb5h2BDqsP4QlC8OsGE2C+j0XXjwMw3pJBAr29/7+8ZpvvobeVyRE
         MrKkp82bSmuVdrozOkBulWhp4tx0ENjqq5mH00dvahncdEHf0G8MS3+FiBm/XNBYfrMa
         4st5oJwbnafNq3KFBqr/aF9hJ9TQeyAqqmtvdT3THoisOlfEV5aPzxxIfznCe5BJYDYt
         JhrRhxMXJ99GS1diDaAk3UkPRVI/NOVczVwIog1X72KQfoepFqyPOUOfS2baKHQyQfmu
         GHu7D426YYK+Q73bEvHfErsZbTwnGVM9rP3Pwhpd/ypywZASr8gda7vy74z/EunR90Kh
         XPSw==
X-Gm-Message-State: AOAM533gcf+0LU1VOvKH86N4A2VQg8/BGkxrSR8ECiCic/IavLRb65og
        Sy2qESZKGWYGBThTM+zwobzoBZWC+un8ZeOqiuCb4xU7vSN8Jt6FD8h32vsHQGeGD/5holWq3kf
        +FmXIL2Wxg8OswRFgR1r3H+gWQD8asBbep9NK8A==
X-Received: by 2002:aa7:c584:: with SMTP id g4mr220256edq.78.1641981650546;
        Wed, 12 Jan 2022 02:00:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPwXb8C8jwC0AeCFbhlzmt3R55DzsEBM3z+QQv07WnckbiFJGdXv4Kanz5OlMs7VuMIKn9xw==
X-Received: by 2002:aa7:c584:: with SMTP id g4mr220236edq.78.1641981650275;
        Wed, 12 Jan 2022 02:00:50 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id hb11sm4311083ejc.33.2022.01.12.02.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 02:00:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v3 0/4] spi: dt-bindings: samsung: convert to dtschema
Date:   Wed, 12 Jan 2022 11:00:42 +0100
Message-Id: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

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
  ARM: dts: exynos: split dmas into array of phandles in Exynos5250
  spi: dt-bindings: samsung: convert to dtschema
  spi: dt-bindings: samsung: allow controller-data to be optional
  spi: s3c64xx: allow controller-data to be optional

 .../spi/samsung,spi-peripheral-props.yaml     |  36 ++++
 .../devicetree/bindings/spi/samsung,spi.yaml  | 187 ++++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml    |   1 +
 .../devicetree/bindings/spi/spi-samsung.txt   | 122 ------------
 MAINTAINERS                                   |   2 +-
 arch/arm/boot/dts/exynos5250.dtsi             |   9 +-
 drivers/spi/spi-s3c64xx.c                     |  14 +-
 7 files changed, 234 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt

-- 
2.32.0


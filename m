Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B3F494177
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 21:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiASUKM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jan 2022 15:10:12 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58500
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243247AbiASUKL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jan 2022 15:10:11 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 94D6340028
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642623010;
        bh=B0MRNjKyPBOkLqskhHhUYFAwrhXXjHwf0AFyIDpdjDg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=JX1hbSAfaC62a3fEINELMe5kiS5yn/ga4E8QwBf7E49ynlUIojZ8F/tjLasMmPlRj
         VHOuDXW1zs5QfYjRFbVQ+BFZF9xjXLed/7R7/w1J1UZb2ZFNMJeD1+4gylxvQrFQ3b
         q3NZ8opKPY+YoW3rNs7AcXnlSSOd6eL+TADkOk53vcAi+nOEhUIyr99R7IccS4v9D/
         0rEqe1lpksLFnFQB45vw8wORl/0P69nLI0iG9Cyi9Akyx0XVFrR/snvMg+aDbYshc/
         fRiy7lVLJay+fnXZCwhOlgdwME1kbf09yYG2Yju48+rsq4fHrKxMiqaQjJhx+pHErt
         xaKpR7HK6A7Iw==
Received: by mail-ed1-f71.google.com with SMTP id c8-20020a05640227c800b003fdc1684cdeso3734345ede.12
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 12:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B0MRNjKyPBOkLqskhHhUYFAwrhXXjHwf0AFyIDpdjDg=;
        b=xEy5hJmKJcP0nsAyr0TxD6+csDfJk9uzZrlTFOHNQVFPkKXmZ7jTxZmf2IUxoEkfYZ
         Dsl5oKZYgC2/K1T2gJRNTJqNuJLepXkU2AFADoCwTT4XphBGwNxgLItulMsAP1QawnnS
         5d+9BAQYJnLxUpFxlFE53IPmElk+ts7DH+6tnPcmJyYbxdQ7n6HP13FQgqGzpE0y2Cs0
         SduAF2KmdwaIpQ3Q60KkLskAB+CE9IV8A8iKMXmro10NvVy+Tws+wuymvwWzNbaZilP/
         W8lZ/iWAx+rX3/i7I8KU+7dkAxlGYO8PWqhYwJTp4x34K0VUJO5X+OuReVkkFyIrwB39
         2P3g==
X-Gm-Message-State: AOAM531ia2GCDr2zQuVOLsJQOMJwahLILnNcmd66Tn54NYy1YoHrGF8L
        KCi5p3uS/JJqINb2/xghU6ky7SK8luCJdL4uUBSFPPrHvPPie73Aw7LX8lPIY/7/WBQopeJzTQt
        nKhgozaHaVGgPGomv5ysckGbeATgcLfvG67SsvA==
X-Received: by 2002:a05:6402:3596:: with SMTP id y22mr31876165edc.340.1642623009985;
        Wed, 19 Jan 2022 12:10:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyXY0vDwKSfhnExno/DI3+JyjNBt4Lf3DhxMlvfzqLgNypDn6KioMudJOfGjSmKq3JQmKr2Q==
X-Received: by 2002:a05:6402:3596:: with SMTP id y22mr31876128edc.340.1642623009706;
        Wed, 19 Jan 2022 12:10:09 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a26sm215005ejr.213.2022.01.19.12.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 12:10:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Balletbo i Serra <enric.balletbo@collabora.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v4 0/5] spi: dt-bindings: samsung: convert to dtschema
Date:   Wed, 19 Jan 2022 21:10:00 +0100
Message-Id: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

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

Krzysztof Kozlowski (5):
  ARM: dts: exynos: split dmas into array of phandles in Exynos5250
  spi: dt-bindings: samsung: convert to dtschema
  spi: dt-bindings: samsung: allow controller-data to be optional
  mfd: dt-bindings: google,cros-ec: reference Samsung SPI bindings
  spi: s3c64xx: allow controller-data to be optional

 .../bindings/mfd/google,cros-ec.yaml          |  29 +--
 .../bindings/soc/samsung/exynos-usi.yaml      |   2 +-
 .../spi/samsung,spi-peripheral-props.yaml     |  36 ++++
 .../devicetree/bindings/spi/samsung,spi.yaml  | 187 ++++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml    |   1 +
 .../devicetree/bindings/spi/spi-samsung.txt   | 122 ------------
 MAINTAINERS                                   |   2 +-
 arch/arm/boot/dts/exynos5250.dtsi             |   9 +-
 drivers/spi/spi-s3c64xx.c                     |  14 +-
 9 files changed, 251 insertions(+), 151 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt

-- 
2.32.0


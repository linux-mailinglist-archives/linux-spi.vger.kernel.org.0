Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BE848AB1F
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jan 2022 11:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348640AbiAKKNp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jan 2022 05:13:45 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60938
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348528AbiAKKNo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Jan 2022 05:13:44 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C49433F32E
        for <linux-spi@vger.kernel.org>; Tue, 11 Jan 2022 10:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641896022;
        bh=dor9qMPQ0mrrX4bfZ8uDHf6Jen+W2LQ6ZgWRYFeDuWA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=fqCx88uVJx96LRKgDuB/AA+iZHJiJYt6ZnztWIgiF1+oa+vUHTNA477LkC75hkUzl
         AnzspdRC7WqY2oHfXsT/uSzwVuTLIWskR3q7g9nzDnE3UuZ4kZcY5sSb9iWghseFHh
         dABeDPh11dIYTG4LA9SPXYQOQEQ1FkPOVQ2u2Cr90hTGau+72CAsvX6PyscdMLA3hP
         Ptg5Z2Hv4LegtQLV0yUP7+rfddFFqt6vD3kEZLi2wqzX7QwPuecfKk88vSbw5KQkKD
         1LrCTdr19q3S8Xon5EHzF4D+XN/QLlwVQcC2FLZbEa1aL+FJEYBHjsewVxpXp8vOuL
         Wwh5KXGTSfMQg==
Received: by mail-ed1-f72.google.com with SMTP id i9-20020a05640242c900b003fe97faab62so3028996edc.9
        for <linux-spi@vger.kernel.org>; Tue, 11 Jan 2022 02:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dor9qMPQ0mrrX4bfZ8uDHf6Jen+W2LQ6ZgWRYFeDuWA=;
        b=Kc9Yu8d8yM1W/h+Qez+oXUJh4w+9FXXTGIfGatysi5PpjSGPpPb7tdBRpuaU/cWfOm
         4odnZ9dVVYlch7Zh/e5AfKm1/W2tiVJcONOMChhslQSlRGP6GIoHeAq50hSE2IquXhox
         ZNxy/XtyocXvdlvz5mJ4W8BkT8EL0adKhCY2k++heg9mqsn8KcVZM+MFRxqUeTrLlCSy
         L49VYPcgjkBbIoknr58ZtPlKdq7o73HFQcebR0dBbV8s4XgB+V0F27SEqMY97sCCSPwg
         usxdgy8uScA5v+o1c4s0vk4CtwFYGFCOK1A+6Zu51Z1wDSaCYIbYaya6tWEMsTizOwdr
         fZDg==
X-Gm-Message-State: AOAM531s+SInu9+S/aSQo91xs6sOTUkxDuX7hYn09OD3ViFr6cFR3z7J
        ZdRs2ZnpWebFIsRu9RyoR/IKKZZziFRD00Pv9s3ycfAitlfV2j0OBgS/2XDn+SWOAnYCYS14ThP
        SVNVaT6pfUhly/7nWbG/VbSZFf6qrKfAZc+Qm7w==
X-Received: by 2002:a17:907:7812:: with SMTP id la18mr2985710ejc.361.1641896021570;
        Tue, 11 Jan 2022 02:13:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzS+KRg2Po2ZmPguoYjn6vWAcaef7toI3fl6TH95T7A0/0ObQGfS0r1niugTRZEPPNRwiEOTw==
X-Received: by 2002:a17:907:7812:: with SMTP id la18mr2985700ejc.361.1641896021430;
        Tue, 11 Jan 2022 02:13:41 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id 26sm3431268ejk.138.2022.01.11.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 02:13:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v2 0/4] spi: dt-bindings: samsung: convert to dtschema
Date:   Tue, 11 Jan 2022 11:13:34 +0100
Message-Id: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

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
 .../devicetree/bindings/spi/samsung,spi.yaml  | 195 ++++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml    |   1 +
 .../devicetree/bindings/spi/spi-samsung.txt   | 122 -----------
 MAINTAINERS                                   |   2 +-
 arch/arm/boot/dts/exynos5250.dtsi             |   9 +-
 drivers/spi/spi-s3c64xx.c                     |  14 +-
 7 files changed, 242 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt

-- 
2.32.0


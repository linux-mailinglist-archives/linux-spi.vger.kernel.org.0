Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AF648AB24
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jan 2022 11:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348807AbiAKKNr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jan 2022 05:13:47 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60980
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348533AbiAKKNq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Jan 2022 05:13:46 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B59DC40703
        for <linux-spi@vger.kernel.org>; Tue, 11 Jan 2022 10:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641896025;
        bh=BJcC+0E6Y2y3qsaMlSAjaaYN+3MxC8IRY4wxOhHEIbc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=eGshMIOABW6vJk0aWnP7tFD4/5u6P5wKhY9R/jh5aQ7oW2G7hzIlPXLJEuMHkOcER
         xDe3a51WEQG7wmjl4LJhnauQocrtbo8HCUnMMyUokTbolQZemhSEcJoynYxKV3PJKs
         XxLhly2KXuLA7uEjW+VCieZR9Y0WmmKhtajw6JhSGuxvAGC7H4VCXUJ/9hEbh1oQJM
         rdgkuERSMKv6vevRSyuW2+pIo+neAS71Kb2/xIvYCr8u20wMEhEDHPfn0XZ/nTGkIX
         315pu3dMu3c8Mp6l/vsgU/HvlLsIXyVVRac5U2DWFfwDE7FwwmAzAtoFqCwAGLDw1V
         FRwkpfHJRYKjw==
Received: by mail-ed1-f72.google.com with SMTP id p8-20020aa7d308000000b003fe9b0c4760so2704132edq.17
        for <linux-spi@vger.kernel.org>; Tue, 11 Jan 2022 02:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJcC+0E6Y2y3qsaMlSAjaaYN+3MxC8IRY4wxOhHEIbc=;
        b=AeS9s32GHD+BTt6u2pY5gZyFMHXpBVE2nsDB2CxyuLh6lvbwOh+BEMgN/gEw8vBflm
         rHEGAOCfL55yFdtCLVqZTEfOStVMq+wH4oVRtkHcEe/44kjPv02zNFgKjKZdxqMG6kkO
         hsSJNAolE34xffC/s+wZuYUiClzAMB+zxhFoNig9Jf3LOKdRtkfGyxoCp8+XHp8wuArd
         KyrKuKRfWmqS9Qe2wCS4PVvcGiMtiB7a9EJicoh0MuFe66/84WUUqbg4v/wz1sOoLExU
         3vA72HvcfANzWujYfchQz2kW37wYUQGGdATiUlMIKYQmgMZEmdg2e5mlT0lRDoAUQUxn
         YNqw==
X-Gm-Message-State: AOAM532IMNh1jwdT0gT/hVq6docS8MnygAjO/Q5dSVDDcq01KfZ+AzBy
        9bAvGutkEz9+3mLl9UW3wvsmxXrwhlLQTprzL9kam7iDyv1N1hCERXfnHIV1/V7cIQafYxyY7f2
        0/4aOzTffE5h0vwXwWouGQi0obbBe5YBk5kI9hw==
X-Received: by 2002:a17:907:728c:: with SMTP id dt12mr3244367ejc.188.1641896025438;
        Tue, 11 Jan 2022 02:13:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRZEoQ5u1bGZQZJNook5L4lY9BkzKhKOYtLcERafkQAKIt2Tq7bk74PNAyjv+BJ4TXFGswLg==
X-Received: by 2002:a17:907:728c:: with SMTP id dt12mr3244340ejc.188.1641896025195;
        Tue, 11 Jan 2022 02:13:45 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id 26sm3431268ejk.138.2022.01.11.02.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 02:13:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/4] spi: dt-bindings: samsung: allow controller-data to be optional
Date:   Tue, 11 Jan 2022 11:13:37 +0100
Message-Id: <20220111101338.58630-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com>
References: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Samsung SoC SPI bindings requires to provide controller-data node
for each of SPI peripheral device nodes.  Make this controller-data node
optional, so DTS could be simpler.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/spi/samsung,spi-peripheral-props.yaml  | 1 +
 Documentation/devicetree/bindings/spi/samsung,spi.yaml         | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
index aa5a1f48494b..cadc8a5f061f 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
@@ -28,6 +28,7 @@ properties:
            - 3: 270 degree phase shift sampling.
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 1, 2, 3]
+        default: 0
 
     required:
       - samsung,spi-feedback-delay
diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index da4533feb946..322558818a43 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -75,9 +75,6 @@ patternProperties:
     allOf:
       - $ref: spi-peripheral-props.yaml
 
-    required:
-      - controller-data
-
     unevaluatedProperties: false
 
 required:
-- 
2.32.0


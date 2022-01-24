Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8270497A3C
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jan 2022 09:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242192AbiAXIYE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jan 2022 03:24:04 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58610
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242167AbiAXIX6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jan 2022 03:23:58 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 479173FFFD
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643012637;
        bh=6MJYb8WcqWhjeyozgAW+GAp1i5m+HDM/agR5Nt4YXgk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=tMcwVFLXCiNxKGqeLD7+mxcuoWX8ukNCXeS31qxRfwwMK34sOU/dmJr7EwYc5w+bs
         PCrkbv/t9aWqGsUF4PzKkp+m3XCyaSj95jqpLiT2gLmUtu+BDdVuj/3nMsYO4tJJUv
         GSAzdaEsQjcBoY0387NmmiTWlNNVg8O084Mkk4cJEcC20zf31/4uW/pssqY8JY57Eo
         EFCjMR85bCFdVeym7pcXHLh0hTuAM1XjlItpGTCq298cA8rjiqtfEcvFdj/NNUWBwv
         pWIyRGcjBq1NzXzpcDsOzif6bKYmc/XkbI1n1rWbNUdQuKIX1Z0ep+aP3JOjvHOJ0k
         37vx+ge/EWbZQ==
Received: by mail-wm1-f70.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso10349949wmb.6
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 00:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MJYb8WcqWhjeyozgAW+GAp1i5m+HDM/agR5Nt4YXgk=;
        b=51J2w4sZ2cZ+7nJRpIQaZuiIltVwUrFArRO3C0QL9gcwlAl5yygnLqS8V0I1qO3vdw
         tQ0C0Gy5KRFQxaaCERWbkeTIt3HaIU0zwSCJXsmyT0OebjsE/W6M9jsdS17GQzsFpS/O
         Dl7VTLIHbukraLlgkCP9dEm6GEpTcdRzsYon2fNj7U50VgV88G2VYUVeyxJdRo7uoumG
         SDXx6P5h2oNR+/0d2ggD1g+pfG7s83J9v/XDh23KcE/UZKMpKHOXSodROnq5qyduWYqJ
         NfG3dOEaP/xOSEFKwlwR0syuzLMgK3Mao6DhAsbegcEIxW1AZvhT+fYz85iHKCdJeobX
         vlkg==
X-Gm-Message-State: AOAM530WAWHQID3WN9Gj90rklV1/Q/6zcrsI7yLPFYC9j2LW9wwaALiD
        rzToJFJ/cC+CXk5RqqWRbUUg5LkbW8SVo6Is3eaaPTy+WO4ogqSMN52bMFaKan/5YqGWe+CAoY1
        MY0l6aLwb+GRVaB5o49NkW98Rtp5Pv03OokyDFQ==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr13030931wry.98.1643012636545;
        Mon, 24 Jan 2022 00:23:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGKdmyKgG7q+F9YXGqPhXojRHXYyPuTj4cdnyu4gQtA6b0oE0q4HED2u/bDAahosOh4nheLQ==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr13030924wry.98.1643012636413;
        Mon, 24 Jan 2022 00:23:56 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m64sm7148550wmm.31.2022.01.24.00.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 00:23:55 -0800 (PST)
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
Subject: [PATCH v6 3/4] mfd: dt-bindings: google,cros-ec: fix indentation in example
Date:   Mon, 24 Jan 2022 09:23:46 +0100
Message-Id: <20220124082347.32747-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Correct level of indentation in the example.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 525ab18005b3..4caadf73fc4a 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -203,7 +203,7 @@ examples:
             spi-max-frequency = <5000000>;
 
             proximity {
-                    compatible = "google,cros-ec-mkbp-proximity";
+                compatible = "google,cros-ec-mkbp-proximity";
             };
 
             cbas {
-- 
2.32.0


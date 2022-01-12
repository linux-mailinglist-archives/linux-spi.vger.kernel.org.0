Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D14248C1D7
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jan 2022 11:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352240AbiALKBM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Jan 2022 05:01:12 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55486
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239651AbiALKA4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Jan 2022 05:00:56 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3D17C3FFDE
        for <linux-spi@vger.kernel.org>; Wed, 12 Jan 2022 10:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641981655;
        bh=sxpoeazVKfRv/TTxlIPcEu0VInhZebJSCyyifiEPVW0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=tUJuFG8OXmUW0dve3bTnerR9+TleH5HxCy+ksux/ROGBarSwX0SpYO8M+cUTeBHNC
         jHcHJkKb1toPOKVB38DnBLU1bLRGcAYKxYbhb4T3X/BMDpyns+MYHXQR4DxxQLl6Fm
         ckKgxd8wHFJMfBYzICnQzrLFnhFaJlbvRbjKDEE7zi4TYf8LaBlvr8pg8ebgVjzXd8
         BfUl7lmrvDKrMOHJOhSXr7JhCPQltk9B6wvNAnq7dRrggI79VolNc+64xaBqZDuMJw
         oTfXmmHCg4ExKa1y1iegY21SFGVr7ZzvVXsgrkqEfzW0bkjCQ6ePVVb49OZs/luD/r
         0CucxLchjwspg==
Received: by mail-ed1-f69.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso1863027edw.0
        for <linux-spi@vger.kernel.org>; Wed, 12 Jan 2022 02:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sxpoeazVKfRv/TTxlIPcEu0VInhZebJSCyyifiEPVW0=;
        b=o9pFpY3RopE7onjzGa3OWrt2W/ottS316jRETSrrVR6dbQkix3d3/up5j2rOjaPZvq
         HuOr69yNZMZ3zzm7nXaDpMzRNuWL1suUcf96vt2A/rZ+3RpOokW+qVHBw2dSE3Bn7ca4
         GY8VA91czZTlQXgTQJIXanRp7Na/mKLrG59m74JxNjP1trdAS8hjdYw/v/bQm7st5ROF
         XgQMgd3YLE4/VdKDbkKAs3prhxFo55f5GyZxaTRRb/V9bUelwrpjLQnQoeSMcOcwJ14U
         p1qLQCPXoM3wUydhy2bkkNVRAH0tXs5lbvOonCme2MuSiaElv0blkb10xEQ31Yvbvnli
         jMFQ==
X-Gm-Message-State: AOAM533/WZaiaIXpnTRVA2uHhF2dw32UuTxVWqJf8DXJcBe3ngE689NG
        I7EurXgvFd4MKrkbpzfS/SW2MIcBThv3OvWZsuQCqMrR+AJQ/9aCLKJJ5i6JOZ9Xhq4ACJSaY1d
        odc4OjQLBkTCLRhU3aH4So6mHAoMaclHL5Xi1Fg==
X-Received: by 2002:a17:907:7d8a:: with SMTP id oz10mr2375263ejc.320.1641981653525;
        Wed, 12 Jan 2022 02:00:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzzXqkrKxbgq5mvkmGUzVcTyBUQLnw1MTu9OyibOn3Q74mOavVnNmdXwrnaGEsFJ/VZr09+g==
X-Received: by 2002:a17:907:7d8a:: with SMTP id oz10mr2375244ejc.320.1641981653311;
        Wed, 12 Jan 2022 02:00:53 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id hb11sm4311083ejc.33.2022.01.12.02.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 02:00:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/4] spi: dt-bindings: samsung: allow controller-data to be optional
Date:   Wed, 12 Jan 2022 11:00:45 +0100
Message-Id: <20220112100046.68068-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
References: <20220112100046.68068-1-krzysztof.kozlowski@canonical.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/samsung,spi-peripheral-props.yaml    | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.32.0


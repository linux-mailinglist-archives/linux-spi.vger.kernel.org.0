Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43564C1A8E
	for <lists+linux-spi@lfdr.de>; Wed, 23 Feb 2022 19:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbiBWSDE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Feb 2022 13:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbiBWSDE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Feb 2022 13:03:04 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D7435856;
        Wed, 23 Feb 2022 10:02:35 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s24so39044780edr.5;
        Wed, 23 Feb 2022 10:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=RvLWLImKF4e7kO+CK5fBPeKwpYaywnsLJXvg5598LAA=;
        b=Xof3f+C2MWxq9dDxNkehSWNiydzzI2D/wlgkOJ7dJOPAKdlh9n/8kH6j44886v6bvf
         iStAlMDwbouUuvI14282aVTnwEcgG9smQp2T1bjLzZcVzb0ymtE8Oqr6FAamP0Fer5Za
         yzrqPFBdfXlmyHAG2TQWbk+98cfvsj5G8nTJwHUao3LxadfH+viz0yPY+JCB3q+a+HCF
         pMbofE4rQIaA1LqAQ5uNmNfZBbUyaDzI/LGWDePrUNLXbddCkh16znD/wdgcVf0TDtQb
         KwxHPsV/nLKs/eEBTS6KCoEbokciWU4dejg+iRa/FNKVStPkfnlkIBybD0MJKRGOdsHb
         FRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=RvLWLImKF4e7kO+CK5fBPeKwpYaywnsLJXvg5598LAA=;
        b=Aw4ZEnnnaIs1DxipSalACs5c+9qSDHtYN09SCFSL2qQVL3W2uHSRLM+q9vC+bR0abB
         YFqAzAnRIE40gdbSRhC9SEis98C4+Kf4ygiBzT5TXGjhBWR+xhHSPubBebuO/uCVSXcA
         fluAxrASTbj1SQyu48De54cxXeYxwDe48xz97DxAVZgxhG0YupV3Bd7v4ahQ253P3sQp
         iDGBo7VHi/voFacCOLmJHuKhm6IXLdP8sSrHyXA0cZ9TRuwwDiTzSWM8Z2hPmyFJxSV8
         xqq8ewHZjlnek4tXYm2SoCgY/wHUdDzLbTUqgBhTK5kE/KWUTeRXMho3lzNK/Bg7HYV+
         5S1g==
X-Gm-Message-State: AOAM533MENFaSvvdzUkM/gcfV+ogu4SzHq+VzrJlUop9xlWSiqeoTekE
        5nrG+SXmQUGuZ/kh6eRayQU=
X-Google-Smtp-Source: ABdhPJx8Mkk+LyafzM/hSAfFdCJCs9Z1ihr6F9bBe+uLkcZDIU3BYCB0OA40n/8jrAW6eP/L2evAKA==
X-Received: by 2002:a05:6402:3487:b0:40f:fa53:956c with SMTP id v7-20020a056402348700b0040ffa53956cmr629775edc.22.1645639354295;
        Wed, 23 Feb 2022 10:02:34 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:d12c:c0a:f603:b44d? (p200300ea8f4d2b00d12c0c0af603b44d.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:d12c:c0a:f603:b44d])
        by smtp.googlemail.com with ESMTPSA id d12sm203890edy.17.2022.02.23.10.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 10:02:33 -0800 (PST)
Message-ID: <dc89a2c4-3652-bf04-c69d-355a5bbd548d@gmail.com>
Date:   Wed, 23 Feb 2022 18:57:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v3 1/5] dt-bindings: vendor-prefixes: Add Titan Micro
 Electronics
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <4eb7b036-a9b9-3bd2-4e84-f56ba4b1a740@gmail.com>
In-Reply-To: <4eb7b036-a9b9-3bd2-4e84-f56ba4b1a740@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Assign vendor prefix "titanmec", matching their domain name.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index e062a8187..6ffdec91f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1238,6 +1238,8 @@ patternProperties:
     description: Texas Instruments
   "^tianma,.*":
     description: Tianma Micro-electronics Co., Ltd.
+  "^titanmec,.*":
+    description: Shenzhen Titan Micro Electronics Co., Ltd.
   "^tlm,.*":
     description: Trusted Logic Mobility
   "^tmt,.*":
-- 
2.35.1



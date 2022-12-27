Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B854D6566DE
	for <lists+linux-spi@lfdr.de>; Tue, 27 Dec 2022 03:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiL0CgM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Dec 2022 21:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiL0CgL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Dec 2022 21:36:11 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6037FC6F
        for <linux-spi@vger.kernel.org>; Mon, 26 Dec 2022 18:36:09 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id a16so9614681qtw.10
        for <linux-spi@vger.kernel.org>; Mon, 26 Dec 2022 18:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vtremblay.dev; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpAvCEdu1kVeU0YM58vsxaj6GEPGZM7b3Qm6JDjndG8=;
        b=JGIwR1UBlrv2p0wBIJSUgS8ugkY5Ec6W8mRLX8A+cjDt37aGeKmNGcfMagSt43JKI5
         xjC3QnvDrMJ4+l/WoebPcBfqHiCqPsLCOkl21jGNsHS8dywA5hAAeJaWm30jmCMH+wGv
         JcOvsFZFleiAFtjZR4vqw5K78D817Nwyapfv1Qzflmx5Tt/lJICurM1MPqKQldIV5aML
         w+IBcuIMUtYR1IheY6BzFTE5qc6lqM4P747KBkxOUKoYaKdF8I1UeIbGXDfL7Mn876Eh
         ERKJpcYdUxPtGFFoWtZCGhVX0ILiyFGShXp7hwtbYN8USPU9qsJEmuPq2i2ISKg3gwTU
         4fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpAvCEdu1kVeU0YM58vsxaj6GEPGZM7b3Qm6JDjndG8=;
        b=MWoqCC/Yeu13PpMHSFbBug6ZvT07Wl1RJ7hYqm0N8WPSG7EiYtzMAxMhLAd5YlGPti
         yBDODbEJu1XY+Jgcghy8TBRLLUCWzJtRtUj3g0eH81rO8Moh9832GxkGd3QKTrSU5NMv
         QJY+rAicHO7ShzD0uyYJQw+sHbDF53ORtcNGquYstR4NB1zW2MuKxxOW+VpP6WffjCQG
         2+Ggo/Cs7eJTVLjnG8dpXjxUktBngMW5rYTrdReyT6oAKmyDcllsqXZtJ+/ADu9LEb0F
         lFL60dyv0UfDLr2ikdJlqoyttM+lUYmF5A2MgjEqJQ0dOWJulo+4bsdcZyNyTeRMZdLa
         DJ8A==
X-Gm-Message-State: AFqh2kojkuOyyEjXzu7ZY8Dol9BNkNuRfAaHAABbcxKXyxd9bYzVLHsf
        ZeIHo4/WMNn4diFS8bZkwZ7kig==
X-Google-Smtp-Source: AMrXdXtZTBYh5L2AJIEwR9te4GxguPn8H1pxkPFfdiYNuA8pd2iLbdcCefDEkeQ9ZKbfKUicAECCeA==
X-Received: by 2002:ac8:568a:0:b0:3a6:348c:5159 with SMTP id h10-20020ac8568a000000b003a6348c5159mr23612448qta.26.1672108568548;
        Mon, 26 Dec 2022 18:36:08 -0800 (PST)
Received: from vtremblay.. (modemcable190.194-177-173.mc.videotron.ca. [173.177.194.190])
        by smtp.gmail.com with ESMTPSA id l8-20020a37f908000000b006fcab4da037sm8612322qkj.39.2022.12.26.18.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 18:36:08 -0800 (PST)
From:   Vincent Tremblay <vincent@vtremblay.dev>
Cc:     vincent@vtremblay.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Samuel Holland <samuel@sholland.org>,
        "Greg.Schwendimann@infineon.com" <Greg.Schwendimann@infineon.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: trivial-devices: Add silabs,em3581
Date:   Mon, 26 Dec 2022 21:35:47 -0500
Message-Id: <20221227023550.569547-1-vincent@vtremblay.dev>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221224041825.171345-1-vincent@vtremblay.dev>
References: <20221224041825.171345-1-vincent@vtremblay.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add Silicon Labs EM3581 Zigbee SoC to trivial-devices.

Signed-off-by: Vincent Tremblay <vincent@vtremblay.dev>
---
Changes in v2:
 - Add missing documentation in trivial-devices

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f5c0a6283e61..5a3ccbce8c23 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -323,6 +323,8 @@ properties:
           - sensortek,stk8ba50
             # SGX Sensortech VZ89X Sensors
           - sgx,vz89x
+            # Silicon Labs EM3581 Zigbee SoC with SPI interface
+          - silabs,em3581
             # Relative Humidity and Temperature Sensors
           - silabs,si7020
             # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
-- 
2.37.2


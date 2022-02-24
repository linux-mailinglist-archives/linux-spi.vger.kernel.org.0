Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6C24C36A2
	for <lists+linux-spi@lfdr.de>; Thu, 24 Feb 2022 21:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiBXUMG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 15:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiBXUMF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 15:12:05 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2872CF25;
        Thu, 24 Feb 2022 12:11:35 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i11so4449788eda.9;
        Thu, 24 Feb 2022 12:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=kKy0SIhSKIu0kr4V4JEIbxoglz4OmTrfglh5tt6nsYg=;
        b=QdhW2DCKhmJB5VXGZFJfH7ZF47QkssFORrQn+dwi6ampYfc6DbEvRiB00HukSiD/Xx
         xLmiCT2E+0K7MEAubTf+4e0pwdJIUhbpjdSNkBFiQM9oSLRRPyKxD+fJ9LpLvIGP0jHI
         gVpuP4MOmdWQXm7hdJ0juO9V3caTWucEcmf7YJYjMDHOm8Zhon1+lFFhYdophwymy1/R
         2tfuko9MQKHhISTAmDY4Pk8RjadWxJOiNCLxJo9RN+c5fGuwOjOYy1xD9HcZ7r34HmwW
         1KPwI/Y/yU1HE1nMsY/2lMK7LLYb+XfJatje+2/IjL056fag2LcCeBtt1ebuE76P9/Hb
         LxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=kKy0SIhSKIu0kr4V4JEIbxoglz4OmTrfglh5tt6nsYg=;
        b=ugB0kRDwc5pFa63WUmE+TjebA3/auaE4lCnOtxlRgc30cObfpgzZ/3ZKBaQH/4tWfy
         aqFb91fJYgFMWoG29DFhtRKbpcJ6oMQDXQvKKufCsC4cG0lKXKRyaIChxiCXWtDAX9Ja
         2Lu2d54T8NGhVVodAIeUN0mGrkGtOZUE9GDAcR6KfDNep/D/g7pP1LzJORxDheYsndRd
         +oJmrpCqF79q3wIn0QUp2xSHbdCj9nibq2DfeeWj6uDXcxl3DwRS4iKyN9j4h8+SfXNw
         xWsrwKDGnTtSKNy8EPXU6yzlm8REbdeX0tWUrOeVl4JWHnfkspfqm99c6MuXb/W+fVwW
         qxuA==
X-Gm-Message-State: AOAM531ynbun2q0l3pevoGICy5GXvhweOwHsJieiSCHfyqkB7U6SG9yP
        Ebv8QNxzcTmlwdi7rRiMXhM=
X-Google-Smtp-Source: ABdhPJxCCcYxGn8Kcl7NsKJCzdQ4Vl6lcaApJwLzVwVutqb4KSaWgUcrjJg1sBfXDTuQvMAevfEsmA==
X-Received: by 2002:a50:8e44:0:b0:40f:d71f:bdf5 with SMTP id 4-20020a508e44000000b0040fd71fbdf5mr4038143edx.166.1645733493712;
        Thu, 24 Feb 2022 12:11:33 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd? (p200300ea8f4d2b0070ade6bd1cea7edd.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd])
        by smtp.googlemail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm130234eji.67.2022.02.24.12.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 12:11:33 -0800 (PST)
Message-ID: <a9db41fc-3409-7a5f-00b1-e9619b80ca5e@gmail.com>
Date:   Thu, 24 Feb 2022 21:10:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v4 5/6] arm64: dts: meson-gxl-s905w-tx3-mini: add support for
 the 7 segment display
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
References: <f911c7d3-a9c4-32ee-68a1-e30b478732c9@gmail.com>
In-Reply-To: <f911c7d3-a9c4-32ee-68a1-e30b478732c9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds support for the 7 segment display of the device.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts  | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
index 6705c2082..20bbd931e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
@@ -10,6 +10,7 @@
 
 #include "meson-gxl-s905x.dtsi"
 #include "meson-gx-p23x-q20x.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	compatible = "oranth,tx3-mini", "amlogic,s905w", "amlogic,meson-gxl";
@@ -19,6 +20,64 @@ memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>; /* 1 GiB or 2 GiB */
 	};
+
+	spi {
+		compatible = "spi-gpio";
+		sck-gpios = <&gpio GPIODV_27  GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio GPIODV_26 GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
+		num-chipselects = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		tm1628: led-controller@0 {
+			compatible = "titanmec,tm1628";
+			reg = <0>;
+			spi-3wire;
+			spi-lsb-first;
+			spi-rx-delay-us = <1>;
+			spi-max-frequency = <500000>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			segment-mapping = /bits/ 8 <4 5 6 1 2 3 7>;
+			grid = /bits/ 8 <4 3 2 1>;
+
+			alarm@5,1 {
+				reg = <5 1>;
+				function = LED_FUNCTION_ALARM;
+			};
+
+			usb@5,2 {
+				reg = <5 2>;
+				function = LED_FUNCTION_USB;
+			};
+			play@5,3 {
+				reg = <5 3>;
+				function = "play";
+			};
+
+			pause@5,4 {
+				reg = <5 4>;
+				function = "pause";
+			};
+
+			colon@5,5 {
+				reg = <5 5>;
+				function = "colon";
+			};
+
+			lan@5,6 {
+				reg = <5 6>;
+				function = LED_FUNCTION_LAN;
+			};
+
+			wlan@5,7 {
+				reg = <5 7>;
+				function = LED_FUNCTION_WLAN;
+			};
+		};
+	};
 };
 
 &ir {
-- 
2.35.1



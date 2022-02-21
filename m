Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C213F4BEBCE
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 21:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiBUU12 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 15:27:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiBUU10 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 15:27:26 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD3A22BFF;
        Mon, 21 Feb 2022 12:26:59 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d10so36077619eje.10;
        Mon, 21 Feb 2022 12:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=kKy0SIhSKIu0kr4V4JEIbxoglz4OmTrfglh5tt6nsYg=;
        b=QhVIXeLafiSQ+OusdmmLI0MIBGtvj3M481RJOUzvum6fl2yqAsuXwGTwQhoP9NLvat
         y4Y+vCs1VSsLIzMLQRF5NuFHG6V8TgmXXLxQ60lQBmu4dmRZV9ItYU/MX0mzMRxuwmwy
         EqyvBxAGVS5LUf+H9sO4IezQR9H3OsdG4GiTusuanzCvgMRXZ6pEPZwSgua6a+yohYwf
         4by0nWAmB9lBf2uIB3ytC4/PhWqcpzzOQ46K8YahEYzftolz1Qf2npCeqtoAV1g3Zslo
         opN2I62ZXz/PAUFu+YXk+dQPE9Kepb5WHawTz8ll4C1CJXarImQ9pStdnL54hqxfPioq
         Criw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=kKy0SIhSKIu0kr4V4JEIbxoglz4OmTrfglh5tt6nsYg=;
        b=x9LEt+MNIo3xcioAM4/ZvCi2/Dcp9IrjQKcGenlf0aH8OSYp+nG90ZApsy15r8RpIl
         XMj5MyFukWWfvPxTS1/4kxqY6nfEdbbsf/mjnMgq5NrS77IXMSHj1G5ATSiQ5QZjSSvz
         OnuqsF8xUt1QKMda8kQk7JtkUoAkzXERv3MLQ1HxJl3w+uNb+gSgc5xTly6Qk43KKYoa
         RiiEJKYXzR9nhPcIfBlDQym2u2cD+fPoeGFT9PIKDptsQLHnE6UhoJpedytbdCo3uNo8
         rdCdLv/xUnrsQSUY2oyxgFGHfMb9DfmXPs/5P7w/IQdb14BSVOt/tPiVArgwwldMOoiL
         3m3g==
X-Gm-Message-State: AOAM532rpfCqWukreM1mzQ7kmCGfik9xtvL8GOOeav0hFt1pS3tZF590
        +DzHBbuT+ML9Qexzk7rRPFc=
X-Google-Smtp-Source: ABdhPJzT/P9zjoUcLxnr99/r6mPFb4wbtKG9JwGOJjHBZorNZuyuG/B2BVUR3d7nISl8goaCC1aj/w==
X-Received: by 2002:a17:906:a057:b0:6cf:2736:ba65 with SMTP id bg23-20020a170906a05700b006cf2736ba65mr16811745ejb.171.1645475218445;
        Mon, 21 Feb 2022 12:26:58 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:b141:a0d:4aad:2a06? (p200300ea8f4d2b00b1410a0d4aad2a06.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:b141:a0d:4aad:2a06])
        by smtp.googlemail.com with ESMTPSA id y21sm5391986ejq.185.2022.02.21.12.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:26:58 -0800 (PST)
Message-ID: <cb4c2ed9-0710-7b6c-f4c1-faf13d814f09@gmail.com>
Date:   Mon, 21 Feb 2022 21:26:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v2 6/6] arm64: dts: meson-gxl-s905w-tx3-mini: add support for
 the 7 segment display
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
In-Reply-To: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
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



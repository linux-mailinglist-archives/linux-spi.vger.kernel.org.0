Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3233B4C50A7
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 22:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbiBYVYi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Feb 2022 16:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbiBYVY3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Feb 2022 16:24:29 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294E188A28;
        Fri, 25 Feb 2022 13:23:54 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qk11so13298429ejb.2;
        Fri, 25 Feb 2022 13:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=ITwZ2iGGWJevAmm+W8iPYQ6tiXhFibH5anmi49Qig/0=;
        b=Gb0HgBQ6y0KAx0MSz95w+dOzfqWoOCxdTtZ0naa5y9d3oA1he40MqTBHqREx+YMwNU
         tM/Q/K3hAumLvQYlfTu26FOVzJwt43lzSEQTfo+PLKk/fiqCZDrhfDaaWH+cPkigp0fE
         5ZdlX2MmPgxC7ENnsE1z50WTkvm2w657wb0tw/oiM8spb8CKjua2D8ABbyKnR3+RqffV
         PnnoUygFBnQZGjeEQrT/aShIt0tdhUzY/IuOlXFN8DPBEUSdioAdPXhHMUwIN/TgQkkz
         UbTx0JtBkSdGpAJfHPjnyEuEo9si5XU3qAjcWkOCbbJQRQ3UbHOuY8Nslq8aMYoOq45l
         tElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ITwZ2iGGWJevAmm+W8iPYQ6tiXhFibH5anmi49Qig/0=;
        b=4SVmo1cA2xIy6BO4YREMQNCwGTCW0d67Eq9EIMZZ6rqd9oEKhaMFRsgQ1FtTKdvk2C
         gNdH/5cmTzSG0rWzxAj4npNYPVvdfrFGqyjRudUw8fk0sEJql8Baz7DIdXmO/zRTIADA
         JcfnQ37NdC+h2xtCtR7Ycf+J+m6QeTCBtH9yBDThW29uDRNjc69KAn2jgtgu1JATqA5W
         5ghpg1A0APUGWCPuagxBHp59wchK01hQi/ZFvLB6LD6wrJ+hTIQT0Omd2kEZRWPoGfb/
         U/AcCXNUvpQ/P7yRiy1mH5rnPMdAvgQ6sLceFd72H9Km//uEU3l0x4VhkIBMGC4f9jVe
         8rCw==
X-Gm-Message-State: AOAM5303gXwgUqZn5Ttn1YTaAB2Y10c9dIT+i2h3u/t0ZIXX3de5NFKH
        WU3p1WuiFelXvQQ8VaoqkMA=
X-Google-Smtp-Source: ABdhPJzUs0H4TCgOlY3vFGZehzz7PcJuULHzTp7dFQgUPHtVX+kHpnMTtDX6gtT/li+x4ea7DXdsEA==
X-Received: by 2002:a17:906:d977:b0:6ce:7097:b8ab with SMTP id rp23-20020a170906d97700b006ce7097b8abmr7317116ejb.766.1645824232592;
        Fri, 25 Feb 2022 13:23:52 -0800 (PST)
Received: from ?IPV6:2a01:c22:7326:e100:c9d3:3c62:2c99:d44b? (dynamic-2a01-0c22-7326-e100-c9d3-3c62-2c99-d44b.c22.pool.telefonica.de. [2a01:c22:7326:e100:c9d3:3c62:2c99:d44b])
        by smtp.googlemail.com with ESMTPSA id j2-20020aa7c0c2000000b00412b6b79d1asm1914186edp.10.2022.02.25.13.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:23:52 -0800 (PST)
Message-ID: <98b09fc5-5de7-ab71-cbfc-843f1c83239b@gmail.com>
Date:   Fri, 25 Feb 2022 22:22:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v5 5/6] arm64: dts: meson-gxl-s905w-tx3-mini: add support for
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
References: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
In-Reply-To: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
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
v5:
- add vendor prefix to controller-specific properties
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
+			titanmec,segment-mapping = /bits/ 8 <4 5 6 1 2 3 7>;
+			titanmec,grid = /bits/ 8 <4 3 2 1>;
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



Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468DA6C4FBE
	for <lists+linux-spi@lfdr.de>; Wed, 22 Mar 2023 16:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCVPzX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Mar 2023 11:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCVPzV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Mar 2023 11:55:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428E95B43B
        for <linux-spi@vger.kernel.org>; Wed, 22 Mar 2023 08:55:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so6575615wmq.4
        for <linux-spi@vger.kernel.org>; Wed, 22 Mar 2023 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679500519;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zJTqUefxnpBvO7DIOSS6rnsCqCeH+NolRi/V2K9dxfM=;
        b=NCdIIOqHzKpbcNsSqbp4T0Wbx9wgB5qslNsVyTS+nBnFKE6zMSOj+9hr19VTdzAoBN
         RtGV0jlb29PXpNCILxAVWsF159DMzBZZOgdWk1LMJFUs2yNiR+Q9J6VitcqrUMhuotsM
         1hz1KSf7VIa8OELwy7ZhfATew9lxeSaYmM0mKdpLokGKVUTDO5zADqClO6gGqmlYtGy6
         PuFA2CgSujK4sqgFPI9EdFX3nXDg8l42rdXgk9dxY8Ryb+b53InDYL7NKLqM+LhW7fb8
         20IMV2mcBND+7Af5GCKNQn8XVdDmbj8o0PZTcaO+NiV5fA+tazO5oHLYyFybQDjZMB8S
         wa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679500519;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJTqUefxnpBvO7DIOSS6rnsCqCeH+NolRi/V2K9dxfM=;
        b=wPxMk9zHxs8nRKIhljirSyQQbU/QPDHkzTmjSy+wJStgxy7AB0hA1V4jv6B6zmbR72
         UJmC9w/ZG8JdGOoqVXwlhe7a1Ac8eloAq0J2io5tEe6ABP1LyZyIHut/Iq0TxnCb4Aym
         9fb047j/IoqD/t5oS0LC5tpPVl3tpaeATicBdryEdskIuS5DukILjCtFTvF/nARwB2T9
         ufUDE9qK6LmB+M5F9uenx7BeOabaLvPYDCoyw0/Wt/tG6hBPOEA6JtyHOYdpYC/OUvJ7
         vIiwqZ2WgIjq/q4vL/sL4DhXpxfw5/nfOHkIgQq+tiX2WxIpvJ5S7htPjUBQoW3/3jFL
         oMxQ==
X-Gm-Message-State: AO0yUKVBPOmzkNhzz1wYyW9eCwG8lV/6i7mhAQHeEx9OInRsIF051trN
        3cd5ilcHnoEzPwSDoI2dyKJy+w==
X-Google-Smtp-Source: AK7set/A6xCnkrsudKHQ0e0Y5/lirw38lluwjAT3qhc34uN8OF92RHjxAc1J1NYlLdOJYFUFgLjP0Q==
X-Received: by 2002:a1c:f311:0:b0:3ed:2a8f:e6dd with SMTP id q17-20020a1cf311000000b003ed2a8fe6ddmr31355wmq.6.1679500518772;
        Wed, 22 Mar 2023 08:55:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3606:a601:f273:994a? ([2a01:e0a:982:cbb0:3606:a601:f273:994a])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bcb90000000b003edf2dc7ca3sm9906939wmi.34.2023.03.22.08.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 08:55:18 -0700 (PDT)
Message-ID: <f173b241-5efd-24a3-de06-647e33a62417@linaro.org>
Date:   Wed, 22 Mar 2023 16:55:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: add binding for meson-spifc-a1
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
References: <20230322150458.783901-1-mmkurbanov@sberdevices.ru>
 <20230322150458.783901-2-mmkurbanov@sberdevices.ru>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <20230322150458.783901-2-mmkurbanov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 22/03/2023 16:04, Martin Kurbanov wrote:
> Add YAML devicetree binding for Amlogic Meson A113L (A1 family)
> SPIFC Driver.
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>   .../bindings/spi/amlogic,meson-a1-spifc.yaml  | 42 +++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml
> new file mode 100644
> index 000000000000..5f84063b01f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/amlogic,meson-a1-spifc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson A113L SPI Flash Controller

I think it should be "A1 SPI Flash Controller" to be more coherent

Neil

> +
> +maintainers:
> +  - Martin Kurbanov <mmkurbanov@sberdevices.ru>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-a1-spifc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/amlogic,a1-clkc.h>
> +    spi@fd000400 {
> +          compatible = "amlogic,meson-a1-spifc";
> +          reg = <0xfd000400 0x290>;
> +          clocks = <&clkc_periphs CLKID_SPIFC>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +    };


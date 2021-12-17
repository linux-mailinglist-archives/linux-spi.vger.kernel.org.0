Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67065478EAD
	for <lists+linux-spi@lfdr.de>; Fri, 17 Dec 2021 15:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhLQO6j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Dec 2021 09:58:39 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36514
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237664AbhLQO6j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Dec 2021 09:58:39 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1834740036
        for <linux-spi@vger.kernel.org>; Fri, 17 Dec 2021 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639753118;
        bh=Hw35a9zAAra+Bh4MYIJdw1ech8klD8or9kfvHyKDECw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=lb+zJoKPZuCAWSEDdqmf8AeQSpS3F+zXPboIdfxSas9pZk/eICJiDylL85L9F0yoZ
         jgB9uKVYkGetGnhU6uMXVFs7fZLUWSbFMDSul3yJ9B7la4uqsnIScTW2Pfg7tJD/Kp
         494LzVhBzGTvtIE4UKU2jyvu22PB/imwNiOf8RX0tvfGgD01RQMs6U6sw9ERhAY1ky
         ZSGC61fHzf/DTAUnZf5bqK5x9iZcsAi5QssKzIrIEWxRlFr6VmcKTvDrwOECr6A3WB
         SxXlcCO87KGWWfQcnY+221Xdje6zHdx8wH0WWw2DbxDNBHO/tRls09BV3/ct3TjUOd
         A0MvJGLn562qw==
Received: by mail-lf1-f72.google.com with SMTP id q13-20020a19f20d000000b0041fcb65b6c7so1022721lfh.8
        for <linux-spi@vger.kernel.org>; Fri, 17 Dec 2021 06:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hw35a9zAAra+Bh4MYIJdw1ech8klD8or9kfvHyKDECw=;
        b=q9h8PA6L/yqGgzRN7qUzu1jSCZSDwClPRkClPSlk9/bKdYP2tUZhwjQKqCpc171TRW
         li0YLBPUuqsc4iNlkgROM1JO0CVivvQLilTc0myeturYf9joPyNSNTixBf/Ou7+YfbP6
         Y5+6uZMZR6MiUyt1oKbolV1RS58nBIBVoepJgVRGL80PBpFu6ijcO2w0+lySnCZ9YPXQ
         ed5x7ZwU3Q1ni7vAiKjEAd7MgQzJ7wfNL3Ysfjih/0/B/Ph5vjy3je7jh3sviy/bIBMF
         sKP+cBGlB+mW7nH+tLJGC09no0axt5GnJr0pcuuvGaMqtv9O/nETBoRRPQuzGZaZxH32
         8JqA==
X-Gm-Message-State: AOAM533qudFqytgvt+Je5pI6S4pqQwlShy7diDYY7EE3zombD6zz+Y/w
        ab5N6P/3av9zKIdQQ/62oyVUe9PtvwbqaXjqSdfT72fRo+9mVou8qCib9FTxXkKrmVMAmsfDKAk
        LdZqhZQ6+rjLQEf+oKFePDd7pNegeiiOQI2s5NA==
X-Received: by 2002:a2e:3c16:: with SMTP id j22mr3118026lja.158.1639753117225;
        Fri, 17 Dec 2021 06:58:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOFUy3T2cRGl82xVn02j230+oyfIezcftFw9B0y5rU/9OtzeUGE1r8DX0H/qzUI3hn4MMlTA==
X-Received: by 2002:a2e:3c16:: with SMTP id j22mr3117988lja.158.1639753116969;
        Fri, 17 Dec 2021 06:58:36 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id b10sm1424506lfj.230.2021.12.17.06.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 06:58:36 -0800 (PST)
Message-ID: <a995a558-6243-e5a1-18f6-fd03054727e7@canonical.com>
Date:   Fri, 17 Dec 2021 15:58:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 12/17] dt-bindings: pwm: add microchip corePWM binding
Content-Language: en-US
To:     conor.dooley@microchip.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     geert@linux-m68k.org, bin.meng@windriver.com, heiko@sntech.de,
        lewis.hanly@microchip.com, daire.mcnamara@microchip.com,
        ivan.griffin@microchip.com, atish.patra@wdc.com
References: <20211217093325.30612-1-conor.dooley@microchip.com>
 <20211217093325.30612-13-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211217093325.30612-13-conor.dooley@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/12/2021 10:33, conor.dooley@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Add device tree bindings for the Microchip fpga fabric based "core" PWM controller.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/pwm/microchip,corepwm.yaml       | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml b/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
> new file mode 100644
> index 000000000000..ed7d0351adc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/microchip,corepwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip ip core PWM controller bindings
> +
> +maintainers:
> +  - Conor Dooley <conor.dooley@microchip.com>
> +
> +description: |
> +  corePWM is an 16 channel pulse width modulator FPGA IP
> +
> +  https://www.microsemi.com/existing-parts/parts/152118
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: microchip,corepwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  microchip,sync-update:
> +    description: |
> +      In synchronous mode, all channels are updated at the beginning of the PWM period.
> +      Asynchronous mode is relevant to applications such as LED control, where
> +      synchronous updates are not required. Asynchronous mode lowers the area size,
> +      reducing shadow register requirements. This can be set at run time, provided
> +      SHADOW_REG_EN is asserted. SHADOW_REG_EN is set by the FPGA bitstream programmed
> +      to the device.

Please also describe what is the meaning of the values used here. What
does a value "2" mean?

> +
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#pwm-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include "dt-bindings/clock/microchip,mpfs-clock.h"
> +    corePWN1: corePWM@41000000 {

Here and in all patches, please skip the label. It's not helping.

Node name: pwm

> +      compatible = "microchip,corepwm";
> +      microchip,sync-update = /bits/ 8 <1>;
> +      clocks = <&clkcfg CLK_FIC3>;
> +      reg = <0x41000000 0xF0>;
> +      #pwm-cells = <2>;
> +    };
> 


Best regards,
Krzysztof

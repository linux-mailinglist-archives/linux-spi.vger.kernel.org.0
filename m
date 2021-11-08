Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B460449E04
	for <lists+linux-spi@lfdr.de>; Mon,  8 Nov 2021 22:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbhKHVXv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Nov 2021 16:23:51 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43186
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240096AbhKHVXu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Nov 2021 16:23:50 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8235D3F044
        for <linux-spi@vger.kernel.org>; Mon,  8 Nov 2021 21:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636406464;
        bh=YogfxXVLG0bgwIYjZVCScA3ZPj2arr94hp6aXYuCGUk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=QbqhbOXeUJoyqq9YUqYXj6NJ4roHk0MqgkuNtwURhbXcERkF1RlqHewA2MUHHrehR
         FhvbKHpASHMASGalhBOE+7ztsbcnt7SIR8DDm8OrXv1oq3NMNZQwIN9tlMKkXDXCWs
         WG2Wkeeof6yjJfQovetHfsc0GaJI5vxjxjHxTOLG2+uoO08g/DLSK4hxxYT6KX59Tz
         y6UmKIAVWgVXpdaNd4BhUZTtpElgZDU/DV429NquH2DN/LDw7ouu3qXQiYywcOg7W1
         A4UWeJM/5PcQErc7M+3A8j/g6Loi5Cu3SKYnXkzyOksMA/1GwUBlNVTviVk4soEw0D
         xm9q1h5xtG2Zw==
Received: by mail-lf1-f72.google.com with SMTP id c40-20020a05651223a800b004018e2f2512so6476100lfv.11
        for <linux-spi@vger.kernel.org>; Mon, 08 Nov 2021 13:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YogfxXVLG0bgwIYjZVCScA3ZPj2arr94hp6aXYuCGUk=;
        b=EK0sLt5lGqmOTPBsrKpB6NZmuZABPaTV2u//mHf3G/QUBfO8Lb+BAxGNPrFVkqzsZb
         MDbcows636w9PWVBswg6FeTIQQigNHx+jNZ/TjuMDesWEWRL6S7+7QabUN9s6TCsBvWo
         AdxKJjX2lvGmHUdp9N6DUZS8idfxCRCSN5gogKmZeuIYfHt7HwFRwNI6Ru01XRP+wCbN
         PKZw18uEk2J9ieiw317xDG7GeOUkRE6oqygz0PDPYkuWsMj4lNOh74EBPCt4P/Ca559p
         8Hf2369dXXgEie7n4hDuVtlJ4RHkan8xivo3OshqnsfzMkYZxALWYMEp+g9EubKGjPwc
         ijzg==
X-Gm-Message-State: AOAM531rvUCIkQQQ+oPe33oqi2dW+SHa94E0G8GohcxBFNIQmySA6l2h
        YmlS4rddH/bjnO+kmCuhMhJ2M31saic1K2RHotsryjkiUn/LiaMvkFj1u14DGubqVigStXBu340
        rsAgZPZpZJMUPNt0IdGiDsuaBnRvJCbI6anb7Qg==
X-Received: by 2002:a05:6512:152a:: with SMTP id bq42mr2090109lfb.109.1636406453479;
        Mon, 08 Nov 2021 13:20:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGaKWNwUoPiLxpzGIDpV6UffO82CncD15TYE1AU5AiV5f3zoXZgGywJ7u5NVSzJMJoy3rnJA==
X-Received: by 2002:a05:6512:152a:: with SMTP id bq42mr2090089lfb.109.1636406453316;
        Mon, 08 Nov 2021 13:20:53 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id i12sm1930457lfb.234.2021.11.08.13.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 13:20:52 -0800 (PST)
Message-ID: <0a2e06af-9aa4-a5a2-f20a-332bdfc69448@canonical.com>
Date:   Mon, 8 Nov 2021 22:20:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 08/13] dt-bindings: soc/microchip: add bindings for mpfs
 system services
Content-Language: en-US
To:     conor.dooley@microchip.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, lewis.hanly@microchip.com,
        daire.mcnamara@microchip.com, atish.patra@wdc.com,
        ivan.griffin@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     geert@linux-m68k.org, bin.meng@windriver.com
References: <20211108150554.4457-1-conor.dooley@microchip.com>
 <20211108150554.4457-9-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211108150554.4457-9-conor.dooley@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 08/11/2021 16:05, conor.dooley@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Add device tree bindings for the services provided by the system
> controller directly on the Microchip PolarFire SoC.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../microchip,mpfs-generic-service.yaml       | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-generic-service.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-generic-service.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-generic-service.yaml
> new file mode 100644
> index 000000000000..f89d3a74c059
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-generic-service.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/microchip/microchip,mpfs-generic-service.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Microchip MPFS system services
> +
> +maintainers:
> +  - Conor Dooley <conor.dooley@microchip.com>
> +
> +properties:
> +  compatible:
> +    const: microchip,mpfs-generic-service
> +
> +  syscontroller:
> +    maxItems: 1
> +    description: name of the system controller device node

Same comment as for rng patch.

> +
> +required:
> +  - compatible
> +  - "syscontroller"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sysserv: sysserv {
> +        compatible = "microchip,mpfs-generic-service";
> +        syscontroller = <&syscontroller>;
> +    };
> 


Best regards,
Krzysztof

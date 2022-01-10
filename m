Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67363489BE5
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jan 2022 16:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiAJPLG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Jan 2022 10:11:06 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51672
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235977AbiAJPLG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Jan 2022 10:11:06 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1E64840A5C
        for <linux-spi@vger.kernel.org>; Mon, 10 Jan 2022 15:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641827463;
        bh=tX3h7hnt8kxt/dVYtcBgB0Ej6aT/jkR+7hhXYExraYQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Nx/Cnb4ybbbFld+YY7nET2sVm1TcUDZ5p/gxtwTlhFLt1XxCW80D/Nvwxapkqv3es
         1nG09P4yocKg42BklYXP+07u1LKL9XZPP+STcoxqZJ6IrdIzmQwuBowUkBorhRVUZ3
         1DHF5NuoJC1A+1o3OudsMQHuvW4yfzuPoyHpNohDNxFlEwa7gG9YiYpqQr8hZkK9J5
         TNMOqnu1IQb/seDjJ7FnT1DuQQxqtjupyVh9oJhOnerUyFTl11DkgpZwKfPyHwyddY
         aFH8ZTrE86c0gMQep3/58X7+RCkS9Py7jK0wSQai0zydrgzNpeQ7Dkk7O9sqMZbwto
         2S/tNz0wrIc+w==
Received: by mail-ed1-f72.google.com with SMTP id b8-20020a056402350800b003f8f42a883dso10364910edd.16
        for <linux-spi@vger.kernel.org>; Mon, 10 Jan 2022 07:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tX3h7hnt8kxt/dVYtcBgB0Ej6aT/jkR+7hhXYExraYQ=;
        b=iURX+Fu9eKIVKDi1C9+SXjblNXjMMEOo4p2Zlcm/eTkwXlJfJRlgOFcuawddyTfugW
         UF0aWTAZBUHhQ1BtY9JyNSrTJ2paUclEBHNQTw+k1GgupcxLcDDEd7cDV2ZlbwfM6U12
         APor8gJutmYvNvazSfQPkdrzdgAF8Ka66GajO93VGOtOuXVpnEJQTeAe0A6lR0P1zOU0
         ziKAwy+19qxggadtwUMmDh86ttqm5hJuIzecala6QLJN7iOz2Dp64o4JbhzJO+mR+K9H
         /0CmHPJpqawtj8vVilM1TukgFAsavV8FvD+Rw2akK6+zclPUR+iCKFD4I1xr/lZPVLLo
         Uzzg==
X-Gm-Message-State: AOAM533ezdbx0IiJPW2FxyqjgZau8xZZNE/AbaSplEt2k20V55G4dGJ/
        bVh0nCmWQIqbtQX4YuXmM5SjPckExrS+8bXWYkHL4uel2rsqR7go6CRoecSNu6l4kcCyAeqJ1hO
        HXaqpo8qNkS49Zu3Eu68fptpo6yCxHd7T5dqTsw==
X-Received: by 2002:a05:6402:2756:: with SMTP id z22mr74502edd.255.1641827460976;
        Mon, 10 Jan 2022 07:11:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwxpZo2R3+fpKQFtBTyG7e4TaBBMrhOqAuzK/7sAzUdh6Cil2bZ3WxmZvF685+f8JUGO5VTA==
X-Received: by 2002:a05:6402:2756:: with SMTP id z22mr74475edd.255.1641827460801;
        Mon, 10 Jan 2022 07:11:00 -0800 (PST)
Received: from [192.168.1.126] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id c1sm2548737ejf.92.2022.01.10.07.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 07:11:00 -0800 (PST)
Message-ID: <372040ab-6ada-62e9-727f-6daeba8e73f8@canonical.com>
Date:   Mon, 10 Jan 2022 16:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/2] spi: dt-bindings: samsung: convert to dtschema
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220102155807.42758-1-krzysztof.kozlowski@canonical.com>
 <20220102155807.42758-2-krzysztof.kozlowski@canonical.com>
 <CAPLW+4miCOwFR11gdaU1nMQZdk8zVcWOcSK=Wjd3AaCagGLyug@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAPLW+4miCOwFR11gdaU1nMQZdk8zVcWOcSK=Wjd3AaCagGLyug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 03/01/2022 15:41, Sam Protsenko wrote:
> On Sun, 2 Jan 2022 at 17:58, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
>> controller bindings to DT schema format
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../devicetree/bindings/spi/samsung,spi.yaml  | 220 ++++++++++++++++++
>>  .../devicetree/bindings/spi/spi-samsung.txt   | 122 ----------
>>  MAINTAINERS                                   |   2 +-
>>  3 files changed, 221 insertions(+), 123 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
>> new file mode 100644
>> index 000000000000..195bfafe05fd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
>> @@ -0,0 +1,220 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/samsung,spi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Samsung S3C/S5P/Exynos SoC SPI controller
>> +
>> +maintainers:
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> +
>> +description:
>> +  All the SPI controller nodes should be represented in the aliases node using
>> +  the following format 'spi{n}' where n is a unique number for the alias.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +          - samsung,s3c2443-spi
> 
> Maybe add the list of supported platforms for each compatible (in a
> comment on the same line), like it was done in .txt binding?
> 
> Other than that:
> 

Sure.


Best regards,
Krzysztof

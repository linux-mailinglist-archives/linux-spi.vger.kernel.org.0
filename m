Return-Path: <linux-spi+bounces-1958-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C906885A3C
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 15:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDC2285E79
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B2884FAB;
	Thu, 21 Mar 2024 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G38yIeOW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2C184FA6
	for <linux-spi@vger.kernel.org>; Thu, 21 Mar 2024 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029647; cv=none; b=msDuZ4PTXgdmjrfOToyfrS+Apozo7T6Zi6HNN5OMDZu0Vov3/EINSQEyFtOS7ZmLZjI1bRpiqZE/rzTvQXSLFHHW+a7QrzdW/UmUgxvxHdyxuZmPo8mFOY0e95Ty2H8kFs9+YYRrX+Rrf5PGGC95IVOcj2kLtvSPIeEnv3fMrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029647; c=relaxed/simple;
	bh=xfHfciwugs3WtmtDV4AADrNkPmDPMpREzb169ut/HJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdG8++eYMq28+R8dDjsGqsZwQhCLb9o0zSZOhJ1FDpTCxIk90/S4QlL0qK0ZNKo+nusbtDPMIR2ljf6/twhngouzuVbLpEevLK48PS5FGoQjmo4BHWOVMkTJG1dWM9W3Kbxx9XiailzSAO83h1Yr7oYV2eguNq+bMsXdSkkkZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G38yIeOW; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d4a901e284so21881771fa.1
        for <linux-spi@vger.kernel.org>; Thu, 21 Mar 2024 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711029644; x=1711634444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UxSEsdxwgjHTiER5VfQyKWsQwZSwTrMKJUoOfVEzdTs=;
        b=G38yIeOWvpr5NMF50GaT2Q7b1FFhoOktyA2zs84+Hn9zjsrFQTMCnPEecu9Kdxv7Yk
         Fri9r1A2Rk8OwU0FR4ry/1jthVw7intxG14XKhnm5iLHPQ7FEJkT2RxV8+hhlCJRyDVT
         lNNn6ecGnMoSW2WA7/9kW5kYsJrBWT96I747CveskSoUKnw+jgVVzxzM0UVSWa08kRM3
         a0nM8aXI+FFcwePxBONIZi2rW34FjRR79u7rQurKcQ4FJdqW0EtYETxfOEGrFymnHnde
         Fe2aB7HwVm9TxwJ7+z0IbxEJvhS4IVWZvsdruLsyEguJWVR5ZAATTWxWZzVcIbnG88AM
         f8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711029644; x=1711634444;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxSEsdxwgjHTiER5VfQyKWsQwZSwTrMKJUoOfVEzdTs=;
        b=O8bqRPlh7Tw7akD+bAasVnd50BcEi5fe5YfUIPWtACHY+XPKPkTOJjXGmoEC702a8p
         +j1NddP1wPOlegnWl5k7qVlwbAJZt6Kn56r3OxjZda7+1yu9YKTtEIWXyEntlD4vQTjQ
         0uiKgBD0KhYnP28mR1Sw0ZlPOhECO9b7LSRmub/tyFtaEijZp6mOU9JpC6/MdqZYP4Dj
         W997jGjlEWhUR4e9qWHMP2aAulb0XBXVlfV7UxZAEHD9uAsJU863L6d+AivhfPCWeoAj
         I/XPZviRRClOZ/p5tA/HAoCkMYnTn6Zz8dRcocc/DbODty7m/8NFC8UgNJhopK6FjpwV
         xt7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkrPrmSaXOzW6kW2kt6clWaUBw2+szw445v+nwpsx5vJuuKQkH8BzN9VMJgyfp+F4MbjYQbMEOHEtMviceTpwlcbqJD/PThGJA
X-Gm-Message-State: AOJu0Yw/fawD1d8SHKTLAwuRMhj8VG9FuwPao029ZbU3zDTjqcEJiMCB
	76ljc9l8ztN8H8mUzzUBelPdLSoRGd79VPtR9LJ9LsT0s/7nYTJdxmi7M10MuCs=
X-Google-Smtp-Source: AGHT+IG2h5yGdIZon9ov65XOrqL2TYnEpISYwfO0Ra8MbK+hEETZE4U0dRumncwp+hJbqUcpMNGKOg==
X-Received: by 2002:a2e:7203:0:b0:2d2:9121:52f5 with SMTP id n3-20020a2e7203000000b002d2912152f5mr1670002ljc.42.1711029643873;
        Thu, 21 Mar 2024 07:00:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id jz8-20020a17090775e800b00a455519bcb3sm8444829ejc.55.2024.03.21.07.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 07:00:43 -0700 (PDT)
Message-ID: <1009fc1b-59f4-408e-9c2d-486e1886ce48@linaro.org>
Date: Thu, 21 Mar 2024 15:00:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: spi: convert spi-jcore to dtschema
To: Kousik Sanagavarapu <five231003@gmail.com>, linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240321134956.7731-1-five231003@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240321134956.7731-1-five231003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 14:47, Kousik Sanagavarapu wrote:
> Convert existing bindings of J-Core spi2 to dtschema.  No new properties
> are added.

Subject:
spi: dt-bindings: jcore,spi:

> 
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
>  .../devicetree/bindings/spi/jcore,spi.txt     | 34 -----------
>  .../devicetree/bindings/spi/jcore,spi.yaml    | 60 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.yaml
> 


> diff --git a/Documentation/devicetree/bindings/spi/jcore,spi.yaml b/Documentation/devicetree/bindings/spi/jcore,spi.yaml
> new file mode 100644
> index 000000000000..e76775bb68d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/jcore,spi.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/spi/jcore,spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: J-Core SPI controller
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The J-Core "spi2" device is a PIO-based SPI controller which used to
> +  perform byte-at-a-time transfers between the CPU and itself.
> +
> +maintainers:
> +  - Kousik Sanagavarapu <five231003@gmail.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: jcore,spi2
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      If a phandle named "ref_clk" is present, SPI clock speed
> +      programming is relative to the frequency of the indicated clock.
> +      Necessary only if the input clock rate is something other than a
> +      fixed 50 MHz.
> +
> +  clock-names:
> +    description:
> +      Clock names, one for each phandle in clocks.

Drop description, but instead provide a name. See existing code.

> +
> +  "#address-cells":
> +    const: 1

Drop

> +
> +  "#size-cells":
> +    const: 0

Drop

Please do not write bindings in entirely different way than existing
ones are written. Open existing recent bindings and look there.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: true

This cannot be true. From which existing code did you take it? What you
need here is unevaluatedProperties: false.

> +
> +examples:
> +  - |
> +    spi@40 {
> +      compatible = "jcore,spi2";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      reg = <0x40 0x8>;

Keep reg the second property.

> +      spi-max-frequency = <25000000>;
> +      clocks = <&bus_clk>;
> +      clock-names = "ref_clk";
> +    };

Best regards,
Krzysztof



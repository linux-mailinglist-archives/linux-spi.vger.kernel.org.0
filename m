Return-Path: <linux-spi+bounces-2303-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950EB8A12A6
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 13:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92D21C20F98
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 11:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E89147C7E;
	Thu, 11 Apr 2024 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dUqfi1KV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F51474CF
	for <linux-spi@vger.kernel.org>; Thu, 11 Apr 2024 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833941; cv=none; b=IiVU8CmfGWwstKMotshOCyep6wkVXFklf3jb41BAJVDAecNqAtpVER+WnCxmBEkvqM+/SGq40I89KwWK3jZeI2wjfPsqRwpraA3cYQ0W+Da/8GFP/XNJTsdz35wmXyEND5Jc2PMHY0Hc0nTHv3nprg32CafSGKxD4BGuDBldzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833941; c=relaxed/simple;
	bh=Yy0ANttmeX1sBSYIrD8j9h47PWNMVq8YNlRoSPuKI5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1grXZ5zK8QT4UCCguHSyb0D7ayv7fLUpU3MTY6s3y9uTDnH8eVNhpjUwkCIXeDjkBmsedM+/A3tOWQiXRcyLQ2+X0DQWw55sSE4FXYEZW9faX0WY5tqNSxpDaKssQ4oZTZuCeBmv7wn9dmYSM20e57J/CL+B6GyajmdazH2tmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dUqfi1KV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-417db45fe01so2473235e9.1
        for <linux-spi@vger.kernel.org>; Thu, 11 Apr 2024 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712833938; x=1713438738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj2EQOGUHS27iVagcIuVOuSoestKYMmh2S4pLmLP8tc=;
        b=dUqfi1KV8/8+TOUYgxIDtJQamwbac0veGUYOo6Z8hhRh5Ql+QVdbJKCNibhlUdKPg2
         Dzez/myQYgFMs1Jez756mgTDb+pJrlBLmUAa+L4qJsJSXxzFY3fC5FCTdzvcmbXWDbIv
         TAtSfDKdrjwOgO7/70Qx2Gwe0M2VXwfOnB5bU5/uM50+VmHmoqeo5OZAJeDpg1B/K62C
         /nrqQ3JTeIT+mZRRFr78Df/EMS1JKjnoKgRPiS5g6fmHH682IAUZisgeS+kqW3nyMioJ
         o9WU3C/BPqcbPoYSn6yHjfq2qa2bHiceLEBRtyY9pxpsZowzdbefEMijDcWp8GmaACh+
         iVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712833938; x=1713438738;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cj2EQOGUHS27iVagcIuVOuSoestKYMmh2S4pLmLP8tc=;
        b=PvYWU+KVqjHSH9pRMjhXRqqGJ0cpWrqVp6pUsJ2QINocP61kWsy1isEeBvkR0nvQHH
         4Y77Rsd0m2N6f2PbcGIjwkwiHQOf+Y0lhAkGOmAwVkdKb6DBsOgT2CclcxEODMw92EMe
         unKzHxN/gWBNKvGqwiU+vGVx91xXx9T2UyB4hDIwBPdtcRCaVgpORKW5tz6NSiqx48m8
         faPVjZtUrQndweV3QOLRvd0je/PPjGE3aW7p+ErONvyyI3aNBKAo40NAq528SRhrVfhy
         pnYf8v5Kwcb1YYpCi2R7SVBOgx/gVD1SANMYHLwPE7oto3IB0rXhzGW4S0NXz+cBDjkf
         pxsw==
X-Forwarded-Encrypted: i=1; AJvYcCWMciQ56zEx4gdI4RsgyejdF/1kLJORh+s2yDvigOBPdNsYUMm2P0I0FInfxQlXl+6DJzCrc/VCTWJHDhrA8wVMdsDF9C8p7ZX2
X-Gm-Message-State: AOJu0YyWQ78yHpCtLbMzlZf5G5vYEfpZEtjPLrOO/2K9r8wrKTFzXq/F
	8gNqtFBrdGISe19E1eggw89Y2TdF++obxr+ymjdEIIIyLj52tHsAB4VX2/Bcz7Y=
X-Google-Smtp-Source: AGHT+IHhTVEz4dKuOPfTHjgbenp7uPEal1W1EGZf4p55WrjhvgXh5CxS7wzKplGLKDv+zE7hLCpnKA==
X-Received: by 2002:a05:600c:1992:b0:416:2a95:6e8b with SMTP id t18-20020a05600c199200b004162a956e8bmr3688444wmq.26.1712833937816;
        Thu, 11 Apr 2024 04:12:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c310700b00417e4add806sm641273wmo.7.2024.04.11.04.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 04:12:17 -0700 (PDT)
Message-ID: <19977d0e-ef31-42c0-aa4b-acd7e773c603@linaro.org>
Date: Thu, 11 Apr 2024 13:12:15 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: spi: airoha: Add YAML schema for SNFI
 controller
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-spi@vger.kernel.org
Cc: broonie@kernel.org, lorenzo.bianconi83@gmail.com,
 linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, nbd@nbd.name, john@phrozen.org, dd@embedd.com,
 catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com,
 angelogioacchino.delregno@collabora.com
References: <cover.1712833493.git.lorenzo@kernel.org>
 <bbc03f8d33c538b36e366e289861b90adbe64a37.1712833493.git.lorenzo@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <bbc03f8d33c538b36e366e289861b90adbe64a37.1712833493.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 13:08, Lorenzo Bianconi wrote:
> Introduce Airoha EN7581 SPI NAND controller binding
> 
> Tested-by: Rajeev Kumar <Rajeev.Kumar@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/spi/airoha,spi-airoha-snfi.yaml  | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/airoha,spi-airoha-snfi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/airoha,spi-airoha-snfi.yaml b/Documentation/devicetree/bindings/spi/airoha,spi-airoha-snfi.yaml
> new file mode 100644
> index 000000000000..0244f242eff1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/airoha,spi-airoha-snfi.yaml

Use compatible as filename.

> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/airoha,spi-airoha-snfi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI-NAND flash controller for Airoha ARM SoCs
> +
> +maintainers:
> +  - Lorenzo Bianconi <lorenzo@kernel.org>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: airoha,en7581-snand
> +
> +  reg:
> +    maxItems: 2

Instead list and describe items.

> +
> +  interrupts:
> +    maxItems: 1

This looks incomplete. No clocks? No other resources?

Best regards,
Krzysztof



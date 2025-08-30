Return-Path: <linux-spi+bounces-9825-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17560B3CE7B
	for <lists+linux-spi@lfdr.de>; Sat, 30 Aug 2025 20:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D99B1B25E37
	for <lists+linux-spi@lfdr.de>; Sat, 30 Aug 2025 18:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06FC2C237F;
	Sat, 30 Aug 2025 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d4kFHbRn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DB326F2A8
	for <linux-spi@vger.kernel.org>; Sat, 30 Aug 2025 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756576952; cv=none; b=kVagJ1Me2hqar5EV3YdYgoPtSpmgwFWFr5CtLvpf3tXjyypUVviDT3O61z5JhUYc+w6pur/h5JCmlGOgupnVlKvH7ihvshv14W277gf6To3fLGxK5ZxZorytArlD5Xjq9dQojZyAQGzANOdriZOWA++M9mekpL8Ts9xm7Yj+yUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756576952; c=relaxed/simple;
	bh=LL1hd9q8LJpTq1VIPJ6jPwhtJlsQGlDix5UjkykB4Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGbw4XAtwkiDWXoCRQznUUcJx3S/W3eESftz2L6Vrys5v/Y2ivA0lxyuZMs0MNhH4t8HkOyCGy6SXsz20Jic2npzM4rSfulx9STt3mIhX62Z3UscuTGdL6w9ZMXv3T72tZ7j2IQIRjaJhKVeQwfRZ1eWqJoJB3FiTifrrJ9BSpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d4kFHbRn; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-315a0b68314so2627889fac.0
        for <linux-spi@vger.kernel.org>; Sat, 30 Aug 2025 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756576950; x=1757181750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PD2EKFpAobF4U0TIuLMjpEcO1H/Nnyn+f8Dfu+DnkNI=;
        b=d4kFHbRnKQoKXBWL1zWyAwAs9XrZhybRacslpYsfOE/8svlNjSAa8Db/NCLXxiJRfA
         J2QD4/foHnDmHwjuCSsOjuJdbemw7PsoCS5Uu6HXPTYCRCgcgnVvheVSKQyQpip6/XBP
         MXz5Fm4B1McmU3Wff8PnTJzziO8LqKydzV6W7lgjTSLztkWWi8KoF8jJh5zTod8q8sIa
         wdfUEv0LJL8woK7iGwOs86dgFktN/7oUDsaxpR4w8skkPSaKoxIEI7ZTIEdD0ImcJ/2B
         NNHGtdWgXgCxV140u8AZQooK2BGzWxAuHzVH5fzMh7d38ELATTJP4PjnOCL/xLmLDsBH
         4Piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756576950; x=1757181750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PD2EKFpAobF4U0TIuLMjpEcO1H/Nnyn+f8Dfu+DnkNI=;
        b=VSyMuhte58mKeI9PfYUAEwAya6Dj/FSL4GJ9LWQWuevdoE2YNFAWE9XFOtCBTyCRDp
         GYwf1iXEw1Bgk9PYqU9FrpnRsIl7MCZ/s5rAhr/+3+ejPSRFAtuQPu62rjMi7D/11vk1
         0HoghdBAeUvuQlXYwztE4ccGisqu5ZR8qZPG86QWI6DyVyPByJg5n/GntjFxPe1y+0co
         cwN2AsPVc8FIKLCHlyhvoe12XoWvV1L5K4O0lZWnUb6gk4K8KTjpOxRqBn04++XZmcn4
         veixOqDClnAh2+eDQ2LIafphy9MYOBwLhKOAAB+T4iMZyTS5Z9u7/azbYBS+Y7gawcis
         XJPA==
X-Forwarded-Encrypted: i=1; AJvYcCVfY/2YEbzj756hUjCSinYa75CoYqgdAqbtgC8ncD+GeOzaXRDFAV5oA75W5qnpHKBCrfeENdB05HU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92vIVHVj65X+4iiMNfy2inVKf8qbp0cR8hP/a7ZfuFmIR73ik
	iM7O5UYfF3b6KQ9a/WMQ6r5Xcou7PeSXuWeWaOi+PBsgmnJCIGEZ28SjK/Uo0Ql6CfA=
X-Gm-Gg: ASbGncuLKWtyzhx16/dsjYwMkHkydXYSOZcxAs6Lj6DG0GGZOkHb9DX6eonwPCdcdyb
	IDRgBj2wMBcyPf5xKLqB/MVEaqe15taHxJZLZjwD3IiRvOQhbxq50KHJu2fJGsVNEXheaw7xgCk
	BNG/Zyinf1mHeA17QNxUjkXBMz6E0mM9ErpE449sdLv6Xt61bUShhaxCYBhZZ/Ztf+6Yf5nBA1x
	uk/jcnsoeWSaG7cZh0jDuwzVYGXifC+Qpw+XjrWhCvrm/sFb5b5VQHVkQqJo9ZFuww2m6B3zvDE
	LKkpxxcIo6jeo+fAqdiQdH87BpgDt+hcXbtBZG4CIxfkDn2hl/8kOD4j0dz0wnVwtzBVPlGYee/
	kfoQjWmO4AoCq0+9JmXskKVbX5ovvlnO1CI18f1fauVOxKT777vsrj+6/XKL3ajMyd+OzeA8t/i
	qHSNi1Fay7Hg==
X-Google-Smtp-Source: AGHT+IGSJvFvC9dcmKaGf9glwESPFKs7sboRW3GSWHC52Tz6jlzKsP6xrkD7Hc7UHEkT8qvw/3aY5Q==
X-Received: by 2002:a05:6870:c0d:b0:315:b768:bd23 with SMTP id 586e51a60fabf-319633c79a1mr1298016fac.34.1756576949951;
        Sat, 30 Aug 2025 11:02:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d? ([2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3196d2a7f3csm392769fac.8.2025.08.30.11.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 11:02:29 -0700 (PDT)
Message-ID: <033e8639-67db-4397-b8c1-d1b7774eb9fe@baylibre.com>
Date: Sat, 30 Aug 2025 13:02:28 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] dt-bindings: iio: adc: adi,ad4030: Add
 adi,clock-mode
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc: jic23@kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, corbet@lwn.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
 Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
 ahaslam@baylibre.com, sergiu.cuciurean@analog.com, marcelo.schmitt1@gmail.com
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
 <1acb071f7140c9d44ed616a9eaea00b0ee423164.1756511030.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <1acb071f7140c9d44ed616a9eaea00b0ee423164.1756511030.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 7:43 PM, Marcelo Schmitt wrote:
> AD4030 and similar designs support three different options for the clock
> that frames ADC output data. Each option implies a different hardware
> configuration for reading ADC data. Document AD4030 clock mode options.
> 
> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4030.yaml      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> index bee85087a7b2..1e4e025b835f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -78,6 +78,18 @@ properties:
>    interrupt-names:
>      const: busy
>  
> +  adi,clock-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ spi, echo, host ]
> +    default: spi
> +    description:
> +      Describes how the clock that frames ADC data output is setup.
> +      spi  - Spi-compatible. Normal SPI operation clocking.
> +      echo - Echo-clock. Synchronous clock echoing to ease timing requirements
> +             when using isolation on the digital interface.
> +      host - Host. The Host clock mode uses an internal oscillator to clock out
> +             the data bits. In this mode, the spi controller is not driving SCLK.
> +
>  required:
>    - compatible
>    - reg

I think this would make sense as a common property in spi-peripheral-props.yaml
as this is something that is not specific to just this ADC and also requires
a supporting SPI controller with the matching wiring.

I would also tweak the names and descriptions a bit to describe how it is wired
rather than how it is used.

  spi-sclk-source:
    enum: [ controller, echo, peripheral ]
    default: controller
    description: |
      Indicates how the SCLK is wired.
      controller: The SCLK line is driven by the controller (typical SPI bus).
      echo: The SCLK line is driven by the controller and the peripheral echos
        the clock back to an input on the controller on a second line.
      peripheral: The SCLK line from the controller is not connected to the
        peripheral and an independent clock output driven by the peripheral is
        connected to an input on the controller.




Return-Path: <linux-spi+bounces-3493-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3567490F742
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 21:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF37B21B79
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 19:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EA9158DDF;
	Wed, 19 Jun 2024 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dBLe2KBm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88768158DB4
	for <linux-spi@vger.kernel.org>; Wed, 19 Jun 2024 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827042; cv=none; b=cb6jiG00uycpzsX2kyzGs1JHZXM4YZ9Mrg47AJtzP7jtQomgeABre/ue32JMPt1Z/FZA/84rbtlTiw9bD8IAMHyFThew7STH9HELDHuSLcBjPwd0b1bJ9nLqVXymRPYrtW+AbB1/Z+RYrQ43sDsFh5k9DgvBJZmylLiiVsxjBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827042; c=relaxed/simple;
	bh=4me6X2bHfsq1TiQJ4WdBTA05DRCGGjpKMn1S9ccRekE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5VCpnUO219NCt23hXRODz/g1gjPIeBqla1ZbOwGOmdPiRHBn9P/r6dQb8QCTrQ2qpOlH3JbOx6jOnUZAk2uklE5isfxK+u5ySs5XqqyHU43x8h5aiMlVwHrBm6oc0C9WBV720mjmA3VYoIFCe8nMLEFr1t3/ei7w2Aq2KYxIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dBLe2KBm; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-254c8e27c80so131079fac.2
        for <linux-spi@vger.kernel.org>; Wed, 19 Jun 2024 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718827039; x=1719431839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9qBxHg+OHvtBgD9gIdkfXbSsKcI6es7NIjQNQHIQGM=;
        b=dBLe2KBmVV8Fk7ssT10EgEzn0AQuDxDNPQP9xZSZ2nTu08oeWwRKO+3iX5voQhOv8t
         NsueDkSkW0SvaRPDSjDcy+tVq3ckQdUc+/TStVAEdzkW0aZcLv90vOmpUYCy0WelTsYL
         kC0yZ8fVV5PjV6n09IHhJowenLQ5KPjSCl+gNMKyH4OittG2hRt0MexqKih4sSRUKjbS
         ffyw6kcNEWa5lfinQmTEFYhxJwJSUZ883T8t7/6L92ebhXMkb8y99MxNOllGtY5BJ04x
         VW72C/vOoYrJOAEQ9BnTfgMkN8So11Ae4Dn31d0g3qDcWj0/6BL/qm83vu7pOvW9j6kZ
         a9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718827039; x=1719431839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9qBxHg+OHvtBgD9gIdkfXbSsKcI6es7NIjQNQHIQGM=;
        b=dnIDSuTDip/rkkrJ/SnxW0a40j7Bs7efDRwH1fRU8yHmxHts3kLZPVeZ61Huoaaa9R
         5EW1wG9EcI6s+W2OXBBfNmfFJlGoq8tcg+qk6TTmRmGGSzPk+iY15ioWrSbGstPjilF3
         /Nl1iL0JMrI+kOowhp7R3SvWN+Ihn13/ySYx6aEAlBAI9BFxu5Z1MROP5FMpl1AXHGcT
         dZ+KFayPgn4w2sDe0waaOgHF8X6LqMhqs6Z2EJ6gGq96cFjKd60Fk/awzocxQJ+j7SWO
         8q+jgxOzb9jMHmjoduam7Mo2eYaVsY8HQGYNyDmiQjPZoTvDS/oV1OnRoiHfXNLQYe1s
         2htg==
X-Forwarded-Encrypted: i=1; AJvYcCUJUq0tV/YqbpisjC1E8qncdUv9fyv9q54+FJVLeoYR6fYGOm3gaHHC2jZmBst7Rsw1ohn8dDQbSUi7xle3348pRV70rhD4uBD4
X-Gm-Message-State: AOJu0YwvhD6KBFdix8J6mA+Q8A6HWNUuVh9vm6Da7UVEGtukCTXRjfYo
	wFXCpUQfL1nop29Hts25NIbt9/+9FONcAn58o2XKId9bDQoMthhDAp5cyClCmIc=
X-Google-Smtp-Source: AGHT+IFIUTihrHZD3I/z7TebG9AmH7Kc94UGPrYGOv57KU4OX/INgP1nt8tRMicOxEV5usreFEe6iQ==
X-Received: by 2002:a05:6870:e2d6:b0:254:affe:5a05 with SMTP id 586e51a60fabf-25c94990ab4mr4149008fac.21.1718827039594;
        Wed, 19 Jun 2024 12:57:19 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25983669238sm951101fac.33.2024.06.19.12.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 12:57:19 -0700 (PDT)
Message-ID: <8d6b39c8-a00c-4440-8451-70eac566c544@baylibre.com>
Date: Wed, 19 Jun 2024 14:57:18 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] dt-bindings: iio: adc: Add AD4000
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <34a16c6e513b32bc6111b695e1c8b467bd6993d9.1718749981.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <34a16c6e513b32bc6111b695e1c8b467bd6993d9.1718749981.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/24 6:12 PM, Marcelo Schmitt wrote:
> Add device tree documentation for AD4000 series of ADC devices.
> 
...

> +  adi,spi-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ single, chain ]
> +    description: |
> +      This property indicates the SPI wiring configuration.
> +
> +      When this property is omitted, it is assumed that the device is using what
> +      the datasheet calls "4-wire mode". This is the conventional SPI mode used
> +      when there are multiple devices on the same bus. In this mode, the CNV
> +      line is used to initiate the conversion and the SDI line is connected to
> +      CS on the SPI controller.
> +
> +      When this property is present, it indicates that the device is using one
> +      of the following alternative wiring configurations:
> +
> +      * single: The datasheet calls this "3-wire mode". (NOTE: The datasheet's
> +        definition of 3-wire mode is NOT at all related to the standard
> +        spi-3wire property!) This mode is often used when the ADC is the only
> +        device on the bus. In this mode, SDI is connected to MOSI or to VIO, and
> +        the CNV line can be connected to the CS line of the SPI controller or to
> +        a GPIO, in which case the CS line of the controller is unused.
> +      * chain: The datasheet calls this "chain mode". This mode is used to save
> +        on wiring when multiple ADCs are used. In this mode, the SDI line of
> +        one chip is tied to the SDO of the next chip in the chain and the SDI of
> +        the last chip in the chain is tied to GND. Only the first chip in the
> +        chain is connected to the SPI bus. The CNV line of all chips are tied
> +        together. The CS line of the SPI controller can be used as the CNV line
> +        only if it is active high.
> +

After reviewing the driver and going back and looking at the diagrams in [1] again,
I think we are missing a wiring mode here. What the driver is calling "single/3-wire"
mode is actually using 4 wires and is the wiring mode that I suggested should be
the default since that is the only wiring configuration where we can read/write
registers.

[1]: https://lore.kernel.org/linux-iio/87058695-a1a6-4e68-87c5-accdb8451bf4@baylibre.com/

So to recap, this is what I suggest we should do:

default unnamed mode:

  * Wiring:
      ADC    HOST
      ---    ----
      CNV    CS (or GPIO)
      SDI    SDO
      SDO    SDI
      SCLK   SCLK
  * Requires SPI controller with SPI_MOSI_IDLE_HIGH/LOW capability
  * Can read/write registers
  * Can do "3-wire mode"-style reads (turbo and not turbo)
    * Requires SPI_MOSI_IDLE_HIGH
  * Can do "4-wire mode"-style reads (turbo and not turbo)
    * Requires SPI_MOSI_IDLE_HIGH, SPI_CS_HIGH (or no CS and cnv-gpios)
  * Can do "daisy-chain mode"-style reads
    * Requires SPI_MOSI_IDLE_LOW, SPI_CS_HIGH (or no CS and cnv-gpios)
  * #daisy-chained-devices is optional

"single" mode:

  * Wiring: same as default except ADC SDI is hard-wired to logic high.
  * Cannot read/write registers.
  * Doesn't require special SPI controller (no SPI_MOSI_IDLE_HIGH/LOW)
  * Can do "3-wire mode"-style reads (turbo and not turbo)
  * #daisy-chained-devices is forbidden
  * Use case: save one wire, works with any SPI controller

"multi" mode:

  * Wiring:
      ADC    HOST
      ---    ----
      CNV    GPIO
      SDI    CSn
      SDO    SDI
      SCLK   SCLK

  * Cannot read/write registers.
  * Doesn't require special SPI controller (no SPI_MOSI_IDLE_HIGH/LOW)
  * Can do "4-wire mode"-style reads (not turbo)
  * #daisy-chained-devices is forbidden
  * Use case: multiple ADCs can share one CNV trigger

"chain" mode:

  * Wiring: same as default except ADC SDI is hard-wired to logic low.
  * Cannot read/write registers.
  * Doesn't require special SPI controller (no SPI_MOSI_IDLE_HIGH/LOW)
  * Can do "daisy-chain mode"-style reads (requires CS high or cnv-gpios)
  * #daisy-chained-devices is required
  * Use case: save one wire, works with any SPI controller

---

To put it more simply in the bindings though, really this property
is just describing how the SDI pin is wired. (CNV pin wiring can be
inferred from this property and presence or absence of cnv-gpios
property.) So maybe better would be:

  adi,sdi-pin:
    $ref: /schemas/types.yaml#/definitions/string
    enum: [ high, low, cs ]
    description:
       Describes how the ADC SDI pin is wired. When this property is
       omitted, ADC SDI is connected to host SDO. "high" indicates
       that the ADC SDI pin is hard-wired to logic high (VIO).
       "low" indicates that it is hard-wired low (GND). "cs" indicates
       that the ADC SDI pin is connected to the host CS line.

And put a note about the specialized SPI controller requirements in
the main description.



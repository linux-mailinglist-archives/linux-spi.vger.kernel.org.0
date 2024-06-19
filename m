Return-Path: <linux-spi+bounces-3473-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7CD90EF6C
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56C7284809
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F65814EC52;
	Wed, 19 Jun 2024 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r/vg1dgr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49614EC4B
	for <linux-spi@vger.kernel.org>; Wed, 19 Jun 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805187; cv=none; b=FfX695yX0CRVnwYgR6MsImFCjyZFj87A7YG9FK9bBdB9hAur3Zh4jja0p7tgE5Rrdbs5DIb7NbOjwuf+2ZCQjtmqjKR9NBg0c+qafpheCoxJZc+iI+AgI7ng4e2e0J0M7TFFyU5R7srA4tpCIqAWcQRZlYabmF1If/YNGmE2o5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805187; c=relaxed/simple;
	bh=hXZM0ZRAqWw64hED68y432f7teoD9ysU+xVFowFrBys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMe7h0E+5e2yOvjqlEica8dhVMykd0XJK/BvZEcLSzV/tqOn7KzgmAoONUJEqCJ65OnJPKXXcwxL8X1jjL+modJSbC+wvgTf0UDIuuAPQVAb+EymAis9w7qTzz3DLEcH5e7iK0q3kDAs28vDqBt5wWiDciKMBTIUZCdnpdv5hRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r/vg1dgr; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b53bb4bebaso3696631eaf.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Jun 2024 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718805184; x=1719409984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/DxaRrf1DfxK2TMVGchQMx4rAQwHFrz6/0aYbhqkBw=;
        b=r/vg1dgrHMvcEDaVUf0WYrBibLQFu9VsIVggPdc0iREpCJ1bTjk7WmOZhJEBCl/MVj
         SaEZ5q7EXld1BJ2dZPmOh6NsvHFVpsKKmMCwztehWokkFyjxWwB4T0JsPkah7LGrOcZs
         3AJvERNjAYmUCb/0+jdhxYG61KIhXvUm9d80l6m9eutIQeLmyNppQEWezodC6glyHzXb
         A3/n9APDsRfme/LUYqb9lUqKSWUYguTxFEoqIzaf78wrWAQiDUEKqsQcfT+dkpdZd/vq
         tmCQ3OqHRW2rmOXJSWWp8JH3SxkFsIqhNbxPyh+3jrxpCvYuMpY11+ovRCsRJuC/3WxM
         7O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805184; x=1719409984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/DxaRrf1DfxK2TMVGchQMx4rAQwHFrz6/0aYbhqkBw=;
        b=ZmZQM0al6PACRReIubhtYBisIO1yM5vRiOX9yOftP3U26vh96tidf+iiy4IuZoB2rC
         hGBpknZqnFRJAj9Y0pzqAj8ThLzFEFC56P1J8j9qXd8rVXUKSW6aTftqZKBXSfGJIrc8
         sq9va5myHNHUEM6tDdpSW6uX/cb8o180PA6PA6nfYooW8yrczRcbsJSOkEdGkUzHRq/s
         aXREKwHPNM1EfrCLAT+WTG6+OQ6mTNqabXVDmTz5Lsl+F1uV+jxxhxYCA8eKbuZ7YReQ
         RYS6E++MFrZUyHpw358d9SZEuUt5E9rRcd56vLPeCmkrrgDBZxCvRPvS0I35lMIxoWFd
         7qMg==
X-Forwarded-Encrypted: i=1; AJvYcCVzYsF0PY0viIJtPmjNODgeaDABZhY1IMonsR4TnHQexjtiUP66l4pttZfHGVN9DVGMPHdqyxbjA5ZO+KIVFqqoRWpVFN5GWQY2
X-Gm-Message-State: AOJu0YxsLKLG18eV0Dp8XKfJnzrtNlaY+pzEaxnnE+67tsk20V6i99BH
	Yk442ooojCsM4rvsGiBfli2eNykmRltm4Q60k7uDhtx7r6fbirQ7fqmlP/bsGo4=
X-Google-Smtp-Source: AGHT+IE6aa6F+4fqR2UHEN9ZwoJVg6KP3q4hH063265F+qTx8Gds/RAgDY8KqMLZZvdKYJvEXz5kdA==
X-Received: by 2002:a4a:9211:0:b0:5b9:f2f4:6a95 with SMTP id 006d021491bc7-5c1adbeab72mr3002704eaf.5.1718805184158;
        Wed, 19 Jun 2024 06:53:04 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd5de6a238sm1619968eaf.5.2024.06.19.06.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 06:53:03 -0700 (PDT)
Message-ID: <63db9349-f453-4a5b-aa09-d1857ddd8b03@baylibre.com>
Date: Wed, 19 Jun 2024 08:53:02 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] spi: Enable controllers to extend the SPI protocol
 with MOSI idle configuration
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/18/24 6:10 PM, Marcelo Schmitt wrote:


> +
> +MOSI idle state configuration
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Common SPI protocol implementations don't specify any state or behavior for the
> +MOSI line when the controller is not clocking out data. However, there do exist
> +peripherals that require specific MOSI line state when data is not being clocked
> +out. For example, if the peripheral expects the MOSI line to be high when the
> +controller is not clocking out data (SPI_MOSI_IDLE_HIGH), then a transfer in SPI
> +mode 0 would look like the following:
> +
> +::
> +
> +  nCSx ___                                                                   ___
> +          \_________________________________________________________________/
> +          •                                                                 •
> +          •                                                                 •
> +  SCLK         ___     ___     ___     ___     ___     ___     ___     ___
> +       _______/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \_____
> +          •   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ; •
> +          •   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ; •
> +  MOSI _____         _______         _______         _______________         ___
> +  0x56      \_0_____/ 1     \_0_____/ 1     \_0_____/ 1       1     \_0_____/
> +          •       ;       ;       ;       ;       ;       ;       ;       ; •
> +          •       ;       ;       ;       ;       ;       ;       ;       ; •
> +  MISO XXX__________         _______________________          _______        XXX
> +  0xBA XXX__/     1 \_____0_/     1       1       1 \_____0__/    1  \____0__XXX
> +
> +Legend::
> +
> +  • marks the start/end of transmission;
> +  : marks when data is clocked into the peripheral;
> +  ; marks when data is clocked into the controller;
> +  X marks when line states are not specified.
> +
> +In this extension to the usual SPI protocol, the MOSI line state is specified to
> +be kept high when CS is active but the controller is not clocking out data to

I think it would be less ambiguous to say "asserted" instead of "active".

> +the peripheral and also when CS is inactive.

As I mentioned in a previous review, I think the key detail here is that the
MOSI line has to be in the required state during the CS line assertion
(falling edge). I didn't really get that from the current wording. The current
wording makes it sound like MOSI needs to be high indefinitely longer.

> +
> +Peripherals that require this extension must request it by setting the
> +SPI_MOSI_IDLE_HIGH bit into the mode attribute of their struct spi_device and

Could use inline code formatting for C code bits, e.g. ``struct spi_device``
``SPI_MOSI_IDLE_HIGH``, etc.

> +call spi_setup(). Controllers that support this extension should indicate it by> +setting SPI_MOSI_IDLE_HIGH in the mode_bits attribute of their struct
> +spi_controller. The configuration to idle MOSI low is analogous but uses the
> +SPI_MOSI_IDLE_LOW mode bit.
> +
> +
>  THANKS TO
>  ---------
>  Contributors to Linux-SPI discussions include (in alphabetical order,

...

> index e8e1e798924f..8e50a8559225 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -599,6 +599,12 @@ struct spi_controller {
>  	 * assert/de-assert more than one chip select at once.
>  	 */
>  #define SPI_CONTROLLER_MULTI_CS		BIT(7)
> +	/*
> +	 * The spi-controller is capable of keeping the MOSI line low or high
> +	 * when not clocking out data.
> +	 */
> +#define SPI_CONTROLLER_MOSI_IDLE_LOW    BIT(8)  /* Can idle MOSI low */
> +#define SPI_CONTROLLER_MOSI_IDLE_HIGH   BIT(9)  /* Can idle MOSI high */

I don't see where these are used anywhere else in the series. They
seem redundant with SPI_MOSI_IDLE_LOW and SPI_MOSI_IDLE_HIGH.

>  
>  	/* Flag indicating if the allocation of this struct is devres-managed */
>  	bool			devm_allocated;
> diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
> index ca56e477d161..ee4ac812b8f8 100644
> --- a/include/uapi/linux/spi/spi.h
> +++ b/include/uapi/linux/spi/spi.h
> @@ -28,7 +28,8 @@
>  #define	SPI_RX_OCTAL		_BITUL(14)	/* receive with 8 wires */
>  #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
>  #define	SPI_RX_CPHA_FLIP	_BITUL(16)	/* flip CPHA on Rx only xfer */
> -#define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave mosi line low when idle */
> +#define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave MOSI line low when idle */
> +#define SPI_MOSI_IDLE_HIGH	_BITUL(18)	/* leave MOSI line high when idle */
>  
>  /*
>   * All the bits defined above should be covered by SPI_MODE_USER_MASK.
> @@ -38,6 +39,6 @@
>   * These bits must not overlap. A static assert check should make sure of that.
>   * If adding extra bits, make sure to increase the bit index below as well.
>   */
> -#define SPI_MODE_USER_MASK	(_BITUL(18) - 1)
> +#define SPI_MODE_USER_MASK	(_BITUL(19) - 1)
>  
>  #endif /* _UAPI_SPI_H */



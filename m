Return-Path: <linux-spi+bounces-10151-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E98B86C3E
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 21:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9726D165151
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 19:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63CE2E370C;
	Thu, 18 Sep 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eva9AvEv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC52224B09
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225050; cv=none; b=erlmBHOY3CpFq0QLHfixnqt6WJaNbx6wvS2zZkdM7M5VFbBdzVYcqD1d6v0bFqUGdsRX/bkHhpOsgj8mKvx8sQH1ALQQUUlg1NFT9uX9V2PslgbhnOzg3vsEVan3MShg8qHuW+PzetuifYivJaAKwfc3z3Op77N0Yq7lLts7gJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225050; c=relaxed/simple;
	bh=HHO9BAc/GcPnikXW7sVULetVQkeYVPNZhR0BOkGedsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiAl/1cecRNaRUIvNr+F3rWTVJoS4VYEx8yHEDfCTs3F/erQRWM6yelQYRBSj335JHH54Y4LWja9NQ/N711BfKyeYGAR1DRBt3zyHh8GP2jkpEEazFKfmlplSf9soPml6+BgvOoPCfn7Mkr0A6KvuPCN4NVEifqC4ozwK3tBwjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eva9AvEv; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3326d9ee5edso990851fac.3
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758225047; x=1758829847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/njUCFRX0+Zez5Vbxzl7crkS7bqMoDfnLtzR1RdZo4=;
        b=eva9AvEvBIFnQI8mWist/SQpcXqkGSpmqlwiCGWUgrvC4NXsjyvmI+ZFzEMNAUwTq9
         Xlur5BY5bjZtazgcym+P40KEYcEJrtZ23S4os3mJ8rWiWYu4w8w1vqd9pPBO0is9vmzj
         5j7ck9vwCdwU0u1QaBk/dxCCTxPtxcbJI+lLlXeikpwczgj0KpWDOSt2+XoNZky0i/Br
         aDj81b7GQbsHgW4QUu3E4q5Hwlr7bv2v7DR+nYMAD624yPFgyCie/t4/iq0qH1JS1X4q
         FdJo4bh1TnEa+PShp5gj9DHaMnrcrARpaOIZ7MnhmpJ1QwUH9ta6VQMK6jSJppOks/5q
         hQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225047; x=1758829847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/njUCFRX0+Zez5Vbxzl7crkS7bqMoDfnLtzR1RdZo4=;
        b=fSvPFvlIMhuDBee6DYYHlwAZVygjAceZD/nJYk7/P58LzcSGb6CyKlp7X7g9tBSE2s
         PfSdzWyen8MYkka6SNa20piESouEy5JFfWmDkt6M6HSgXX3m2rzR2I66nCxoKEgJmXFp
         uIS3syNq149VZPWNuIuJAa93KFQ1gwdVWFanKGlbjL+DS8YdgECcka2FCiVKEg77k2aj
         1H9BdiaFOVpqkH/Y4d+DsaVvx3GWdBOFV5bZuZE2L4qT9acIsEc1ukK6tKg/6lB0T/QH
         V5QsV6xYtVwumWoiXhdeOBWSgCLnsjcLOyt35B/lIQP9LAQC38kk1JgXLBpA8KtlK+ze
         T6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFjLovv7ZMybD6AtRXan5tqELxFGiKGQkL1CWAqJVOd70EExNUhpMPZZbPuZE6fW+3vmAK624GxwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykUhV+CU5kaVSHaqC7tsJHq7W/48/FGOW4VfZsAWOxUD+oS/BS
	KTu7r0eOj33dEPTCgiXuHd82GW8PFH1jZ1NY7bb5fsgCDDmOq0iWIoLr4bV1j+1F5Es=
X-Gm-Gg: ASbGnctj6HNMB8uV5HEmASjG9StpBNtNery9nSrk9Gpgb0vlwSazP5nMH+2x0Yhi0Fm
	3NuP14IPRvqB0JrwAu+PbfkHjAuzi+Q48Vef+LAR43MsBH39eEg4BQSIgyZU+ZLrqR2SXlicULK
	Thq7vOnow6CGoQRCBEgwG2nLQupw4wRaJXNjcJHoKzYNJCaeaHMLcPbOtRsrpjGoSkh8dU/p5dW
	SNi6vF7khidk7BnvDB5eIC9U7i3teT+zY6apDNhYpGrzB25tpl/HagEu4o1u6hh5qP4dLyZE/HF
	UE+CcbV/EpZqVd+VMOqlK+Qh6EOLPLlRdsDw1Zvq+VChZivpNDnoNSsfHwv14ysn8Oj/D0DgCrL
	JKOgbkUP3kd/zo39nShR8QbdFD0hsepOf5wDOB8AYGhDfeoMfccf+oysxh+/WcQlhUhGuDfAvXe
	BO2unkPUur3NPutFbq3bE1R4kIPn5F
X-Google-Smtp-Source: AGHT+IEHVxGf2yhLB3b35LtxkKozvBgxsFWLkSjfMAnEfJuFnLKkmmbeQcAg1qXyYA+/yqoKPs96RA==
X-Received: by 2002:a05:6870:9f81:b0:315:bb13:5709 with SMTP id 586e51a60fabf-33bb4965597mr508926fac.47.1758225046732;
        Thu, 18 Sep 2025 12:50:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e5a2ab2esm1789178fac.17.2025.09.18.12.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:50:46 -0700 (PDT)
Message-ID: <62989891-e166-419b-b6ab-cf1eca781b32@baylibre.com>
Date: Thu, 18 Sep 2025 14:50:45 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] Documentation: iio: ad4030: Add double PWM SPI
 offload doc
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <4f3b1c516f8148e0b7e1c430bb184a2db12ade3c.1758214628.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <4f3b1c516f8148e0b7e1c430bb184a2db12ade3c.1758214628.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Could use docs: instead of Documentation: in the subject to
make it a bit shorter. Seems common enough.

On 9/18/25 12:38 PM, Marcelo Schmitt wrote:
> Document double PWM setup SPI offload wiring schema.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v1 -> v2
> - Swapped PWM numbering.
> - Expanded double PWM description and capture zone description.
> 
>  Documentation/iio/ad4030.rst | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/iio/ad4030.rst b/Documentation/iio/ad4030.rst
> index b57424b650a8..9501d3fee9bb 100644
> --- a/Documentation/iio/ad4030.rst
> +++ b/Documentation/iio/ad4030.rst
> @@ -92,6 +92,41 @@ Interleaved mode
>  In this mode, both channels conversion results are bit interleaved one SDO line.
>  As such the wiring is the same as `One lane mode`_.
>  
> +SPI offload wiring
> +^^^^^^^^^^^^^^^^^^
> +
> +.. code-block::
> +
> +    +-------------+         +-------------+
> +    |         CNV |<-----+--| GPIO        |
> +    |             |      +--| PWM0        |
> +    |             |         |             |
> +    |             |      +--| PWM1        |
> +    |             |      |  +-------------+
> +    |             |      +->| TRIGGER     |
> +    |          CS |<--------| CS          |
> +    |             |         |             |
> +    |     ADC     |         |     SPI     |
> +    |             |         |             |
> +    |         SDI |<--------| SDO         |
> +    |         SDO |-------->| SDI         |
> +    |        SCLK |<--------| SCLK        |
> +    +-------------+         +-------------+
> +
> +In this mode, both the ``cnv-gpios`` and a ``pwms`` properties are required.
> +The ``pwms`` property specifies the PWM that is connected to the ADC CNV pin.
> +The SPI offload will have a ``trigger-sources`` property to indicate the SPI
> +offload (PWM) trigger source. For AD4030 and similar ADCs, there are two
> +possible data transfer zones for sample N. One of them (zone 1) starts after the
> +data conversion for sample N is complete while the other one (zone 2) starts 9.8
> +nanoseconds after the rising edge of CNV for sample N + 1.
> +
> +The configuration depicted in the above ASCII art is intended to perform data

Could say "diagram" instead of "ASCII art" if you want to be more formal.

> +transfer in zone 2. To achieve high sample rates while meeting ADC timing
> +requirements, an offset is added between the rising edges of PWM0 and PWM1 to
> +delay the SPI transfer until 9.8 nanoseconds after CNV rising edge. This
> +requires a specialized PWM controller that can provide such an offset.
> +

Could add a link to the HDL project as an example of such hardware.

>  SPI Clock mode
>  --------------
>  

Good enough as it is.

Reviewed-by: David Lechner <dlechner@baylibre.com>


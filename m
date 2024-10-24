Return-Path: <linux-spi+bounces-5370-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEABB9AE94B
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 16:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE82FB25661
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906961E378A;
	Thu, 24 Oct 2024 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yvW2F9zO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604531E2009
	for <linux-spi@vger.kernel.org>; Thu, 24 Oct 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781392; cv=none; b=DZlbInAAAnnoSfXq7sdg2wLeBhDuyFD3S1dVFWwrTBbLJaskLF2U22jwvtNILtvu/0jqG4M2PR29S/96URwYOKOgfmMxn1OIC60y3ANsjMPQoWuA4C5pCxayTNnWWrAFteCIcIa2Etbb3HHKUGXlCLQZ6aj96so7rScbUnobuxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781392; c=relaxed/simple;
	bh=gVUPvv/FnmRY7foM5Tyh9ireuXWq1boSSJ5EWGM8bO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAmPnm1ycFN4DDIdX72PmeA7Xix4NDeG/zrHGVX0KBwfg+SsLmSsdvrPI4xBY5pBr7Ht5Y9nQ4nVBSkb+kTMOQJuR9nU/aTCkZLOJp4AcYYGxQcxrgpyPdSM5uudxld/8w03w9jKcdrB9zsNminBl+Oe2eXXhQGnWd5FHdPlqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yvW2F9zO; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71809fe188cso635870a34.0
        for <linux-spi@vger.kernel.org>; Thu, 24 Oct 2024 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729781389; x=1730386189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v94UAHAt0z/GlIRWzSb/aqpgf9U8SvwT3lelP7L/T8M=;
        b=yvW2F9zOr9Sf1sqnEkbgC6EXZYUktEdcgHjquzA3w5nctGrXXS0YQQlvpTagDF70fE
         u1IIvlJ4/CF0wns8G2I6AXN4b0+3DjGS4dpi7mvqZCC0SMee11i3rw67CS7WZFxbQ9Mf
         csHS54c0thr3Pu821cyVYf9sDbUhwqz/q2v3BO/c9fcntGxAyJdqTNhbvYN3LGjIVfI4
         buUXWu10WB3BgOtaIzMZCKjy7q68IEDt7I4zCQSCCvQP0k6uvp8utPAUP88H2D9xuiFQ
         MURyC7IA3tRb+znUcPR90uXzIu3pCgry+mZrihIxWntVpqLmXHcLIg8QMsCg7RFXO29m
         N3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729781389; x=1730386189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v94UAHAt0z/GlIRWzSb/aqpgf9U8SvwT3lelP7L/T8M=;
        b=hOES0xPfSA7iwSe+SSy7vwXrsM7oeeLKGQr3+qhJLi0DdQQTo5a7FAMizCbOmNXz9a
         k9xsYazOzG1hpO8c3PThOPKS8iF/tWOnwHqatFxDE/3LoJ2i0c5FcYgOuHLEpJDfHF0J
         KSh1Nro6wesjKeHytuDv9TlQmcWTKlFqtGxl9fbLIHTfofrLxY/g6YlZKbJPlPnUNwz5
         jkZyvYlg2DvZqcJeSV2a6ahmSeij/3AU4YcaIJkgXA+/fXQFJAixtOP3QAexlCLPM46/
         y5OBShYIckFCWaN3bIUlgLfRr8E1ITgFHVrRJOrwyx/Ps2U1XBvelXDN7ba+e8JO+Us3
         4vVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2C/sSigzhijMdpHS0ptQ0Vt4uX61R4WLyDvQo8yt/dSWRQ0bSlR06mCIVxR7bOHmmNy859NB3ExA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+mu71gJgrBHPf+boSuUK4PdfAMHYpQVTe6XBhGO5BkczdVAl
	nSykzjDmewfiOIL6QULTEyY8gkGRCD57JRTOQTR7Gjs490fKh18Cd4psUq165i8=
X-Google-Smtp-Source: AGHT+IFSOJa5tZQDfiyvifYRt2spOoqw/LKgbaZOjiDrgieDP9qwmB+SmfLhxczWOx70km6r217TWg==
X-Received: by 2002:a05:6830:2113:b0:718:8eb:531a with SMTP id 46e09a7af769-7184b29606dmr6867406a34.4.1729781389223;
        Thu, 24 Oct 2024 07:49:49 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7182ec025cdsm2152200a34.68.2024.10.24.07.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:49:47 -0700 (PDT)
Message-ID: <7782352b-b8b3-4f2c-8a6a-b92dab8cb1b6@baylibre.com>
Date: Thu, 24 Oct 2024 09:49:46 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 02/15] spi: add basic support for SPI offloading
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-2-f8125b99f5a1@baylibre.com>
 <ba3eed090e29deda797b0dea8162949c82743ccf.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ba3eed090e29deda797b0dea8162949c82743ccf.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/24/24 8:27 AM, Nuno Sá wrote:
> On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
>> Add the basic infrastructure to support SPI offload providers and
>> consumers.
>>

...

>> +struct spi_offload *devm_spi_offload_get(struct device *dev,
>> +					 struct spi_device *spi,
>> +					 const struct spi_offload_config *config)
>> +{
>> +	struct spi_offload *offload;
>> +	int ret;
>> +
>> +	if (!spi || !config)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (!spi->controller->get_offload)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	offload = spi->controller->get_offload(spi, config);
>> +	if (IS_ERR(offload))
>> +		return offload;
>> +
>> +	if (offload->spi)
>> +		return ERR_PTR(-EBUSY);
>> +
>> +	offload->spi = spi;
>> +	get_device(offload->provider_dev);
> 
> Isn't this redundant? From what I can tell, we're assuming that the spi controller
> (of the spi device) is the offload provider. Therefore, getting an extra reference
> for it does not really seems necessary. The device cannot go away without under the
> spi_device feet. If that could happen, then we would also need to take care about
> callback access and things like that. Going this way, it would also be arguable to
> have a try_module_get().
> 
> - Nuno Sá
> 
> 

Yes, you are right that we don't really need to take a reference to the device.
This was left over from when I made an implementation that assumed the offload
provider could be anything, not just a SPI controller.


Return-Path: <linux-spi+bounces-11173-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC00C53980
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 18:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A969507EF1
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 16:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394103431FA;
	Wed, 12 Nov 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jO46oGgS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221A2080C1
	for <linux-spi@vger.kernel.org>; Wed, 12 Nov 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966361; cv=none; b=UAP4z/Upb8Od1nsrV/DyBWh46j8uvJLMGiJp2H7UCPx3jTVJY3p6mh3PGywn/qVIlpE0GdBdkp7oaGh1NxPm9ui0gyE0vDlpk3yASUciT+AzRKg7X2cyjaua5ILuTiecBz4Racrr6EEod0mdNDN2c5Uz98ncLktx/F183D8aYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966361; c=relaxed/simple;
	bh=vquyA6U0yVLVU87ffFxSvxSxY4DbgBQ5yYCH68Wc3l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmFq1QHBplCSd1qLuZS5WNbmE+gEGJl2e8dypp55LTAZecKeRA+eafXX+4G5n1kNZa+EqpYsOPMUFpZGZ0YuPytuktswkjPWoirxdKxWpFVWmTEE0LzCh2i6fW0Y2t3ocWkM+56lPqbF5siO5HAYCApi1JfiLlIIzM078lrcFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jO46oGgS; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c704bf2d9eso485905a34.0
        for <linux-spi@vger.kernel.org>; Wed, 12 Nov 2025 08:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762966356; x=1763571156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otKN6HaBW7TeFZXmhol1N0rafttZcw0ehXIldHQZRQU=;
        b=jO46oGgS/vM3MXXYczpi4QHmtXP4ZJ6G9q+Sfnq2whfaApDS5crM9wQfMGl7pYGSSF
         kS5DX/Ko2AXyYeJ1cwm2qjGLv6RlMafrr5J1cXTVxvacrsR6SW2gT6knsOQdYZAO6zSY
         d9Cgmf99MFjOpBDPnWQ8BW8GwOun1+B8s7WWmDVNjto8kTwxkkntu4+H/CsBP0F/arPK
         2Ry3hfnAzVIGT8YeflrPx+6zEc3djCRx3Vonriz2hNiJKY9YXrPjki+5youDgXgRqU+L
         twTzmcbLFregOVEXAm2a6AA1Vr0EaauKeBWqhA9Z1OTTlndzLeM2pdXl5x8Hz8/KaHQC
         9JdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966356; x=1763571156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otKN6HaBW7TeFZXmhol1N0rafttZcw0ehXIldHQZRQU=;
        b=GD4TvmAVBoCXdWZfpY+Nff9dAsx716v+04rebiOlxwPMkjuPmxbCCr0mGbUe6g9el7
         o3NiyEVTDgRH5AKqVqNp3UWZqupOZuga+00Bqu9DMNjSMkid7UUCrmGZq5WjE6hZ2XXP
         A24HivVLVFh1w7/b+P00BOPH5H4FQr7tdGC2cMFz1RE0Aro7WCkLD+eBbszGdUqJ5NBn
         45oQedMbN3o3jv5z59PylDUbShMLr4KS2a3glCMYNpGXXjiUP9Wc/z1CkRohiLkRCQp1
         PTR4rHNAB+bYwlfUQpOZ7P3GuZNLzPRfte32aqlkvw5QP96x/c4GHSLOJEJD/8m65BG0
         4sJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8kaTwMtNdRcC/Fvpe3g4bPxurzUl/Z6JbUVnFmHJDZOIq96HaKDfiEJUq3AXj/ctuW9FavNLh4E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKDADjD1p0378juKJBiQcgO1cyLNbB7orKKjTSC3udhAo93ugQ
	pwlHZq4wDGsq19EYmHVlfgr4ye0T/MPZsIFIl7bIba7UcNGPkxYFn3749sUKnPdamx0=
X-Gm-Gg: ASbGncvSWHr5lfY9/nQsLQ/xtcoN5H/TnQG/diC4+HETHxLaXc3hsyyp9KU08UKDDy7
	mmaD6vBBDi10ugNwYcSs2al3O0qOa6dOX9D8yuVM5xyUEn4s3UcHTV9CdmZdCecAWRuGR/dfkG8
	Ql2OHaUOk+QiT22h1Fa2NzKVdLazVG5C1zfytWr8/QtTiYDHEjvk9jFeHfJaBi4GE2V/zxHtycv
	sT5iYyEBkf02Ikn1g8GlRGe6NY6yxlBsBi+4fgdOY5AUbQ6H0aUqpU6axpcA8NZST/RXt0sFEy7
	juPJ66EzPIjMQOJG+yI+6BvdBv8LWtHJY5idNJ/8Nto6qOVyJlU4hAAlwEdkYyMw3ElovqI/ub6
	jBGyKMDrGsu89wewkFony10bqBhPbvYHg0+iqCtsSlzyXAdoXRS530iLFk8BEw8sAYpPMqY6daQ
	2dNcnhSDMKt0BdEnb0nMzNre/ToHiBW8u1E2/r348NZjyVz9Xb0g==
X-Google-Smtp-Source: AGHT+IEzlLhnjrljziZsPJD+6TFphu87RW7odVOmHqBJgKS1HNWc+2CO5ak3CF5B+KTraiO0uH2Sxw==
X-Received: by 2002:a05:6808:1b07:b0:450:3c49:519 with SMTP id 5614622812f47-450743f38afmr1702472b6e.7.1762966355944;
        Wed, 12 Nov 2025 08:52:35 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d404:301b:b985:c499? ([2600:8803:e7e4:500:d404:301b:b985:c499])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57ec231sm8495588eaf.17.2025.11.12.08.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:52:35 -0800 (PST)
Message-ID: <b18db31d-47e5-44bb-a671-c8d8a9f2cd82@baylibre.com>
Date: Wed, 12 Nov 2025 10:52:34 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: spi: Add spi-buses property
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-1-2098c12d6f5f@baylibre.com>
 <20251021142129.GA34073-robh@kernel.org>
 <14ae0769-341b-4325-b925-7bba6d57bbdf@baylibre.com>
 <20251030135126.GA3749313-robh@kernel.org>
 <f731ebd7-6494-45f5-861d-05a2926cc5fa@baylibre.com>
 <aRIbBVNzo-7EYJbl@finisterre.sirena.org.uk>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aRIbBVNzo-7EYJbl@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/25 11:04 AM, Mark Brown wrote:
> On Thu, Oct 30, 2025 at 05:42:44PM -0500, David Lechner wrote:
>> On 10/30/25 8:51 AM, Rob Herring wrote:
> 
>>> But it can't really be 2 independent buses/controllers unless the ADC 
>>> has 2 completely independent interfaces, right?
> 
>> Correct.
> 
>> The proposed property really only concerns the data lines (tx/rx). It doesn't
>> care if there is 1 or 2 SCLK lines and it doesn't care if there is only 1 CS
>> line.
> 
>> So maybe spi-data-buses would be a better name for the property? Or
>> spi-data-ports (using the NXP FlexSPI controller docs terminology)?
>> Or spi-data-channels?
> 
> This bindings discussion seems to have stalled out?

Yes, it seems so. I sent a v2 with with the property changed to "spi-data-buses"
in hopes that that it would be good enough, or if not, get the conversation going
again. [1]

[1]: https://lore.kernel.org/linux-iio/20251107-spi-add-multi-bus-support-v2-1-8a92693314d9@baylibre.com/





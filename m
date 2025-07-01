Return-Path: <linux-spi+bounces-8961-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D6FAF0533
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 22:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A05D4E3799
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 20:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CF530204A;
	Tue,  1 Jul 2025 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gZ0sF+XM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539CF28B3FD
	for <linux-spi@vger.kernel.org>; Tue,  1 Jul 2025 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751403447; cv=none; b=sVCYYD7RA+8rf34B1goB91u2kXwmDY0P6/q/9PXSEg1Ig9Dj1f7OUCUWwDg+W8xwnuC6jnhmI2b/pFKBnxofdIpmkwc8N+omdw3qp1HvmojR0qxxkJlSnzevxxsUpW5N7Zc2fqgb1NAi86I1nsHp0Q0JQRLwY78H193P2M/RwFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751403447; c=relaxed/simple;
	bh=TJykQ/gRq/gf10TIynCQbjQP1Ab2MiEGTp6/NL4ri1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbRU3T/fCV6M2s2gNqaT9xF18EjFtXPAEDSvYRReTeQdtZEiOzXOZZqSVEaxW3SyEm9x606YRXrjXOBT8ki6swMQULYhZ38Xgorfacow1hNlDv8VxKxoWL31RvoXQ4gPLE/K3NhiD4fWN1bEnFz7MAOXMSuIt4aZPitNPkAtNwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gZ0sF+XM; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40a4de1753fso3814042b6e.1
        for <linux-spi@vger.kernel.org>; Tue, 01 Jul 2025 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751403443; x=1752008243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3FGHq0li4IAoMzOrmPNDDSYUiPqRZNOr/Yo4wW/FVs=;
        b=gZ0sF+XM1SpimnEhG/gqhiXbxEzZh6jN05bGhoYuexBbmOW8AEXXs57UjjNI2zV4i9
         9B3ewzV3wqv1v6JPgHq1L2NzmVEHTCv8nU5rUIe1Qb6iGD51fXEMA3GWNAkBRQgcCy4e
         1nrDBaQgfJfVw7AanYZwlzkew4cGgisZ+eig1/nPHCuA/KPEEm5BrZYOFQhIQP8G93X+
         ess3OEHJfLwCeOwOS8l6MCgjwtNDnIOXFey9BVmJb5dt2WRDQh54wYz3qnh8b4FFVqdA
         skS3pXdUe6E08aj+L16Y8t96HzFUpk+FKjmelnWF4iAvE0TRH6Aw647byaZQT8G9p5jP
         6bgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751403443; x=1752008243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3FGHq0li4IAoMzOrmPNDDSYUiPqRZNOr/Yo4wW/FVs=;
        b=vI39gQL0K7rkZ/1mJ7vJqNapj0EOfVH8MOIVYUQHYDcBdrxoFtD7CgutYzCULFMFWv
         C1C0GAB/WzoIhQzPRccXFeXi0/A4MyBmN4nZhGW7LH0zDCe5Rj4SZB2arHchVrDgCCi8
         enZszTY2dQFCFGHI9588/FAvPseuPMQCqwKVKIAQMfUkQNd0WOwU+lADFnsVqXfpV2V4
         1Y4K0Hb/k7uE2C1ooZS4tEpkKNRUkeY2aNY3HZAwAzjZZ7ZKUf9lkMWmdNQ+yU3Xons7
         VFfC2hq7BeBA/RjMnZhfdowqdQhbuEoYF7VXwxIW8Tm6O6mSbHzbqFXn9ANfF6HhJ/o0
         3tHw==
X-Forwarded-Encrypted: i=1; AJvYcCU+SZGjnX0sT+QXlIi6zTClF26POb6/cvL5jYDTw6MBgetkXOZ97UKJL4lzeIbpSjUtPQFMA8m6pbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaLuenSsSY958yVtxV8Pz+gKVNf+gbjWj8lMuf9Y+l3zBKqRIE
	yzVOhgoKodXCN7QBN4+lwOZamLpYxHz9/0Vu5x4MVH6KkDdoD0MwmS0JlOJ3JaAXTNI=
X-Gm-Gg: ASbGnctmAonGhF9pezDpMbYOpISJVW1vPbc0IQX145QbxneZOR6HAyGP19Vqi+Q9s8p
	zbap+/MGqZLmAS4RYaIfam/VuzICLjntlCPPSDh6tLTllZfEOD5CaruTm6FTPbNANYvw2fEoWuD
	oamvRNX8zKNfXfD4/A+axfV0lRUNeyoFPlmYveaQkyRaSgnpEu9sUmIU/d5smq1tMXZajvxmovJ
	Lsj7Ktl+sIL6UfsEVrtJUZ3g1Hl2ks8IUmJxE/DRhojjxB8FblNRAR3CrflGFwORyrFUGCob9a2
	vyOIGMH1V+itdzF4DsdLkCR+6hZDw/9yO9/KubI0riihKEkPOu4y/nSULPUnEJS5eBtLe2NgXmL
	Z+foHeQiWY9lKxpti93iMtYNUnongfvWH/w0YIuo=
X-Google-Smtp-Source: AGHT+IH3mXwfNatjVX7249TuXT4mbijuHY97w9uhrbRcJoybXxQKtykU0E/lA0MVCBy0eHSWIO3Icg==
X-Received: by 2002:a05:6808:19a7:b0:406:6aa1:38d9 with SMTP id 5614622812f47-40b8a7c55c0mr82409b6e.13.1751403443339;
        Tue, 01 Jul 2025 13:57:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5? ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3240277bsm2268043b6e.23.2025.07.01.13.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 13:57:22 -0700 (PDT)
Message-ID: <d1e5f360-cf2b-4c50-bb26-64db47a78c43@baylibre.com>
Date: Tue, 1 Jul 2025 15:57:22 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] spi: offload trigger: add ADI Util Sigma-Delta
 SPI driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
 <20250627-iio-adc-ad7173-add-spi-offload-support-v2-9-f49c55599113@baylibre.com>
 <20250628160259.6f220dfd@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250628160259.6f220dfd@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/25 10:02 AM, Jonathan Cameron wrote:
> On Fri, 27 Jun 2025 18:40:05 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add a new driver for the ADI Util Sigma-Delta SPI FPGA IP core.
>>
>> This is used to trigger a SPI offload based on a RDY signal from an ADC
>> while masking out other signals on the same line.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Hi David, Mark,
> 
> This looks fine to me and I'm not immediately spotting any
> build requirements to mean this (and binding in previous patch)
> need to go through IIO with the rest of the series? Shall I leave
> this for Mark to pick up through the SPI tree if he is happy with it?

Sounds reasonable to me. There is no build-time dependency.



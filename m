Return-Path: <linux-spi+bounces-1414-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4C4858EBF
	for <lists+linux-spi@lfdr.de>; Sat, 17 Feb 2024 11:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B40B21052
	for <lists+linux-spi@lfdr.de>; Sat, 17 Feb 2024 10:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142348CFD;
	Sat, 17 Feb 2024 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKMhOhB6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28290487AB
	for <linux-spi@vger.kernel.org>; Sat, 17 Feb 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708165877; cv=none; b=LL5CZEGJvArC7wGzwNRlOIG4WlZsSdM8uLfUteS6lOM/p2Jp3U0qfwtOjmGTWtL3W1oeDloEyvSEn9qLVn2nABI51XHV6djZP8pT31D0YEJnDUcJGHHMXdr0Al83NdA4NlIJ8x3582V1n0Cp3Fw26E46QD2COkNMETtnhi+GiqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708165877; c=relaxed/simple;
	bh=+I0QJBGUj115X7dpK2YXGWFpKav7lr/f3euJGicjFds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5CggvogfmzV6R+nVvS5y+4u1qEHq71J1jjsinbX+bQbwL90e6l+Lpt836yn/N8Vndzg2adaNjR7+PUdCQVdXlYEg3+ae+1vG13EPwnslhW+nmDmnTt6fGQBKvPou+Y6Oc+7wTsSBavEzWuK1NM0vOAKKKo5G9uUmHFcdTjcLyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BKMhOhB6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so1911967a12.1
        for <linux-spi@vger.kernel.org>; Sat, 17 Feb 2024 02:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708165874; x=1708770674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+I0QJBGUj115X7dpK2YXGWFpKav7lr/f3euJGicjFds=;
        b=BKMhOhB6rL0aJ+NXX5SKMOftVkiggRGWpybTxvrApF7VkBtSYYMaHM4zjGaOGfFSwQ
         /yZMF1agc/rVY03KXOUqrWgwGax7xLFZSN4m6OXLjI9eVeaJpPguAYaHw7J+IgTj+WmO
         gxyqzelXz7fhxD/z+wNV79JXp1YHBbaGhUyMvPzxp4Nd9CwHOYXw94Pa7bDVxC2UPiwM
         WrpbbH0caQi+P4VIDByc2iTuSPl41eZlGt1/T9UsGMetyDuVAZQ6z4rxM3rV+IA/4OeU
         iadTVjWTl/aEz5S9n8Wo61yCexnywukcLfQ+uPBZJ7wwoZHqf4AUFEh5T1mkNVR1v/TX
         JfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708165874; x=1708770674;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+I0QJBGUj115X7dpK2YXGWFpKav7lr/f3euJGicjFds=;
        b=XRamHIkjZHmMvKYZpNiNmPFD3+ZEzp8HvA4Uz9/CrjgAvhm8VrDxS/bSi53vsx0bwf
         lecotCBeHi9EoC08V1G7kUD0W/Gm281alSZrNv+/nzDK+nZ2c9fnTgClP5mSuUql4nhC
         Vqbr1WR8mjaE3xMsB0f45+x8RUSyQ9MW1R7SgMY5xtup/Uif8p8+CrZBt/gcNYms/Vd2
         2AAdIhzb9cxrRQg5wwCypVrbBKHvi5Zj7MjYCJjbo2qn8LNLtaf4+x0PprIm2n3QMsVJ
         Q6PjPXJPLmXdDr0VK7ML+gIO/6t4zkzthdE0xOkq36LsN2f5w/jVE9L1Om1yP0hqhyWC
         GWzw==
X-Forwarded-Encrypted: i=1; AJvYcCXRrseGpWAeR6R7Kq+/iyw9iR/r4Xkmdk/1JqzIr45I+B7Ugj1VkJ27RssGnL8IiwyoVPq0Dcyx1vAwCmEZTVf+4J6WQ7GQq8br
X-Gm-Message-State: AOJu0YzpagYqUSIIdX+R3o0v8CCZGGLpDuZChSIIAkfOMFe+q/mnTaUy
	+FIssVvQZDffZj8Gxf+eWC9gRpq5aQpqIUOpOF1n9zAL5RexkfS0Bf6TtsjFco4=
X-Google-Smtp-Source: AGHT+IEnfnaROKRSCTMA20KHMVgCeVo1F9b0P0rDdD7CmKQ+RK8pARS39TmEpvwqUwN/bN8LEGHXzQ==
X-Received: by 2002:aa7:d047:0:b0:55f:ec52:73c4 with SMTP id n7-20020aa7d047000000b0055fec5273c4mr5343705edo.34.1708165874437;
        Sat, 17 Feb 2024 02:31:14 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b00563a3ff30basm836085edi.59.2024.02.17.02.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 02:31:13 -0800 (PST)
Message-ID: <3a4658ed-1418-4197-8d1d-f35975d8cd25@linaro.org>
Date: Sat, 17 Feb 2024 11:31:12 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: trivial-devices: Add qca,qca4024
Content-Language: en-US
To: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Peter Yin <peteryin.openbmc@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Fabio Estevam <festevam@denx.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
 <20240207224546.44030-1-frut3k7@gmail.com>
 <20240207224546.44030-2-frut3k7@gmail.com>
 <cd8c2f79-2307-4ad8-90c7-747d40f14ede@linaro.org>
 <CAKEyCaAy9U_qQ=pXPYaGetEuuuVuoejxjKPrG92fBFauy1wwuw@mail.gmail.com>
 <263bb77f-b91d-4139-91a5-0ddeda0ece17@linaro.org>
 <CAKEyCaD=2Md8f=K0pfAFmSCQjL0PkBvAzG_g5Me-wpd5iv2rVw@mail.gmail.com>
 <18583e61-bc7e-47ef-ab2c-c669785dfd08@linaro.org>
 <ae0827d9-416c-4547-8882-44dbb46931fe@linaro.org>
 <CAKEyCaCteCG+B0H4DTRtZ3JcU1_-Qimc4iR6UJDCokvvkwPydQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAKEyCaCteCG+B0H4DTRtZ3JcU1_-Qimc4iR6UJDCokvvkwPydQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/02/2024 11:29, Paweł Owoc wrote:
> Can you point me to some example?

Please stop top-posting. I really have no clue what you want here and
what you are referring to.

Best regards,
Krzysztof



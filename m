Return-Path: <linux-spi+bounces-1402-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E57D857FBA
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 15:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50491F255FD
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293F12EBE9;
	Fri, 16 Feb 2024 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FqTA0YyX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED12412C809
	for <linux-spi@vger.kernel.org>; Fri, 16 Feb 2024 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094882; cv=none; b=GoYrxOAoU1dTnClgKeHh5JeFIonwymfm+lbg3ofyyA1EYra4t/VlpxPXbsATKpp11U8zhhSlWaZEO4FPJlqCwLJKHXKji/FeW12icsRtk4qJ0oZWT6po/kwC1adobxGCFuo7D7pQlTBvlPFhScxjvD7QFTybhc1ljkzq7KSmNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094882; c=relaxed/simple;
	bh=lZmHjqtF/2UNAgt4ejNsB9asktrwsrIKoHWPhPxN+yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chEmA0U5REWJBW26O7bawMhkwxEaAdBvvv/IBbLT12MvCcQmSTo9uYJRfW+dJCenUxKFoiWDbE+GVFIGiICzAUYsw4gtNIfG6Oio36F2lU3ITQNrENofX4O//Xb481EJXZZmM8/cE0UvbxCxaikCWIqgDbBPs4Utcv8TLmwMQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FqTA0YyX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26fa294e56so321740166b.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Feb 2024 06:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708094879; x=1708699679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZmHjqtF/2UNAgt4ejNsB9asktrwsrIKoHWPhPxN+yQ=;
        b=FqTA0YyXJf2+q95osnaIshR7zoH2YMbUWYOASaU7RuZAkowsbG5jEerfFa7Ec5+/B5
         OJhlLS5uBsLlFhrbh2VflPHsbPXnZQnfaq8xED66mlPA3mNFUojjQYloooEGJtX3agt6
         /t6LXl7AN2czzx54+YQaf4Tmxqh3CvuZjZBw5Fr0qF8tLfAbfwdwiGvmE17dpInNFZiW
         ZeI373iyy4wbNqoP/CEz02DWzWg5AxsxVTx+BPpBPD9MqhD65J4WsMJcu6XTclfim0+x
         G/LhInPoksV9WyemVU1uapd7v1xQ+Z++zvLAh38/nNu3gmrG2jFsDYWM9/lJm8yQKHhN
         d4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708094879; x=1708699679;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZmHjqtF/2UNAgt4ejNsB9asktrwsrIKoHWPhPxN+yQ=;
        b=v9VtZSF2CpyQlwnPDwmLA1wq/sdx9CLJaZIjuO219Ugr13l6CZRTBIt4QIQeDDyGJl
         9422ZtiZTRTKnnBc72cKXrkKqujSZO6pgEBAvLqv0e2jlwUP+JoFdvGYu/lInuP1+26V
         UabyHyiVUKyRJ/EFZSvKyuJ67Nk5cdkbkcqn0Wpkdj6e9dEsXBjk1jfNWY0/I7Xeugh8
         8+y0+YTNDOHhh+BgWnb6apmATve182KHK5NL/YOs62IFOvayFEUhU8kAbqo5T7S0V0Im
         gmHA4LaqgH+3T/7Eo+mYeLjMrGhoDo+14GccLHfEEBgWl6qV5lgiErPvZ7Rax6crhKG8
         aoOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwk42tz90Lcws5zvblFgbA4J7byiOu2K1n2l4HDiWhBLmeoP9bxF+8CN6WSk7YHED+pjBXpxfsnFJyverMyKSpfRb56sDY+FZ6
X-Gm-Message-State: AOJu0Yy8ECr4t5cGGq5tZV8VyGDf/7q5syDwnD2MRNUejiRPMUyyyTNB
	PeJ1IFeqSpCg2L4sK1l7WmBs4PVlTl3r5UiAFvtSW6IeFEl2Rpm+epEY5kUGa9U=
X-Google-Smtp-Source: AGHT+IH8C2qIVCzYP3fytmbQmm9WMTVGYp1c2Rah7vM8VLxTCkHnrWY4pW4cSRo2RCYxVAUafW2vcQ==
X-Received: by 2002:a17:906:110f:b0:a3d:6592:a7e with SMTP id h15-20020a170906110f00b00a3d65920a7emr4170696eja.37.1708094879255;
        Fri, 16 Feb 2024 06:47:59 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id fj16-20020a1709069c9000b00a3d07f3ac61sm222ejc.101.2024.02.16.06.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:47:58 -0800 (PST)
Message-ID: <18583e61-bc7e-47ef-ab2c-c669785dfd08@linaro.org>
Date: Fri, 16 Feb 2024 15:47:57 +0100
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAKEyCaD=2Md8f=K0pfAFmSCQjL0PkBvAzG_g5Me-wpd5iv2rVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/02/2024 14:39, Paweł Owoc wrote:
> To be clear, I don't want to add support for the QCA4024, I just want
> to use this SoC with its own firmware connected to another SoC
> (IPQ8072A) via spi.

I know and this does not change what I told you days ago: this is not a
trivial device, IMO. Please open the schematics or datasheet and check
its pins.

Best regards,
Krzysztof



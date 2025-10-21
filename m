Return-Path: <linux-spi+bounces-10761-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F04DBF739C
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 17:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6DA18A5869
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3194340A7A;
	Tue, 21 Oct 2025 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cKblhV2o"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C133FE1B
	for <linux-spi@vger.kernel.org>; Tue, 21 Oct 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058766; cv=none; b=tNPRrGB4gQkJNnS9MOkeZqih2vSh4aJN+uO861V61jq/1c+iM1bzyQ8wTD98MCmZA6BJ6jQcG+o6tqNaGl34hoq/jjZXF/U9M5vI4mhZhRIp15QPtBJp2nUiM4pMhUXZD4yGUxQSsjmEV+cM/uvWkBUd6KjvNCh3lv1Exub1bHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058766; c=relaxed/simple;
	bh=BF7CnhuFTJ7vA3b9I0uk6rAuh9/EJC3i+BVltZT70Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqLTnA7DsFg1AlyPg8TZUBoUl7TmPkrabobtyXdGtnyLcklR7WAGL65EvPT8L13NLXQ64XN4l+moTJOLE0dzGArYnhLLiLhlbEdgAEWBViofGi7dqh96pJvzzAeAhtAQjPn4TeOQJl1fRq9oWBtn0iIbIOXlWNA39Ovthio46sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cKblhV2o; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-443ac891210so2360262b6e.1
        for <linux-spi@vger.kernel.org>; Tue, 21 Oct 2025 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761058764; x=1761663564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/yTo+AWdbIYNazgbweD584J68eS2cC9KXUZcXNE/O4=;
        b=cKblhV2oWvaUFQpPpCcBxgf7IwespGrZjyPeqThSz1IqdyrM7h9Wmi1lBOkgHzpPMn
         oRHkjGEDXWurJD/qvy91Y0l9CV04K1Onv7obUUZZ/N1SadkL/ZmByxaBk7WQvT7GrjcN
         8VQo0+Ft5UBo1hVNztx8uOhqIcSj+ZDw0uW2lt0vPfuYBQTzFKrsd88J2ujtz5cTB4ch
         iSRmRgvdrqmtZIJF0sFIWUab9rMh+1kmJydoiHrSBZNmArzjjVGpb678d5cQK3yoDxtB
         Qzjk0xmdY/cXA+88o7b+1riz6zUkl+oF5KPPM/md0C/NBfcqqpl26lSP13OtgzcaqJo5
         Zoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058764; x=1761663564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/yTo+AWdbIYNazgbweD584J68eS2cC9KXUZcXNE/O4=;
        b=EQC5SZCntOh7PaOGtSHlkClpA/l8etASjsk8mJp+I6f3yaIioIRgSIJyn0VmCo2UK5
         7ndYkTVgnvSvUKeZnrGpqBnnn09OHtMtgrscFlhpZ4xa40SInzZRtx9CayeT+ulQOWKt
         8G+mYd13k080CwgFATH8+kqr4dYTM/qrMiaBDFHbmAwR+L1hXIWhCSZ8i1/mlsFjYE/G
         Z8Aivy8EIsm073OQwWEj/XfvAPENZxpeFkTf+AQ6VKCD/ijRRR/IxgTnlR2DXWtUY3lV
         9paYOeemNsRzOLkAU3Z4ek9raH7ZajqpJp/fLB9iubDfDM7vTtxEyD06FDBlW2JX94ig
         jnjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH1qRvsXKAKaahwp9bYrLbO44xjQeGEM23ZGRYaL9ZuBb1ixAoiuz/oifRImwqPiEsb+5Er7j1jDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweOTfpbRir+jEiIGqSVB8YpfIhalC8FbWP3Xe6j89ZcdL4YtLD
	FJDRbilReYXvvLmeh4ZHP4LpJNugXwE5F4ezqfBC5uqXyey3/tnZ6mxiE8/iWdl2SOc=
X-Gm-Gg: ASbGncsVXVDnOd3jfTcoZ1X+fmAis5G50Vref1mJ7gZ/3U9HuTKXPu20XrJGkQ0C7iK
	VnTxkMc3JASqo/Mue0pdTSqQs0Ed63rim9jfFgNHhmoGySDYiLhJXNCEiD0BtUzIN7Pqw2nBK7k
	IGz+yNVfXVnKjFxHiPUn5S6/paEpqGGvQhzEEAcsgZ8UmAYhCSfrgUTVA1au9VpOhtpa9oXlztb
	qlV78kY4N12oNTVhKJoxvmgsxHBHEhLaU8Pn3Ost/FaCYStUhIVLMQFN8b91/cU+ODVLWWlaJuH
	OyWv/zS6euaboAjG0DMmxpohTXtuc7z/Wle5Vd0kQ1OgnqrI/2Znh/KsnQ79z3lJwwCeCgK9Exs
	Fh+9Kgpk1ZYZmv1UEgFom10FG9R/OZOZAj3CFizjsUuxlC/4C93FYoXAYo2g/J9GpsCUuRIF6Uh
	ZeQ3jEdhBFrIDvMMOkZtQybI96CasIVwD998uMiTqo1+x0dI+44eS2HY7w1brU
X-Google-Smtp-Source: AGHT+IEkFVfsSviTuxzMCB8iw1UUta4Rc99+J99lU5MJAgNaQS84secYXlQwYi3GsiXRW9f0mMBMdA==
X-Received: by 2002:a05:6808:6909:b0:43b:9be2:2f45 with SMTP id 5614622812f47-443a2f17cd5mr7696038b6e.22.1761058763912;
        Tue, 21 Oct 2025 07:59:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b5c0:1844:fb75:2a91? ([2600:8803:e7e4:500:b5c0:1844:fb75:2a91])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df722e5csm2662753b6e.24.2025.10.21.07.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 07:59:23 -0700 (PDT)
Message-ID: <14ae0769-341b-4325-b925-7bba6d57bbdf@baylibre.com>
Date: Tue, 21 Oct 2025 09:59:22 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: spi: Add spi-buses property
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251021142129.GA34073-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 9:21 AM, Rob Herring wrote:
> On Tue, Oct 14, 2025 at 05:02:11PM -0500, David Lechner wrote:
>> Add a spi-buses property to the spi-peripheral-props binding to allow
>> specifying the SPI data bus or buses that a peripheral is connected to
>> in cases where the SPI controller has more than one physical SPI data
>> bus.
> 
> Is there a reason why spi-rx-bus-width property doesn't work for you? 
> The only thing I see would be you need to define the order of the pins 
> like "data-lanes" property.
> 
> Rob

Because we can have both at the same time. In one of the other threads,
we talked about the AD4630 ADC that will require this since it has 2 data
buses each with a width of 4 (total of 8 lines).

See: https://lore.kernel.org/linux-iio/ad929fe5-be03-4628-b95a-5c3523bae0c8@baylibre.com/




Return-Path: <linux-spi+bounces-3161-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2E48D5247
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 21:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D841F23CB2
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 19:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90FE147C9B;
	Thu, 30 May 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Nh0qGhKv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5904147C80
	for <linux-spi@vger.kernel.org>; Thu, 30 May 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717097061; cv=none; b=CDkWVga3ixtAYWyXj0SsaTW/qKiktKUHyzq2UjI7RV1jtVm0CvzW4o1Y1HU3U0yPWbrrm9DRbUStELimeyXrhfwNvyjDrJzpJa56Y/SdwsNVIiLbcg4FDFOR+TvgW6iYvtkes+z2ZH095EXMJIWj5srlcXJTXEKbF/NktG2oEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717097061; c=relaxed/simple;
	bh=m4Nse25y6EsuGDUh4EtZfvdY5SZs8Aj2Asf9IIe5CPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rlsm3ktFWIEwZD5rzKf5WXqAelRxeTKQkgzlNci7eZv/UUIXr0uWhcWF1slsoyQiW2GY57fxFVdpOaEcThHD+1J365O9nW7PUoaKExk/fb5gjkL4tiQroS5+xYaOb9XHYQEQy3I5x6aeQCe4+X0uaH576IVZBgV3BhDtqz0h2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Nh0qGhKv; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f8f56a30a4so669777a34.0
        for <linux-spi@vger.kernel.org>; Thu, 30 May 2024 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717097059; x=1717701859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pTv8vl3hBxcvdk6Q4RODEZFm7a5MH4UmFXjV0ydwHe8=;
        b=Nh0qGhKv3kyCZ4O5E8qWFEWyc9fkrAqkIRD7w/TPkAzhnQhesp8k+A1Q3iawhjPUO/
         +CIBpjlEGlNUa0z7Ca/sG5/aydO0ZrEiJrQUxYvjnkgMLHtHg7Yeuhri1PsuQLY2xymP
         8nTmwVbT6W0yzrp20flmPIbDQA3ZgcsTPBLPko0TSIUBTmGb4vY1+cmceyuTRzDzdNdJ
         RpgDFZOSfJxSz2ldRLovToq4jrNtpnuNiI7IcgqZ2oBn6H56wifIM397YSWWU42CJJUW
         55U/zB+CKPsZ9oRoP4/jukJF0cfyyQT2cvRwwOYtbWykHeOfMy1OHzK7fcy3+CwgQmFJ
         5N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717097059; x=1717701859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTv8vl3hBxcvdk6Q4RODEZFm7a5MH4UmFXjV0ydwHe8=;
        b=pK4PEX7CKqB2gXuGGUDIXLfKar0VG2k05Ed1GiVvANtszJuM3t2YvjYpytln/t3uuK
         cmpe/jslPsEl/Mh7WkYAt0aBqm66Xhi4U7yAFc79Jz51wGj5Q9K7Bjtjq/uj5lVJJ0Xx
         kRWRWd3vHLrXqhF0ucIwsUVGDdj/66iq3jiSVlarqH/4AH4hBLNzAMc265e+1OvBhWgk
         czqEoXZhsDuvRw2UGsIzihTuUrmQ2wqD2E/ExJ7bNTkFNhqmF3yHWZkXWX9dMcUaryuh
         um/alWQZC/1HaDDsjOiSigeYLK64us7hMAvVuJ64oN3NiqKUAjKBIgHgd8oopb2wDn9B
         8ENA==
X-Forwarded-Encrypted: i=1; AJvYcCXWRTUVgDV0iXhqV2+Co8CS+/w46cDC2GajPB9m3gIfTu4s5/mdMkJoWFBsFwH6HH7wWMa22tyo6/2Prl2R+h8x1I5PGw4vRzZF
X-Gm-Message-State: AOJu0Ywm8By03VjHQDGgR2boE6GV0fTyB4D2iASmmy0qZ9O0T2ObtDaT
	k4kmyX0JFtLe9DN1kgbemXcpKp//rlJ5NTGooas/LR7smIhjW2BuNJuKCSg2r1w=
X-Google-Smtp-Source: AGHT+IE21ywEBoUcu4MUr1ZZ9nNBF6Eh1L/o5nvA80dAOPVfZVORqsCVWsrKJNTvL0sdQUlSYOLV0A==
X-Received: by 2002:a05:6830:1db1:b0:6f0:bf65:9c42 with SMTP id 46e09a7af769-6f90aeb990cmr3295087a34.15.1717097058762;
        Thu, 30 May 2024 12:24:18 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91053a3c1sm71347a34.27.2024.05.30.12.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 12:24:17 -0700 (PDT)
Message-ID: <6db8ba66-841b-4425-9dd4-9d6e7b0463bf@baylibre.com>
Date: Thu, 30 May 2024 14:24:17 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240513-headsman-hacking-d51fcc811695@spud>
 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
 <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
 <20240526-peculiar-panama-badda4f02336@spud>
 <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/29/24 3:07 AM, Nuno Sá wrote:
> On Sun, 2024-05-26 at 18:35 +0100, Conor Dooley wrote:


>> It might be easy to do it this way right now, but be problematic for a
>> future device or if someone wants to chuck away the ADI provided RTL and
>> do their own thing for this device. Really it just makes me wonder if
>> what's needed to describe more complex data pipelines uses an of_graph,
>> just like how video pipelines are handled, rather than the implementation
>> of io-backends that don't really seem to model the flow of data.
>>
> 
> Yeah, backends is more for devices/soft-cores that extend the functionality of the
> device they are connected too. Like having DACs/ADCs hdl cores for connecting to high
> speed controllers. Note that in some cases they also manipulate or even create data
> but since they fit in IIO, having things like the DMA property in the hdl binding was
> fairly straight.
> 
> Maybe having an offload dedicated API (through spi) to get/share a DMA handle would
> be acceptable. Then we could add support to "import" it in the IIO core. Then it
> would be up to the controller to accept or not to share the handle (in some cases the
> controller could really want to have the control of the DMA transfers).

I could see this working for some SPI controllers, but for the AXI SPI Engine
+ DMA currently, the DMA has a fixed word size, so can't be used as a generic
DMA with arbitrary SPI xfers. For example, if the HDL is compiled with a 32-bit
word size, then even if we are reading 16-bit sample data, the DMA is going to
put it in a 32-bit slot. So one could argue that this is still doing some data
manipulation similar to the CRC checker example.

> 
> Not familiar enough with of_graph so can't argue about it but likely is something
> worth looking at.
> 
> - Nuno Sá
>>>

I did try implementing something using graph bindings when I first started
working on this, but it didn't seem to really give us any extra useful
information. It was just describing connections (endpoints) that I thought
we could just implicitly assume. After this discussion though, maybe worth
a second look. I'll have to think about it more.


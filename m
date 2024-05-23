Return-Path: <linux-spi+bounces-3049-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036808CD6B7
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 17:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962A31F224A9
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584E5B662;
	Thu, 23 May 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eFOjcelj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8A171AB
	for <linux-spi@vger.kernel.org>; Thu, 23 May 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476949; cv=none; b=Jv9llUm1tb0T/SMb40Jo79psbojuPKLlliGEmfeKPWBXKd/QWr4/dgJt4jVgo77nG5o7ofomCTKgWXNIfXruBGZ9hmoG8xiZy1iTsY7WsN0OQsuGCx1zd493xOh58rCJSChR5NUj8q/bclLQ8CYW1oVL3WNAhapdorbWSp6k1WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476949; c=relaxed/simple;
	bh=Pl1mOlxsgsZjv5GC6ZJOtnNAWIIh4LnpWp+JPZyPZT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQz11+WyL7cINa4REuXZKouCNh4NvVlA6RqFQ2dyWuugBHgrvAsCFhjAkFCKyrxwJc4xI+Q3pmJEWxEqjD7eGtXrkS3/9pyUXXCTGXZJ/8t+OlCNPn3+QRiG0AyfEJahqZ+ldRq0vUiAPbyvRhmUyE34nvfGKY3xMglCe+lbrU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eFOjcelj; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f12d22331fso976340a34.1
        for <linux-spi@vger.kernel.org>; Thu, 23 May 2024 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716476947; x=1717081747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhVj6FCoDzPR+MbDpoxutT96uTiXlHhWUxlVPMCsRV0=;
        b=eFOjceljwceEv0kmvBOdTx/R57f2r4iBS/DwhCAR01X+PhwNv3JLh+QlZZBIy4NDy1
         B4xgCjHQD/hLuZIzgRBDmSif5UBnA1T0m6XfC4slKzKG04tG4jY8XN/7Pn955nEhDsM7
         R1S1ICYKJdYJ0AGCje+kdMcqUKnt9zkuSi82wLpHzBBneHS4sqDTBo1/wP3bj/Jchnth
         wrY3vYy7zDRv/sKHzLQii57U7wIaZdlEKMK36RgzoiwuAGJMDL/Hh7sUEaNQ+eAY/bZZ
         Jnsp1+Ij0GotdNz0KRGAW7ZRECWoR40HDOmSJexUQiiFpqJllYuxuAu/wUb+unIj16fZ
         fe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476947; x=1717081747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhVj6FCoDzPR+MbDpoxutT96uTiXlHhWUxlVPMCsRV0=;
        b=A5r9yPUIzmZKGejg7tC9/GKZVwELo/bKTjFEzfVPbgc4OrI9xmAilMq3yCMV4Mdgah
         qsKHg8eQnQAiGL4vH+m9CF1PTfik1p2tJr1T7k2wL1ZvPOUfvzZyLGNUoLr4PDuIqItA
         4/6nUD4zHvY/N4t0m/tLKgSRIR2Q/IuaaCCBYByutf2sAkxdu+B+pEtyqiXPa/ut2rvj
         KI/k7BBV2FQvpGthcxMeHmEYVEq3LXsTtE6fgVexEB7PaJ0jtfklVY2PkyebkyjQXPMT
         TujIQzmlEp9Kr6R6Wynxk6JslMh7/hp1W9kqcJ1+n0BqgMsYuWAWUifIqwZB2Ny+WHjQ
         IFGw==
X-Forwarded-Encrypted: i=1; AJvYcCWma6JVGrJ7hGSKRjoEffo5oByW/aHZikuPaJSA9sP2T+KDiN3ghz4VnrOWwUTuIWJdbAMA4sUQnnYTe/71Vcmb7ph90OxVOkor
X-Gm-Message-State: AOJu0Yz9Qcc/qI/hQDhDmpQTHX8EIqfQ60JYTIP+sjk0yC4+HivFhY/j
	SSMSfDDcXFdBa/OKpaGRGbxI/us2k54Emwd1XdDz+wRV/TnvYoQ/MdkYh+Gpmgk=
X-Google-Smtp-Source: AGHT+IGA5q7G27Y8PaMTdFJeCZappJ3k2ZJ4VmDgR6MSN90k5mJKReZ1wo483N2rA4PDO56q5kWqyA==
X-Received: by 2002:a05:6830:2b10:b0:6f0:3d07:ef7e with SMTP id 46e09a7af769-6f7d4e11f56mr1417237a34.8.1716476946841;
        Thu, 23 May 2024 08:09:06 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e7efd0c6sm5203398a34.1.2024.05.23.08.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 08:09:06 -0700 (PDT)
Message-ID: <3fad2e61-c3e4-4bb1-bbea-101d5d0f91ee@baylibre.com>
Date: Thu, 23 May 2024 10:09:05 -0500
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
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
 <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>
 <20240513-headsman-hacking-d51fcc811695@spud>
 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
 <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <59df2cc3-5a62-45be-a0aa-5bbff13c2ae4@baylibre.com>
 <35de37c08331a8384aa9ebde3a9be5fec6fc418e.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <35de37c08331a8384aa9ebde3a9be5fec6fc418e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/23/24 9:57 AM, Nuno Sá wrote:
> On Thu, 2024-05-23 at 09:28 -0500, David Lechner wrote:
>> On 5/22/24 1:24 PM, Conor Dooley wrote:
>>> On Tue, May 21, 2024 at 09:54:39AM -0500, David Lechner wrote:
>>>> On Sun, May 19, 2024 at 7:53 AM Conor Dooley <conor@kernel.org> wrote:
>>>>>
>>>>> On Fri, May 17, 2024 at 11:51:58AM -0500, David Lechner wrote:
>>>>>> On Thu, May 16, 2024 at 4:32 PM Conor Dooley <conor@kernel.org> wrote:
>>>>>>> On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wrote:
>>>>>
>>
> 
> ...
> 
>>
>> controller:
>> #spi-offload-cells = <2>: /* 1st cell = offload instance
>>                            * 2nd cell = trigger provider */
>>
> 
> What about things like DMA? I'm mentioning it a lot because it's way more complex
> having it on the controller (from a SW perspective). But from an HW point of view,
> it's always very similar (if not the same) as your case A.
> 

If we had a setup where there was more than one place that, e.g. the
RX stream from the offload could be piped, then I would add a 3rd
cell to describe that. If the hardware is fixed and the RX stream
always goes to a specific DMA channel, then it doesn't seem like we
need to describe that in the SPI controller node because the hardware
is fixed.



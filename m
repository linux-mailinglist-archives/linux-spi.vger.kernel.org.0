Return-Path: <linux-spi+bounces-635-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D01D839071
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 14:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309D828D7CD
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5A75F841;
	Tue, 23 Jan 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrniSicP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E885F563;
	Tue, 23 Jan 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017875; cv=none; b=inR/V0nmfWJb5f/a59bv6sIDxPK127yZOjiFT3WxbJ+OxPyyjrNMhrnmHPDxr46qZqfGJr4G5wfZ3RU8nFoSByO1/mBnridoWxkQapbkorb/qEVVniFLOrws+H7LxZUOB8SBu/nBC88RaeyqoAgvmXY3gDHrrSYxoIw0J4thpb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017875; c=relaxed/simple;
	bh=An5eKsNfJbgcT2d6+gGwNupZ+ioTflkVRVPbjB0iCyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfETdYhqwQ9DnlSLXb+fx48CTS9BV44geEiIFl5+K/O4PtsJsAyh1KFExdpPNxYYf/dq89VFAlQUuyqx6/PvtQTwRG4b5twY6QmGA987CaEF8gnq60Gaa4Ux8DBnIQKL/2BzE68TUVBzMMGNT+wPKzze4t7f9csCF61eFqhRrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrniSicP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e9d4ab5f3so46865665e9.2;
        Tue, 23 Jan 2024 05:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706017871; x=1706622671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dV+BDeygc2noRbP53tgI9IP4fQK/HUWRgHZ0AVe1P88=;
        b=VrniSicPdP/TDDpjmMZdrsGYQc3lU+LUUql1Ji9mBVJRR8l7rlQHRXAMOnNc8W5vHr
         m4ZSoGFPv/HUzSvggR8GQH/IdAjiLjQ4hJyepFZVULBYW3QNOc3m2ywzo/BnZSCdutD7
         y55/bD+U8ERNYTpZc/dPf68SYDKxnPXdu8MCdF0VrQn0hWuL90z72a1SJ0gHgs2HEHON
         tiLis4cfNaL8YqvdlnG7ucSqLu1AqX8B1xHuQw+QzSlR2DMMUKsacXhVrYpi+lbgO1UC
         M/ZYwUgQNVJPLiEkZpuvQqBrPVd0yXWeM8TEJxKvn19dvE9JUDiH4jwqCzAkCEHbtSAq
         Wi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706017871; x=1706622671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dV+BDeygc2noRbP53tgI9IP4fQK/HUWRgHZ0AVe1P88=;
        b=DFO0l+AeX21mjxjIwimD6DRKXoROfYxUIy8TtKqdyhk0Ujh59is5uL2GympITL+UDj
         p7X0YG+yDIDuSSPOyjTVwwUewELKsf+adUwofITWkkgK4c/XUUWGYXRdoowJkIhk4s7a
         COgBI6Fg0lx8d8rBXEPNf3m0ZX2ciHC2iUXtRJFGIvqGxhVO2Bakw48T970lbpDqQ2KD
         XVxz8aXTwUeof+xjW1rJOnmi08LkqOqkODaTG8Rf8YmIiHnaxi9n1b/4ihbWn/neGKWb
         cISA4g4hWz62rm1khV50jIWmeG4JTBlOGkSaNM4paHEHBIA79+kZ82m5Yh7QqtSwUSHB
         TI6w==
X-Gm-Message-State: AOJu0YwTMR+tUep7VBtiCbbvhjZCONWeMUBxwFIjaJNlLVNBgYsL4K2l
	EAyHEjoe9/ooWQN1Ortck1J+txMqYdFwQp2O8pMkkOATIWwCuE2zPvGJfA7JMxki4w==
X-Google-Smtp-Source: AGHT+IFbptdjITkQ6GhGrCP/WSSPwBibDyt75XrZLT7OV1LlskK6f/3gKqz29PjZYXDdRobWhPVKMQ==
X-Received: by 2002:a05:600c:3482:b0:40d:9377:d97c with SMTP id a2-20020a05600c348200b0040d9377d97cmr169438wmq.65.1706017871382;
        Tue, 23 Jan 2024 05:51:11 -0800 (PST)
Received: from [192.168.0.5] (cm-83-97-153-254.telecable.es. [83.97.153.254])
        by smtp.gmail.com with ESMTPSA id x8-20020adfdd88000000b003392ae3aee8sm8552647wrl.97.2024.01.23.05.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 05:51:11 -0800 (PST)
Message-ID: <733a2572-779f-4354-a51a-23c0b6732ca2@gmail.com>
Date: Tue, 23 Jan 2024 14:51:09 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: dt-bindings: spi-rockchip: restrict num-cs
Content-Language: en-US
To: Johan Jonker <jbx6244@gmail.com>, broonie@kernel.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <acc4ff4b-811a-4a6d-8f58-9d8da3be40bb@gmail.com>
 <d6fc0ad6-ce20-4604-89e5-2598dc3fc0a6@gmail.com>
 <344a3de8-7f10-46f0-9524-dca58ceda671@gmail.com>
From: Luis de Arquer <ldearquer@gmail.com>
In-Reply-To: <344a3de8-7f10-46f0-9524-dca58ceda671@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/23/24 11:49, Johan Jonker wrote:
> 
> 
> On 1/23/24 10:17, Luis de Arquer wrote:
>> On 1/22/24 23:59, Johan Jonker wrote:
>>> In the driver spi-rockchip.c max_native_cs is limited to 4 and the
>>> default num-cs property is 1. Restrict num-cs in spi-rockchip.yaml.
>>>
>>
> 
>> Doesn't num-cs include gpio chip selects too?
>> I have a setup with num-cs = <12> which uses non-native cs-gpios just fine
> 
> Given that bindings and Linux drivers capabilities are 2 separate things.
> However this document has also a purpose that must notify mainline maintainers if users submit bogus DT values.
> Currently that limit is set to 4 in the mainline driver.
> You are free to submit a real board file/patch serie afterwords as proof for review with 12 spi chips and then adjust this limit and increase ROCKCHIP_SPI_MAX_CS_NUM.

Hi Johan,

OK to that, I was not aware a driver could limit num-cs (I thought it 
could be extended with as many gpios as needed without involving the 
controller driver). I thought of num-cs as a spi subsystem generic thing.

In fact, I was reviewing the setup I mentioned, and even it defines 12 
cs in the controller with no driver complaints, so far only 3 of them 
are mapped to devices (I'll have to review the driver before going any 
futher!)

Luis


> 
> Johan
> 
>>
>> Luis
>>
>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>> ---
>>>    Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>>> index e4941e9212d1..00d555bcbad3 100644
>>> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>>> @@ -65,6 +65,11 @@ properties:
>>>          - const: tx
>>>          - const: rx
>>>
>>> +  num-cs:
>>> +    default: 1
>>> +    minimum: 1
>>> +    maximum: 4
>>> +
>>>      rx-sample-delay-ns:
>>>        default: 0
>>>        description:
>>> -- 
>>> 2.39.2
>>>
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>



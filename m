Return-Path: <linux-spi+bounces-620-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6C3838C80
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 11:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72F4284786
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 10:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872135C8F6;
	Tue, 23 Jan 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNqDzaWi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36AA5C8ED;
	Tue, 23 Jan 2024 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006993; cv=none; b=m+yHAEbHHNA62VIUKYnu/MZ/PyPB1SK119ec7fD1F4eE52zvj4qFwwu9ELr28kIyVoOtTZfke05vez0lB1VMaGgpumStbdELAP6DJ8lasOrzlJ0EipnUowQKl4nlj3MqnPsSVgLjlPm+ld6R45S06RDJQuswNwV+Ab+cVhBjVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006993; c=relaxed/simple;
	bh=kYN0y4dPsYooNH+c8Qwtty0BKVzTGVGg2vyDLpbRNw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uas1z1yaRe0hIi/huor+prpyz1GM44mmd6/yJ0x3gZWLt67bnnze1twSiDj+anoYprACvCXF4VTDrwLZPfh6O/j5bLrByl2Se+Io4Ikz0WvTMDVmht47Wzxc+cieONQ+s0Cc8JV5IYLo+i/umJQ4rAGoumHMtt9qpFjbACB+m3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNqDzaWi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so4806575a12.2;
        Tue, 23 Jan 2024 02:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706006990; x=1706611790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1tTcpctKr7+to+rDFJ+mLDlkTkuMFtvhVWhYOJfG4o=;
        b=CNqDzaWivtz/17hhiY99kHgtSGHfe5rIbt81z4NuKMI5QYC2AqSelxTL6p9X0LahN5
         5bqA9YOAjlS61TD+9aO7xSbi1Mb4GS8g5zu3Ii0KzxngccjzO9Nfkx7Uup6nLJu5lEmH
         hBFIjqDGIhy3uGmWKXSLjGLE/fREBpG1Vn2bLvNZmz5i13kNrPZVpwQQoDkPbtA51jhS
         fIqXhXO6EDQRziaAIbpvYoaw/8J3W/khScPqO0902hWvtMnpJgEZX6c0M94K/wh15l9U
         0uJIKJqK8Zz/uAC6TZighl/Otz1pYMNpMv/GTyasBMRqB6/QpmWhBRPcYbKiA1bLVoFR
         RH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706006990; x=1706611790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1tTcpctKr7+to+rDFJ+mLDlkTkuMFtvhVWhYOJfG4o=;
        b=Sw7HiT3U2J4hAxOEZdK20ihm20ffuLKQ0fot260dRq34OOz1pzcMzqgx9XwZ6V5RQj
         Pb5kZIG8aYQNDdQGtMHl+a67i8Q265yoYrALYTEAQRs1D30HYn/YEm0cQpuV8H/7ye7V
         oMqk6GkYGhNs2sgKzeX89RpchYFgIX56Gynrco+HaX6vjQnfKD3S6kKpI+r7Wm3eVlKP
         ZD30dIebdoiQVBNBMdtLOxIlvs8eVwgbp07qaHAEWTgn9lQ9+2shMPlttDbERqtSgGb6
         Pd+ss4cjwRVBKk55cE+QwHiJP+rhZ0H1KL7h/VC7LaQOlGts/4EfhWHLQfPxTbG+14k3
         ZA/w==
X-Gm-Message-State: AOJu0YxsRv1X7d5kWDJioXr9m6XXSLSrvaRNecAB0ghTqUbZgLx8URtz
	LTkfYeflA6ov6+NZfQ8XrMr/qyqAYf+V7skGGM2lsMqPtQYMrjF7w7tZKc5I
X-Google-Smtp-Source: AGHT+IERL/uUCLXkfWZSoUxkEgKCiGTldKue+P4EfKPsE7LACeSUpjZSr2Q4PWCPOqOJQIifcX9wPQ==
X-Received: by 2002:a05:6402:1502:b0:55a:b97:f79f with SMTP id f2-20020a056402150200b0055a0b97f79fmr751898edw.45.1706006989876;
        Tue, 23 Jan 2024 02:49:49 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id eo3-20020a056402530300b0055c76eebbdbsm779591edb.30.2024.01.23.02.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 02:49:49 -0800 (PST)
Message-ID: <344a3de8-7f10-46f0-9524-dca58ceda671@gmail.com>
Date: Tue, 23 Jan 2024 11:49:48 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: dt-bindings: spi-rockchip: restrict num-cs
To: Luis de Arquer <ldearquer@gmail.com>, broonie@kernel.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <acc4ff4b-811a-4a6d-8f58-9d8da3be40bb@gmail.com>
 <d6fc0ad6-ce20-4604-89e5-2598dc3fc0a6@gmail.com>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <d6fc0ad6-ce20-4604-89e5-2598dc3fc0a6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/23/24 10:17, Luis de Arquer wrote:
> On 1/22/24 23:59, Johan Jonker wrote:
>> In the driver spi-rockchip.c max_native_cs is limited to 4 and the
>> default num-cs property is 1. Restrict num-cs in spi-rockchip.yaml.
>>
> 

> Doesn't num-cs include gpio chip selects too?
> I have a setup with num-cs = <12> which uses non-native cs-gpios just fine

Given that bindings and Linux drivers capabilities are 2 separate things.
However this document has also a purpose that must notify mainline maintainers if users submit bogus DT values.
Currently that limit is set to 4 in the mainline driver.
You are free to submit a real board file/patch serie afterwords as proof for review with 12 spi chips and then adjust this limit and increase ROCKCHIP_SPI_MAX_CS_NUM.

Johan

> 
> Luis
> 
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>> index e4941e9212d1..00d555bcbad3 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>> @@ -65,6 +65,11 @@ properties:
>>         - const: tx
>>         - const: rx
>>
>> +  num-cs:
>> +    default: 1
>> +    minimum: 1
>> +    maximum: 4
>> +
>>     rx-sample-delay-ns:
>>       default: 0
>>       description:
>> -- 
>> 2.39.2
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 


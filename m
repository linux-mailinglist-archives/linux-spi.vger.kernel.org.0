Return-Path: <linux-spi+bounces-9131-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D1EB0B348
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 05:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F89E189E12D
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 03:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3CF1917D0;
	Sun, 20 Jul 2025 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZtaiJmg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6E189BB0;
	Sun, 20 Jul 2025 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752981911; cv=none; b=dJT0JRyAQ2e1bFbVQ7wiA0ABpGnHChbX0HlSZfWtTJkXHQNmW11eaxFxGq0vfkO/cJW7189BGj1s4RgkazOZqXWpaf5itjD82CiC4EtDyDpNCZi4d7tL6itCXqEVFWroG6EyuxqIGcPIZKidqc4hZjrsUg3GZh1Xm7P4QGxKiSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752981911; c=relaxed/simple;
	bh=CeQwnlZaJeJrVxDPgd4TrQH74wzcQw4oXR9oNKXwlcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EK7N9f2qZB7GIzGpMk880J37nG2E557QM0cWZ0MdXgR3J3fHF+u2xmCCNYIp4GIY7IA7+027r9vGzjFU8ir7w653XzAuUURpjVXLBi9BTtGcmC0imVfWTx0jNdCfMJPBsT9al8oYls21IvRb3kqmSZcQGV0bEJdjTiMARvaqOAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZtaiJmg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2350b1b9129so22286145ad.0;
        Sat, 19 Jul 2025 20:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752981909; x=1753586709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/UCEY4wxrS/NpA0nt1HOc0dP763s7JlyvgbRa5hrlcE=;
        b=kZtaiJmgUCGBufsGwAgdvcquvxPmWKRhakbARUWVsgOaAKkAUAIDQVCWX5ZrPq3ONj
         Kg0EDwZlU0Xhyg9PMm956qiFEa86iCEgggXJn8hZCbtfwnAaW65+F/gA2PiSK1OvXv8l
         LdPZr5jev2+tPGFXFyVD2NG0a2DWHiT1/SwBrINoS7Q4QGUOJ7fehAY21DHSZySb9Qmj
         Ma1YY2TAaMvw7S3RTfUXCeK1REtpuYjOrGSazph3E5zw0S/L1kG/W1wmiGQpNYrEhJbr
         Ya3sGoqoW2MmNg91wP6t7EeFn4m8JzXqVteI7vc9UltYXNLIkTxhzWFwdZejdsq/Oahh
         ekyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752981909; x=1753586709;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UCEY4wxrS/NpA0nt1HOc0dP763s7JlyvgbRa5hrlcE=;
        b=qzJtnfdz2HjSBE1xf1pCCZ+yBqS03qtbFXwteth1P0wB2ImwNv4aJTVzIN0Id+/u5g
         ky3w9uY47s7Oj/SPASIB2EiamPUaLeGA0tmrYdDCJdMqILFoGU95IVdyBfa6F6bv9rdS
         n5ef+zqV40poDOkREB4SxXTx0tuIE+ufAGF9eedLCzsU11niIar75hdkVYT9PbMh9T1b
         mfVvQUsAqkbiNPo+kUSf9ehNJ9kYIC3Ia4JrRTzwIQOXBOFw2wklXi2hrOMNVdLAl9E6
         ZgneyGmTmhOAXceY5afo7P6d58Z8D8VYU3RY+vqsJVWB8f1MepUzosx+skfvOIhtHKbr
         X+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUpDsdOepdfu0dxEf2+OCXOsjazzY8wXhyH7RN/io1DloQ2ZnOsbWDZ4MYvrrmvfjKNSC1iyMwJoP00J1l9@vger.kernel.org, AJvYcCW2JFrB217XQ8aIr9nDqiWViVlym0uZ/yK9a4djHSBTlDybHDvZ7ELosgTtwdslPoDaSQg1Q9pMBPAD@vger.kernel.org
X-Gm-Message-State: AOJu0YzDLdKyNamD2HOj7t4tulaOPixJ7vkzdR8bWQJEA2adY50PJ55+
	szOdSpX6YYR51Ck4/LAhR6pRrDgvVrVFPRgwQmQvRgBy/KJzkBRBKG/y
X-Gm-Gg: ASbGnctjDZEN0b/DQ2LyF7y0FHhvMYzUTLwQNAZ1zl9/uDJtAQxjErsvZSNYiFeWFC5
	aXwjAbYBVqwABT3eaSJfDK1y+ksh+5Z1tUzoJUjpokZH1TrYKq3T5CF8MfpFLrzz4uDtx329tE9
	gLyfFToRyWfTdlWawqOCg3uCA1asZpMuL3zrP59XUS8EDWPyrg3V1CkByGt3ym/Op4grqVho36C
	TATWhrU6qgxYLi2Ye/lNtp47fozO5UoIIS4JrHcETZ3Qia67zIj99/kEM+7nG9VZw76zwo/KA+3
	U8FBTgKfqNV15C6pILlkxJ4JZMLrU4VWatgsUzGa7HcHPWMi4CPJBkiIn4QgdOrG2cQqaOr4eKP
	qAw8/V3FDhLgaL/FO7/3PRz/Cs1P5yyvKIqbZZ14BsNtWBYeQJUUtOOKUUgRbo6LU8efN0K4=
X-Google-Smtp-Source: AGHT+IG8wJXRYieGimKQKhGTkevXaLtmeXilYhBC+8Z1j4PjscSVa78Sx5Ke62E/cR0MUub13w3vwg==
X-Received: by 2002:a17:903:2f85:b0:235:1962:1c13 with SMTP id d9443c01a7336-23e256aeee5mr217586595ad.14.1752981908613;
        Sat, 19 Jul 2025 20:25:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f2b4a40sm7727337a91.45.2025.07.19.20.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 20:25:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c972dcba-ec99-47e4-ad19-18ebe97dfdd0@roeck-us.net>
Date: Sat, 19 Jul 2025 20:25:06 -0700
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: trivial-devices: Document ABB sensors
To: Rob Herring <robh@kernel.org>, Heiko Schocher <hs@denx.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrei Lalaev <andrey.lalaev@gmail.com>,
 Chanh Nguyen <chanh@os.amperecomputing.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Grant Peltier <grantpeltier93@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, devicetree@vger.kernel.org
References: <20250719063355.73111-1-hs@denx.de>
 <20250719063355.73111-2-hs@denx.de> <20250720021151.GA931647-robh@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250720021151.GA931647-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/19/25 19:11, Rob Herring wrote:
> On Sat, Jul 19, 2025 at 08:33:52AM +0200, Heiko Schocher wrote:
>> Add documentation for spi based ABB sensors, which are
>> currently operated from userspace.
> 
> What is userspace? That has nothing to do with bindings.
> 

Taking one step further back ... what are "spi based ABB sensors" ?

Guenter

> Please provide some details about this h/w and convince me it is
> trivial.
> 
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>>
>>   Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index 27930708ccd5..25260c2b81df 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -30,6 +30,8 @@ properties:
>>       items:
>>         # Entries are sorted alphanumerically by the compatible
>>         - enum:
>> +            # ABB register based spi sensors
>> +          - abb,spi-sensor
>>               # Acbel fsg032 power supply
>>             - acbel,fsg032
>>               # SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
>> -- 
>> 2.20.1
>>



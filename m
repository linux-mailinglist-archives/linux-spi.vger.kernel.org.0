Return-Path: <linux-spi+bounces-4691-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E996E40A
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 22:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1021C22D74
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F3C1A4B68;
	Thu,  5 Sep 2024 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="FlpHb8kz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A161A2570
	for <linux-spi@vger.kernel.org>; Thu,  5 Sep 2024 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567899; cv=none; b=kbYfo147mKNm/G/UJvdIssux+g2Y5VbZckdk7fvEB7zzt04+VV4xVl9gO7gyZevvLRwO7sZwvbfnp5o6cQAqxcrK1+lLTMhhUE/PqU7wlS0t8hGKemh+Jfb1UeEvmC1jRWQh0RuZPdj88uniQjkfFNUHfA2QR1Lk2854JHrK+eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567899; c=relaxed/simple;
	bh=wvJODaIBgD1jUPLAQ4kNOzQaEXZUpgapfSzeNtFOXRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhTjDUFZTnVRV4jnRlSwzWY3BZYqwAZ1+1m+pMuB+2Zk1rs13JVaFiOPnCyi3g86Zq3RfHBU+MwUn3bItGr1nN0aN9pz81Ot64NiPnWK9HzPpk7nypFEDuPv9rXkvOrfYq9w/K/nm4AxRwzyfiq33y6xvhkHipZFZR/BOcoNGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=FlpHb8kz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so889333a91.1
        for <linux-spi@vger.kernel.org>; Thu, 05 Sep 2024 13:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1725567897; x=1726172697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MFqtA/E7v5gQ+W6lQ8y6AL+BzpP0eM4/rxOM2YdHIlk=;
        b=FlpHb8kzYDORq0QbPZFkH11NHAZgFVQBw4+9gvAZPatfjnoxjH/5LcJmbMid07hDUg
         WRFzLMRdxTv9L8MsK8L4EqqnAEC/VtjBF3qILWt5XKnH4qCy5GQoxRMKfFdK5dMZ0i+8
         acKxa9ilDb94rEPRa+/OfNeVit0U5Bfk8+13UeBox92eLC4fNq1C/743ZSDPgkolCpb1
         CwkTevUn0beRFFvyDvcWAez/PwotWT0ELIz/H+xUSlg8lNXY0ZQ7OOYGPuqerKa1WDfu
         nUtgj4GiVE3ooXiwGzpYBNZkZ+VWxfnGvUzWVeb1X3kE0xIhCuPvb9zSvqESeJmdJ0F9
         uJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567897; x=1726172697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFqtA/E7v5gQ+W6lQ8y6AL+BzpP0eM4/rxOM2YdHIlk=;
        b=RVD6Cq4ZY3XFIpCwCL3CcEeOIeINr3zAA5IH/8bCywmWBiZNrDMdKboK8/iYb6/HKP
         nKtUCaSeKmYxPXV5DmAw/cgxkY2M8/V6gqfKHlL9zKIaZFYMn/VEzw0OXnA+FrzesXRA
         iwFOpoDl6zCRXeqUG2JdO7RSzY4odJrPPTLPof5dOUpD9yNJEv5/fbCOEl/utJxLDjB6
         ODPDsI92OcXh4jMRLLrU3AXDLcfskrOKjsBJlKn9nadybmMELdGWF5WuU3ZKf0wYEBQG
         jnO5LH3RftOIttfJhqQf8HYUN+TgHOqyfzBXl09ZwjYuJJXAU1yTb2zmZN8c1jJr6dbX
         qr/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMIuNTgGOLv0/B6pYI8k3Suk6NNPPo4I+OzpzVfm1KKSwiWMeq/D8nQW1Zn0pCrLBeVYljHqX49gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoP/optZ+MCtipe2OTNhh59kGRrMxAwKdqJhCQk5TzMHNPDNTn
	LWSGhUAY/yrshFs/SRhtZxezlFTbjZ++/i2bb7cOwb9Yn6q3On7ZCMyNWcu2FA==
X-Google-Smtp-Source: AGHT+IHWsZrJ/0FG7b8hwchFVze0z1FJkzK5dQbSnSTMfUnlfMdkkmNUaojAuy0wmGiazF8Xhwp4mQ==
X-Received: by 2002:a17:90b:3cce:b0:2c9:6abd:ca64 with SMTP id 98e67ed59e1d1-2dad506f880mr762344a91.9.1725567896838;
        Thu, 05 Sep 2024 13:24:56 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8d38ffff9sm9454416a91.39.2024.09.05.13.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 13:24:56 -0700 (PDT)
Message-ID: <dfb5b79f-4241-4507-8aaa-3c57f3038c3f@beagleboard.org>
Date: Fri, 6 Sep 2024 01:54:48 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] dt-bindings: connector: Add mikrobus-connector
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
 Vaishnav M A <vaishnav@beagleboard.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, jkridner@beagleboard.org,
 robertcnelson@beagleboard.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>
 <D2AYUH4XY0SK.1SYOUCT0PLAKT@kernel.org>
 <e0f9754e-4d84-4ab4-82a4-34cb12800927@beagleboard.org>
 <D2AZMD2YYGAQ.1B3AGXIC7B44@kernel.org>
 <e2558820-f36f-406d-8f83-95c7188c0ce3@beagleboard.org>
 <CAL_Jsq+6ruu23UrwJ=NUUrh-9R_E5tKREv1AyU24op_uUigpNg@mail.gmail.com>
 <2d3fd95f-6f4d-49d9-a473-b4c5631a4fee@beagleboard.org>
 <CAL_JsqLEfBGQsJw6Vn2FnCrMOEmwhTq9ro2Qca7bBAM_UKZ6-g@mail.gmail.com>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <CAL_JsqLEfBGQsJw6Vn2FnCrMOEmwhTq9ro2Qca7bBAM_UKZ6-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/24 23:19, Rob Herring wrote:

> On Wed, Sep 4, 2024 at 12:09 PM Ayush Singh <ayush@beagleboard.org> wrote:
>>>> gpio-map is what you are looking for. It's documented in the DT spec.
>>>> It was created exactly for this purpose of remapping GPIO lines on a
>>>> connector.
>>>>
>>>> Rob
>>
>> Hi. I found docs on nexus nodes [1] and tried using it for mikroBUS, but
>> it does not seem to be working. Here is my connector:
>>
>> ```
>>
>>       mikrobus_gpio0: mikrobus-gpio0 {
>>           #gpio-cells = <2>;
>>           gpio-map =
>>           <0 0 &main_gpio1 11 0>, <1 0 &main_gpio1 9 0>,
>>           <2 0 &main_gpio1 24 0>, <3 0 &main_gpio1 25 0>,
>>           <4 0 &main_gpio1 22 0>, <5 0 &main_gpio1 23 0>,
>>           <6 0 &main_gpio1 7 0>, <7 0 &main_gpio1 8 0>,
>>           <8 0 &main_gpio1 14 0>, <9 0 &main_gpio1 13 0>,
>>           <10 0 &main_gpio1 12 0>, <11 0 &main_gpio1 10 0>;
>>           gpio-map-mask = <0xf 0x0>;
>>           gpio-map-pass-thru = <0x0 0x1>;
>>       };
>>
>> ...
>>
>> &main_uart5 {
>>       status = "okay";
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&mikrobus_uart_pins_default>;
>>
>>       gnss {
>>           compatible = "u-blox,neo-8";
>>           reset-gpios = <&mikrobus_gpio0 10 GPIO_ACTIVE_LOW>;
>>       };
>> };
>>
>> ```
>>
>>
>> After some fdtdump, I can see that at least the dtc compiler does not
>> seem to do the forwarding at dt compile time. Here is the dump:
> dtc knows nothing about it.
>
>> ```
>>
>> mikrobus-gpio0 {
>>           #gpio-cells = <0x00000002>;
>>           gpio-map = <0x00000000 0x00000000 0x00000025 0x0000000b
>> 0x00000000 0x00000001 0x00000000 0x00000025 0x00000009 0x00000000
>> 0x00000002 0x00000000 0x00000025 0x00000018 0x00000000 0x00000003
>> 0x00000000 0x00000025 0x00000019 0x00000000 0x00000004 0x00000000
>> 0x00000025 0x00000016 0x00000000 0x00000005 0x00000000 0x00000025
>> 0x00000017 0x00000000 0x00000006 0x00000000 0x00000025 0x00000007
>> 0x00000000 0x00000007 0x00000000 0x00000025 0x00000008 0x00000000
>> 0x00000008 0x00000000 0x00000025 0x0000000e 0x00000000 0x00000009
>> 0x00000000 0x00000025 0x0000000d 0x00000000 0x0000000a 0x00000000
>> 0x00000025 0x0000000c 0x00000000 0x0000000b 0x00000000 0x00000025
>> 0x0000000a 0x00000000>;
>>           gpio-map-mask = <0x0000000f 0x00000000>;
>>           gpio-map-pass-thru = <0x00000000 0x00000001>;
>>           phandle = <0x0000000e>;
>>       };
> You might need "gpio-controller" here. Though if you do, I think
> that's a mistake in the kernel. It should work like interrupt-map and
> generally you have either interrupt-controller or interrupt-map, but
> not both (though that is allowed now too).
>
>> ...
>>
>> serial@2850000 {
>>               compatible = "ti,am64-uart", "ti,am654-uart";
>>               reg = <0x00000000 0x02850000 0x00000000 0x00000100>;
>>               interrupts = <0x00000000 0x000000b7 0x00000004>;
>>               power-domains = <0x00000003 0x0000009c 0x00000001>;
>>               clocks = <0x00000002 0x0000009c 0x00000000>;
>>               clock-names = "fclk";
>>               status = "okay";
>>               pinctrl-names = "default";
>>               pinctrl-0 = <0x0000000d>;
>>               phandle = <0x00000081>;
>>               gnss {
>>                   compatible = "u-blox,neo-8";
>>                   reset-gpios = <0x0000000e 0x0000000a 0x00000001>;
>>               };
>>    };
>>
>> ```
>>
>>
>> So I am a bit unsure. Is the dtc parser in the kernel supposed to do the
> No such thing as "dtc parser in the kernel".
>
>> mapping, or is it supposed to be done by `dtc` at compile time?
> No.
>
>> Maybe we
>> do not have support for it in upstream kernel yet?
> Yes, there is upstream support. Grep for of_parse_phandle_with_args_map.
>
> Rob


So, after a bit of troubleshooting, it seems that a nexus node should 
not be present at root level (unless it also has an actual driver). If 
the nexus node is a root node without an actual driver, anything 
referring to the node is deferred.


I am still a bit unsure if I should make the `mikrobus-connector` itself 
a nexus node or if I should have a subnode named `mikrobus_gpio`, but at 
least things seem to be working now. So, thanks for your help.


Ayush Singh



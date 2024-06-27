Return-Path: <linux-spi+bounces-3643-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4D191AE61
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 19:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BA21F29765
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 17:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1D019A2AA;
	Thu, 27 Jun 2024 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="VNdS1+8y"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1591C6A7
	for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510245; cv=none; b=sHOh8kNVnYhdn9fF6M0Ir/4macHJIlAOKn1Lf24pK9Mt4EpkCjWWVU1/Dl/Pf+cs3MsaEyTTotCcnSXhynd0gCWcEUw+6VDB9ggn7ZVQVeJZArN76GhJLAjBprX/N6mZSWu8jhe+V5cTGrX+8V7yBREBr1Eqe+NxIG/2+l62NUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510245; c=relaxed/simple;
	bh=vcIwdKY0EP/84YGmwUhNIzcEbcCytsrcq4wbTWYu480=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDdxzXuG3GePihWDJp7yUkP48uTm7zE8mAhEOiSzUuQBaaJn79WMAftnVG4Xx2eqiPFTRrAeXLceV2B061QfOQs3OpqcxLsznUev/VizEsoxU1/P05JxfXGP3nmOlh3Vd9GtCklB2MwkVUHpOv/YGXaKTahqPx2bHYsZlFdt2FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=VNdS1+8y; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6c2d04b0833so334543a12.2
        for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1719510244; x=1720115044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vv3RkHj5qVyzhhNw70UviSSMsgyw+mXFjS3DERvERac=;
        b=VNdS1+8yDLeAmfWn63iovgbJH2uiyZJEOEHE+Ay3kmKfcOhzcJnta+ZNeJRRriVy6K
         IYZeghjTa/Kcri9byu3fm+ldx0nxWY7jKNkVJiKOFh2UYJ9x7SXoGzvXX0+jsQGD45Y2
         3G4yj0+BWGm+KDcf4qJ3ZpXoHYSoiekc5f5lkITNUPvrplfo9MzeaGU7r2x4Q27xyfQ5
         B+b+0ZXUPQ63Vs2OKLq2gGFY00cUph0hwDMHJ8V+YGPeZiDFjSiK5hQZrq3bcTBYZ6dU
         kEOeXWoeP/tJMdIW5N0xw5beK7E6VN6IMw4zNE9DdBN7Ti4qthOzdzP/3BMkK18nlmI0
         A/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719510244; x=1720115044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vv3RkHj5qVyzhhNw70UviSSMsgyw+mXFjS3DERvERac=;
        b=tohSL+Ol5twSbn8lkk31tRgBcCsZ4V08og3B1Z473NKHslmoUeOdjj1xx+c+cJWjgi
         P6xZXOcWxDf+EYosfTtsV6aEyhApOWAAJj9UA1RJ90Jeua92OG/731KKPgP8LKom1LZe
         i9VJp9kx0d79EY9ulen9ie6drni5iD+I7LLkWkp/Cg0t9HK1kM32LxRT0sHNkyj/HkOz
         0tqJqQur8VJmoeuA8X3CfzuKIlnZD/yprx+/FVzGYB8zcQNCVDfunhKrsoD7a527JVP4
         6cQ7IeyMZNMNrykp2ogYYJ3KVzWBVlejdKv4ixdnypWo3yQ9pc07qtB83QVUopUeaIet
         /AfA==
X-Gm-Message-State: AOJu0YzbAvubH9jWTM7EhH1en0QQ6YCaujJpyULNK0RZdYdtgXWxLSHE
	hW0tmmUpRTmMKV4QiB1PDb0pSTQtd048OXaS+wXdvkBgsDfW8JsAvRAHAlt0Yw==
X-Google-Smtp-Source: AGHT+IFWsmGs19cCV3TdLReK8RcFiPpPZrw4wi58uIgJm5x5o0oe1yH8EQjLmPECs5E+1GtaCvH4KQ==
X-Received: by 2002:a17:902:e888:b0:1f8:6e3f:9e7 with SMTP id d9443c01a7336-1fa09d94a65mr172005795ad.1.1719510243687;
        Thu, 27 Jun 2024 10:44:03 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3e:18b0:f314:9f76:9f94:eb43? ([2401:4900:1f3e:18b0:f314:9f76:9f94:eb43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535cc8sm191425ad.122.2024.06.27.10.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 10:44:03 -0700 (PDT)
Message-ID: <583334ad-2f87-479c-a4c6-bd4da11bae31@beagleboard.org>
Date: Thu, 27 Jun 2024 23:13:54 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] dts: ti: k3-am625-beagleplay: Add mikroBUS
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Andrew Davis <afd@ti.com>,
 Mark Brown <broonie@kernel.org>, Vaishnav M A <vaishnav@beagleboard.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, jkridner@beagleboard.org,
 robertcnelson@beagleboard.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org>
 <4e23ec81-b278-4f2b-815d-64ed9390ca55@ti.com>
 <D2AZ0QKTPY3B.1I48GLI90XD0P@kernel.org>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <D2AZ0QKTPY3B.1I48GLI90XD0P@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/27/24 22:51, Michael Walle wrote:
> On Thu Jun 27, 2024 at 7:07 PM CEST, Andrew Davis wrote:
>>> +	mikrobus_boards {
>>> +		thermo_click: thermo-click {
>>> +			compatible = "maxim,max31855k", "mikrobus-spi";
>> I might be missing something, but your solution cannot possibly be
>> to list every click board that could be connected (all 1500+ of them)
>> to every mikroBUS connector on every device's DT file..
>>
>> Each click board should have a single DTSO overlay file to describe the
>> click board, one per click board total. And then that overlay should
>> apply cleanly to any device that has a mikroBUS interface.
>>
>> Which means you have not completely solved the fundamental problem of
>> abstracting the mikroBUS connector in DT. Each of these click device child
>> nodes has to be under the parent connector node. Which means a phandle
>> to the parent node, which is not generically named. For instance
>> if my board has 2 connectors, I would have mikrobus0 and mikrobus1,
>> the click board's overlay would look like this:
>>
>> /dts-v1/;
>> /plugin/;
>>
>> &mikrobus0 {
>> 	status = "okay";
>>
>> 	mikrobus_board {
>> 		thermo-click {
>> 			compatible = "maxim,max31855k", "mikrobus-spi";
>> 			spi-max-frequency = <1000000>;
>> 			pinctrl-apply = "spi_default";
>> 		};
>> 	};
>> };
> If there should only be one DT overlay per click board, how would
> you apply that to to different connectors?


See my other two replies for more context:

https://lore.kernel.org/linux-arm-kernel/cef08d49-a462-4167-8b9d-bf09e8aac92f@beagleboard.org/

https://lore.kernel.org/linux-arm-kernel/e0f9754e-4d84-4ab4-82a4-34cb12800927@beagleboard.org/


My ideal design is that most mikroBUS board configs will be defined in a 
`dtsi` file which can be included by any system with mikroBUS support. 
This file might look as follows:

```

/dts-v1/;
/plugin/;

/ {
	mikrobus_boards {
		thermo_click: thermo-click {
			compatible = "maxim,max31855k", "mikrobus-spi";
			spi-max-frequency = <1000000>;
			pinctrl-apply = "spi_default";
		};

		lsm6dsl_click: lsm6dsl-click {
			compatible = "st,lsm6ds3", "mikrobus-spi";
			spi-max-frequency = <1000000>;
			pinctrl-apply = "spi_default";
		};
	};
};

```


And the board overlay will look as follows:

```

&conector {

     board = <&lsm6dsl_click>;

};

```


I do have an experimental configfs entry that passes the mikroBUS board 
id(s) and creates and applies the dt changeset to the connector dynamically.


>
>> I think this solution is almost there, but once you solve the above
>> issue, we could just apply the right overlay for our attached click
>> board ahead of time and not need the mikroBUS bus driver at all.
> The bus driver would still be needed to do the enumeration of the
> children, no? And it could make the chip select translations etc. So
> you can use the normal bindings of these devices.
>
> -michael


If static dt was the only method to detect the board, then it would be 
fine. But boards with 1-wire-eeprom can allow for for dynamic detection 
if the overlay can be system agnostic.


To make the dt system agnostic, it should be possible for the board to 
specify the following information:

1. If a pin is supposed to perform its normal function (UART TX should 
actually do UART TX), or if it should work as say GPIO (Eg, using RST 
pin as SPI chipselect).

2. Which pin(s) are the SPI chipselect.

3. If a particular pin needs to be pulled high or low for the board to 
function, etc.


So while most of the normal properties of SPI devices can be reused, 
there is a need to introduce new properties for additional information. 
In the previous patches, MikroBUS manifest was being used for this 
purpose, but for a full dt driver, the device tree needs to be extended 
to specify these extra properties that are not relevant to the 
non-mikrobus variant of the device.


Ayush Singh



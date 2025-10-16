Return-Path: <linux-spi+bounces-10701-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D970BE4357
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 17:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83EED359656
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515BF3469FC;
	Thu, 16 Oct 2025 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FGWdwkd7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE193469F1
	for <linux-spi@vger.kernel.org>; Thu, 16 Oct 2025 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628347; cv=none; b=vFhe+lldPn5SPOoK1RSM9idD8nj4T6h+8v+UA+Nh7FAI13GQy307PjvWj7lAbJ3o7gDOMEOiMJT6zulvnaxgPdTlxpQXRujZHUMakdKi6LDPXDS4BFY7P25A/iWGtjA9KUeyRQpVRm4Vk9SCYyVwvxhkYQKbBBS8TkOgwHPj1qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628347; c=relaxed/simple;
	bh=oZuGEFGbX6oR0toYc711vT3FrpnAZW4F24vLJVW9nwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Za4d4N5mWZKH/P3opHrjWqOBLicrQLL1L8LFUhmhP8HQsfMVr9jKI52onxcFeOfcn9+8x81KGla7qNOHCLagTajuQVjbmeMr2xtpNNXcZM89s/iF1KmMD+Usx2uBW0VbOL3UTF3CA6E5OZI2LM30X4BClC11QAptA3bxXt5GOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FGWdwkd7; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c12ddebffdso279288a34.2
        for <linux-spi@vger.kernel.org>; Thu, 16 Oct 2025 08:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760628344; x=1761233144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRDJom06kYcViBp21r1cNp18crk2JJxYu33qcIgFpss=;
        b=FGWdwkd7ouRELbSqq2TQQfswdgp2k18cXEu7ZoJpAXpr61P6d0C6i74YMKp2S+MQP9
         oWSguH5b6LNbJ/7A3mnb78J3F3fZpm7G0rn6ClxbLacHeYLaQIsi10yCD2eu/bXXp3c2
         8MmzoeYu+sy7L+mupzp8NJ1kQVr0YbbKfaUmNwqni6peA/Cc4K3yGkGKwfOIa2llWsVl
         VTffrL2U2Ix+FMxmvMG5GjWqfT0QB+mC/Q1JALVOrn3astBxAIkt+5e4JmXOv+grugNq
         qE1iRSaS/bmUxrXr2kra0H2wuM+pvM3UgeRwO9R0fID4xT2rNi5ZKHZyaz1HtBjWycRc
         KtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760628344; x=1761233144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRDJom06kYcViBp21r1cNp18crk2JJxYu33qcIgFpss=;
        b=rdNRGMgJ1Lcdg2263iDcCrryN99LAeOsZu30ZM3DlOmsF/xVWSPsTH7W9gkwc7OW+/
         crXIByb0i/5/mB/1A4coQ26kLSwnYgZXva51LgvyAC78smp66eRHptN5rkhlXVHn08av
         AHPKnL+luFgl2qqHTOpDyDvrWXO7hDXoAgeVGbt8HPh72jhV5YiMRpVEJBas4cG8dM3M
         iSsFaA7mUr/uhDAzpf1LHYaSX/YXTpNR7C4QTDcYH1FW7Z28uLj5+R80GoazGgWb5kOn
         RznRorp1dmFCnMvuEzhi9cZmKUJ0/Nu7piza8yDWOG9RPX8MfIlqeTfSahB8zbGuTcrT
         eueA==
X-Forwarded-Encrypted: i=1; AJvYcCXqY3n2QSdPoJzuT5AHt7lUTMUfC0brmaFD5SBm+lOVe3tjYAhp0ClXV8hfGGcrXhJrMGPlbAFXvfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyD1wUf8oO25o3veDp0/6OON+rFsjNgr8+WUQD1y/aztQEQ8H0
	oxBEffabEL9vRjExNLkM0jsSisqexFnp+hTWSGuo/R5qQO7hdUGnsG1WUbt+Ab5Avtk=
X-Gm-Gg: ASbGncuCaUCVR7Nuy0SJzugWvLNOLGVObchNJgm2W0mZGGLamnjeMW7TM8mWp28jUPt
	s3h11X3nqoX/wF/FqszD6fuY8OZwT3ShjR8aYWKcoS5cXYT3Z7vgnoICXEnXX37u6hF98VQl2qm
	8Q8WbYB6p8AvL93isXR6/83M2fPPKlffexTq+A/Bb3FYQFj3OJyNoMsjcLLkhjEr8C7YcsTpNeB
	3Es94v4xVpCJVo8vkREkJ6bk4P8DY7kdZxoKyXGajS5E3X5rkeEkeca8Um9oq9KdN1AWsB8BdWk
	SQxJzaVd7715afHBwblJOHcXq2c42VJT2a4a6sG056GY42jFiRwllncotQp0Yxp3o38fpAsKjnq
	8Iv0mW0SzYzNh78X+BoTNzfO/+khktr2KI66lQpBrRTtG79bdSSrLW6UUmdnmwQ2myS333CcdrZ
	bn85JLC3RPeBHyS2hcPYhZ6CaOYZwbGkazIrA0wQvS36FcMy2gUQkUApmNuw==
X-Google-Smtp-Source: AGHT+IHQd1etEc00vCfr9TOASkqT9Pb4HP9nTzlHiZYHvdxM+5kCvGAInuFv8f6kXQRiRquoh7Foww==
X-Received: by 2002:a05:6808:14c8:b0:441:896c:fab7 with SMTP id 5614622812f47-443a2ea6fedmr179835b6e.9.1760628344051;
        Thu, 16 Oct 2025 08:25:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:86b5:623:b364:9913? ([2600:8803:e7e4:500:86b5:623:b364:9913])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-651c2c40b4dsm354513eaf.20.2025.10.16.08.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 08:25:42 -0700 (PDT)
Message-ID: <66f94eb6-15a9-457f-a7b8-47710652a34b@baylibre.com>
Date: Thu, 16 Oct 2025 10:25:41 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] spi: add multi_bus_mode field to struct spi_transfer
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
 <9269eadc1ea593e5bc8f5cad8061b48220f4d2b2.camel@gmail.com>
 <409ad505-8846-443e-8d71-baca3c9aef21@sirena.org.uk>
 <12db0930458ceb596010655736b0a67a0ad0ae53.camel@gmail.com>
 <8c7bf62a-c5dc-4e4d-8059-8abea15ba94e@sirena.org.uk>
 <d9455d90-31ca-4be7-b17c-2b339e92f8a0@baylibre.com>
 <9024f05854dcc3cc59345c0a3de900f57c4730d9.camel@gmail.com>
 <ad929fe5-be03-4628-b95a-5c3523bae0c8@baylibre.com>
 <c4b5a42f5f1d3f577cb986946b642b4edc1300e9.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <c4b5a42f5f1d3f577cb986946b642b4edc1300e9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/16/25 4:08 AM, Nuno Sá wrote:
> On Wed, 2025-10-15 at 13:38 -0500, David Lechner wrote:
>> On 10/15/25 11:43 AM, Nuno Sá wrote:
>>> On Wed, 2025-10-15 at 11:15 -0500, David Lechner wrote:
>>>> On 10/15/25 10:18 AM, Mark Brown wrote:
>>>>> On Wed, Oct 15, 2025 at 03:43:09PM +0100, Nuno Sá wrote:
>>>>>> On Wed, 2025-10-15 at 13:01 +0100, Mark Brown wrote:
>>>>>>> On Wed, Oct 15, 2025 at 11:16:01AM +0100, Nuno Sá wrote:
>>>>>>>> On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:

...

>>
>> The AXI SPI Engine doesn't know how to do the quad SPI part yet though, so
>> it isn't something we could implement right now.
>>
>> If we tried to do it with spi-buses = <8>; then we would end up with the
>> "interleaved" bits (or nibbles depending on the wiring) that requires the
>> extra IP block to sort out when using SPI offloading. Technically, we could
> 
> I think that extra block already exists today. I was thinking the idea was just:
> 
> // the case where we just have one channel with eg: 32 bits words (eg: test
> patterns) 
> struct spi_transfer example = {
> 	rx_buf = rx_buf;
> 	len = 1; /* 1 32bit words */

This would still need to be len = 4; since there are 4 bytes in a
32-bit word. (If this was tx with SPI_MULTI_BUS_MODE_MIRROR, then
len = 1 would be correct, but for striping, it is still the length
of all data combined).

> 	/* 4 lanes which is actually quadspi */
> 	multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE; 
> };

This will work with the caveat that for non-offload case, the software 
will need to rearrange the bits in rx_buf into the correct order after
the spi_sync().

For example, u8 *rx_buf will contain bits of the 32-bit word in the
following order:

rx_buf[0] = b28 b24 b20 b16 b12 b8 b4 b0
rx_buf[1] = b29 b25 b21 b17 b13 b9 b5 b1
rx_buf[2] = b30 b26 b22 b18 b14 b10 b6 b2
rx_buf[3] = b31 b27 b23 b19 b15 b11 b7 b3

The correct order of course would be (assuming little endian):


rx_buf[0] = b7 b6 b5 b4 b3 b2 b1 b0
...

And for the offload case, it would require an extra IP block between
SPI and DMA to rearrange the bits in hardware. So to "do it right", the
driver should be checking for a hardware description that such an IP
block exists in the pipline before creating such a SPI xfer.

> 
> I still did not looked at how the stripe mode is implemented in the hdl IP but
> maybe the above would work as we get 8 bits per lane and we do have the data
> reorder IP (or at least used to have) after the offload engine. 
> 
> That said, I do see now the above is not the intended usecase for this series
> and even if it works we kind of have to hack the xfer len to 1 which does not
> reflect reality.
> 
>> make it work, but it would require a bunch of extra hardware description that
>> the driver would have to interpret in order to correctly format the struct
>> spi_transfer. I was hoping we could avoid that and just teach the SPI Engine
>> how to do dual/quad SPI like other SPI controllers.
> 
> Agreed!
> 
> - Nuno Sá
> 


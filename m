Return-Path: <linux-spi+bounces-7485-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0314A82477
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 14:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1674C82ED
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696C26158B;
	Wed,  9 Apr 2025 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0h3yKRZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A467D25E476;
	Wed,  9 Apr 2025 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200541; cv=none; b=gU3nWDpIb7Q7+DbI4sEr7s9dqb4Tl1z607P+PcRdI8G4gz/I6VjsnRoimsdCtdskU0dQgxhOVvAC8Q/gtQIzk/aZogtfjA+Ezgj+ZbHBoWHijRfpCLJtmgzcDRy8bJ6H5/mZj91u4xH0QapbcdJbxRnisoy/zRw8mJrhb0xAHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200541; c=relaxed/simple;
	bh=b5H6XBMBRKX+AtB67h5AfxGb16PNAyyMrCcBOBIj4fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eo9WPsL4GPotLKwUG0QzjSW43CA7rvDau+p8qdiS+yQPFf1KinsHZFbt5/Z5qCbzi/5hFk2gJPoy3Jobe7IZrlfKO2DYrJamVRFIkA9aE/0j2ndLJPi+FQcmm6b3MKysEwt2KMEmeb4s+9V1X8iF5sPSpxzZ/98S7NW0FZKqsks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0h3yKRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34D7C4CEE7;
	Wed,  9 Apr 2025 12:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744200541;
	bh=b5H6XBMBRKX+AtB67h5AfxGb16PNAyyMrCcBOBIj4fY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N0h3yKRZOEb9eUHFx+tEjwCUKkVfbPkHQ/HTZI9vTfOinIpVFxLPoHv4SV4kTjRs1
	 zTKkdgsQ6XcM0Is9xCeynlCiPPBtCFowklh+7M3UBiFghlU3q69796WFEV14neb+Z7
	 EegZ24sdh+A6cNeC8icNRc5x+7iuzvU2/Vy9KKcjpruRFPDKus13KHll+/6CvZoLel
	 Qv3eA7BBAT13q3/gErnhDQO/dEhRr1XUJsl0D/wgiob6zla533fCP8keiLdQtqPenW
	 TExyLjD0IsR4oweXEBVcb6vqJrQ+mptf3u6lIUi3T/Myn95i/mEgyyTfHtmyZJqyYF
	 OOoPM8yC8H2dA==
Message-ID: <41954d00-0abe-40ea-8d8a-2201e6e75743@kernel.org>
Date: Wed, 9 Apr 2025 14:08:56 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] ASoC: renesas: add MSIOF sound Documentation
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
 <87y0wa9mb2.wl-kuninori.morimoto.gx@renesas.com>
 <bd15c145-c175-468d-a1ac-1ad157358aea@kernel.org>
 <CAMuHMdUiO2mVzYn4PGZwUat6W_0JQjD3be7X6ThzK7vcPisKEg@mail.gmail.com>
 <20250409-functional-cheetah-of-honor-b9d9cf@shite>
 <CAMuHMdWto+2Kyecc5B+PvcF6+fXkmLf-skpX+rmRb3O68bbeAQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <CAMuHMdWto+2Kyecc5B+PvcF6+fXkmLf-skpX+rmRb3O68bbeAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2025 10:09, Geert Uytterhoeven wrote:
>>>>
>>>> If you have duplicated compatibles then:
>>>> 1. It rarely makes sense because you claim that two different devices
>>>> are using the same compatible. Different device, different compatible.
>>>> 2. Or if this is really same device, then only one schema.
>>>
>>> This the same device, but it can be used in two (actually more)
>>> different modes: SPI and I2S.  Hence it has two separate DT binding
>>> documents.  If this needs to be merged (the result is gonna be ugly):
>>
>> ... then next time don't post incomplete bindings. I know we do not have
> 
> :-)
> 
>> time machine, but any mess is on contributors who posted some limited
>> scope/view of the hardware entirely ignoring the rest of interfaces.
> 
> This is the first time someone implemented I2S using MSIOF on a system
> intended to run Linux.  Note that MSIOF is not even limited to SPI and
> I2S.  It can be used as a generic synchronous serial interface, too. So

So like a serial engine for UART/I2C/SPI? I think all or most of new
SoCs since few years switched to these.

> far no one did under Linux, so it is not reflected yet in the bindings.
> MSIOF is also used to provide a clock signal to a PMIC on some older
> R-Car boards.  As that PMIC has no upstream Linux driver, no one ever
> implemented support for this mode in Linux.  So I guess I should be
> pro-active, and add #clock-cells to the unified MSIOF DT bindings, too?

Yes, probably. Although missing cells is easy to change but missing
protocol, like this patchset here, is quite more challenging.


> 
> Note that there are other devices to consider, too. E.g. SCIF can
> not only be used as a UART, but also as a USART, SPI, or even I2C
> controller... (currently Linux with DT supports the UART personality only,
> but drivers/spi/spi-sh-sci.c does exist for SH).

Just like all serial engines for all other SoCs and there are no
problems with them... Why is this somehow different?

> 
>>> where to fit it in the DT binding doc hierarchy?
>>
>> Does not matter, whatever fits better in overal picture/purpose of this
>> device.
> 
> OK, hence the existing SPI bindings....
> 
>>>>> +  dmas:
>>>>> +    minItems: 2
>>>>> +    maxItems: 4
>>>>
>>>> Why flexible?
>>>>
>>>>> +
>>>>> +  dma-names:
>>>>> +    minItems: 2
>>>>> +    maxItems: 4
>>>>> +    items:
>>>>> +      enum: [ tx, rx ]
>>>>
>>>> How would that work? tx rx tx rx? And then driver requests 'tx' (by
>>>> name) and what is supposed to be returned?
>>>
>>> The module may be connected to one or more DMA controllers (see below).
>>
>> Yes, but how the implementation would work?
>>
>> Anyway, this needs to be strictly ordered, not random rx rx tx tx or rx
>> rx rx rx.
> 
> Why?

Because that's the standard DT rule, so unless, you come with a need to
bypass the rule, standard applies. Why? Because implementations can use
one of two ABIs - name or index - and binding should allow it. The names
are for cases where entries are optional in the middle, so you cannot
use index. Only for that. You cannot use that exception and make a
standard case "now I want flexibility everywhere". No. Flexibility is
only for special cases.

> 
>>>>> +
>>>>> +    msiof1: serial@e6ea0000 {
>>>>
>>>> serial means UART controller. You need name matching the class of the
>>>> device.
>>>> Node names should be generic. See also an explanation and list of
>>>> examples (not exhaustive) in DT specification:
>>>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>>
>>> What is the recommend generic node name for a flexible serial device
>>> that can operate as (a.o.) either SPI or I2S controller?
>>
>> i2s
>> or even not so generic msiof, but definitely not serial because that is
>> reserved for UART.
> 
> The MSIOF device node lives in the SoC-specific .dtsi file.  Its use
> case is not known in that file, and specified only in the board
> .dts file.

sure, so call it serial-engine. or msiof.

Not serial. Why? well, I said twice - it is reserved by dtschema for serial.


Best regards,
Krzysztof


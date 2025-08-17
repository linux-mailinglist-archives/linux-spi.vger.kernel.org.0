Return-Path: <linux-spi+bounces-9493-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA101B291FF
	for <lists+linux-spi@lfdr.de>; Sun, 17 Aug 2025 09:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92BF201F34
	for <lists+linux-spi@lfdr.de>; Sun, 17 Aug 2025 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAE520AF98;
	Sun, 17 Aug 2025 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSI8vqTN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9D1D61AA;
	Sun, 17 Aug 2025 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755415259; cv=none; b=akfm29dSp3HT6F8nufIK6Rha49EYgl1gPrNh4zswbWtgXaqvq6M/mFfs55SDnJudj+oKTVaOCq4kf5khvGaFdMv3uR6TI+q1sJrWA4xLDJWTgbLOVFvgwdPG6ZQlNBi3m96UIWHQpVWvU+IXbwgg5a5+pWGy7z4sAVvftHV2b8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755415259; c=relaxed/simple;
	bh=JQ9I2ZA6NpxuMGRw8pMBYPM7Uq05lyYD7RorcnDzmE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/LI7/ji+WedAkDIx2NSeWyATlQD1uhHJOZH4HvdFhniRC7Ew50TCzwVHGdOfZ4uIexfxrMEOkJFLOdhtTvcAYT+K69YuTz3glFYdiTjqS8jqGQKcH8LJUkFShmw2WvE1Mrh9xe9fppgkp0ixpm3iNXhzprKZTJMVw0BC9xgAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSI8vqTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A674C4CEEB;
	Sun, 17 Aug 2025 07:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755415258;
	bh=JQ9I2ZA6NpxuMGRw8pMBYPM7Uq05lyYD7RorcnDzmE4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lSI8vqTNzeBPDxdLTp2i2cQaiaCWOq9avtgUBF0WanE+AzYS2kW+QiH+9XEVOKbzK
	 K1YxBet3nf1oZjkwZoL7StOOhAIu8cAuu08zGQAM/E7lN/SdhUJYQ6XPQmUHa95Rl+
	 sW+VLqEH2Pcbqp05UuFgokqjlcUXCwkYZbbqKpBnr1fo2p/XI5J0da5FgEqPcvIUKa
	 5BLd4OYX/ZIyNCNe1HtY/EKvNBenMCVE4Go1iSDMOJ2+pwqZKIqyHi7k9yI96RUg2M
	 EwPgBZ9mY/XFDV8qQON3sBWLfV/XhMREB5uxpAicYALqVxuuOZQG3nrVimz+H3Yb25
	 3C0eJ7Rezd3AA==
Message-ID: <d8248069-c12e-4f72-a625-c4f68aa42f1f@kernel.org>
Date: Sun, 17 Aug 2025 09:20:54 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] spi: dt-bindings: add doc for Amlogic A113L2 SFC
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>,
 Feng Chen <feng.chen@amlogic.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org
References: <20250808-spifc-v1-0-ff4e30e26a6b@amlogic.com>
 <20250808-spifc-v1-1-ff4e30e26a6b@amlogic.com>
 <20250808-adamant-fat-raven-38c8b3@kuoka>
 <7fab19de-8ed1-4fe5-b2a4-a7e9c13d8424@amlogic.com>
 <5cc336bc-f071-41d2-b59a-af0df23af00b@kernel.org>
 <d872a711-7442-4e2e-bc59-0d6f4f656fde@amlogic.com>
 <017a4d15-286d-4e0a-89ff-f658009a6de6@kernel.org>
 <cf825229-7294-4fc5-b7dd-09dc1198db74@amlogic.com>
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
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
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
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <cf825229-7294-4fc5-b7dd-09dc1198db74@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/08/2025 08:38, Xianwei Zhao wrote:
> Hi Krzysztof,
>     Thanks for your reply.
> 
> On 2025/8/14 00:19, Krzysztof Kozlowski wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 13/08/2025 11:34, Xianwei Zhao wrote:
>>> Hi Krzysztof,
>>>      Thanks  for your reply.
>>>
>>> On 2025/8/13 15:36, Krzysztof Kozlowski wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> On 13/08/2025 08:13, Xianwei Zhao wrote:
>>>>>>> +allOf:
>>>>>>> +  - $ref: /schemas/spi/spi-controller.yaml#
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    const: amlogic,a4-spifc
>>>>>>> +
>>>>>>> +  reg:
>>>>>>> +    items:
>>>>>>> +      - description: core registers
>>>>>>> +      - description: parent clk control registers
>>>>>>
>>>>>> Why are you poking to parent node or to clock registers? This looks like
>>>>>> mixing up device address spaces.
>>>>>>
>>>>>
>>>>> The SPIFC bus clock multiplexes EMMC modules, so the corresponding
>>>>> frequency division register is also in EMMC module. The SPIFC and the
>>>>> EMMC modules cannot be used simultaneously.
>>>>
>>>> Then obviously you cannot put here EMMC or parent registers.
>>>>
>>>> It looks really like you miss proper hardware representation.
>>>>
>>>
>>> It does seem a bit unusual. However, in our hardware design, EMMC and
>>> SFC modules are integrated, and they share common resources such as the
>>> clock and I/O pins .They are mutually exclusive.
>>>
>>
>> How did you express it in DT? This looks similar to serial engines and
>> such are not implemented independently.
>>
> 
> The hardware design provides this clock for both modules — EMMC and 
> SPIFC. A control bit (bit 31: Cfg_NAND, where 0 = Port C only, 1 = NAND) 
> is used to determine which module uses the clock.
> 
> It's not that NAND is using EMMC’s resources; rather, the configuration 
> register controlling this selection is located within the EMMC module, 
> which makes the setup appear somewhat unusual.

No, how did you express in DT that they are mutually exclusive?

> 
> In the device tree (DT), I'll just refer directly to the clock frequency 
> division control register.

This does not solve the exclusive usage...


Best regards,
Krzysztof


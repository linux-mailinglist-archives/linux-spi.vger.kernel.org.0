Return-Path: <linux-spi+bounces-8305-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03109AC4851
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 08:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979933B3B0A
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 06:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5821D7E5C;
	Tue, 27 May 2025 06:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEVaxzp1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0F91A275;
	Tue, 27 May 2025 06:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748326952; cv=none; b=KIzUSz1IrKiWqa6E97nC9CLPLkDNWORUM6er5k+dSLnnXs6tlpyZoLdvb0gLmrScm0ddod8NU3rK2HCDKBrPUT/bXWtXwPLUBkedryXJhxr3a9DwV3GyP2mg0jB4ZVuJqFEDitmsh/cUTqmKHIAzB6H2LTtj1vU1VwO8Glwvq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748326952; c=relaxed/simple;
	bh=uMhzJEnISnkAz4/I6xvIqtlsw5R7K1OhMifpQIBtYS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ki7zSlVHafqUh28d+UJTTcMerdzvVtGV8tHpS4NzvsOsRyX98T9aMznEZET6++s6Kn/NYDHnZ2Fu20O8cxhnikp6hOvCZ+oLPaLdQxK2LBYmotyM/1AzS4Abg/IDlnHPS5vp0ziPw4L0wXKZ+E8mYbqNQ20M2Zt13H/Tnifgbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEVaxzp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABA1C4CEEA;
	Tue, 27 May 2025 06:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748326952;
	bh=uMhzJEnISnkAz4/I6xvIqtlsw5R7K1OhMifpQIBtYS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gEVaxzp1f/NRjOBoynXk187lzAQbiUGRc6ufouUcBqnfppYsnNb6Ja40MfZZE9Mwd
	 bv4s/IOrZhNWhnRCSVLyxt0i9IhCjrs+1uEHTCHZ6k3uwcdAaQdeMQsb2PSk3GBzSt
	 JqAq6iWYk2/XIfOsZPuAdDrq18GKJkmILZD3oUIbS0thilv6JFTs9lO+etOksyVwEX
	 F6TUaHDw+R2gqZxVS1BMcf3jiIfXN3if5ndrkfNW4JiFS3KEIv9YZoaKNd88/5CbGc
	 7+2A21QZvhpb0zoHYYsm/Y5TFtPABYwEfzse8nnkTEy2EUVjoaSkxPnDi85Wsbw1vU
	 2tZC8+B3bOgNQ==
Message-ID: <c1e0bfde-03e4-4f77-a8b4-892ae3a82306@kernel.org>
Date: Tue, 27 May 2025 08:22:27 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: dt-bindings: cdns,qspi-nor: Update
 minItems/maxItems of resets for Cadence OSPI controller
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 Conor Dooley <conor@kernel.org>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
References: <20250522104745.327675-1-amit.kumar-mahapatra@amd.com>
 <20250522-dropout-hertz-6f1db9256655@spud>
 <IA0PR12MB769903933CC9200FD082143BDC65A@IA0PR12MB7699.namprd12.prod.outlook.com>
 <6b71bbef-84f6-4255-b8b2-cf50c5183235@kernel.org>
 <IA0PR12MB76991D522A8E47DDA3800EE5DC64A@IA0PR12MB7699.namprd12.prod.outlook.com>
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
In-Reply-To: <IA0PR12MB76991D522A8E47DDA3800EE5DC64A@IA0PR12MB7699.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/05/2025 08:05, Mahapatra, Amit Kumar wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> Subject: Re: [PATCH v2] spi: dt-bindings: cdns,qspi-nor: Update minItems/maxItems
>> of resets for Cadence OSPI controller
>>
>> On 26/05/2025 09:07, Mahapatra, Amit Kumar wrote:
>>>>>    - if:
>>>>> @@ -132,11 +139,11 @@ properties:
>>>>>      maxItems: 1
>>>>>
>>>>>    resets:
>>>>> -    minItems: 2
>>>>> +    minItems: 1
>>>>
>>>> I think you're still missing one of the things Krzysztof requested on
>>>> v1, cos you reduce minItems for all platforms without restricting it
>>>> back to 2 for non-versal platforms.
>>>
>>> I believe we can remove the "resets" and corresponding "reset-names"
>>> properties from here, as their default minItems/maxItems are already
>>> taken care of in the else block [1].
>>>
>>> [1]
>>> https://github.com/torvalds/linux/blob/0ff41df1cb268fc69e703a08a57ee14
>>> ae967d0ca/Documentation/devicetree/bindings/spi/cdns%2Cqspi-nor.yaml#L
>>> 39
>> I don't see anything fixed there.
> 
> The intention was to point out the redundancy related to the 'resets' and
> 'reset-names' properties. At [1], the default minItems and maxItems values
> are already defined for all platforms. However, the same constraints are
> redefined at [2] with different minItems and maxItems values , again
> applying to all platforms. Based on my understanding, the definitions at
> [2] for 'resets' and the corresponding 'reset-names' can be safely
> removed.
It is not about redefining. You need to constrain your properties. They
have to be fixed, not flexible.

Best regards,
Krzysztof


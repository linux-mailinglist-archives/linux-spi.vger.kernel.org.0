Return-Path: <linux-spi+bounces-5215-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F05B99BB5C
	for <lists+linux-spi@lfdr.de>; Sun, 13 Oct 2024 22:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFDC1F21437
	for <lists+linux-spi@lfdr.de>; Sun, 13 Oct 2024 20:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9593E3E499;
	Sun, 13 Oct 2024 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Dxe5xpZ8"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96DE7F48C
	for <linux-spi@vger.kernel.org>; Sun, 13 Oct 2024 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728850601; cv=none; b=aw4LX2WKpx2QP9MoB5t1jdsp064uLQPGtEgaQPAvGPSvHGZaWe/XugHrM7ysg3mLuDIJSutk98zlqrUcHrluyQUUEV7uYVlhRPHhj1g9WJFtrTKexPMNnB/6ApFvYyPzRldHx68q5xUOOeX00sWoja3sUerGrDuSlfn67OrjrpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728850601; c=relaxed/simple;
	bh=n3aL7QBd93HecoBZ3RrysFWa7UAjV/qiZF42VjSVfxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRxw7zmwl/Z6PgLXhP/Zj+Nj6bfsZNTXazz/8+d0jLyEHCr/H6D/fHUqVGlyTk/FGTY+jgburExfDyy/Evd89stg0dNhhCKsG29RVqfJdEGdpovhbPIpV7TKT+b6KPjuNX9alfcCoREwWftPBf0z/j8JHHpXnAtBtQIPeEm0gCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Dxe5xpZ8; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AC1502C0404;
	Mon, 14 Oct 2024 09:16:29 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728850589;
	bh=CviG87Gxw+/eZ9A7f0iznUZ3zcPHLQqJBw0vRPoGROo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dxe5xpZ8leZBnCIiS1eFizgkxuXMIaZfFXWiieMnTuTkYiuIA6lEpy3BCwVK6Jml3
	 w4mjy8a/s1/E4MW3FADLK38Bf/B5QcMaChKM0+je2nBLKSOBkdgQ/w2VImjrDe+pDh
	 iGOxuMsBHZFTSgj/S81UsYmP+aTb4kZkLUHAaXN7iMmzJaE8StxRF9cWShAaX6+bWu
	 +ClSIhsbhC+CofKfRluAN0X5XYhPtgIQquyQa7Fcf7BbsCRLim86uPiNyRYILFFjgx
	 H6MHcxIEqa0H+ACOdGVjGBdr62afdnhe+GaS9+3WG+MTuQmRkAr7mIrfS6YaE8x57y
	 zzShfL+NJJsog==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670c2a9d0000>; Mon, 14 Oct 2024 09:16:29 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 8CBFC13ED7B;
	Mon, 14 Oct 2024 09:16:29 +1300 (NZDT)
Message-ID: <0b717cbb-ad89-4d3a-a795-080dd716f06d@alliedtelesis.co.nz>
Date: Mon, 14 Oct 2024 09:16:29 +1300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add realtek,rtl9300-snand
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, tsbogend@alpha.franken.de, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org
References: <20241006233347.333586-1-chris.packham@alliedtelesis.co.nz>
 <20241006233347.333586-2-chris.packham@alliedtelesis.co.nz>
 <3tu6x2644lxvvbk74nv5qva7qupsvgxyxkwc5g5n7n4bh3mbwi@457wbps4kpns>
 <963a57ec-c09d-4a4e-b8b8-a89354cf3264@alliedtelesis.co.nz>
 <93c4dfe6-8ddf-425d-bf9c-245e94c4290e@kernel.org>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <93c4dfe6-8ddf-425d-bf9c-245e94c4290e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670c2a9d a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=62ntRvTiAAAA:8 a=gEfo2CItAAAA:8 a=nxSgMk7qIiEtrF1QXo4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


On 8/10/24 19:59, Krzysztof Kozlowski wrote:
> On 07/10/2024 21:58, Chris Packham wrote:
>> On 7/10/24 19:40, Krzysztof Kozlowski wrote:
>>> On Mon, Oct 07, 2024 at 12:33:45PM +1300, Chris Packham wrote:
>>>> Add a dtschema for the SPI-NAND controller on the RTL9300 SoCs. The
>>>> controller supports
>>>>    * Serial/Dual/Quad data with
>>>>    * PIO and DMA data read/write operation
>>>>    * Configurable flash access timing
>>>>
>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>>> ---
>>>>    .../bindings/spi/realtek,rtl9300-snand.yaml   | 58 +++++++++++++++++++
>>>>    1 file changed, 58 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
>>>> new file mode 100644
>>>> index 000000000000..c66aea24cb35
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
>>>> @@ -0,0 +1,58 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://scanmail.trustwave.com/?c=20988&d=2tiE5xx2mR7Mo-BCj_ZnEp9_tDM1bfG85uPlEm-9ag&u=http%3a%2f%2fdevicetree%2eorg%2fschemas%2fspi%2frealtek%2crtl9300-snand%2eyaml%23
>>>> +$schema: http://scanmail.trustwave.com/?c=20988&d=2tiE5xx2mR7Mo-BCj_ZnEp9_tDM1bfG85uCwRjixZQ&u=http%3a%2f%2fdevicetree%2eorg%2fmeta-schemas%2fcore%2eyaml%23
>>>> +
>>>> +title: SPI-NAND Flash Controller for Realtek RTL9300 SoCs
>>>> +
>>>> +maintainers:
>>>> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
>>>> +
>>>> +description:
>>>> +  The Realtek RTL9300 SoCs have a built in SPI-NAND controller. It supports
>>>> +  typical SPI-NAND page cache operations in single, dual or quad IO mode.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>> Why 9300 cannot be alone? What does 9300 mean even? Wildcards and family
>>> models are not allowed in general.
>> The main thing about the RTL9300 is that that is what all the Realtek
>> documents use to refer to these chips and the specific numbers are akin
>> to the manufacturing part number that you'd actually order (maybe that's
>> a bit of a stretch).
>>
>> The SoC/CPU block probably does exist as a separate silicon die that
>> they connect to the different switch blocks in the chips that they sell
>> but I don't think you can get "just" the SoC. There is every chance that
>> we'll see that same SoC/CPU block pop up in new chips (I see references
>> to a RTL9302D in some documents). I'd like to be able to support these
>> chips using "rtl9300" but if that's violating the wildcard rule I can
>> drop it.
> Yeah, that's violating the wildcard rule. You cannot even guarantee that
> 9300 will match future designs.

When the dust settles I'll try do clean up the things I've already had 
in flight. Hopefully it's not too late to just change things rather than 
needing to support the incorrect wildcards as deprecated.

I have been meaning to clean up the mips dtsi files so that there is one 
for each of the rtl9301, rtl9302b etc but wanted to wait for my other 
changes to land. Sorry for creating a bit of a mess.

>>>> +      - enum:
>>>> +          - realtek,rtl9301-snand
>>>> +          - realtek,rtl9302b-snand
>>>> +          - realtek,rtl9302c-snand
>>>> +          - realtek,rtl9303-snand
>>>> +      - const: realtek,rtl9300-snand
>>>> +
>>>> +  reg:
>>>> +    items:
>>>> +      - description: SPI NAND controller registers address and size
>>> Also: why no clocks? Binding is supposed to be complete. If it cannot,
>>> you should explain it in the commit msg.
>> I didn't add it because I had no need for it in my driver. But as you've
>> said previously the binding shouldn't care what the driver does.
>>
>> I do have the clocking info from the datasheets. I'll add it in v2.
>
> Best regards,
> Krzysztof
>


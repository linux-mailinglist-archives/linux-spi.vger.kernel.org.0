Return-Path: <linux-spi+bounces-5126-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE40399388A
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 22:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB4CB22690
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 20:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995321DDA3F;
	Mon,  7 Oct 2024 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="l7EQmoWY"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE68D1D31A0
	for <linux-spi@vger.kernel.org>; Mon,  7 Oct 2024 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728334195; cv=none; b=dstp9V+g/hXfztzDxr+ogw0zPlNRsPkI3Ere6s8DkGNhfIIXCmC9jLpRL5U6s4MOWrKGXF1mYVmHl89PgAo+KoPf+fBFchs7mL9NaOytf9uG1hAGRsHP+I/DnqfsPB+KxqApVLpBVrMytue4UYuGC3JGvkinL8x5guDB3SvEwJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728334195; c=relaxed/simple;
	bh=IZfOo8coClihvsH2TTkHO+abz2SwMDB31rZRYwzXsq8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iZ9GqhzgSPUcBh8KuMle4TMbnWkzc0eGZnCQVUQIhzHtFKZ5EekzMUoqlMED60oAIMIbjh23RFTfwhkx55zkad3F6JP7NZFbgiuSgvV9R9coTq92UwVcByYxzrdmCwKt1T5iB73VQuxUUJ0vvjlzkwlqawJlw0OZQeyll4b9bvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=l7EQmoWY; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B62B62C0E1E;
	Tue,  8 Oct 2024 09:49:49 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728334189;
	bh=IZfOo8coClihvsH2TTkHO+abz2SwMDB31rZRYwzXsq8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=l7EQmoWYFchn6IYfDYl6OtgKhJj5tWPV+xHT0INkY/w3wIAHTccg76MfedH9yhJiU
	 EBL1JVgxK/0abQ86bx/Be3GpNVxI9W5pkrA14h1L/EKqB0mXOq8Km6Fr8qQiMZjrZK
	 Dt5Tm9helwC7PF1UdKsnQ6tSS/AkRrvzE9dIA/CSkKtby0ycHXMobUIvMOZJFFsSFy
	 2+Cms/8oI1IUhiJsTU9mKOr9THtZ5BdpOGv7cIKz7Jb5/ckF9D/TVRVOv8Al+DVH2p
	 vl0aO/A6xEpDTOTD94HZW8fNgVBQWOlux5j5iFhYHYRzUGBnu4IUB6mQ0vdaeT8izy
	 N3Cj1TtUCVmQA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6704496d0000>; Tue, 08 Oct 2024 09:49:49 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 8A2C313ED7B;
	Tue,  8 Oct 2024 09:49:49 +1300 (NZDT)
Message-ID: <8bf08456-0780-4dfe-9153-37ef5d01285b@alliedtelesis.co.nz>
Date: Tue, 8 Oct 2024 09:49:49 +1300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add realtek,rtl9300-snand
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, tsbogend@alpha.franken.de, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org
References: <20241006233347.333586-1-chris.packham@alliedtelesis.co.nz>
 <20241006233347.333586-2-chris.packham@alliedtelesis.co.nz>
 <3tu6x2644lxvvbk74nv5qva7qupsvgxyxkwc5g5n7n4bh3mbwi@457wbps4kpns>
 <963a57ec-c09d-4a4e-b8b8-a89354cf3264@alliedtelesis.co.nz>
Content-Language: en-US
In-Reply-To: <963a57ec-c09d-4a4e-b8b8-a89354cf3264@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Id0kWnqa c=1 sm=1 tr=0 ts=6704496d a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=gEfo2CItAAAA:8 a=X0WHbVYDd5x4bSxCIEEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


On 8/10/24 08:58, Chris Packham wrote:
>
> On 7/10/24 19:40, Krzysztof Kozlowski wrote:
>> On Mon, Oct 07, 2024 at 12:33:45PM +1300, Chris Packham wrote:
>>> Add a dtschema for the SPI-NAND controller on the RTL9300 SoCs. The
>>> controller supports
>>> =C2=A0 * Serial/Dual/Quad data with
>>> =C2=A0 * PIO and DMA data read/write operation
>>> =C2=A0 * Configurable flash access timing
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
>>> =C2=A0 .../bindings/spi/realtek,rtl9300-snand.yaml=C2=A0=C2=A0 | 58=20
>>> +++++++++++++++++++
>>> =C2=A0 1 file changed, 58 insertions(+)
>>> =C2=A0 create mode 100644=20
>>> Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
>>>
>>> diff --git=20
>>> a/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml=20
>>> b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
>>> new file mode 100644
>>> index 000000000000..c66aea24cb35
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yam=
l
>>> @@ -0,0 +1,58 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/spi/realtek,rtl9300-snand.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: SPI-NAND Flash Controller for Realtek RTL9300 SoCs
>>> +
>>> +maintainers:
>>> +=C2=A0 - Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> +
>>> +description:
>>> +=C2=A0 The Realtek RTL9300 SoCs have a built in SPI-NAND controller.=
 It=20
>>> supports
>>> +=C2=A0 typical SPI-NAND page cache operations in single, dual or qua=
d IO=20
>>> mode.
>>> +
>>> +properties:
>>> +=C2=A0 compatible:
>>> +=C2=A0=C2=A0=C2=A0 items:
>> Why 9300 cannot be alone? What does 9300 mean even? Wildcards and fami=
ly
>> models are not allowed in general.
>
> The main thing about the RTL9300 is that that is what all the Realtek=20
> documents use to refer to these chips and the specific numbers are=20
> akin to the manufacturing part number that you'd actually order (maybe=20
> that's a bit of a stretch).
>
> The SoC/CPU block probably does exist as a separate silicon die that=20
> they connect to the different switch blocks in the chips that they=20
> sell but I don't think you can get "just" the SoC. There is every=20
> chance that we'll see that same SoC/CPU block pop up in new chips (I=20
> see references to a RTL9302D in some documents). I'd like to be able=20
> to support these chips using "rtl9300" but if that's violating the=20
> wildcard rule I can drop it.
>
Maybe it's helpful to think of the RTL9300 as the IP block that is=20
integrated into the RTL9301, RTL9302B, etc.

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - realtek,rtl=
9301-snand
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - realtek,rtl=
9302b-snand
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - realtek,rtl=
9302c-snand
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - realtek,rtl=
9303-snand
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: realtek,rtl9300-snand
>>> +
>>> +=C2=A0 reg:
>>> +=C2=A0=C2=A0=C2=A0 items:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: SPI NAND controller re=
gisters address and size
>> Also: why no clocks? Binding is supposed to be complete. If it cannot,
>> you should explain it in the commit msg.
>
> I didn't add it because I had no need for it in my driver. But as=20
> you've said previously the binding shouldn't care what the driver does.
>
> I do have the clocking info from the datasheets. I'll add it in v2.
>
>> Best regards,
>> Krzysztof
>>
>>


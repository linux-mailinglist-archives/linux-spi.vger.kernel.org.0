Return-Path: <linux-spi+bounces-5125-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC649937C0
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 21:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A411F22AC3
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 19:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EAA1DE3DC;
	Mon,  7 Oct 2024 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="E5WrB3yD"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D31DE3C9
	for <linux-spi@vger.kernel.org>; Mon,  7 Oct 2024 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331094; cv=none; b=rNOTSxyAabPUc12LODPFU8QkDewGU7OOfvswUGE92dHKdfA0f46INcnh13dZdBvwDK21dt1IELpI3TPVKcaRuWP0Sb1dEx0PmkGenyyZBSr7DypguFS/p8Og7S/3LCHaYVycKDOLuSHASko5KnEkv463sx+C1nH3EIh45ndI/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331094; c=relaxed/simple;
	bh=Q/bYb1pMVMLVPVMVex2XR6Tq1r1mlNFkMhJ8glv5J2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YP3HgCbpbYRlt0FZUTo0efyE72IQb9dVdRLjUppQX0Te/oL4KRCX6oCJRWKHmK4waIuU+kM2+EHCqlSFCJuXT5gWFxcVvZi3WvGJ+FXSbNcwk3nVzXdLACBnnnO7V4ehmoPLDNKbCJsZOy/7QTkjiWYP0nm4JKyl4YF0pYdc7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=E5WrB3yD; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0C4DB2C02B3;
	Tue,  8 Oct 2024 08:58:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728331089;
	bh=/39mV6iejhOw7NJUKNi2sJ5/2LRJSI5O8+WLMW5fWWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E5WrB3yDoqeymGmaWmocm9AvIREPaktV5L1pcGcfQCJLEjsFHIVx14nwLmkCr+wOr
	 QUQGmIU/nJiU7FL0JaJgtuToP9qkfTFuO1Xm+un4PVqSfPiIoywgcbLcoPXV05OdCx
	 HHF7JcIEW2Io4Cn3xexlTu213hwrohv4NEXZSSvXE/AeVj8p+3v/uO8QGTmz4Oz7Gj
	 3rBwhFOgkM2AKQ9Cui53UyWLgJCqZ2AHSdJIT2VREdw/MuuwBhiYAwlZGhTrZdr5rx
	 FuZobVSJw/y81kWSAX8Fsb59bUUxpWuQt98NcJliRL9rHDceMO0fD5W3d7Gw7c+IN+
	 5E0KjQ+fapoyA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67043d500000>; Tue, 08 Oct 2024 08:58:08 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id D5B3513ED7B;
	Tue,  8 Oct 2024 08:58:08 +1300 (NZDT)
Message-ID: <963a57ec-c09d-4a4e-b8b8-a89354cf3264@alliedtelesis.co.nz>
Date: Tue, 8 Oct 2024 08:58:08 +1300
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
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <3tu6x2644lxvvbk74nv5qva7qupsvgxyxkwc5g5n7n4bh3mbwi@457wbps4kpns>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Id0kWnqa c=1 sm=1 tr=0 ts=67043d50 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=gEfo2CItAAAA:8 a=3Y26vnuh6TdEGk8GsFAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


On 7/10/24 19:40, Krzysztof Kozlowski wrote:
> On Mon, Oct 07, 2024 at 12:33:45PM +1300, Chris Packham wrote:
>> Add a dtschema for the SPI-NAND controller on the RTL9300 SoCs. The
>> controller supports
>>   * Serial/Dual/Quad data with
>>   * PIO and DMA data read/write operation
>>   * Configurable flash access timing
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>>   .../bindings/spi/realtek,rtl9300-snand.yaml   | 58 +++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
>> new file mode 100644
>> index 000000000000..c66aea24cb35
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/realtek,rtl9300-snand.yaml
>> @@ -0,0 +1,58 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/realtek,rtl9300-snand.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SPI-NAND Flash Controller for Realtek RTL9300 SoCs
>> +
>> +maintainers:
>> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
>> +
>> +description:
>> +  The Realtek RTL9300 SoCs have a built in SPI-NAND controller. It supports
>> +  typical SPI-NAND page cache operations in single, dual or quad IO mode.
>> +
>> +properties:
>> +  compatible:
>> +    items:
> Why 9300 cannot be alone? What does 9300 mean even? Wildcards and family
> models are not allowed in general.

The main thing about the RTL9300 is that that is what all the Realtek 
documents use to refer to these chips and the specific numbers are akin 
to the manufacturing part number that you'd actually order (maybe that's 
a bit of a stretch).

The SoC/CPU block probably does exist as a separate silicon die that 
they connect to the different switch blocks in the chips that they sell 
but I don't think you can get "just" the SoC. There is every chance that 
we'll see that same SoC/CPU block pop up in new chips (I see references 
to a RTL9302D in some documents). I'd like to be able to support these 
chips using "rtl9300" but if that's violating the wildcard rule I can 
drop it.

>> +      - enum:
>> +          - realtek,rtl9301-snand
>> +          - realtek,rtl9302b-snand
>> +          - realtek,rtl9302c-snand
>> +          - realtek,rtl9303-snand
>> +      - const: realtek,rtl9300-snand
>> +
>> +  reg:
>> +    items:
>> +      - description: SPI NAND controller registers address and size
> Also: why no clocks? Binding is supposed to be complete. If it cannot,
> you should explain it in the commit msg.

I didn't add it because I had no need for it in my driver. But as you've 
said previously the binding shouldn't care what the driver does.

I do have the clocking info from the datasheets. I'll add it in v2.

> Best regards,
> Krzysztof
>
>


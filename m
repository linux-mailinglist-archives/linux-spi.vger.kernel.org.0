Return-Path: <linux-spi+bounces-5095-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D346198EABF
	for <lists+linux-spi@lfdr.de>; Thu,  3 Oct 2024 09:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B402835E9
	for <lists+linux-spi@lfdr.de>; Thu,  3 Oct 2024 07:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BD3136330;
	Thu,  3 Oct 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACmNa5hg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872B9130E57;
	Thu,  3 Oct 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941630; cv=none; b=mBp2B1bjtHs+eWBUIdwSbt6MMIF50SQdbnYktU1H22XihsQlekQNv6VtLE1Z8uSMbk6v8a+afny+4/RsD4PjCQJc6TPxOq8ZLNUyX51PraMmBgaR64PA4ZEkpaLmGQZV8p0/3HdKPpnqR/+lTD4fnHGPwWGmq5/V6hsJVdKNLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941630; c=relaxed/simple;
	bh=p6WqCzERm6aq0elcjS2UZHjg0ch54nfn4SlGcTmWtAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pc/vrDqYY1IjO5BgWNzREx2GGe80Y+Tzk2pgX/bDDGg8ErpuqCekJIoSm7SK/QRLe0RvrkKhIY9cwTV83npzLngSu2BrKVqS7KSpkrpnZSMRIsFQn9BEIXloM1i7+a7lNw0fbGTWqyWkGrfKDU+pX+ieO3qTfCbUtq2bLlou5T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACmNa5hg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81E0C4CEC7;
	Thu,  3 Oct 2024 07:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727941630;
	bh=p6WqCzERm6aq0elcjS2UZHjg0ch54nfn4SlGcTmWtAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ACmNa5hgt1j8fuldryUNK4LpJxMoX0QOGAluCskPef3MJe13UdhLDDWh1IP6IrPEz
	 xsUfLRdq1y7OnVFMH1X3ofvUXsG3EHMvC53q99UWy80YIlzb8djD4L5RBo9xdnDj5/
	 omeFuSrBrA+cXXmXRO1mW3vRQFAeTGcxCQkq6GAs4cX6peGn/6fXRjvAi5BR+BumZs
	 rB/Qq0Mrs0jNhwVSteHH3yvlfAGfgW21udvKtgxdAYkJuhSyvoC21Nh992spaA1j60
	 ghxVb2MojlXMMvUvy0Kp4/1Jq5hXuC777hGuH1RAiZW/2oiyIIBmfUxZAMG+iK7DJ+
	 A9+Qr4u7D6+xg==
Message-ID: <1368312a-4f48-4363-b97c-5f0675f721f7@kernel.org>
Date: Thu, 3 Oct 2024 09:47:05 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names
 properties
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 Conor Dooley <conor@kernel.org>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
References: <20240923123242.2101562-1-amit.kumar-mahapatra@amd.com>
 <20240924-impaired-starving-eef91b339f67@spud>
 <IA0PR12MB76998D7BC3429606508E6202DC692@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240925-trapdoor-stunt-33516665fdc5@spud>
 <IA0PR12MB76999B696A9BA0834644AC71DC6B2@IA0PR12MB7699.namprd12.prod.outlook.com>
 <03a1c7e7-c516-41ab-a668-7c6785ab1c4f@kernel.org>
 <20240928-postcard-lively-c0c9bbe74d04@spud>
 <IA0PR12MB7699EDFA3753D25C8126D901DC762@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240930-unbalance-wake-e1a6f07ea79d@spud>
 <IA0PR12MB769964FA23FA8B889B47539DDC712@IA0PR12MB7699.namprd12.prod.outlook.com>
 <1195de0e-4a14-446f-bd1f-0116d4abf18b@kernel.org>
 <IA0PR12MB76992D9DDE6AF254FA884A52DC712@IA0PR12MB7699.namprd12.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <IA0PR12MB76992D9DDE6AF254FA884A52DC712@IA0PR12MB7699.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/10/2024 09:42, Mahapatra, Amit Kumar wrote:
> Hello Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Thursday, October 3, 2024 12:31 PM
>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>; Conor Dooley
>> <conor@kernel.org>
>> Cc: broonie@kernel.org; robh@kernel.org; krzk+dt@kernel.org;
>> conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>; linux-
>> spi@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git (AMD-Xilinx)
>> <git@amd.com>; amitrkcian2002@gmail.com
>> Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names properties
>>
>> On 03/10/2024 08:23, Mahapatra, Amit Kumar wrote:
>>> Hello Conor,
>>>
>>>> -----Original Message-----
>>>> From: Conor Dooley <conor@kernel.org>
>>>> Sent: Monday, September 30, 2024 10:10 PM
>>>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
>>>> Cc: Krzysztof Kozlowski <krzk@kernel.org>; broonie@kernel.org;
>>>> robh@kernel.org;
>>>> krzk+dt@kernel.org; conor+dt@kernel.org; Simek, Michal
>>>> <michal.simek@amd.com>; linux-spi@vger.kernel.org;
>>>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>> linux-kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>;
>>>> amitrkcian2002@gmail.com
>>>> Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks &
>>>> clock-names properties
>>>>
>>>> On Mon, Sep 30, 2024 at 03:44:47PM +0000, Mahapatra, Amit Kumar wrote:
>>>>> Hello Conor,
>>>>>
>>>>>>>>>>> Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks &
>>>>>>>>>>> clock-names properties
>>>>>>>>>>>
>>>>>>>>>>> On Mon, Sep 23, 2024 at 06:02:42PM +0530, Amit Kumar Mahapatra
>>>> wrote:
>>>>>>>>>>>> Include the 'clocks' and 'clock-names' properties in the AXI
>>>>>>>>>>>> Quad-SPI bindings. When the AXI4-Lite interface is enabled,
>>>>>>>>>>>> the core operates in legacy mode, maintaining backward
>>>>>>>>>>>> compatibility with version 1.00, and uses 's_axi_aclk' and
>>>>>>>>>>>> 'ext_spi_clk'. For the AXI interface, it uses 's_axi4_aclk'
>>>>>>>>>>>> and
>>>> 'ext_spi_clk'.
>>>>>>
>>>>>>>>>>>> +      properties:
>>>>>>>>>>>> +        clock-names:
>>>>>>>>>>>> +          items:
>>>>>>>>>>>> +            - const: s_axi_aclk
>>>>>>>>>>>> +            - const: ext_spi_clk
>>>>>>>>>>>
>>>>>>>>>>> These are all clocks, there should be no need to have "clk" in the
>> names.
>>>>>>>>>>
>>>>>>>>>> These are the names exported by the IP and used by the DTG.
>>>>>>>>>
>>>>>>>>> So? This is a binding, not a verilog file.
>>>>>>>>
>>>>>>>> Axi Quad SPI is an FPGA-based IP, and the clock names are derived
>>>>>>>> from the IP signal names as specified in the IP documentation [1].
>>>>>>>> We chose these names to ensure alignment with the I/O signal
>>>>>>>> names listed in Table 2-2 on page 19 of [1].
>>>>>>>>
>>>>>>>> [1]
>>>>>>>> chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://www.amd.
>>>>>>>> com/content/dam/xilinx/support/documents/ip_documentation/axi_qu
>>>>>>>> ad_s
>>>>>>>> pi/v3_2/pg153-axi-quad-spi.pdf
>>>>>>>
>>>>>>> So if hardware engineers call them "pink_pony_clk_aclk_really_clk"
>>>>>>> we should follow...
>>>>>>>
>>>>>>>  - bus or axi
>>>>>>>  - ext_spi or spi
>>>>>>>
>>>>>>> You have descriptions of each item to reference real signals.
>>>>>>> Conor's comment is valid - do no make it verilog file.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>>> +
>>>>>>>>>>>> +    else:
>>>>>>>>>>>> +      properties:
>>>>>>>>>>>> +        clock-names:
>>>>>>>>>>>> +          items:
>>>>>>>>>>>> +            - const: s_axi4_aclk
>>>>>>>>>>>> +            - const: ext_spi_clk
>>>>>>>
>>>>>>> Nah, these are the same.
>>>>>>
>>>>>> They may be different, depending on whether or not the driver has
>>>>>> to handle "axi4- lite" versus "axi" differently. That said, I find
>>>>>> the commit message kinda odd in that it states that axi4-lite goes
>>>>>> with the s_axi_aclk
>>>> clock and axi goes with s_axi4_aclk.
>>>>>
>>>>> Apologies for the typo. When the AXI4 interface is enabled, it uses
>>>>> s_axi4_aclk, and when the AXI4-Lite interface is enabled, it uses s_axi_aclk.
>>>>>
>>>>> In my next series I will update my commit message & change the
>>>>> clock-names 's_axi4_aclk', 's_axi_aclk' & 'ext_spi_clk' to 'axi4',
>>>>> 'axi' & 'ref' respectively
>>>>
>>>> There's no driver here, so it is hard to know (why isn't there?) -
>>>> are you using the axi
>>>
>>> We are working on the driver. Once it is ready we will send it to upstream.
>>
>> Why would you send separate binding from driver? That's only making everything
>> more difficult...
> 
> Alright, I will send the next version along with the driver changes.
> 
>>
>>>
>>>> v axi4 to do some sort of differentiation in the driver?
>>> In the driver we don't do any different operations based on the clocks
>>> , we simply enable the available clocks in the driver.
>>
>> So it is the same clock?
> 
> These are two different clocks and depending on the mode—Legacy or 
> Enhanced—either clock will be enabled, but the purpose of both the 
> clocks are the same. We can have the name 'axi' for both the 
> clocks (axi & axi4). Please let me know if you are fine with this.

Please read my first comment in this thread. We are dragging this way
too much...

Best regards,
Krzysztof



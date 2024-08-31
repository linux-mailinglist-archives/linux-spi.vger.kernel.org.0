Return-Path: <linux-spi+bounces-4491-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C02966FC8
	for <lists+linux-spi@lfdr.de>; Sat, 31 Aug 2024 08:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A39284584
	for <lists+linux-spi@lfdr.de>; Sat, 31 Aug 2024 06:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999AA14A0B8;
	Sat, 31 Aug 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlSKY3EO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C91758F;
	Sat, 31 Aug 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725085951; cv=none; b=n9C0M9X+JmDYAA36c+nFVNDJRni1M4nPVDhIt5fqmedY+O+JpBR+GocAmg1qbUhbep2IfT74w4BvVn1+HQxSUVPWVEFOUe7Jc6eXTyf8UUsaM0wnGwWWWEVix3FNhcGZzdjhpZXSvrt6/BKV/DXFlm7lSXf1Ze9KsDo3UKWfK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725085951; c=relaxed/simple;
	bh=0SE4Y8e9pdsbKz+fTAQYhk11k5ecqn2Bkee2i4SanNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzKCLaUoza7PX5GCN0+PQE+Yl3SwRzxOAVNuYfVNh9wBSaxtNyCikSlz4QTLE0Ci0uD9aL8fJw+qjnD3fboEc2eK1tbD4zTP0q8D9PLv5Ke4rlcobR6uaNsxvtTfsvR9RX5KwxfCq5q+E4sWsz/aHwInkQnl8a4XIsuoiccw9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlSKY3EO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB4FC4CEC0;
	Sat, 31 Aug 2024 06:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725085951;
	bh=0SE4Y8e9pdsbKz+fTAQYhk11k5ecqn2Bkee2i4SanNs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FlSKY3EOZsKQESnZ2GqpbH4Ug1leeE0TXUyRKmSH0TSrEZvtXny1YMWejSHxIu7+x
	 286OHg5SOkEFS9on9D52/VCfZxGkdU2ARmu6HNAlBZq8OjFpItncF1WcuxuiV+z6xE
	 oQLqUIynd7g5NpUd+zvnJuHNxhCEDo1xQHbmhQ4YFLnI0gwPctnfSVlyLyVjn+tHms
	 ZjZAAI6eTH/bPscxpVpSzO/tFTXwvWZ1oac5Y4zxyMzfUxTenW5wzycFMSbhEA98Yn
	 cGFIOguWj+Pcg64NUDjWMcA/3FQRzmRihflIwSyEgt1rnydL6V4/L6VhxfZ2RS1RKP
	 6AEm6NZFznLbQ==
Message-ID: <cb3c1a79-69e2-4ff6-9a5a-aa28c87f6f6b@kernel.org>
Date: Sat, 31 Aug 2024 08:32:23 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add a reference to
 spi-peripheral-props.yaml
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org,
 linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br,
 heiko@sntech.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240829201315.3412759-1-festevam@gmail.com>
 <20240829201315.3412759-2-festevam@gmail.com>
 <20240830-anchor-glucose-f8dcc1b0fd16@spud>
 <CAOMZO5AAyjq2M09Ynbu57jd_RyDe_5fN4oaoxMv1CeKjo2aG5Q@mail.gmail.com>
 <20240830-rockfish-shun-da3e42b69f1d@spud>
 <20240830180509.GA565970-robh@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240830180509.GA565970-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/08/2024 20:05, Rob Herring wrote:
> On Fri, Aug 30, 2024 at 04:17:02PM +0100, Conor Dooley wrote:
>> On Fri, Aug 30, 2024 at 12:05:20PM -0300, Fabio Estevam wrote:
>>> Hi Conor,
>>>
>>> On Fri, Aug 30, 2024 at 11:14 AM Conor Dooley <conor@kernel.org> wrote:
>>>
>>>> Since those don't come from spi-peripheral-props, not really the correct
>>>> justification (although why they don't, I'm not sure). If you still saw
>>>> dtbs_check complaints after the first patch, I maybe the controller
>>>> schema is missing a reference to spi-controller.yaml?
>>>
>>> I changed the first patch as suggested:
>>>
>>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> @@ -29,6 +29,10 @@ properties:
>>>      description:
>>>        Chip select used by the device.
>>>
>>> +  spi-cpha: true
>>> +
>>> +  spi-cpol: true
>>> +
>>>    spi-cs-high:
>>>      $ref: /schemas/types.yaml#/definitions/flag
>>>      description:
>>>
>>> spi-rockchip.yaml does reference spi-controller.yaml, but I still get
>>> dtbs_check complaints after the first patch.
>>>
>>> $ make CHECK_DTBS=y rockchip/rv1108-elgin-r1.dtb -j12
>>>   UPD     include/config/kernel.release
>>>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>>>   DTC [C] arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb
>>> /home/fabio/linux-next/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb:
>>> display@0: 'spi-cpha', 'spi-cpol' do not match any of the regexes:
>>> 'pinctrl-[0-9]+'
>>> from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>>>
>>> I would appreciate some suggestions on how to fix this warning.
>>
>> Ah, I think I suggested something garbage, because I misread the diff,
>> as my quoted mail evidences. I was really trying to suggest putting
>> spi-cpha: true
>> spi-cpol: true
>> in trivial-devices.yaml, but I didn't notice that the patch was to
>> spi-peripheral-props rather than trivial-devices. These properties are
>> defined (for reasons I don't quite understand) in spi-controller.yaml
>> and applied to children of the controller node by that binding and I
>> wanted to avoid the redefinition.
> 
> I steered Fabio wrong...
> 
> I think we originally had these in spi-peripheral-props, but then 
> decided they are properties of the device, not the controller. These 
> properties should really only be needed if the device supports different 
> modes. If what a device supports is fixed, then that can be implicit.
> 
> There's one other case I see with "dh,dhcom-board". So I guess add 
> spi-cpha and spi-cpol directly to trivial-devices.yaml.

I responded to v2 before reaching here. Are you sure that's intended?
It's almost equal to the patch here: all trivial devices will have it,
even if they do not need it. For a device requiring CPOL/CPHA, not
having it (or the reverse) is a bug in DTS and basically we would miss
such check for all trivial devices.

Best regards,
Krzysztof



Return-Path: <linux-spi+bounces-5233-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D499DD8D
	for <lists+linux-spi@lfdr.de>; Tue, 15 Oct 2024 07:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59D31F243F3
	for <lists+linux-spi@lfdr.de>; Tue, 15 Oct 2024 05:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E6017C225;
	Tue, 15 Oct 2024 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzLce1Wx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B3E17B401;
	Tue, 15 Oct 2024 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728970509; cv=none; b=dFfLoan5TrrYP+j2H+uGPpufjAA8YiIAag8gAW37IABj0173VFTF8Ow0elUWpjkJM1RFk2KLTM1LZgVdmHZALuIQDRMkeG4HTuATHQxmnpx3ZXSF6428y/PfDYH/IMe0ezZ1eDZMCsO/QSE+84XjcvfxLEvh4Cl0YordgL1A9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728970509; c=relaxed/simple;
	bh=s2gDWG8c1/1aN0rFvnQyq2DVmYeSgf55AvMK7mOPr3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eC2MKnP5vLwg8+kKO+TZsAOl5KGiKEN9XbvpkrXpNuxNX/RNBOEyHx8ATgk9trlWHJqSD8jCItRB9D3OYnEfD+6IP0Ag5HSbR697XxQ7deWZ5ImCuJKs9q5ro7q3vsp35jQ6WzbZryRSskm+eiP6l1snhiKmo8f8f5m8gPBPkgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzLce1Wx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5D7C4CECE;
	Tue, 15 Oct 2024 05:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728970509;
	bh=s2gDWG8c1/1aN0rFvnQyq2DVmYeSgf55AvMK7mOPr3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KzLce1Wx4qhlmS9pBWhblgSm4WQDC+qTMRoT3H+v7frgm+ZwIi+eLQMi8Vjwzex1o
	 nPFE57YLB3qIQoQNFxZIVushoLnom609jgQ5Pvqmz7urQxBkjSf5aQ1OAqfMyG7i5J
	 VHw/lNXyrk+DgnVrRcEQT/QXar0ML2eS0UO6zR8KvaymD5Q3dzwlPUmVCJO+ojWHj5
	 jRupvD5/TPd0pYiDA86JidB0AMuDJad66GD8a6VdmPiR9e9lC0OiVSoM9RtSE0us9I
	 2CZswBrM6PPaXZaeKhadjuyBIhFhgl8dNOI3QyGuKYVAXh3xkkS354GmYEKph7ycAd
	 cZBsEdKKnKEKQ==
Message-ID: <77b03a23-6880-4722-bafa-167bb5d45ae1@kernel.org>
Date: Tue, 15 Oct 2024 07:35:04 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: spi: Add realtek,rtl9301-snand
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, tsbogend@alpha.franken.de, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org
References: <20241014015245.2513738-1-chris.packham@alliedtelesis.co.nz>
 <20241014015245.2513738-2-chris.packham@alliedtelesis.co.nz>
 <nuadh2elbry2qc4l7rdngfvs4inbsmo2vg2w72w5d4cgpnail2@zidp7kzxp7qp>
 <bd802a5c-e09e-4f4d-9d37-b87d85efb4e4@alliedtelesis.co.nz>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <bd802a5c-e09e-4f4d-9d37-b87d85efb4e4@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/10/2024 22:38, Chris Packham wrote:
> 
> On 14/10/24 20:12, Krzysztof Kozlowski wrote:
>> On Mon, Oct 14, 2024 at 02:52:43PM +1300, Chris Packham wrote:
>>   
>>> diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml b/Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml
>>> new file mode 100644
>>> index 000000000000..397b32b41e86
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml
>>> @@ -0,0 +1,59 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://scanmail.trustwave.com/?c=20988&d=3cSM59Be7zhiOY6j70BGhTh0kCvZ-1Nf0f5XJZnTzQ&u=http%3a%2f%2fdevicetree%2eorg%2fschemas%2fspi%2frealtek%2crtl9301-snand%2eyaml%23
>>> +$schema: http://scanmail.trustwave.com/?c=20988&d=3cSM59Be7zhiOY6j70BGhTh0kCvZ-1Nf0a1RIsqGnw&u=http%3a%2f%2fdevicetree%2eorg%2fmeta-schemas%2fcore%2eyaml%23
>>> +
>>> +title: SPI-NAND Flash Controller for Realtek RTL9300 SoCs
>>> +
>>> +maintainers:
>>> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> +
>>> +description:
>>> +  The Realtek RTL9300 SoCs have a built in SPI-NAND controller. It supports
>>> +  typical SPI-NAND page cache operations in single, dual or quad IO mode.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - realtek,rtl9301-snand
>>> +      - realtek,rtl9302b-snand
>>> +      - realtek,rtl9302c-snand
>>> +      - realtek,rtl9303-snand
>> All of them look compatible with each other, why not using fallback to
>> 9301? That's common and expected pattern.
> 
> So something like
> 
> properties:
>    compatible:
>      oneOf:
>        - items:
>           -  enum:
>               - realtek,rtl9302b-snand
>              - realtek,rtl9302c-snand
>              - realtek,rtl9303-snand
>         - const: realtek,rtl9301-snand
>       - items:

Yes, except this one is not a list, so just const.

>          const: realtek,rtl9301-snand
> 
> Or am I over thinking it and I should just use only a single "const: 
> realtek,rtl9301-snand"?
> 
>>
>> Best regards,
>> Krzysztof
>>

Best regards,
Krzysztof



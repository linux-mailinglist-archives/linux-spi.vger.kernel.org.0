Return-Path: <linux-spi+bounces-10094-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43378B824FE
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 01:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37C758774E
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 23:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8938E329518;
	Wed, 17 Sep 2025 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="fnnTFpM9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582ED329504
	for <linux-spi@vger.kernel.org>; Wed, 17 Sep 2025 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758152437; cv=none; b=vEbX0jLjZXBYCIWDveUI9GW/U6Fjju8RTtM64/WJy/71XzBvvhkREQTIelxWLZc7RDSutuQfLcWNTPcsRDoR+t91uaZ/hN9voFUT9hZccDWWvmMPdiBfTBbSP3NAMrahYRSpDtR/AXfEcFEbXqkPr7Pz8qvMNSLbROaD0cbqkhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758152437; c=relaxed/simple;
	bh=WSUDTo2YPrsMhanXvD2WU2viqGWsoO+MKY+Xv+c2P7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kue83cMECa4OXEQec75jhWdnstDN9hZwnfDxpSYJrgBbG56UeQ4YndE9I7rsNGKdT30H+dajeR6lUdPHKzli4t8ZfIvCA8XIG90aj/bmqFbJjAQkAe/JYev9XNssQ9C4EjSBjNUPuMvapk/D/qP9RN2IvwKIeeGmFmT/ef/RooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=fnnTFpM9; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8935b53bb14so16191439f.0
        for <linux-spi@vger.kernel.org>; Wed, 17 Sep 2025 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758152433; x=1758757233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4LnKnBe0mUrdxdcBF4M/llb4IeQlPfA2whttLuEB5Q=;
        b=fnnTFpM9dbLZRTz6baEM0q99r59tQD9IRcrATU5qxeYy4P/VepArnvQsfq0gjt1/4D
         VuhWE4wm00PqAmNIuqzZxOB1w8NejghD3PjIw5pKPbSqNLdInB+0YDnB+fADVgP4vrBt
         8JOCwHBCYp9xiSxlxw+RWGitND6DfcJCOr+W2WsyA8GW0xfe2bA97HIJd5I6uuNfaACN
         VbuVFlYwq32bXQUcFk0WVqpYMMq+bEPdUOBxA4eSxsM3ZbAAvu+vZ4vZ7bwPu/cLprQC
         i7BYhE74YyHMnSqUMsjeDaj1IfYQIJdD5S/gN1oy36v6WOoraplaSZWe/rFWkO6CoPyZ
         V0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758152433; x=1758757233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4LnKnBe0mUrdxdcBF4M/llb4IeQlPfA2whttLuEB5Q=;
        b=RBEHNEsZeOk8dgdcIbrgVqq1B3E1zvzFDKDllgiVd05rUJXn40PdKIdyhaMDbbUFLA
         tx0hqwxpg0mhuxESATGBLVI1gu0Td/1SuHihQy78QyWKSML0N5zf0Xonms2DLQfjIzL5
         YrL9+UiW1q6vgEsq1l/Hfx7wvgCZ4HAwMDXSYhI3EMyEapPVissClUSgEU38Ebmc4ogw
         PYkn8DQtjnkADz/PKaSU32GxRMTO5Cwa3tW3zmXT1aauCapMSX7ejTF/pWFmqaDMDcHk
         KKQzANoD/5ofYIz78e59v2HA0XzgjE3mm5ySqK35Vy/657D9+9wGJSxz6q9ulqiASnZE
         jOKA==
X-Forwarded-Encrypted: i=1; AJvYcCVe3LE22DR9/B32B8zOH5/GUMr8loMnXglh4WuLmhcHPGPmgygIz89W0TnYIBX0gWSZNXWXgqJZx+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5sVDdd68IZbQYfHV4MBPar8zYFkLenOU5QjgpcqbElDh1goN9
	fH6IMPrCJXwxcgWPpDb4NOxEKAqRYtn0eE8Vt9dPAk+ifUbh9cnImQfERm+qeWIHzUE=
X-Gm-Gg: ASbGncuXbvkowVs6U95uRcn3mAmBZRcjZZ/JPH8fFioJ2X/9x3elVBMXxeVUQ5Uz8dF
	m1RbQ5P5o48PtTgFL4y6dJAdAJBmn07qtfXlCxTHnyfNi2lMXUZqBd/L3rT8fT3AKDyLW/HY6Ww
	Svy5dxQ13/1oM6GGNVKuDpw+/0GyWNp9dfhWj7C/af2e0K7PfExAJc1qEN7L5H243mM0qBk5uaI
	32DxxecsO0PWfAsiOTWdrgI0VT/Tu5WxQ9Pr48DepxqCgoJCx/jQxzgiCd0JszJmjU5B7cF/Squ
	3BgObbbfTVbbZxr/yKijXG//gq0uATVyUT1sXU/7eG0aBfKxuiZ3nMLx7oqbTffSgscWyQq4Qxy
	yEI+8dnssuRiUsvum7+L8Dgm+zjsq+iNWQo50344auT5VkZLLnJDkxw==
X-Google-Smtp-Source: AGHT+IFIMlPua7p/TY9YMSKjXsZOBX/5j6z1IJQ7nS5dT8sO4hABWq+/kl4R3zdjJi/vT1pYQ+i8NA==
X-Received: by 2002:a05:6602:6c10:b0:86d:9ec7:267e with SMTP id ca18e2360f4ac-89d1a7c97eamr718446339f.4.1758152433403;
        Wed, 17 Sep 2025 16:40:33 -0700 (PDT)
Received: from [10.211.55.5] ([131.212.251.230])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46fea3353sm31238739f.12.2025.09.17.16.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 16:40:32 -0700 (PDT)
Message-ID: <3b815302-21f2-4ee2-bf83-c1dba77ce3d1@riscstar.com>
Date: Wed, 17 Sep 2025 18:40:31 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-2-elder@riscstar.com>
 <20250917231520-GYA1269891@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250917231520-GYA1269891@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/25 6:15 PM, Yixun Lan wrote:
> Hi Alex,
> 
> On 17:07 Wed 17 Sep     , Alex Elder wrote:
>> Add support for the SPI controller implemented by the SpacemiT K1 SoC.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/spi/spacemit,k1-spi.yaml         | 94 +++++++++++++++++++
>>   1 file changed, 94 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
>> new file mode 100644
>> index 0000000000000..5abd4fe268da9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
>> @@ -0,0 +1,94 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/spacemit,k1-spi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SpacemiT K1 SoC Serial Peripheral Interface (SPI)
>> +
>> +maintainers:
>> +  - Alex Elder <elder@kernel.org>
>> +
>> +description:
>> +  The SpacemiT K1 SoC implements a SPI controller that has two 32-entry
>> +  FIFOs, for transmit and receive.  Details are currently available in
>> +  section 18.2.1 of the K1 User Manual, found in the SpacemiT Keystone
>> +  K1 Documentation[1].  The controller transfers words using PIO.  DMA
>> +  transfers are supported as well, if both TX and RX DMA channels are
>> +  specified,
>> +
>> +  [1] https://developer.spacemit.com/documentation
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - spacemit,k1-spi
> one enum is effectively equal to const..

OK.  That's an easy fix.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Core clock
>> +      - description: Bus clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +      - const: bus
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  dmas:
>> +    items:
>> +      - description: RX DMA channel
>> +      - description: TX DMA channel
>> +
>> +  dma-names:
>> +    items:
>> +      - const: rx
>> +      - const: tx
>> +
>> +  spacemit,k1-ssp-id:
>> +    description: SPI controller number
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> could you explain a little bit why this vendor specific property should
> be introduced? I took a look at the code, and didn't get the reason
> behind.. or what's the problem of simply using "pdev->id"?

This property was carried over from the vendor code.  It is
optional, and if it isn't specified, the platform device ID (-1)
will be used.  It's just intended to provide a well-defined ID
for a particular SPI controller.

> we should really be careful to introduce vendor specific property..

If there were a standard way of doing this I'd love to use it.

And if it isn't necessary, please just explain to me why.  I
have no problem removing it.

>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - interrupts
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +
>> +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
>> +    spi3: spi@d401c000 {
> label not needed for DT example

OK.

>> +        compatible = "spacemit,k1-spi";
>> +        reg = <0xd401c000 0x30>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        clocks = <&syscon_apbc CLK_SSP3>,
>> +                 <&syscon_apbc CLK_SSP3_BUS>;
>> +        clock-names = "core",
>> +                      "bus";
>> +        resets = <&syscon_apbc RESET_SSP3>;
>> +        interrupts-extended = <&plic 55>;
>> +        spacemit,k1-ssp-id = <3>;
>> +        dmas = <&pdma 20>,
>> +               <&pdma 19>;
>> +        dma-names = "rx",
>> +                    "tx";
> ..
>> +        status = "disabled";
> ditto, drop it

OK.  Thanks a lot for your quick review.  I'll wait a bit
(probably until Monday) before I send an update.

					-Alex

>> +    };
>> -- 
>> 2.48.1
>>
> 



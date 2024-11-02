Return-Path: <linux-spi+bounces-5601-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C569BA057
	for <lists+linux-spi@lfdr.de>; Sat,  2 Nov 2024 14:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3AC281D6B
	for <lists+linux-spi@lfdr.de>; Sat,  2 Nov 2024 13:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22841CAAC;
	Sat,  2 Nov 2024 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kru/qg6H"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64043156CA;
	Sat,  2 Nov 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553311; cv=none; b=ocMQ5trng53Hrf0rKK5MB42pt3At0MUkN/Nfbc/G9pV7Fw98TxC/EYrs8PlFidp7dLr7pFhlQJmjkEnLw9b5DNnhP4ZFcLA/qWHwCK8lPYiSkEbUPLMAW4iMLuNC5/LbKpU3QYuoH+JXXNIShDdx2NlzD9YjMnyXv2zViX7VKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553311; c=relaxed/simple;
	bh=fWFWaJrtT873uGrZbfXFWcjGiIbzel0zDqI7deZ84Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKqLevXTGOa4BECgAqHz1py6zM2XUxJZwxst1XpPW6AoQTXN7SbQVwvQaSXawUmn+gKtKrjYF4JkZreixH2DZyy+D3vVXeMr7/zwUNhINoVJKBDE2wmFA2RqIerfEAPH/OjA5DkV9fJG2wcc/xFNKV7m/5uFuxevv/BcIO5HTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kru/qg6H; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cdb889222so28071155ad.3;
        Sat, 02 Nov 2024 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730553310; x=1731158110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqIV8fJvUTPe1XkFfFuu3lKfRKNmYvmwJe3hWNSUszg=;
        b=Kru/qg6HWM5IEdh6/nZFQ2Wyw3K9iESEFDvZb3s8+L4BTzX1NyUtud+IBMxV8Y7Xeq
         ZZZdD+5vJ83rgidLycuM5Bziw5fbVCjixAXYMYHQuNXx0nKXOSL/thMbwD4evABwY5s4
         jFHlUH/C7JbIXJwlpKnDG6ihSTkhEutsRhvS+WKTIBaWhJE3PnrrkYJulRQHIRVQdTm6
         idd04Zg7db4u96DkKcpW3NB5oYrxy1LMzS8apcdwlZVpwkfJ/Mr6CIFvvCR38BFi2G9q
         3P0TVuRDcggvIqbc6bazdJm/mn93Na+BPUH7CmZWCM/oM58nBXiwtIH3k4r+z9rjzdsP
         UBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730553310; x=1731158110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqIV8fJvUTPe1XkFfFuu3lKfRKNmYvmwJe3hWNSUszg=;
        b=ZLQtFnl+Mw97INbR+ngVeTe+YkVJd+VIJPfDKN53IHFPW7hGlC+1p8LAWrfgoF4zpd
         Vl8kvDWppoE9SrshbWyGDS18S0z6ZxcDKkvsh5TqInvbrDXGi7F5jEfGpC2FZC4Zxmsv
         fzhjaWW53ZGpkj0OoLQCj4lM3m9kwehco+GBCg7iRPYn0h2xdifIbNHbo40eusRI6lAY
         jLTPrY+PxOWtGFe2/xneJ6iSHN+uhm6VrKQtAVrsj23SZm8aQGULdx9z+8W7MMhXemgR
         QxtUFOhGrtclmLuu07XxtrNyiMT3PL93U2a+UdEq9161pR80crL99B560GpGJERQhT3+
         9idQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfMN0Yz98TWWMr9hfIpNuvPaqjlE0+jT/VY7ILzrK3oYPq1sgOKOL2iHXsxRUK9b/nGX2bmEXQRx4U@vger.kernel.org, AJvYcCVYfIu8+LgAfgAG3rfvnjNSQMLZMHqIFlJYd8YKmplKISYZRe7yIsY0rnB2bY1SBcMX3F4zldhsF38eTYls@vger.kernel.org, AJvYcCXVDTlXcV4Rnjl/PwUJh2A4OSkVL2FWdceRcD0KS9lo+o+pNxG1CSJBoz9AASzU78kg69fGcYshJbjo@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/ioBzz3700fNpyURt35JNT8PUwnN79QWshODYZXSuyyo1LvR
	//sJttg8HDN2gu11PzuDQpcdg26enQEWiXTMpCPYjUf/orj8NvJ9zmrihx1Q
X-Google-Smtp-Source: AGHT+IEjZyMhv52i+FdmXziel3S6uh0T/4JCB2ptezWEGIl82CVPxNSuviQk+FJATDrk0E2JnpSDUw==
X-Received: by 2002:a17:902:d4cd:b0:20c:dc32:b5d0 with SMTP id d9443c01a7336-21103ca87e7mr141827475ad.58.1730553309583;
        Sat, 02 Nov 2024 06:15:09 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105706886sm33500465ad.68.2024.11.02.06.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 06:15:09 -0700 (PDT)
Message-ID: <6fb61676-2744-4735-ab00-2a523e03ea96@gmail.com>
Date: Sat, 2 Nov 2024 21:15:05 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: apple,spi: Add binding for Apple
 SPI controllers
Content-Language: en-MW
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net>
 <20241101-asahi-spi-v3-1-3b411c5fb8e5@jannau.net>
 <46b31874-9fe2-4534-9777-816765a265b1@gmail.com>
 <87wmhm3u7v.fsf@bloch.sibelius.xs4all.nl>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <87wmhm3u7v.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/2024 16:39, Mark Kettenis wrote:
>> Date: Sat, 2 Nov 2024 10:36:56 +0800
>> Content-Language: en-MW
>>
>> On 2/11/2024 03:26, Janne Grunau via B4 Relay wrote:
>>
>> [...]
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - apple,t8103-spi
>>> +          - apple,t8112-spi
>>> +          - apple,t6000-spi
>>> +      - const: apple,spi
>> Apple A7-A11 SoCs seems to use a Samsung SPI block, so apple,spi is too
>> generic. Fallback to something like apple,t8103-spi instead.
> 
> Well, if that is a Samsung SPI block it probably should have a
> "generic" compatible that starts with "samsung,".  The M1/M2
> controllers have a different SPI block (presumably) designed by Apple
> themselves.  So I think it is (still) appropriate that that one is
> "apple,spi".
I just looked into the SPI on A7-A11 SoC in more detail instead of just
going off the ADT compatible. It seems a very big chunk of the registers
offsets and bits seems to be the same as the ones in M1. So, feel free to
ignore my comment above.

Acked-by: Nick Chan <towinchenmi@gmail.com>

> 
> Also, (upstream) U-Boot already uses the "apple,spi" compatible.  So
> changing it for purity sake just causes pain.
Well, if upstream U-Boot is using it, then I agree that "apple,spi"
should continue to be used.

> 

Nick Chan


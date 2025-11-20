Return-Path: <linux-spi+bounces-11371-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9AAC72ED4
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 823DD4E8044
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086C33081AD;
	Thu, 20 Nov 2025 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rr6CbknU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5832367CE
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627753; cv=none; b=Ed+Eul8h+1IbKLDqSNJZUHNcej823ISGyVYw1uZdXqivk+5J3VsbQir6qBi9vlJVfqwNJwuM53Qc/Ppelpr0hHMUWw0cAlzm/AtDudeO4zFZjHp7yOMu++ZiMfcsyjvHCpe0hz/DRr40lL0y+gtxQ2+YprtDw6/LrM++uFwtU4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627753; c=relaxed/simple;
	bh=ady1OctmfWAWlp6ZEv6jm7omLGzqw96V0J9xgYeVwzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUKWDxPRWXRPRQJcholTVcF35KDt0qGu1wIi+SHggZWk03IjuIGYZ2zUmEYrZqD6GYEf8eHJPk+73GUy2et+XnMaq/JnYLIvpblm/LofLJuqFAh3hIc8tn+TF4zAI/XF6pB1uEvVBAlNZHY91sF4xHaf0+VTOd7/SdthURdJbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rr6CbknU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so4175225e9.0
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 00:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763627750; x=1764232550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1jSWZCgeAfmjjyjsevv49mjqnEq82g0aMsUmMetKc4=;
        b=Rr6CbknUJEF5fLfGE1JDLrx2CAKmbcLkISHfJoyZP5Ym10G97Iyj0haLvt9BJf8FOg
         SEtBWkvd1OyjIXKvZEwFhFV3pZ8+5ld4nVAB2TekF/jk0ap4y4Uw6MBCHsWN1MJ3Nz6w
         5nU/DYjFY9Cooa350PeQhpCdTwY2fbCmdZd+++56NZOLBrXu5452PKC1GQs/Oj8kLeg+
         /APYgQhHepUsdaW/oFzBdw+CRe7E0cH4AAhWXb7zeg7vgyk8cLVK/GJnAAkR8jMHCh1y
         NefpENpqAxBK3k9ZRhMYzoLDpVQ4OZDMhEXFib9MS7M2G5fqj/qpiffy8IvLwrrQEf6Y
         aFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763627750; x=1764232550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1jSWZCgeAfmjjyjsevv49mjqnEq82g0aMsUmMetKc4=;
        b=j+YMT/eV6idB3UUv4h17NM8UUcBXXvT9bXTksxrg0PYjMIzZZ7pU6hAwzN9za2pvZ0
         ZHP0ihv85sVHZNmyLsYnFuMSGJ6+8nIqGL+LwhHYnuqbJM3Pwai8MKH22yeE7N3ELTYL
         dgFwOPr9ovW9Ql69lZkkViXb5KQwG92yVBW+W8Cu8FY+9/Mr9tD/uzwQ2NAmnSDK5lfn
         8OP9Ocdvt6enOdXtQC7KEj1b/r4H7hdK/lvSB0wEqQR8TXbeHcTh56VtkznGqHsjaB60
         +Z6VvD/jTY7KtTlQk+3LeBmasyLfwp6DYIkOvYgFyGFywM80H1SupveKy+kutL8TkT8/
         6CHA==
X-Forwarded-Encrypted: i=1; AJvYcCX2CAr5GKH7PiOBGlQnSt1UhViYPusRyhREnqq1iCKhvEtSbykQaPt4ooqBB2ZpxD8DFT7MT7nuQ9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCYIgsPbRobCsKWXW7rxL2B/lXquuvPU++Tq9ht4SW//DOGE5
	efEgXW0tPgRr8Snj/UyIUeNpm2YGL+6IpU88c2OO5rfHfSj9P0RHnXaFkFbI4R51c6lMQ6ub1l0
	cg+KX
X-Gm-Gg: ASbGnct8gubbkTO/hr4YY4yDPB5lcHp0SCv6oBp7+uc1wkSbED7xRVPtnIvPqOaPHg0
	rq+CYeyHYZW3oCV3TuZj45MAix4ZRojnABCdft4i4PCA5Q107a8lyYNStmpjLew6zUZ+rIKEz8o
	Yv/FRnXWZokhLL1+Gh3tiinI/QTJePbZdWXfYGVUbszT+oC/ymZ5517cEOFaYl41yJPKAxPWddP
	3AEmZ9eH075m7xrGxePo+lMHiJsGUqRWAevjPe/fmy1sIndIDCMOXzpQVyiRpuSShp0yVIWFnZC
	wUr6nJ/MX9u7R73nemk9Ue/4R1KbiVw9VfxZzvullwF4aOhTcRhz+XBCmDX47BSIIR+Xi2WS30z
	4bhO2UX8iU6XMoZ86pDIjBCto0tEGS+HICph/rsH4qMiCqKEmiJIJyGlSUW9UQEyANMtzRQgIop
	1PcunrJajigcO1XHwG
X-Google-Smtp-Source: AGHT+IF1ZFBDL71uBaSwbhNDatpe1vIJpFPHU6lONyVDyD5pnpwHGngatw+aFLHLdudpyOTvNR4+Tg==
X-Received: by 2002:a05:600c:1d01:b0:475:daba:d03c with SMTP id 5b1f17b1804b1-477b89541d7mr19670195e9.13.1763627750364;
        Thu, 20 Nov 2025 00:35:50 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34ffesm4648081f8f.10.2025.11.20.00.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 00:35:49 -0800 (PST)
Message-ID: <81a0af49-9c0c-43e7-9a40-d66ba95c578c@linaro.org>
Date: Thu, 20 Nov 2025 10:35:48 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/28] mtd: spinand: Make use of the operation templates
 through SPINAND_OP()
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-10-be42de23ebf1@bootlin.com>
 <5680a2a8-aeb3-4274-a264-4ff658cc9246@linaro.org>
 <87jyzmaqcq.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87jyzmaqcq.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/25 7:23 PM, Miquel Raynal wrote:
> On 05/11/2025 at 17:28:29 +01, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
>> On 10/31/25 6:26 PM, Miquel Raynal wrote:
>>> index 4afebaf5f0195b9bc617ea1f125f637f76fff9f8..a8fd04a67cfa9925bd68c57539d86e0816b76274 100644
>>> --- a/include/linux/mtd/spinand.h
>>> +++ b/include/linux/mtd/spinand.h
>>> @@ -701,6 +701,93 @@ struct spinand_device {
>>>  			     unsigned int retry_mode);
>>>  };
>>>  
>>> +static inline struct spi_mem_op
>>
>> Do we still do inlines?
> 
> Defining functions in headers like that, I think yes? (static inline,
> not just inline). The full line is something like:
> 
> +static inline struct spi_mem_op
> +spinand_fill_reset_op(struct spinand_device *spinand)
> +{
> 
> So it's not an inline declaration of a variable, but the definition of a
> function (just saying, in case the diff mislead you).

I saw it's a static inline function. Check this please:
https://lore.kernel.org/all/Pine.LNX.4.64.0601021105000.3668@g5.osdl.org/T/#u


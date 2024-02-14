Return-Path: <linux-spi+bounces-1344-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45708543B2
	for <lists+linux-spi@lfdr.de>; Wed, 14 Feb 2024 09:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890872832A7
	for <lists+linux-spi@lfdr.de>; Wed, 14 Feb 2024 08:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A7A1173D;
	Wed, 14 Feb 2024 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yXYlM94B"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1D11729
	for <linux-spi@vger.kernel.org>; Wed, 14 Feb 2024 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897616; cv=none; b=ANmvMPXAmGW6uz5oj84dqBhcDG+oUTysAhWuPqKjDNP0Ig6G5hU0nQApVNxh5oSpiGMA0n3e1KREzvZkOCbUtRH7E1svHDHn4VPqQ3CUM/YmkeGi782z/RHx0B+HiaCR5VVWy8RczSWiBdukO3JlR/Q0ymu1aUp7AACKt58aLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897616; c=relaxed/simple;
	bh=vjpnlKEhQq/r0Igaef6nhe29nSkAdUNlJtYNHjTnc00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwu9AA9lhMb7JcDHx+ZHUMJ1ql5awSe4zm++0EYeuR3fBtPsVbf8KPrpY2Fh0Zlhfc0GtCzVahh1TvQ8XXR/Xz4GPeNTkPky+ivH6Xpi0E47cvJKEy8xOhDu6oK0OvYA1e1UWbjFJ8jIjydzRoyJLJSGhxhj2CJXCa/bP82/1sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yXYlM94B; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b66883de9so3650810f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 14 Feb 2024 00:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707897612; x=1708502412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/98+Vsklm/Qv1wuZkAjVdAvLbcO9KmXWyjzxx0XiFU=;
        b=yXYlM94BCWoKNo3mnDANzW/TpLXS29Rk9uBYlyUv+oscoYGt/FY78KIKczS950j95p
         gExKDjAeddNQaNpwZmqFb8F956gLJ6m2uBQn1OldFdr22TBEJ1p2N9Idf5y91vXSTQc9
         8wXpIHDIY6rs0d9/03Iz3PZsBsRwRvm8PzknCHJBLe550DwFcOIxSjSksxaH4rWuoxr9
         4rcU3bMyNelKL77XL9zitZMUtC2naPgx176FzGNDvFjHksy83clJC/ZPZHEp7meTwvby
         XjVjdPmkWgI2K7gf7R3M+SeD0SHEdAJ+we/HfM44IPmTIa52FlnDZ9nt48bigRekj3bn
         8qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707897612; x=1708502412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/98+Vsklm/Qv1wuZkAjVdAvLbcO9KmXWyjzxx0XiFU=;
        b=J2bhdQeY0BQ1C33RrCJJSV8KHbeG23kE2a2W97r7alflECbmHGiSO9zClTOFqdFrh0
         ppHGjqepTYfIlKP+YCpGIONesAtesme9WWOUeQWeM2LaFboMQwHiQ176jaAIpEMR0B5M
         bqorhEtBK5fss480UHl7xaIhr/+c38nOK4gaNCoC+U49w7wQ6xdU39qQxHGvl8lhWJBY
         JKsuKbJ/yodGsxXRk/hn98lgaaoZszPZ3LiURNn6g6RaD0mDHTw9YsDFRV3CAhrWOm04
         QWql1qa+07q2nOE5Pa6xgVLXefF0ChaPWPiSPWM1II3Dva+O8sB6ui6/59B4pn/UeZ97
         vxrw==
X-Gm-Message-State: AOJu0Yy9jP7J5/j9nFgYdE32cMCosFtHg5hvxjc+hEif2T65XljfkQPM
	9pfZm/DMoqcuNDnqtzZZPZNbU+QuS87dbPm6RuxBPyI/OF7WFP8RE3ElLWpZlL0=
X-Google-Smtp-Source: AGHT+IEJ7O59OW1Vvvl7WoZPbst+hYTgMmc74nQj2mJjmJcsqPZ3mHFxWKOR5ET6H5/vjTfJfK1w/w==
X-Received: by 2002:adf:f50c:0:b0:33b:4d27:6303 with SMTP id q12-20020adff50c000000b0033b4d276303mr1315228wro.12.1707897612293;
        Wed, 14 Feb 2024 00:00:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXamBlwa95sGJCE7W/i692Nd5e3+Ft4fy8SMeN53kd1UDLY/3paZBzv4gP7YRVN6qLamcpD7EmS2BHE+nx4OrmROStrZNn98yxdoiKw0iodWniy8XmdHbnc4RLCW7G8JEMIRLLz4SEFeyfdVjW88FKFs+100Pnnt8zC0vjtZdJrhXagEF+uOYKzrM2shDpTBbQk98sSfSpJe7NnA4SfKJeqVlTM8f4Y2TD9IHyik26an+zCYm7L+Any4jb2gBzlS38zeq3Ty5Neo2gDN+GQF/TopuLFJODkPADIy9LSYe6sGaPNOvsV2KJX
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d44cb000000b0033b43a5f53csm11485428wrr.103.2024.02.14.00.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 00:00:11 -0800 (PST)
Message-ID: <7b3c08b0-80ed-4409-96d4-d55b938df6f4@linaro.org>
Date: Wed, 14 Feb 2024 08:00:06 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-mem: add statistics support to ->exec_op() calls
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
 <b0844e5a-ee4b-4608-99a1-877660e01d57@linaro.org>
 <CZ41HDHS7WX6.6MJL1O2PBVW1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CZ41HDHS7WX6.6MJL1O2PBVW1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/13/24 15:00, Théo Lebrun wrote:
> Hello Tudor,

Hi!

> 
> On Tue Feb 13, 2024 at 1:39 PM CET, Tudor Ambarus wrote:
>>>  /**
>>>   * spi_mem_exec_op() - Execute a memory operation
>>>   * @mem: the SPI memory
>>> @@ -339,8 +383,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>>  		 * read path) and expect the core to use the regular SPI
>>>  		 * interface in other cases.
>>>  		 */
>>> -		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP)
>>> +		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
>>> +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
>>> +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
>>> +
>>
>> Would be good to be able to opt out the statistics if one wants it.
>>
>> SPI NORs can write with a single write op maximum page_size bytes, which
>> is typically 256 bytes. And since there are SPI NORs that can run at 400
>> MHz, I guess some performance penalty shouldn't be excluded.
> 
> I did my testing on a 40 MHz octal SPI NOR with most reads being much
> bigger than 256 bytes, so I probably didn't have the fastest setup
> indeed.

yeah, reads are bigger, the entire flash can be read with a single read op.

> 
> What shape would that take? A spi-mem DT prop? New field in the SPI
> statistics sysfs directory?
> 

I think I'd go with a sysfs entry, it provides flexibility. But I guess
we can worry about this if we have some numbers, and I don't have, so
you're fine even without the opt-out option.

> Other remarks have been taken into account, thanks!
> 

Ok, thanks.
Cheers,
ta


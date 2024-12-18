Return-Path: <linux-spi+bounces-6094-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC689F5FEA
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 09:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3541605E2
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F2A17ADFA;
	Wed, 18 Dec 2024 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zSpy6QS8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A405167DAC
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734509253; cv=none; b=VizqwINW7wAp9JQK/5piYO1p8MrkEDOvLYbfkzUFvmTChDuAEvgC7PO9f8z1Wwf+Et2WnL9fqkzVUOjrplceZgzzFABB+5rfemaolZgg7Dze1jYPaBpLIwaoYbuQHHjEPXpmsvHXkMofh+Q4U18/nt5xenHjKfNGf7Km0lg5WpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734509253; c=relaxed/simple;
	bh=NmOdqCf/gF7DYtQA/n52K6byB1yaIUwrUMkfsSbD3tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S57r/w116yOpjL9sWTbjVjZbZdzw3s9mvTFsHNHvh8hyjHY40f2ED6S7ZY+2rJIQM7SCvpvz7lHziQ+3CK+NIWO+XjeJxpnIKCzY/rpDp97UkrWnjhWDu8isnjry39WCAJ5wfwXYJvHMVe8gZPxQKnKD3JPMkfr9jtzbbw8EVUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zSpy6QS8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4362f61757fso48499075e9.2
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 00:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734509248; x=1735114048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUO13Va1s/28T6qIaWM110YfN47cZBFUYRB3INwDCck=;
        b=zSpy6QS88oFA85bLLwBsjw+NzV+RgTkqV4sahmNws0YNeuOEpIxIpx+nON8q1Gi19r
         Z7yeQaDXoVV2ncgEAf/FTMVWU+NzdUAQ7+E8lppHVeqep8gwYEq9WQXol48XKdE6wj28
         4rwLAiZYNtUfalvZuTOpKQinwa3KLoZ+Vv4vwHIDVc5vlEGI95LjgWBVYd71KWkx8SFn
         X88uuHmIER/UXdRhQVl0XezAAxk5d3uPT514XdLrToRPdgCZ6BW46MKGgBXO7D2hr2Zn
         15+frFKVorVmwscwL40xamLTCAs0vlBve5vY9KVdJBnaMI4iiPrg3XP1T1YJtMfLPTcM
         Yj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734509248; x=1735114048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUO13Va1s/28T6qIaWM110YfN47cZBFUYRB3INwDCck=;
        b=vFd4d4/gVR2+0Bs7dTEGOTP1tka63O6hLlu1BG68qxFllm84Ubzzwu9K1+r5QSGfxA
         1cSdtq+07L9n6fKajcY88JLuFf43iqqJUy/8+8sr6P0xRT7Z/OglUPDpi2taND3mya23
         Mw+KAqoRxEXLFJeLy3rKiUPnXs+F+AZHW7sgs7WimhdXS5X+5peLFPrXz8egOCiZ9W/Z
         6QhRfc2BNaIWpZ6Vacg+SJjgL1t63+gC87ERDOb8WcJRAXXEdzoqUNfu0HWZIse4VDq3
         BcGZKHxtWv5LTXKqvsbBTMLElFofjEJiIW+qYA2zYLTfth6fz93I/ZXDjVSTmv2k+/XI
         Hogg==
X-Forwarded-Encrypted: i=1; AJvYcCV2yi04O63ooRcpJmfeOn8ZJeAE1k2cmjRVI3zJ0Ati48YgGQEsxhettLCJY9/ALHpD5ykMDMBbZqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhabl/0kAlA+rEW9xQZn3drINi32kE7rEBJB+lsNnI713WE4X
	IVN5Y32Xc9UkVZaZodwSkKhCh5esG0R9NanUiiUc5/+ALye5IfjYZG//CeMIEoA=
X-Gm-Gg: ASbGncvq6bbzqT5uI1oogE6ymhwxxYR5PL4Mp9rEf+ToHZrc1MyhfPVyi/2UxKEjLxW
	t82R9u3vqgEXMmVXP3P1bKeow3L8eOC8Sg0fDIwWsRkc7I2g7N++SMSdaqzgpwThAts4HrPTcqW
	8JOag1bV4y9eZqXulUxwPUE0BeSZRTdzzfBPxOXSERl5Xxd1+LF10AalKcLmRpilcvudbhp8ANv
	efRfBC2hEpC8W+1YLeWDHumtxibBIGxvqo3i132oFF0mcDO/V63mC/zgrhZId3e
X-Google-Smtp-Source: AGHT+IE/VOpr6ya6Vanrk543BWmCOmJzLMi4pEYNjPk21m8gtDLfkvb6JJfIygcCELDi7lmkG+sr+w==
X-Received: by 2002:a05:600c:154c:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-436553e9de5mr10906735e9.23.1734509247721;
        Wed, 18 Dec 2024 00:07:27 -0800 (PST)
Received: from [192.168.0.14] ([188.26.61.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b12399sm12277485e9.20.2024.12.18.00.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 00:07:26 -0800 (PST)
Message-ID: <01f1bddd-7aee-4c90-9fa0-3b94c87eb469@linaro.org>
Date: Wed, 18 Dec 2024 08:07:24 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] spi: spi-mem: Extend spi-mem operations with a
 per-operation maximum frequency
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Steam Lin <stlin2@winbond.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-2-miquel.raynal@bootlin.com>
 <e76ff30b-342e-4e4c-aa84-40312c3ffc72@linaro.org>
 <87jzc3oo6g.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87jzc3oo6g.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/13/24 10:46 AM, Miquel Raynal wrote:
> Hello Tudor,
> 

Hi!

> On 11/11/2024 at 13:07:09 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
>> On 10/25/24 5:14 PM, Miquel Raynal wrote:
>>
>> cut
>>
>>>
>>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>>> index 17b8baf749e6..ab650ae953bb 100644
>>> --- a/drivers/spi/spi-mem.c
>>> +++ b/drivers/spi/spi-mem.c

cut

>>> +	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
>>> +		((struct spi_mem_op *)op)->max_freq = mem->spi->max_speed_hz;
>>
>> not a big fan of casting the const out. How about introducing a
>> spi_mem_adjust_op_freq()? The upper layers will use that were needed,
>> and you'll still be able to pass a const op to spi_mem_exec_op()
> 
> I know it is not ideal so to follow your idea I drafted the use of
> spi_mem_adjust_op_freq(). In order to avoid the cast, we actually need
> to call this function everywhere in the core and the drivers to make
> sure we never get out of bounds, but here is the problem:
> 
>     $ git grep -w spi_mem_exec_op -- drivers/ | wc -l
>     42
> 
> This approach requires to add a call to spi_mem_adjust_op_freq() before
> *every* spi_mem_exec_op(). Yes I can do that but that means to be very
> attentive to the fact that these two functions are always called
> together. I am not sure it is a good idea.
> 
> What about doing the following once in spi_mem_exec_op() instead?
> 
>     spi_mem_adjust_op_freq(desc->mem, (struct spi_mem_op *)op);
> 
> I know we still have a cast, but it feels more acceptable than the one I
> initially proposed and covers all cases. I would not accept that in a
> driver, but here we are in the core, so that sounds acceptable.
> 
> Another possibility otherwise would be to drop the const from the
> spi_mem_op structure entirely. But I prefer the above function call.

How about introducing a spi_nand_spimem_exec_op() where you call
spi_mem_adjust_op_freq() and spi_mem_exec_op()?


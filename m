Return-Path: <linux-spi+bounces-1343-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A179485438F
	for <lists+linux-spi@lfdr.de>; Wed, 14 Feb 2024 08:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A43EB20E04
	for <lists+linux-spi@lfdr.de>; Wed, 14 Feb 2024 07:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4B71097D;
	Wed, 14 Feb 2024 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0+dNpg4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B0125A1
	for <linux-spi@vger.kernel.org>; Wed, 14 Feb 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896586; cv=none; b=f1cgINfZKTUO82HFYNO1oCwA08V0z3ryNtglteHLKTAJ5Ont38Mas6MNwuvD19mE36IJQuUr2uFXflj7AdfHDcw8tdG/In/M6SQvGvMSxGmDsiovj8xtL0SaJ/FL0IuD0LBeQGSk+ACY2bZwrlu8Y6efBVUAzmz95MDbaj3TnGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896586; c=relaxed/simple;
	bh=VWEOVPjzwG5LyVakYdf3057OxZUScV4IOC88KiJYLM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRgTp2XJLoAwNpZWGwD/fVoY/tnChkSXkbStrhRJ8x/cs3DOSmRJqyhe+tTVBOPr5QePt8Lh1wYDCy7FDqYYGWHV4DV45tdsG2Jdff9BESCZ7pM0QoAfUUFg+8t8zGETvqOHiPAjA8duh3ZfJmABavTJ75F4bImDaRKt2APykek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i0+dNpg4; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0fd07ba8bso33025171fa.1
        for <linux-spi@vger.kernel.org>; Tue, 13 Feb 2024 23:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707896582; x=1708501382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qm35U4zALwNw8pnZRUH8OtgtOhB7/DRacCD6hYwcr6s=;
        b=i0+dNpg4+lo1JHLpmJDwvRh6w8H5ra71CjQy3kIEHaRhKePq1hCYhxuZ3hK+5cBFxo
         BRbi55RLs0LwK/3t4DYeKMf5qJeuyvM5vQGoIcAzVbjIAJNLE9FqOizQzYeSOVBS6DYP
         KKL7l61ZgzngMfJEAbciAUVBzjykfRuxbSJKkC13R8ScHD/dvjjIxltAl5O1PUTgL5SN
         IX8NziLLYbEYDYWBGPl0Ymn/3XsKLY0cwRS0uZzu/SfkvTK/BxwQFyREMnQFA45Lwu2F
         yCiT0hx4kqsxgfDXkjlzOggoUvexfX4pElxwEx2V3Tcj37llgDFU0whPRUVZLb5nSYK8
         1HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707896582; x=1708501382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm35U4zALwNw8pnZRUH8OtgtOhB7/DRacCD6hYwcr6s=;
        b=b7taEmdsvGLibrMaf+mK/G/znoSBaWJ6Y9idH+V9Ui2u0t8hDCs6Nrb9eReoE3oRbc
         TVb4egpoq26KDDBke2I0JHdQwwRRJ/COvbck14Apw8KlQtRfbIz86ZxW3yhlLbQ3PLdL
         xMiA2c7y8guLfQqNq13J+yjuB//Gsd9uq3nXElhkUNY+ScOSD00ToBUMdMo13yK3j5lf
         bMkhQf3N+HVlz8gCMUs+wDkiUQ+5DqUannPNtsBJQjLUoJ95uFQ7QU+FO9LBnkcdV6iL
         mqEujXC3CfrV0S/n/dR9EHdy1EK43lQQFAb8AIruSE5e6RnbNmBzSZJ1eH/e4htQbtCz
         gLKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6RwgZCemkO1qNf8BCJf4x7Qk+RSftyAdR8H+Ofc3S6Z217GnHYy+T8bK4o3VviOiZHm0yblgs0gO293SUMqar7drOST+PKHhm
X-Gm-Message-State: AOJu0YwkunnEgr+5J2S9ub+hT8xhqe5r/LB/Vla28IXTmQYXfBOj81zI
	3ZFfp+XfweEpRR3ph6Op0Jf6Su/RQkZ+AZz1K6W3QyjXzz/rVHoKbn1Z0yY9Mnk=
X-Google-Smtp-Source: AGHT+IFgCBpIBi9Yw7Zbk0svMSXIz5z2ckU3mgemyBuFKJc7Ohs0vatZR0iczHy/Ul9qTbzaqUc4yg==
X-Received: by 2002:a2e:82c3:0:b0:2d0:ac7f:eef9 with SMTP id n3-20020a2e82c3000000b002d0ac7feef9mr1312036ljh.34.1707896582368;
        Tue, 13 Feb 2024 23:43:02 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id x17-20020a05600c21d100b00410b98a5c77sm1059749wmj.32.2024.02.13.23.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 23:43:01 -0800 (PST)
Message-ID: <d5d71068-eff7-4a1d-ad2f-948bf0313b9c@linaro.org>
Date: Wed, 14 Feb 2024 07:42:57 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-mem: add statistics support to ->exec_op() calls
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
 <b0844e5a-ee4b-4608-99a1-877660e01d57@linaro.org>
 <69f023bb-2844-496f-9f3f-4e2e80129d33@sirena.org.uk>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <69f023bb-2844-496f-9f3f-4e2e80129d33@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/13/24 15:28, Mark Brown wrote:
> On Tue, Feb 13, 2024 at 12:39:02PM +0000, Tudor Ambarus wrote:
>> On 2/9/24 13:51, Théo Lebrun wrote:
> 
>>> +		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
>>> +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
>>> +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
>>> +
> 
>> Would be good to be able to opt out the statistics if one wants it.
> 
>> SPI NORs can write with a single write op maximum page_size bytes, which
>> is typically 256 bytes. And since there are SPI NORs that can run at 400
>> MHz, I guess some performance penalty shouldn't be excluded.
> 
> If we can cope with this sort of statistics collection in the networking
> fast path we can probably cope with it for SPI too, the immediate
> recording is all per CPU so I'd like to see some numbers showing that
> it's a problem before worrying about it too much.  Even the people doing
> things like saturating CAN buses haven't been raising it as a concern
> for the regular SPI data path.  We could add a Kconfig if it's an issue.

Ok, we can deal with it afterwards if it'll become an issue.


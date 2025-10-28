Return-Path: <linux-spi+bounces-10872-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E29F6C148F3
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 13:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35D01AA3A62
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 12:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F79632B99B;
	Tue, 28 Oct 2025 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="teS58CmQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277E35B121
	for <linux-spi@vger.kernel.org>; Tue, 28 Oct 2025 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653628; cv=none; b=uWn8R68X3MZly1nNLREuhwtiKQEJ6gNECTTbxz2HKeJiLDaz+GvEPYkUdTiAbK646AZydxs1ye7SoP8diRNKDUj3KAX1pbU7gGDfnpKZDNVOqgoDTH4/rWDJW8fbmwwgKD02N3pJjfnmlKACClwZ1SZxFmXEw1C+7Wts4L2/FOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653628; c=relaxed/simple;
	bh=kbcPGBau+vooz71sYCj+fU43PtJotVJhPet/tmcL4PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeLLet9OjMChH0ScAJ8pwb0C48ve+Y7OlsAS0gq9hxExoz2K2iYwoAo8QgZ+GNKxwiHO8mCvgDh854ZM4yBASCh9YgPobfDNxiAOSNHTX/rvou/qVRfpC3C6E9gRt0m/K/7o3+RVvbBEYZSz7LkBb1NQUezZUtDeVumuJVKM4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=teS58CmQ; arc=none smtp.client-ip=209.85.166.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f194.google.com with SMTP id e9e14a558f8ab-430d098121cso25671015ab.0
        for <linux-spi@vger.kernel.org>; Tue, 28 Oct 2025 05:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761653625; x=1762258425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khwU93CFPe3QSgLFIeava2HVYo78KABRwFXaYkzJCAk=;
        b=teS58CmQVvvUym+YrlFp3zwOrka5vN1kZIajXuH85CQnYmCNGv2Q9K0qZQ7M0MORjh
         soe1psPExXKvvkIL9/MCOOcwa+l+1vMEh3KtgX7x9gPT605pXQ3zN2eVN/ZoDub21/Md
         hoIjdBIbAQydBkQsmDk7ZpOg8uuaQmcZgPPjuyX3q2n8kaN8lelDme1CoxSq9IhvphF2
         cPlvw9U0fMorQCc5ryrqLqAEUup9RRaTnuNzM/rlzExze4LIgOOkXpeAu6bRzemwP/or
         RH/4l9Obzg/SrVLbciVj8Owh0ytu6pq3QiGZ6WVWUk2kMVSEPrHqyoQtvNdwvSBy3Xl2
         9bQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761653625; x=1762258425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khwU93CFPe3QSgLFIeava2HVYo78KABRwFXaYkzJCAk=;
        b=xSoxp3+E9LwMcztEbi6Qy+VT0jJDFhI7iglSwztxIeNo3vqJCzT4UxFqYKDx8hjPtj
         j6/jOMD3Vf1zmxIaE4Sdlmj2kxYIidpXe9Um28Gs65eka4uLydJPjygRiTRWu/3snP+0
         2vj7ZtTSuqWiI0KfL6SCqS4dzj3OTAo7TQmlcQZtaMIhfM8QC8haaaeKJ9NuRH01IkI2
         JNWVgwiK8qIGSP0BfQSSMc7mn53loX66gNBHz/a5tK0YeY7ElYDRMXyIArNjUaWeo2uY
         82Q1JKRRCa7jSPbgfylUT0CUftida1wqBta5AkCYpuLbfloaWZHIS1gkuFrYPRgu2AjB
         n0vA==
X-Forwarded-Encrypted: i=1; AJvYcCXxBNpwhyHELx9p0elMSrDDUcvF6bKZCJaCgxgUQ6i8L0D1nwzwmzO33wMUWWM/BbyP7Kw4NU3TSbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRmvmcAlBapkckI1Nl6rebHdYCfDlg15HK6ylQRrrizsTqmdq
	8eBx4aWzuXvuvw1nt+l/TfDCemoc4eEsbc9IO77mHsoZMNimEAoT70SxfppG/UdHkQA=
X-Gm-Gg: ASbGnct9qDQ12yRabSXIQXsZOHerrj5aPgF7zRtTjbYrpI619f/28Et+asLIw0JajM+
	mFEqZNzYJkusQPj3oGw257dF0fJtnkClhtpa33zeMaUC6gMzC9/b1PK45KnqeGRVxJvsTdNOKhE
	eXlkXgsHsJA6b9Cg2gHwYHwZH3C4Bm9zt6sJeF8z8bKSl4Fw4quhil1YV55DM/OEAcODPtb3/oP
	k6ZWdFrBiMKPTJ/8rfGJ8Nk+q9VmOsY6Z/tS2QqxtgcOPRmf1+yvLfOlI6acmU1v6SXNdeLQ1hL
	QMvIhkV48DIPSqIgoalYbB0/XrzLwp+aevGSzF4KeWg+hHPKGdWEuF9+zRH4Z7aWKcVvqx0G6EQ
	gDbM30WgeRgiwjRGVGI/wxLtTVoMTvZJcJAOGBjMTnuHBsfPnMEmxQ8aG1CunyDMe66/DySXPDS
	wD3A7ScVk/UpiuEaq+uAUDd1nCgap5iT2XZu0NuAdo
X-Google-Smtp-Source: AGHT+IFFKmfRm7wHQRo/Azl9/WRSsx5DMAL5YyC5rW7dp5KofBMFZhyFfl0BPEsUUmZluzy0ORJ7BQ==
X-Received: by 2002:a05:6e02:18c5:b0:42f:9eb7:759b with SMTP id e9e14a558f8ab-4320f7a8a05mr41476835ab.28.1761653625563;
        Tue, 28 Oct 2025 05:13:45 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f6898adfsm42280895ab.31.2025.10.28.05.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 05:13:45 -0700 (PDT)
Message-ID: <71ee4a10-70a7-49e1-919a-0b47af4780fa@riscstar.com>
Date: Tue, 28 Oct 2025 07:13:43 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] spi: support the SpacemiT K1 SPI controller
To: Mark Brown <broonie@kernel.org>
Cc: dlan@gentoo.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251027125504.297033-1-elder@riscstar.com>
 <e4dd3db6-d554-4fd3-a674-60f2ff6e5475@sirena.org.uk>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <e4dd3db6-d554-4fd3-a674-60f2ff6e5475@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 9:40 AM, Mark Brown wrote:
> On Mon, Oct 27, 2025 at 07:55:00AM -0500, Alex Elder wrote:
> 
>> Between version 5 and version 6:
>>    - Rebase only
>>
>> Here is version 5 of this series:
>>    https://lore.kernel.org/lkml/20251013123309.2252042-1-elder@riscstar.com/
>>
>> Between version 4 and version 5:
>>    - Added Yixun's Reviewed-by tag on patch 3
>>
> 
> Please stop doing all these resends, this is just making things noisy
> and pushing you further down the review queue.  You should not resend to
> collect tags, and you should leave a reasonable time for review.

OK, no more.	-Alex


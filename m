Return-Path: <linux-spi+bounces-1460-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03F085F467
	for <lists+linux-spi@lfdr.de>; Thu, 22 Feb 2024 10:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6871C2114A
	for <lists+linux-spi@lfdr.de>; Thu, 22 Feb 2024 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D3E36AED;
	Thu, 22 Feb 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yiy2jJP6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD702BD1C
	for <linux-spi@vger.kernel.org>; Thu, 22 Feb 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594338; cv=none; b=miaQ2T07x84yhc3IwaAJJEZ8MQdxkxCrSc4LcqMvMfg6TughZYzguD8eKZovYl2NwpfDkyABR058z5ndjetgZ2DVv1BA95kv46VpYJ6N/ixVslKx84MjKqFqchB4XRj5gIuNtNegJJS/QMQ1bzQuoLSn2LrsozA56cHOfifajzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594338; c=relaxed/simple;
	bh=XOqM3NsDuWKMQENhNm5+cil6xV61x6dYDLcx2FP7twQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2DWG+VTLqumDpqm6+ZE5X7wKze/jukicSHJqagOEETjRhfYghWyTFLZN69T5hSvtgqKvD8HQlubKUU0I0zB3GpsbZkxq2vgY/HFV1lMwxstM6n0fpGtHPcYNaMmsmskd3cLZJriE4JhsccLQtwAyb9Y78DSpGanBZIaK00laaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yiy2jJP6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so7607099a12.0
        for <linux-spi@vger.kernel.org>; Thu, 22 Feb 2024 01:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708594335; x=1709199135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XOqM3NsDuWKMQENhNm5+cil6xV61x6dYDLcx2FP7twQ=;
        b=Yiy2jJP6QigQEOw2V/pWmWJrroxmk56BRctJfNOT1A0F56B8CQlDki81ZKKbwPvH2H
         sKCN2hka6v55aWd78z66o54pZ/p11vd8lBHjdqu4vlgnCx/LM2iC8v+g97IS39dF6Qaz
         VKS6RDlh2m2Hc7Z7RztVHrEUKom0Y/En7FPveJczGitUsd2oAnSP1TNJdChrdd3/RTpm
         D5IsHNVp5Oa7J2AxpOK2Ms+3Oz4oNXG5c9ecONiMPPbj0yfIy61rD7uWZOOf0QVR8o93
         dVoZ/N0T//CkGGC/6o2qr5muxJEuO+vnlrwmS+nouy6dhzdbwvVS7GbnS2AVOLY1Qs1y
         T1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594335; x=1709199135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOqM3NsDuWKMQENhNm5+cil6xV61x6dYDLcx2FP7twQ=;
        b=CMghds4Z+Mf3979rZVeY+WVL6PiaowiZBzzHiZR3ooRvlxgx4C/PAxBZ//F55FKGwp
         QwMK7IMP228zGuwVMPf3QNAVxfSSNdhNuHQd4jJ1/TDRpSfHwHoqYIWExmAMYdTyqdqC
         e380qF+GZlQ99APtDO3DhaNVD1tJ0mPvt00cwda1dZcyyCpBMpPm7ZeD7/7+HNLwRcbp
         LfhyMmsOe8RODUgVXWBezaUdSJTrUW01b7Stq65rKcdiupvbCK/AC/+4TWpggJNoHgPF
         c+mW+7P0FiT0GNWXJWAlqiomPGgEL+hVF0D62gaSvM3dyB/p5kozUPvXItNzq1ikwqjR
         1lKg==
X-Forwarded-Encrypted: i=1; AJvYcCXXsEIU0L4yvhd9cLKaInoF1V8C07/LjocamM1YdDN0rq3PVXUpkGGEZ4ODx3qLLqWsSQzVJMRVqlyVMf9atR69JqewPdo93Pl7
X-Gm-Message-State: AOJu0YxsESRmUkMaQX0kT/PJ5vOf4qo86rrbdgwgKaG5VrLUa6rVN42s
	ianoIhBeN6q3eZcHU3ex0JGgxM8Zw3p7NS76MP7331zDHLt/NaXqofLmrh+rzqE=
X-Google-Smtp-Source: AGHT+IENrhhk/UuD9Uow/GPjukRT5yJvT9rnH/FfAXts5feTUta/DGa+0TovOKoVhCGhw9WaDjA8Yg==
X-Received: by 2002:a05:6402:797:b0:563:f854:1a57 with SMTP id d23-20020a056402079700b00563f8541a57mr12309566edy.40.1708594335069;
        Thu, 22 Feb 2024 01:32:15 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id fj21-20020a0564022b9500b00564da28dfe2sm1857570edb.19.2024.02.22.01.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 01:32:14 -0800 (PST)
Message-ID: <75a22482-0d2a-4e0c-86e8-3a8e71f2f403@linaro.org>
Date: Thu, 22 Feb 2024 09:32:13 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/9] Add octal DTR support for Macronix flash
Content-Language: en-US
To: Jaime Liao <jaimeliao.tw@gmail.com>, linux-mtd@lists.infradead.org,
 linux-spi@vger.kernel.org, pratyush@kernel.org, mwalle@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 broonie@kernel.org
Cc: leoyu@mxic.com.tw, jaimeliao@mxic.com.tw
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jaime,

You're so close to have these integrated, I see there are no major
comments for the patch set. Would you please address the comments and
re-submit?

I plan to do the PR next Monday.

ta


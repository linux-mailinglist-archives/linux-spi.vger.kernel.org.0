Return-Path: <linux-spi+bounces-7687-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA3BA9400F
	for <lists+linux-spi@lfdr.de>; Sat, 19 Apr 2025 00:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5468C1891B24
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 22:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E130D2417E6;
	Fri, 18 Apr 2025 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x3Pg0Gp7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6422F17B
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016685; cv=none; b=Ix2wnM0pGEHn20POsnCbEA++exCr59uelIk9kNnZ4OAKu/ZJsnCfsUh9LA1XAofywecV++pV4w346b6xFn9Exueckk2vWwDnco1DKlwVJvVhuCkb0i9vAGy3nZwk/VxYLhhKYbbsejA9TV2q7DUiNrm+AFrIFy0P2KpfVPf/u/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016685; c=relaxed/simple;
	bh=FD7qYZACx6hcTpg8TzaopBbjgX34k5mUJ8eFrioiSLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9eu2u5tsu0Ixk7sNG42eWF+xUbqVrUPO6rdX0lW3XLg+YM4sw8aCTUmLnEgOdZ9JRW+6pTo456bk7j7Do1fnnn/Uj+HQmiVhU9LcoNf6vcBRflMC2AIGw9jwpeKAAs1MCZLpqO/thVm39Xd/6q/59TbNxJ0MVqK9KEHMy2R5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=x3Pg0Gp7; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-60406de9cbfso785602eaf.3
        for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 15:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745016682; x=1745621482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x55V+VCRlisrHXg+pIA7fD/Ysy8e6uk+suCZmNG7DvI=;
        b=x3Pg0Gp7LGvPfLAyOSHJ4mzpHk8X/Iok5m/UM50j5t/ZitjdPO7dEpbsC/01cc/1SZ
         7UMUB3CeZKMNsswkWQAAjsD+TYbGX6HvnWTIJIK93NqR9RrI5vZkGA8eK/MfJcwV6bun
         BwXTWcGig7Ae3jJq5S/AARdQWckTVZCIKuLPGrKLhuR2wvt2zaDEVCNAV/Zf2404ytid
         l+vkKuJjKh+6EByL5flHcC8NAsSYd1Nt/+1ar/4iK2IIoExMGTXlYTK4++oFwYPmfEpO
         eQG0h4OSkGC1ml74s27wmM2vdz56WpoSscwVfz2MLEJarG1W9eVDpOYFGniOdfeVxQmV
         cmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745016682; x=1745621482;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x55V+VCRlisrHXg+pIA7fD/Ysy8e6uk+suCZmNG7DvI=;
        b=mpj9YDi6dSiQMw28SFMb8fspN9L3avnpIcGp2ZU9siPALdOMVJ6vJzAMUQylTJoHa8
         Kzd+S3IvLaZbv1eLxCQPUjB2qcDLcenqNAD7V4NQEhvepGpTkiJTVbAisD+cOLvFLrwM
         KVR0l9lrL49nJk6PB7x6E0BBVxqkyGnOqBS+FplWh6mPEQ6ad3mbYrgM4pEh9EZGRbPV
         awSpK/+0bZ31yIZaicNjALwzLmJnsyPcUrJHvkbEiWrtrZoEtl2l4Krk1c28DRG5GNBX
         GkBCdcdX4aJAw70y2Q6Nmhkiv8KqetUBj3Es8+Ffie1xxezj72Hwzw/4gVNB1UAhntUR
         cWxw==
X-Forwarded-Encrypted: i=1; AJvYcCUY2kOd32US0yZgENWmqCpeHFVmeZw6n7D1UZtnrh2mRur1Cl896wgAnLPLnuOK4WhcGj47jhMmPjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9e2ZGLFTnRW4JpVmUOOVykKhLfqSHwWZYb6piuf7X+WlxUsSd
	PjXwW4iN2CkqimPI22skKxip26gaMW1DQolIcBRGE4AqZ3w4NVLj9Nrv9mRSCtg=
X-Gm-Gg: ASbGncuUxc3jKhnuWix8KcxZ+X4AsGSukYu1711l2a5zurrJ+/eAlIt7jYvRi3uOqn1
	K80Jb+o9qGiYHHwan+OOUcw8OBFCtwFWdwjY2NhvcYTKtik2U6KO4qmq9+uGo/RL4mR7Uh0Nofj
	Huya8t3AsBMs53ewN2fx9UGsiTwM4UidETik1NqCqu/+mPAM0pwl7UOz6+yfNxVkBDLndAkQAJC
	q2kyI9iiWWxnVXWI3CpTt7GirqmddPqfjkq+NQBQd3cz2609+7yDD00yaJuaH0lIP9Wa1Qgz6XK
	xi6dB81r+VCyslYqBd/1dXookekfsJEXEnEv3UBlWjaHJcufHeKCJtnUOMkYRJqLFf5wFk/FIrv
	wQ4qwQg3o51NnMDFHxw==
X-Google-Smtp-Source: AGHT+IFrv/AVCLgBdZolRgPwF489YbZw0WwENA37vNXowoNHh6HdP1gyMb5d6db+e7IxVah0vg9CcQ==
X-Received: by 2002:a05:6808:3c4d:b0:3fa:1d22:6d2c with SMTP id 5614622812f47-401c0a7b13bmr2534402b6e.15.1745016682003;
        Fri, 18 Apr 2025 15:51:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279? ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401bf081e3csm502573b6e.32.2025.04.18.15.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 15:51:20 -0700 (PDT)
Message-ID: <47f29807-4c1c-4d90-b284-256931e3f411@baylibre.com>
Date: Fri, 18 Apr 2025 17:51:20 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: offload: check for match callback when a trigger
 is being registered
To: Andres Urian Florez <andres.emb.sys@gmail.com>, broonie@kernel.org
Cc: skhan@linuxfoundation.org, linux-spi@vger.kernel.org
References: <20250418224750.46219-1-andres.emb.sys@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250418224750.46219-1-andres.emb.sys@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/25 5:47 PM, Andres Urian Florez wrote:
> Make match a required callback when a new trigger is being registered,
> this allows that other functions like spi_offload_trigger_get() could
> safely invoke the callback when it is required
> 
> In v2:
> - improve readability of the condition
> 
> Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>



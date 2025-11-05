Return-Path: <linux-spi+bounces-11051-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B9DC369DB
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A99A1A27A3A
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA15B3346BD;
	Wed,  5 Nov 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+H8tiNB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA8333755
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358811; cv=none; b=ZocJYeNGkAsS9u21eQYCB84xg6TRZy/Uru4kfpCxy9WCsrT3aCj3mDaH++OjDBZxSEWkbWm1xhYuT4vUzUWxIXrvlwz2hQRpNzwbEstbT+GAs2Ikd9e/JCf7Bvf97/G8OgNNzrImZXlhzr2Brp8wj3ExHfsAnsjMrD7PEjvlZOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358811; c=relaxed/simple;
	bh=m9b+6Qd0RrFy0k4qrFIgFV3TWvTpO/YcaGxKS9mqK3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADIL0LBJTweQG0sj/DKnJZ43rSAfB0lwEWW5+1ZTdj/HYfRXFYXuHHC84MARwMRE63aI8AbBSkBMjB6HqRJLLCZ6R3Zp8OX8oyzrXdeFkHa4U0dE2ctMr8b/IKS4B7IA9vAfuE+lokFF+fDg+S4CrrDV8ZmtIjySLZK3Oo2Mu8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m+H8tiNB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b727f452fffso79676966b.1
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 08:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762358806; x=1762963606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m9b+6Qd0RrFy0k4qrFIgFV3TWvTpO/YcaGxKS9mqK3E=;
        b=m+H8tiNB0Jl+JKTf8/gJ3pAmFH6LyH6aKRw6nyZkHQbg1rZtOW07SPuIPkhwSkOPWR
         5GEAeq0hvqChRaXYF5ozqVos9Y4J4t1ZI1caTPjUpnBWxu3hhzNfzYstiJpOIkArS8qk
         VvoUttWhpzBq2tmIC8s+RMsZYfvbVN3pAimBPVI7+zsOIdz0wzLCxX4L/pjsRUAP50sK
         LBHrd7JFyrfJ2m/vDVAr3NJLqk5XLnfhqZQSgwia+nDX60U6b8eXigQKjNcQk+fKxzHJ
         N5Wy4jkOYGQR4MrW5d4Iphkd2M17Idz3S7vn+ThkKRt/9TPRLnN9Fig2X/9M9y9F3CmN
         NBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358806; x=1762963606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9b+6Qd0RrFy0k4qrFIgFV3TWvTpO/YcaGxKS9mqK3E=;
        b=Qj866lT7KHkdE7503Le3Y+GpsdyN4FJXXgaToWBWjha4l8PNFZKLFHVu8Ofmkf7KMe
         mzxfhBd/fFhwTe0hZfniCfUo+tTc6HsWyiMg5tWOhCY3W1gR7geLOf+zqi3dOaGn0iZZ
         dqHestx0L68ucIfS0joFTvA7GJqhiNYIbPZplkurlMyGJtIBv1GL3Sol5r5geL9pZHWg
         zQSqmcNSKWIKQEwgoFjpHHZ9rSaIhd8/+5tciY5vDC+ey6wqINOJQG5xPhZESJY3IFnx
         isTvL9DucYZaM8RPWluODTSIAqKeUtcZKDZ0fVcxFWKgI899lMTo2VG1ND/fioAYC+CU
         74hw==
X-Forwarded-Encrypted: i=1; AJvYcCXC8CbydeUdSvDd7tKUNymxAE6y+hgrFv1kr88MpPNPCDUP6pToa7y2ss4x5qwQQWOxVFqAa+3j7Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YysWvJQ+sid/hGcbONWNmScIIIGDpD/1tiINQgINo6xGVACaxSs
	/7pEMP8pivPb5Czp3WPvmfZTa5t+AnbC0TFso1ny9QGeINW5GhP1w9eQXIrgnmUqRC4=
X-Gm-Gg: ASbGncu9NRsg44GF8m69decFtWPtx23J2e8ZUMmGkolM/hk8hiIXnGAAzU8Q4e9pN0F
	/VcgvMKO5MqdOhEf7xGYqrRun1QT5L/qrfTckX2DCeLkzkh6iPqIE7NCsnrPyT5d2NH0GQ8Cx7L
	OFkWSOusIvSqfwQWpkOK+pRO19v9xGpY1Ta1B8D80pwiGYTjU7szlhK4GEzE6r71SCBQ1spJ4xm
	6GpU9UxkyPQDGL+fuOHEs5dndTMwIHdYWKrs5JFuBpsypYPtbY7fl7Onjfkxnns0AHrKSdIEgmR
	gnhLy998DmoqCP1RB+7P01N8x3RsTU2RSAiEYezyAkam7X7JaMOMt2Mo9LJTqtuaTGSdsxmwlin
	UiVe8/cQKT9v2CdUJQ8oT87cfAGWJWvs0CWySWyYMnVr0wWneHxB32m0BQpg62svQ51vVpPYUG4
	P0WDLGNY+sifBOqIRebSqyyKM=
X-Google-Smtp-Source: AGHT+IG75jAMbaFvc4eUbrny4N5h/msFWd7WmC5fwk/VMEKKvJ9mo2OYEnDfZlTd6IeuC0xb1XzJNw==
X-Received: by 2002:a17:907:94ca:b0:b70:b9fe:aa56 with SMTP id a640c23a62f3a-b726320200dmr415235466b.20.1762358806257;
        Wed, 05 Nov 2025 08:06:46 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe3902bsm512775666b.63.2025.11.05.08.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:06:45 -0800 (PST)
Message-ID: <a852781a-70e1-4da3-a283-a81be10daac5@linaro.org>
Date: Wed, 5 Nov 2025 17:06:44 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/28] mtd: spinand: Use standard return values
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-7-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-7-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 6:26 PM, Miquel Raynal wrote:
> Replace -ENOTSUP

do you care to fix all mtd? :)

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


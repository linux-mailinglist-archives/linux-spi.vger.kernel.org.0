Return-Path: <linux-spi+bounces-11050-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC4C369A8
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86D51A41D6B
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098FD320A22;
	Wed,  5 Nov 2025 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hENwCIhG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C6333732
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358717; cv=none; b=q/R9ANDjK4WGLYHrBJsjerpBP0m/QC+QtId9l6s22fWn+4VXbLVGNI8nz6RtSS7uLIQwG9bZbetHd183d81Uda5+sHzjpb9StMw5CTjtlA25noZs6YOxqt+VcWdiMI2Fo5XD/dCSSgLAItrbhhtt0nhlGEp0cmBE2l1R9wgSDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358717; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Me9FGS6lMt7I/LkTsk1YED0w9I53iz/03omo4aZymQ/e2VGHgixLbXqPD3eShhbo4F6zX/7Rs4Ux3ee/iNZDCCgp3Gio8OdVux/a7wV5ptfKQ9HYGCZLNYjZ1rQPVBcp+nGxeDbhOOyhfHjNmx1ccoyzRXvKto2rCKtbsT5S3XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hENwCIhG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so6352178a12.3
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 08:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762358714; x=1762963514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=hENwCIhGKqCzd8LgQc0blP4zGkTKatUNzALQjiKSsQkn5oJZf4hai0EhW4B57cdFv6
         K0626mapCt3Tzx0jL6fcl8Xo/9BVxqMMrHUZnHBV6GD5ru8rqyraqivim7bKk4gZdlnh
         Bc5eLWAEj8dC3Kvt66ucKR5qOyTn84l+57FauCvoJ4uxB4WBhzZqQ13GYQVTkznXsm8n
         1M7/VsgH4tjexnc8v4QiXXa2/2fv0J3XDdEt5gRUnySgk0QzFCHxLUsn9gFsJ1XjzRSi
         DxAoKH82W94dGtTLEdtldzNZjolWVJZbfj5VP/LGwHdT8NIBpQlkgEblYuIbe+6au9rr
         wSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358714; x=1762963514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=eolFR5KMSwulnl2C/ahdjS0ZP4u3xhcjyixLewyQL5Gilc+0QMaBfwiJc+8nASf/Yc
         zC+p2wLzI2UAjYzLHQ03jCwnAd6ZcmjwNO3RDldRageH9iteE6PSVjiLyyFwtsB5bE5+
         cOWbmBPMefcI9cFkD5gy1oZvvuYl3bDM90+9CXKfSk3KqiDZjHiNI4FAFYat1tsCPCJq
         Y2GtU6xTOdl3OB2PvC9RckUstBt2gheH5ODlzVCEy+YdVL087nQGgoHdWtXIa31Rgh1d
         6zyrxSPWDb5droSRW2CixE8o3pUF8nTlIM4v4fTsDRR3mC+YErP1vin+Rdo1ovm68YKK
         TJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCXr2ovPb33989D7InQUUWjIfi8cmDPwOlNdpNIZSxm5udUkqnqdMYjAaE6qI3Sg6mOGNYvf7/uRDXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWGbOHX9Oq4MsldjHx8uF+NYvwbTuiXlEeefohOkNGX/Bw5KP
	DZa0paHrigMlI3W7t1dRj6YEjqqYqERgpsTsCxthfZDm1bthpJwoiRF/ooT6dvFgHW8=
X-Gm-Gg: ASbGncswpBPp6KFKxeNZj63jNXC4hC6qvkvjf9lUdXoQdnLqhMIqG0IJds6FXnbluty
	Nb8pF+TC84eQ6MKJmE8Fpj5SkoO/++UByNFktWqV7boDqFw6BRbRUeGG4jKPuVwlQOfq7IOxBS8
	0RyzaKTYXM0PiFKh9V1z3WsR9LUDnWDVcORTlNIJJOwwCawKEits8krAWwICYODCJdcFipZk9yr
	xt9vI1UwACDVrc+qC0f5tqt3nvPJUM+cQslZyBF4vH/wf78y1uBkEgmbzsNfMzSq7dpVwexwvUw
	8eWB8PZyFIE4QrJ32quzT4d5ugthoVZdrw0AJDjf0ZP1Il1RFsXG9IcpxuIN/CLUyXCwJmSftnU
	D7Cnq23SdDL0zL3LGejZsUvL9BuXuL+mcPnQu0MXx+1IPH06oPiCzj5bJlF6O99OAKePUelC8SJ
	3JQL1BM+xf2a7yjjW2k8VrHRc=
X-Google-Smtp-Source: AGHT+IEZ4jSMqgU1j3ShuBTWV7Zpy421hTwNR5u92fURxhF1PiKkkzbDZyzXF4ZYvCapBIQeuCyJsA==
X-Received: by 2002:a05:6402:3247:10b0:63c:4da1:9a10 with SMTP id 4fb4d7f45d1cf-64105b9d03cmr2682548a12.31.1762358714583;
        Wed, 05 Nov 2025 08:05:14 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e680578esm4903569a12.10.2025.11.05.08.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:05:14 -0800 (PST)
Message-ID: <fbe28f12-b462-4620-80ef-b6ba5ff3e0a3@linaro.org>
Date: Wed, 5 Nov 2025 17:05:12 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/28] mtd: spinand: Remove stale definitions
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-6-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-6-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


Return-Path: <linux-spi+bounces-5088-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A098CDC0
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 09:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159F51F24682
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C0825771;
	Wed,  2 Oct 2024 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7TfZKSu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3E839EB
	for <linux-spi@vger.kernel.org>; Wed,  2 Oct 2024 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854108; cv=none; b=XtYgHHH+NBudIkeKvCGOirT4CrWBzROTc0UeGI++Yqdl+3x8siCWR7SMpQa+j/QtQx1oaDsUfKXQhYwSvkTzijAAI4iKNaOuH5lbssttKQIA7rscVeBts/2yVDu89rjaCCT1tU/WUFbL+ClgmM+W9/H4+20bqLZbpL26yfWTBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854108; c=relaxed/simple;
	bh=7Pki5qIMgZGtlpzs164aQqzu7jxloaodB/5u3xxRbXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haC5TOkbnc7RQ2Emk5P5tJOn+qstZ/hmFGwlSuGr17pJRQ9xM3qX61x2GBxAtHCwPAMk7X1QUNpW9n488JvWY8lSr2aNVYvkCHkjsN7QjEb4YB2VsWr5lHOJuRZTPXDkREJQrgzFhZ6ALDgcgJVsJbY7ZscmSQuDG8Tx1Oayy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l7TfZKSu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c88370ad7bso6533114a12.3
        for <linux-spi@vger.kernel.org>; Wed, 02 Oct 2024 00:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727854105; x=1728458905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hl8FCKc64Ssu2GNc1972+PuKRGXuRwQabL9GP2xv2w=;
        b=l7TfZKSu9BgaDD1Bbqd0LgD7W9B01npGSxGMKnqQ1Y2IZZ+nHH6zNq8RT2fxHurMml
         tkHpfEc8AJXPX15n2L/ei/yG1sGateY4nI4LGBBJqksgQXRKr3sRORQxzEZZl7MaW5nq
         r474nQk/1g6YQXhQyNFFcFo1FUI1s01/Kg9rEpQFoYg1XITdXqlqGeELCLLHEJB13fqM
         mteFiTri5L2CdLKlCiP34UZ8rgDncJMtJWWNhTW2z9Ty3856mGlAMfudbFOXnrlDZ39K
         zK+jhmKXVVpZKxhz9T7YEGrQljtH/uK5AtEqsS6xYYiYln2IerVcvc3EWHiqpAQRTw6o
         /tIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727854105; x=1728458905;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hl8FCKc64Ssu2GNc1972+PuKRGXuRwQabL9GP2xv2w=;
        b=oaEIcn9LfmeY2VGnPSZ745sfmvPaA1FJE9/WMuZf4jNOOSNXN9X0HXO2QPC7hXC7gl
         yNoMQh5oYYchZTFl5mAhzowgsWqZioQEVpbXAq2xb3QGieXvuYhBrm5OcpatNhqeKPZt
         vQ5tCmYVtoHUv67IkuUXWp0415Lu9+Ktl5MWq2gQFhpjUHISccqBQa51mdIcFSxeMuwM
         iBr6Oweup4NKnVwsTsLM2WaEu7xGqvmVl6/Xbo19VxILyjAUYgt58vvEkZT3LEkA5Ief
         5Mf/i2IOrxCXCRtS0mplzQHZGYY9G292pID5qfw0B8mlz79RXzHAH5lsAQCK2F5Iog5m
         XDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZF/UquBMWE3rzSWjein+RHCwK0Nw12CEpSpOCuTUf5AMCmj3UK8zlzCQoIqrMjXbSPgalw/5esXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNPkUwFxQ3XrfYKNolmfRobnkkFP1ThBhAQ5jda8xLkT90NHAI
	Z4orQ7CcLdDVB+YS5hBx2txsLeKe5b2VKxHBoNGzzkqi+2KZAbS1SDRty1uEPnw=
X-Google-Smtp-Source: AGHT+IHcfQc9l8CIqhgpaESQ2s1HdIuuIEefyoKHY8MCEZ4FaqpllkEYkfaFFBTq9cnf7X9RZ20zIA==
X-Received: by 2002:a05:6402:2114:b0:5c5:cdf0:177b with SMTP id 4fb4d7f45d1cf-5c8b1a3c3e8mr1401881a12.21.1727854104762;
        Wed, 02 Oct 2024 00:28:24 -0700 (PDT)
Received: from [10.11.12.174] ([82.76.204.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88240a325sm7234101a12.33.2024.10.02.00.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 00:28:24 -0700 (PDT)
Message-ID: <5ef0b8bc-9728-45d1-9566-3f780fb70ee2@linaro.org>
Date: Wed, 2 Oct 2024 10:28:21 +0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/6] mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order
 from BFPT
To: AlvinZhou <alvinzhou.tw@gmail.com>, linux-mtd@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, broonie@kernel.org
Cc: chengminglin@mxic.com.tw, leoyu@mxic.com.tw,
 AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
 <20240926141956.2386374-5-alvinzhou.tw@gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20240926141956.2386374-5-alvinzhou.tw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.09.2024 17:19, AlvinZhou wrote:
> +#define BFPT_DWORD18_BYTE_ORDER_SWAPPED		BIT(31)	/* Byte sawp of 16-bit in 8D-8D-8D mode */
typo: sawp. I'll replace the comment with
/* Byte order swapped in 8D-8D-8D mode */

No need to resend.


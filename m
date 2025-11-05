Return-Path: <linux-spi+bounces-11049-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B112C36987
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F109D626408
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA90320A24;
	Wed,  5 Nov 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqpSPRMj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE13C156F20
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358660; cv=none; b=tj38Dk5igGCdWFIIFg+OE8oNd1Ob3qd9U7gJuqGi0d2voLd/v48NWnc3bUs0AoGfObwWcKz7MfltqNrHk3CKlF/ShPOUtpQ83cWtI244IwOPwrRS6eWCqCagn7mkVLU/mkaFgw0AEtnOcZytPmV3mGjIZtwyrveHNdDkJPnVX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358660; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YS40onc+12q1/0j0tJ5x530kolvV4PJi1KcrDMM9Grnkk1fq6HXL4K6pedrDfBhuUrNMr3J8Tryb7FSdJ0rvVu2q/djO/fYHszs1QXJwtnDWSfHe1SFSHq6LYY+DxF6D2OqBrz9Ua8+GDNUwUd8LxeBwmLzRSvjjH4rw+mj9fdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bqpSPRMj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b726f913150so1307566b.0
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762358657; x=1762963457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=bqpSPRMjCQVmrJtPa26ktK2vYMifg3gFOZuXJxHd9oO60/Jv1ztnmQTWt6Z34lNslF
         gl7xwwDsMSi/YS6cL8ziKvu1EQRFVUakPd7LlVJZPzvkKsInJJSSJ3kz6lUcmWvdnUd4
         RwICeq5AgDU/14dw6TMHI6mtoY3lEGE2wLEAUZlGN/7YgIeObg0MF/J6WRqiYBTMAE05
         NgwxxRuT9In3/tm9n2cql/iJdfhgJqKwktpbPsTkBu9/ro0UEpHN3HsbF83vvfeoqrFw
         GaxKRjLgxf5XU2rplp6f90gzidkI0gb4JZfvEqBKhllLyVuxC1xqmHBOrBDsnspTf6Dj
         k+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358657; x=1762963457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=h82rD0kn+SC/khTMfB6rtMwKgGQl4Fa9wPNrmrEQ/izcXPBe9CCKf7uPAB7sBvUSYq
         3yvbPnfQ4xSo0Cq1cya1+559kaGGjKhfn9B/13cVdl2yK7be7YP1tEg98pD7T+wJYEF6
         8Ty16GdI3DI6hRzbujnbZbLQbORF5XZqfKwBrnIKVz3LCti+hq1Rw3zBy5fgj4fg54Pq
         CGn9qE97xiYe8pGFJ7ET1QhUiasT2QHY4aS0Bs+IBZTc6Th6tzc9moWBAk5QXpPZ6z0d
         l7lCbjzIuM1rMDkEBAiaSdWEq+5zunqQ542ah5pl8r0D9+IHFgkp8pmLTvWjGIfxHXr8
         j0ag==
X-Forwarded-Encrypted: i=1; AJvYcCXEjGG9oUaqOv0P+ncEpEuZ6JXJzl7sk3nGENdoFZKx6MDlAs65aREdlgxxbJo/JeORIQHB9VTLa+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLYghT713P5unAuFk+JdAxXjsgg//mkUESFl+rG/YDEIMG0yg
	N3tj+Gx+3AKlqv7BnBUtpguR6w2KwRV8NMrCAgc/VqBMfQpdEAEuMmQBfxJXRcoy7sw=
X-Gm-Gg: ASbGnctT6FXae5yQ7GVNpa3dIN6ZYlnde6Z1gBRxD2GPYGBtCILRbKBv/2vjG8i8mrA
	Pbxib5jt08nrX5B2WOPYS5nqHaTmtcx7xI5aZrX7uJ1ErMowZqh4Oj9wiCq+pqCPR7PJ7Ab5iMN
	ySjPzKc7sDd1ZzzhfNROln05A6WLbaUg9l5uLsgeRnPAp1YXDxTup98yP/4w431dK83Ra2xTIL2
	NRoeOtVwN3Fokzehs5AE+MsE465WheuS7WcOzhYXhKrXEasEmTC+EIm9m31+eGt1gf6BNwPJOgY
	bTpTZhZ0EbbUMWuvN9pkFoLTL+DFucd73oBX+51YtQ+ngzWQkJMDimOXQvxZtmrzwtPmqQFr/vw
	1y4OrHtl05Gp8hrwMistCKahooQxN3taz2KEpk6U1iFIeiptklzhYNsT368YPloSKP0TQhulnXj
	odqQNMRQ9Ku7l8I5NrgyVhVcA=
X-Google-Smtp-Source: AGHT+IH+8UBl88iOFcuJ5mLvs7y03FE0ImwwlDmWIzieFw+K4sIaLEleiL54hEot6DxqVBsb24f+9A==
X-Received: by 2002:a17:906:d54f:b0:b46:57fd:8443 with SMTP id a640c23a62f3a-b726323d55cmr451555866b.24.1762358657186;
        Wed, 05 Nov 2025 08:04:17 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa0828dsm518078166b.50.2025.11.05.08.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:04:16 -0800 (PST)
Message-ID: <89fc4526-db36-4974-8a38-554315fe76ed@linaro.org>
Date: Wed, 5 Nov 2025 17:04:15 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/28] mtd: spinand: Add missing check
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-5-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-5-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>



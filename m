Return-Path: <linux-spi+bounces-11060-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4533C36CB6
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 919F24E4E08
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DA22D3A80;
	Wed,  5 Nov 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zi3XNqgQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87D2F7446
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360812; cv=none; b=Giq4kuJaDE9SZUB1V0/8xm60uiyeYpyhWwDwxgtBGZrQweQegdjd0TPt2ggb8Agm7s20qDhjiL2MSFGvqbhf285x536AWEuea/8i5aigUxb21ncYyw+OR1kxYXHYUYccSw0qq4ZDGzwpgD6g+8H6sy3jys6Iryz3McLpnolbD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360812; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEAHsPgCIBJgTu4uP7bmfTuwZuMjvE8x8KJRVuXj6hocGPR+Q4kI6A2+1oFrxBh8gsYmlJ/S8iKua2T4MDGL8pYfUX+5o1PqQ0vTJbkOy1Zi2iae9LICNkZE51tK+NC+NiW9OgwHmGBeVjTAB37kF5exN4PKCBmUE2iYlrbmcL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zi3XNqgQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so109537a12.0
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 08:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762360809; x=1762965609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=Zi3XNqgQzrgwkf2OKfht20nI+Tb4tSvjgtK/ZG8cw+muxWsyhikkaxIEBivtdsyYDb
         oNvfShzgEHSDcH+DuPZvMZIPt6s5nqwYU7Tc6RVlFpUYSLyBpIBgh2ELWJXpVEA3rzxk
         VvDLl9fIhDEjI7BlhHHH3yBjnHR5RjAPNi+J4I4Gnb7g1h+zq0uKg6TPiIu5TgYGWfZQ
         xWHW6kq2yYHYKqyS5yZp8VliOrXzIORHlYzw6u1htOEbJu55JcDIJG05+EAt0qVWNHmL
         XAxJquiRB8jKRuFTtdnFRw8CTn1AvlCFuKPpzq8GvDML3ZvGd6KaQmv9up9NsE5CwLp1
         xTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360809; x=1762965609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=f/EnylpjclDFof7LewgMiGkc+rD9OTvQi16krhtE4Rtb2DV2P7HSKc3sZW4McaOGBO
         Vr59yIvkLm1eopJWCHjMLKetm8ECihUWRVKFIs9avExcSucVDxJShTQfDwC7U8Ui3i0o
         CY9MYpsYAAWNn51IHBIrmOGuXvmL169hfbGST1i3Sg4BWY/R3daN0OnoITEZl7jpvvFA
         Vgm+OxwxF1bnAFFgHtb7MJF4cjUy9mpWOjvPU8GIhhamfrt0CG1O7BSl2b/BWQgMmR2F
         wHYMZOvCxbxFor0SzBlkBcARONCxuzgCADFS3YH/x/v42DopeT5VY4bWPSE61XlzX1pY
         lNVg==
X-Forwarded-Encrypted: i=1; AJvYcCU2iG/65mV3QUkhSQy7+kJ175gp/rw5LHVUt2JxLK0NYPWhZLUUMpYeGsVwZBVJ5uIlvwPMsH8yKWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVdMqXW/AfhCzuMt9l77eZ7Z0FB5gND0Lr7TeRJpm6KS59deMZ
	aAp41VKVX8wjICra5JoP5OUOI55+oj6gsWT/kqz+GJIXNoupN1WQ25tuQ5KXzYfrQbA=
X-Gm-Gg: ASbGncvBkKpQChBe1dYSHICSKIKtnUjXm1FzP4fclVECm74HNCTSYbFfIWn1jO8KU2P
	KrIW7eSU5DuSmV+wtDnReEoTs/f03rxk1w33Rl1zmdyBIReLSBykbKbawf5xQNs14xKUogyOhWA
	z/t750AZy1OELXXqANqwErpIhpVTLT3dYPmoMFM5+R5KE72JFAwd2jXRoXVblKseqi1CCAFe3fd
	fQ3zcHwbZiaDkcPM86yEgcBV0LN0EfMDuXjGBOBRBeT7YKosmW7UkVptwwI2I0IxxdigeOgfNRi
	1IddSpXF3b27J4lpN/XHCceqwShjGwFxjN7ixx9DJ3BqoWEQ+Nn1iNeBU3L9XjSe4uD4BgtkdEL
	aS2ZGkybbmCAnhXtKt1hRs6WHwhiNJ+Z5TT9RkEMy/H2qoGx6LPtWESpSLjrEA1LRwFVvb11JJu
	FGq4bVNl4OOhdElV6WjSe5Bys7RWhevhg17g==
X-Google-Smtp-Source: AGHT+IE7wXx3urTFDNDSqobwKamWQF4BItgkmBjCAwdlchVnppz88UvExNlhgtNOLk7PtlOnGNVWQA==
X-Received: by 2002:a05:6402:40c7:b0:640:9997:a229 with SMTP id 4fb4d7f45d1cf-6411d16412emr55871a12.3.1762360808780;
        Wed, 05 Nov 2025 08:40:08 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a721f1sm5105380a12.32.2025.11.05.08.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:40:07 -0800 (PST)
Message-ID: <4ad47442-1c51-45b7-b709-3cca029e4fc7@linaro.org>
Date: Wed, 5 Nov 2025 17:40:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/28] mtd: spinand: macronix: Convert vendor specific
 operation to SPINAND_OP()
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-12-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-12-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


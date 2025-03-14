Return-Path: <linux-spi+bounces-7146-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C394A60EE3
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 11:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87143B3279
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD831F130E;
	Fri, 14 Mar 2025 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugRG7j+5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C19155C96
	for <linux-spi@vger.kernel.org>; Fri, 14 Mar 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948283; cv=none; b=rAwLR6WVqBeYb9+OGN763keCLQVNIbgV8GhtTePuoKCf3tWk62++cpi8JoFBPAo0Cqrpsfa6jhsbaPzaixnaLWhlAt9JjwtdUrRqfOKutPhgVHUxgXK79eqq3PsA1CRISRA8ry0ffgoXsFYMM0YUdje84TUKq1wb+WlvJkbLSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948283; c=relaxed/simple;
	bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GW3QRkoZDrEAFAEww0eEQZ+1nhgakPi0hUZ59yDUfHbx4dxmf9mDP1iz6wKbQSx8zRI0V4qMNYzBG/H0ycEtbP3qxe5ANwXfvJvhXSWkk3AhEbP1jIS3/e39tYophhnIX/LaHbMPui1U9Mv3LkfTTfhO3hSXGghkcWVeB58jg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ugRG7j+5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so18420355e9.0
        for <linux-spi@vger.kernel.org>; Fri, 14 Mar 2025 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741948280; x=1742553080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=ugRG7j+5b96XhyIQq7zctZzyUeJ8Gr9xm+/kCamNifzo9osp0FhFt+gmjk1snVCDSa
         UEdqPBWqZJMpGdyxnRoMPSzMpMdh/8Mn9YHzrfnBcXkiTJqQA5RM8uTDE4gMpnIyGGXS
         kkFT8NMSrGt8+jQi3AjKu63KUWcnNjd4xs8ffFDyplArHYAEUJyknMhjJs5TzljWJ0eV
         iAbnfD0s6YvVGmYfiBPdJLB5BXu1tC5ab0EjTbAeMiFJrO2fIUbsMtxk4m+ybjohNM+H
         oQwlMM7KOyBBjlvddDSz6nUWbMJI2uZHLfSsmrx5BNnGJk7U7NKl/FDft7/U5v7hceHK
         ai3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948280; x=1742553080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=R/XB8S/h3wFsia9zZOZbITaFQSONWmFBXpBEk3Qm7KygbQWdbD8q9b6wbYOyIanw9N
         PeFlxUmoHVhKjSCV2NPuG4DU9dFqL3NTdlcqsu4X4Ex2XAcSUknnlJwtFES4+H7iokrW
         WFZkRsq2AsssPDYAg10RS1tgyg4hKxRpugEd9eX73udgz41UZrQXZhwQNowlUCR0zVp/
         mOGJilxMTUiVfXkKa4zwHKl2XI5UVGvcUkHQ7AGDyLdyQsoR3Cf5iH482tc+RQp6vq8p
         AihZU7MW8C5NvWCeYUblILfuG8bTCGD+EtdEzSEKOtJbqTYCzeohgJVJNSRyaYjDOx/4
         GjCg==
X-Forwarded-Encrypted: i=1; AJvYcCW62qG0aUgIR+B64ixTM6lHTIMPfqHjTc3MFES8R3Z9+v2Q8s6aUR+NRdaa5wMm7L2hLmB+9iifq9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0QMG3ZN7RLnuZojLXfcZEqhxU72qgQLzBMv0R55jZiaO5R0Vh
	T4NfraudfonY+GzGochFWGCQgB9BAJ9UegI+6H5+1uv+2JIM34B+YS7EXPpu6Y4=
X-Gm-Gg: ASbGnctG2bzNlJZnRwFJ5M781vmAsDmmen55EUQmY65PkHp5Itp7ahwJ2I64ZM/D7sI
	yFG53gVY5d5Y5guF13BTcAhgNIDRDS9JySaIoYCw5dO9Bw3uIQs7GPxqdhTBvgzDExBNUAQ6E45
	5CNQJVXyM/Ogy7RCIZdVeYNZvBfJMZ9lPUuRhIKXUVo9fTprVzul51qbwuQioqsnqm+kvfNKxMZ
	DN4pzse1ahpAStn6Vd9RzXI2Ly3CSK1jPdzqXucU/zuyQ6wlS0ozN7peQ3oaY0mnzQ+RbyH5qmS
	cb3d3c98cFgTMHVfTrJZmSFNp8+6SM0D8kpvGLpn6y4wogWwSTsbcQ==
X-Google-Smtp-Source: AGHT+IHLxgSnBZcseOLOPQyS2epU0s8c7uzffYTWTiPGztxQVaBwu3fBYij2zWFBMDtyUoWPqCYOHA==
X-Received: by 2002:a05:6000:1f82:b0:391:11b:c7e9 with SMTP id ffacd0b85a97d-3971ee43e56mr1935297f8f.28.1741948280252;
        Fri, 14 Mar 2025 03:31:20 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb9ccsm5169603f8f.96.2025.03.14.03.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 03:31:19 -0700 (PDT)
Message-ID: <73d9a5ab-0fd0-4a8a-80f0-b43c4bf45e4a@linaro.org>
Date: Fri, 14 Mar 2025 10:31:16 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: sg2044-nor: fix signedness bug in
 sg2044_spifmc_write()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Longbin Li <looong.bin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <4e16e1bf-e5fb-4771-bc92-c5cba9aac473@stanley.mountain>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <4e16e1bf-e5fb-4771-bc92-c5cba9aac473@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


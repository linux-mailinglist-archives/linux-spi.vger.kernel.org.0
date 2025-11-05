Return-Path: <linux-spi+bounces-11052-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98210C36AB5
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F7EB4F5432
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8119D33FE04;
	Wed,  5 Nov 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+7WSOQD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115733F8DD
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358895; cv=none; b=WUJaLoyz9uU4/m3MdoOecUkGu2O2oDrtB8COrhV5z9wuybTxQMzopc4ue+aYmVGdtzMNoAFlGCqNZBm2yyCoW7hX56rCWvRIAfzYoX4T9L8XuM5TBoDo01Tnvp/6n4aaBVhiyP/vDBf+xCNbic8qelElh+2P4JVvDTMwwbZkRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358895; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWchkrAiQYDxx0f76ySGEjjmavh4QXHQn67BcYtQow2BbCT8cmjC1evt9xLl/Rb5/0waIA65JYQAQuw8z+tAKxsg5ehEagCRmmBO3hHDWovB6/ZiD9/5mvB8x3149QDGuO4B+OFcdXpPuegq1YpH9F0Jg917+Lr9vKE6gAtV5cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I+7WSOQD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so852818766b.2
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 08:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762358892; x=1762963692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=I+7WSOQDJ8lWXRHjECJ4kq8DJewHq05zptgpC+C6y0x19ljiu5juPr5UnW7HNwTQyv
         3O+UI/YZXL7qWftr51yFL+vDd/sfagIrpm6O4sDtAsHS5u2AyuaQCD/Qw439jqg71WFd
         iCV2rN9iceDVdLA84rLpEiMaTpCUiZelAc9YoJdhiL5TRy9HKUr4RhY6CUZGgghpg4hv
         XCgHUE/6eS9A017AG4EjAyGF+R/nzAENB8BrlxfKR5+RvptoucFz5WCM2CgkUPx7Slsx
         zehWZdfEfSTWdNzWhpm8ceZncP3kVUGkTWSPw0K4lD/aiI+TDILhntgZmL/mz/YSRG4Y
         YlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358892; x=1762963692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=D9WiBUw5rFIDX84r+eAYjuYMnRuox1A9oNmN8C5leoN0jOkUPQ/51+IWlDOhUjHxwQ
         VmH8hylE4d2UYZuadyCCD31W+IitSqBx1fFWdyjOpXs8jCKIigJeUFLPS5rXXv7x2qGu
         uSzZMMWiQH45ixhBdbyGyiNmYbWzYzAzbGmT1+haeF41sLLszk02HdqDlBYwSi4o/c1A
         P9nHPGnEvVw4iUiAotGFtmmNTeMksvEM2tSE8JICSNlpGVl6dfR6ULVzXzqsdVu1mMh+
         6mKMvZNt+jNGjXrwkU+j3oiSMnf+4NYI6IcCYRC/SmQZ6+qUZFwRnmO3g6i2mbDr1T+0
         pXFg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2liVJSXsVu25Vy6P0KcgGOA43EJxIl6b85HipCWBb/GYvv25i/JcT6VdHF6geZ5Fix8mnHorv1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYzam/3RSN0hALnBI3bz1IeXwTq2HqFVJWbC6zcrMDI7pK7OQN
	/6D77rMzKHR3ge4Yw3pVG+l/pS4AocvW992Hx57xXG0FHiVyFpJ13NBKcRwnQENXrM0=
X-Gm-Gg: ASbGncu8Wx/InvLtpbtWnduj5auKOnNlu9AVzivS89+Dkqia8leErucFYEWqx1RP+BS
	cduAv2aAuKm4lCLktG3P3aY4EkMjoPFN+2DOFUf069sL3sI8cORRUGqAz/Jcrp22NaYZhOKhEL4
	wW9Gh0EOD6q78jXzALZptn2uBhJFUUVm77Ia6DtA9GYBXluVUADitG7losPHIANCj2KcmP5SagO
	FY31wq9cTZqv5pUHcHhWrxKh85uRkieiRun8TLodDEQGXvrdoC2iWmBhT6ciGyS+3+Kwuuz51G+
	3gHIjGp2fjrWayWbhOTzZTM6i3IH565QC+D2SkOv2ZB3wkANUL44xZ/gNqXo8E8pq73fO1iNe8r
	F5uU4OfLhsCH+5wHidG8jzrp5fhWes03AvcBJHRmlwSXDlBVk+QS6vp6RWBKCjGsbKNiDzaoQhp
	7eAta+QtJXOc6m1wXpwXMpRug=
X-Google-Smtp-Source: AGHT+IHe66dGPDCnJF7sA+RdxQD5iEthJ64gnOWmVuY/8/hMYmiDCG3IMe4DFjg+VhIBkBwfSorlzw==
X-Received: by 2002:a17:907:7f14:b0:b6d:67b0:ca0b with SMTP id a640c23a62f3a-b72655a6bf7mr368361366b.61.1762358891995;
        Wed, 05 Nov 2025 08:08:11 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d91990asm516374066b.28.2025.11.05.08.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:08:11 -0800 (PST)
Message-ID: <ae156508-c73a-49ba-b366-a35185a7ce5b@linaro.org>
Date: Wed, 5 Nov 2025 17:08:10 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/28] mtd: spinand: Decouple write enable and write
 disable operations
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-8-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-8-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>



Return-Path: <linux-spi+bounces-2569-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EACE8B51A7
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 08:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8749E1F21429
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 06:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31C410A09;
	Mon, 29 Apr 2024 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="adz/K/ki"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288AE1118A
	for <linux-spi@vger.kernel.org>; Mon, 29 Apr 2024 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714373002; cv=none; b=q+JFhzeqgC0xN8pnZmIna0szZm3Ltc26nvGBT8/FRR0KjBZ7/IjJuppwIHSzUXlT3z8vq4fltbeGuZD2OzBbEPZ0AnaveXUZwTeZVlfkijpmpXt54730uPj0AT1lQS0VtjQFS1xpnCd/mR4CyzOHTgbDUfvlve78b0kESlX8YgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714373002; c=relaxed/simple;
	bh=H0FSF0iZXCEONAQyvExDRe0e+a1q/lay5cdTnSMgfEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXutNK3wnLAJVIKLkfSLOKgNPnjpTxIuUcHuavywkU12cLAWalHTJSGz3HR8EccL0Xu5aA0UNv0ynqF+dsHOkZspexgZtaAqfO1Ger1ODCxG88xFdNFeBKUEEZO4L5g5vwfUqTZWeHbheFRKaVjyrwn6dzLsNXVVwCPOdmdY0p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=adz/K/ki; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e0b2ddc54fso413791fa.0
        for <linux-spi@vger.kernel.org>; Sun, 28 Apr 2024 23:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714372999; x=1714977799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DT5Libw2mqJPOafL2HpG/y/Ut6VhpcNYjyZvzbmzrlQ=;
        b=adz/K/kit0KAIr3B2YRCGMhJ9/ybCMUfIV+yQ3ZmFkxEsgdpbd8uta7DMkOLNTry2H
         30xXmhEKU12M0ccTCvdOTQNtqX7SZCSKYZ3WBC8j2MeNXsOUP+DXeLEY5XSJtPbDQfYk
         hXi7oqcKzcKTbM543fmk2PTKn3l2TqqMK3OM0T5q8swV4QnkmfBNeYIDlRSEJTHk3C+R
         npwRl4LLIFqDjxFWHA2duodd9plw7qcQVH8bQoBkLMvwIPmtHEPgHPgAVC1iZfygtnbd
         +jqx9n+txbAAOybNooWx6Eqdx5UmgIqaSFsm62NxAzVC7CqSOB2lSbtCPe7Jh2zOw5N3
         TVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714372999; x=1714977799;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DT5Libw2mqJPOafL2HpG/y/Ut6VhpcNYjyZvzbmzrlQ=;
        b=ikoTvXCK/1/LorKhn3Xtb0gAfLqGkS8t+9S0rUL5cpJ5rtSfBqD0siLMYTyIioFpHy
         tGcDhXEoG+1NcZezKiR4ofDmJgHc/lNT5vQ+W2vcBBwGPsPpl+HhHL5IwSTkOXlbz9Rw
         mnm4niDLR6SCt7o1NtvPd2WIDAk/v2Z45b7KcyKQ4xzMyOQ6KiPLQKeMxgHk7e0yftt6
         rVgxcPEytiYABLfZdjf35wBhic2LdNy18m4g9zDL8gTVTO13SZStzcNJCrIMHoCJv8VS
         kFkVYhuXWWcD0pGGqKrw4E++Lu4PQg2g1QVIcoOFZRPnXRVcIvLQaJ5BQ5ggyskcTkiq
         GUJg==
X-Forwarded-Encrypted: i=1; AJvYcCVcTQOFihdYL6Kfd6c/bk+ORYT0IFgbH8PMzensq7bIXFEpm/NWpYl7AxgHvrnikgQi2L08CYdTnspFYdThKnTvdNLGIgX2/Dev
X-Gm-Message-State: AOJu0YxR4yqns3exCrJylsf+9YoS3b+yUR54vU9bO1GlDdK0dJkga7uy
	dKqypKBcwM3yBuIdzdsCHz42w1HtaaDWeJ0RXdB9Nc5hlrw+OPjBKsYke3wXzuY=
X-Google-Smtp-Source: AGHT+IF4YyaejGQ2/OwfLYvMmj2HkKn6Nc7+yp2bTKR2Cm3DeLxyZEUqX72ATe8YF9h4jT2DjNUWig==
X-Received: by 2002:ac2:5f99:0:b0:519:5df9:d945 with SMTP id r25-20020ac25f99000000b005195df9d945mr6168347lfe.4.1714372999209;
        Sun, 28 Apr 2024 23:43:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d18-20020a1709064c5200b00a58aff25d77sm4823617ejw.193.2024.04.28.23.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 23:43:18 -0700 (PDT)
Message-ID: <1bc01cc9-313d-4433-9995-49a5738adeca@linaro.org>
Date: Mon, 29 Apr 2024 08:43:17 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: mtd: add sophgo spi-nor-controller
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, unicorn_wang@outlook.com, inochiama@outlook.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 dlan@gentoo.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240427075426.662671-1-qiujingbao.dlmu@gmail.com>
 <20240427075426.662671-2-qiujingbao.dlmu@gmail.com>
 <40eee0ca-fb15-40c7-80be-a1198f37663d@linaro.org>
 <CAJRtX8RztQfeoBhGjdAZZBW5h9PQT_pYhyKCRsbXwx83SbCExA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAJRtX8RztQfeoBhGjdAZZBW5h9PQT_pYhyKCRsbXwx83SbCExA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2024 08:41, Jingbao Qiu wrote:
> 
>>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>
>> No clocks? No interrupts? This looks incomplete.
> 
> If necessary, I will add clocks and interrupts.

Does your hardware has them? Binding should be complete, so fully
describe your hardware.

Best regards,
Krzysztof



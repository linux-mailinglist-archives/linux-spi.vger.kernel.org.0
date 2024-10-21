Return-Path: <linux-spi+bounces-5283-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ABD9A6BF0
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 16:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70C31F21728
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64841F8921;
	Mon, 21 Oct 2024 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OV4va0C5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B2881E
	for <linux-spi@vger.kernel.org>; Mon, 21 Oct 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520416; cv=none; b=QWvWnFC7LiAoGi1F2hHQS6gADP5PjCTfpZZX327SveHtdCHf4M4lmkze9hroEfLvqND7WQik6rWMGG81+vtbCi6caKNy4co9sOgJ/xRJRb01hUzSyZwsOr++T1Bxf31w20kpJ0AMAUBS/3hOS1+cRj8EdfNs5R5lv8mdDeQsu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520416; c=relaxed/simple;
	bh=A+YMALRUUtUo6qeutNBaZZwmbsqWTDSANoCqqNXzqQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFcL4gbJi+PJiNQc3akV+T/rFEg4/pugg0B0EeSlkrRAAdWBv4IemNONjMUDC8FpTzStQijotSgMvWv/F9OylsX3DmuBPnDaD8jGNdAvlUuCtG9vfrPPeP4rajQCZjrQqGloakbaukHwk90RbPtRBLHOJNtFcE10owl2wQAcH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OV4va0C5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314c452180so37206625e9.0
        for <linux-spi@vger.kernel.org>; Mon, 21 Oct 2024 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729520413; x=1730125213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+YMALRUUtUo6qeutNBaZZwmbsqWTDSANoCqqNXzqQU=;
        b=OV4va0C5pj8fSuqFWvcoGHNAsLBqmV1Qp0HDySeXjEjb776VH5fAonsuOJM2/j/23f
         N5l8Pbev3g3bDqTFr7r4ds8aJ9dzYZWsC5/+rKIESz0j8V3kneAIgghkklwzKEJ4LoKp
         2pkQlYvZH8P7lL9IFtXHm2OzmIB/qLB76ZI/OaBw6cL01LAcYsBzQ+L5vT07MsvTHT5h
         nHUnqSCK+hBF+Vz5AbKSi2HAAQEplAKqIish4VnC86faWnjt18fxU3jgXIZNuyhvzDs8
         ib6IVgA5DNAAEbolDkUGMV2gAIbD/60v2gHkU8aJz8UMZOYY24byozXXhVcGm4cRDCHa
         TL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729520413; x=1730125213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+YMALRUUtUo6qeutNBaZZwmbsqWTDSANoCqqNXzqQU=;
        b=SpmNoob717AJXCf6CLaBI0YG7+e6FIC39b3CQHLzFIQZ4A3jjhIxhmuKvwxjcC+Gbb
         xn4S6PU+72alDRrb20tZfKK83QX7tLC1A1hgOuXiD6bC1Rar/FwSYaBUw+6yGtX/TIdS
         CFtlrr5j4mgpnOvlHDQ4kfdAdH90xR9EXO9QxkqwGReIEeVrATW9xiRUOKbr+c9q+TPa
         1MOAykaUGVUCfJlyO6gNQE8feHloyehdqJ984oTi+QLkrght8oVBajjHMv6zZwMjGJQS
         WFoSUhNrM3X02/dEsgth3Kqs/4LGs/bGlXsiYxuf89PJA74RnZoECYhEnzJoSIHmgu6z
         4iHA==
X-Forwarded-Encrypted: i=1; AJvYcCX22/MZjM538oFyEvBGCV26Le0Nm/zrG8+FkiD9L2gi8uvEznz6nc+hZML8O2plS5nu2OQj+KEzNIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGpnaTUFLq8xOakqlIg+1cAORgPfmdoJ7LbnyQhq+X5Nx7cdZ
	rn2wMGNTs8ZvQ8QmnbcSNWBz+x0ctQ53C1goTu2HB9Ii1/Yq0vCe4OpHJojqcr8=
X-Google-Smtp-Source: AGHT+IF7W2XyOnxUqLb1FWpGOAxV/gojJBDVjqvpo1hiwSxRpKSQ1PYxo61kzClxUXyJQzB+jcFBJQ==
X-Received: by 2002:adf:b609:0:b0:37c:ca20:52a with SMTP id ffacd0b85a97d-37ecef82581mr8228800f8f.8.1729520413077;
        Mon, 21 Oct 2024 07:20:13 -0700 (PDT)
Received: from [192.168.0.157] ([82.76.204.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b8b9sm4439402f8f.92.2024.10.21.07.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:20:12 -0700 (PDT)
Message-ID: <ece81819-3a00-4eef-b241-1adc82629ed4@linaro.org>
Date: Mon, 21 Oct 2024 15:20:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: atmel-quadspi: Add support for sama7g5 QSPI
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 broonie@kernel.org
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 ludovic.desroches@microchip.com, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Varshini Rajendran <varshini.rajendran@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20211214133404.121739-1-tudor.ambarus@microchip.com>
 <eae501a6-d210-4576-afa0-010f9cc8c5fd@prolan.hu>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <eae501a6-d210-4576-afa0-010f9cc8c5fd@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 10/21/24 1:19 PM, Csókás Bence wrote:
> This patch doesn't seem to have been merged. Is it no longer needed? Has
> Claudiu's comment been addressed? Likely not, as the vendor kernel
> (linux4microchip) still contains the un-amended commit.

Of course it's needed. I haven't sent a v2 at the time. Someone needs to
take over and submit a v2 if it cares.

Cheers,
ta


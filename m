Return-Path: <linux-spi+bounces-10152-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92589B86C68
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 21:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6392616B0A5
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 19:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821042EC54A;
	Thu, 18 Sep 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uhTVDOEL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09252EC0BF
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225088; cv=none; b=JCMmtwK0Vz6nqqyh37ZGyzfkt2XjiAtOvxluPN/Mtmm3+wrC4golk8ah3n4fD5vx/JDgwt/sfpOaKMgRG1f0RQYgcYK64gVNHH6tDyV5dxxRxEAa1Vo8TXHsmDEgRChw/qT1s+YdwyKq2bcGwb+RfG6n0pW0Y31XyhCTIZYDQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225088; c=relaxed/simple;
	bh=+vCpNQP3gmwChNJcUCWInLDRRa5HHP5yLhQ1psOMqTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMNDOr6aXOpabqgVnZrDaeMRUW9uBK2A4czRazdttrsnZ0M905hPxYPWru83c6tRgbV+LUFbqY/nVtrwYn0gd15MAxkRi2Cz5GLnH/VbkBXaw/Pi4a8PGEHwgwYMcb6tzRJZwkS5h67MOsfj6ipRa+8DO7A8hju8iAn1DyBaDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uhTVDOEL; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-621b4d2b2f3so1080726eaf.0
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758225086; x=1758829886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ycb6BrVm3o3tgecg3NZ2b8GKaDVhR9xxtrfWCgsW3GI=;
        b=uhTVDOEL13vWSEZ+PHy9Gpzci9lgihjB94UiPff8m4ZgUOMFrr5L0r7eMZae+JHgHm
         Owmm7nu1rKxAgMtXT101hm6pTxVpL64qQObvWJ99wzS4ysBmGGu2ke+o4aeGLmDtWL0w
         6EoPS660WndQ4blKQujTf/FNMPzqsAk9sg+ZLKWUx0lDp3YinE1ajinBxjC4hCgY+dW5
         V6IqF7Ncryaafpgc6WTcdHN0PLvzp98GYFOW7TeQW3jORpjR1K3baX5NNbMULS1y56Ac
         fPMEm52zXPcIb5saHVoZbTll7zFao4S0n7n+T6jgjEacSeQqUe7Z/k14iE/sOgv8D2lv
         sRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225086; x=1758829886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ycb6BrVm3o3tgecg3NZ2b8GKaDVhR9xxtrfWCgsW3GI=;
        b=Geok1q2eHr00XwhAzprKS/nU16xwMRykKYfxarche36Yi85BQqlN7CPvv3EHI6Dswm
         UpP5bWpUZl75oyf3g/zfjo1KIDdkeqknMl1FBdHgiWEXeHfkPm4hTMHPDRX9TcCEKET/
         dEuYzQnJ2t8Uzl3yAi7aKr6cfX+Vd/1H86W1+LKSJOwfDc/BZi0l0yPQjLg6uHuW2d20
         2b3e2+LxjmUW+35kqFULOr4pkHoLr0lYp8SvLR2zT6JKaf8OPIZD+rXIfANsAH7RmBlF
         wlxYM27xx3FokCOvX1pYX/AveIfldhPE1uRghdNqVg8006C2/LnunTSCwC2fSXKP1B5A
         p38w==
X-Forwarded-Encrypted: i=1; AJvYcCUZZuFPxsco19pJhqHCYmCyPtj+F5QB6dbbZhSI/mopGXqdA66gmI0AH1v8JZ6ewPTwatIWJnJqzoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPqdgdzpsJ17L3hj4Ja3u1o+icS8bqx0gh4He6IDyip6jUYul
	ZKFzNWvgiZxWeWCVCtU6Iyv/kbokJ2sKnEART10FtKY9G+CTqeCz25pdhi13iuBBqTs=
X-Gm-Gg: ASbGncvPCUQH4GALMhbHf0LIExjhsAg9FudpNRLHAIIAwzSM6JuIannSYzRYaweZdOH
	oSaUvOI0qVUejzzjgXHFelP6qeu3cfQiRTkb2J19Z69jFPhkL9IeOEL7411Gdh0lNMstPvP+Nm9
	cEkwcUyWupsuSVipVMfdxhjV5nb0ar0zsXhLrCMKRotoWkjSDhC6i+sTxpnb8JnaAzHhS+hAL9b
	aVDst+x/bijhd0cXjz/xIV+tzKFzgK0wttlEkAa3mDnFhwedaBrgtud/mZtzqAOtkrFregzqJT5
	SVgAynxXkrS1Ky/gGWNRyYroc+svTbXXJS1MFFJ6jNMXBCNFc+dvNsEOBXY5rOfE5kLCPt9Knad
	eGO/k1WRunhcYZT1fHtwrKTKAnDny/pEhD2Rcy+pc5xQTo7khF9edXgD2b4ZRIcd+Oh78hBhJQg
	9ef8G0bo7iQRbssgVTz9wlCNYTRwoQ
X-Google-Smtp-Source: AGHT+IH4gnu5ZviVz4ulNiX2L97wXpeu2HQYjfDnnt0qWqu/Pap+ivM2yq37UDqW5VBY04FXNOqo9w==
X-Received: by 2002:a05:6870:8088:b0:315:60a6:c28f with SMTP id 586e51a60fabf-33bb3aa16afmr568561fac.3.1758225085748;
        Thu, 18 Sep 2025 12:51:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e3af73f5sm1892886fac.6.2025.09.18.12.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:51:25 -0700 (PDT)
Message-ID: <46575acd-9e7b-4462-989b-d74de4d86311@baylibre.com>
Date: Thu, 18 Sep 2025 14:51:24 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] dt-bindings: iio: adc: adi,ad4030: Add PWM
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <7a1a68a33769c69967bcffbbf7a0bdfec69516ed.1758214628.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7a1a68a33769c69967bcffbbf7a0bdfec69516ed.1758214628.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:38 PM, Marcelo Schmitt wrote:
> In setups designed for high speed data rate capture, a PWM is used to
> generate the CNV signal that issues data captures from the ADC. Document
> the use of a PWM for AD4030 and similar devices.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>



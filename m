Return-Path: <linux-spi+bounces-5545-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D54D9B611A
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 12:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1261F21E64
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6A81E284D;
	Wed, 30 Oct 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFt6riOe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51B01E3DD7
	for <linux-spi@vger.kernel.org>; Wed, 30 Oct 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286571; cv=none; b=At5oqFIKRwSYyV+K38/IHPeComeXrMmpc9Yo+Ds12drkxKSQyQLd3BmTyTPlzp6Xf5c1gY9fYwjXFeNhr10v/sZFlwew2ooc5fc18JXYTMt4lhzZXLCrKzNpaIkTTACEmPSThSXeQYr+48gByA/fsclTWp+i87Sm0DJIM/kGaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286571; c=relaxed/simple;
	bh=mQaUzwaxnnqV45/x8tEAI39WnNj925wRWeOEbSeY/uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BG74QH+4Kc5pcc4c2XzIX8et83T1qTQGQfu521BQtcCtRiRZcpjjGyYhbVZ9L8TWqYeUVz1h0FXA81lQPq287lFONCsmsKzN4IOyHgk6KgrJQWxyX7sgEIXCVGznLCFIRUIb3zqCj+RiL+La7tMJvHc/1y03CgopzNxvGXe+DsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kFt6riOe; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e59dadebso7678687e87.0
        for <linux-spi@vger.kernel.org>; Wed, 30 Oct 2024 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730286568; x=1730891368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQaUzwaxnnqV45/x8tEAI39WnNj925wRWeOEbSeY/uI=;
        b=kFt6riOeslgr9ibbQBWoLzlp+k9h2TAaHmfwjEbqd7uQkrp2UPvOrWbZA+PNOqmsYf
         WyGQsJ1zh8xfgBntHkr9xUujqEFQ584rgvqViPHgZTwYx428K4cVSFSj5Xcmq0/lopgp
         i4E8c6iX939GWxXBJ2YkdRRrU74/DTQ54ikp3BAQRMh4zsdLZcp7wD6WBpvVQisLPEHO
         6MiobcaF0aYkXesNsWnUsyOCXPBOWiO6Nv7elYBSmbGjFYgNCcUuf5C1qQneCR3QkfsF
         xtwfLlVznGE/DWDHu6sKcXmXH/M5CubWSgUPhSj3x8CyC6AH0Ki/z3yWRJB4uHuuKn/q
         nFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730286568; x=1730891368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQaUzwaxnnqV45/x8tEAI39WnNj925wRWeOEbSeY/uI=;
        b=I0z6+eSbh7QW6+lkIbWwIeUK7+cbGHqzdigOFLDubO0/KhWebxmrzhPRQ4YjzEL6Gg
         E+AV7rFDCR0RMsLZ6OwhWvsXZEB2wQsPYk8NLKuhb6v0Wv+PMeLzCVqddCd/+ICXPoW+
         RuP2QXKuC6Q9SkP/UR0pGR/wJ1TwyGrwGklXPsDYtcF2pSCaQOIBcwsoUMO7BKWL0HIw
         QWGtb2EcItUlWRXnIH3quvzPOywGpUZyyUJ5R3QHaZjyrRHbyMUdWPe1YppfY6oQ9CRf
         UEeZ087uoqQ8sP8yTvxC/uXhFeIsBQETLi+HtG3jId6hMvvYPBn+LG2JVh+Emud8IsA5
         voRg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ5a1/X/vA7t6uv3AdQpJrpH6YQ/S5MBKxj6oIzO4tSvNq+74qJyfLqx+zzhRtqd64IjChyhygR5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuscfcYQ6Mk6jXNbgBXMehn/wLMZXmapQJMlcNe8tqTqGwV8OZ
	TRNbu/enR6Vfyi4bEjtOLMfGc8kfTAJ3ESwYfZtiW7WlatDTfKPjQZQzioK5a++297F1aOecAlO
	xSSU=
X-Google-Smtp-Source: AGHT+IFQvNMe1Knd6pNleviaqJovBHa2NbBVLssU/HpGHKZatxe8p94FQpXjkdGNR+UdreZfcJSkiQ==
X-Received: by 2002:a05:6512:6801:b0:53c:7652:6c9e with SMTP id 2adb3069b0e04-53c76526f55mr415631e87.53.1730286567743;
        Wed, 30 Oct 2024 04:09:27 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca704sm18186125e9.41.2024.10.30.04.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 04:09:27 -0700 (PDT)
Message-ID: <7cc95e52-7509-44eb-8e30-d518283e7d87@linaro.org>
Date: Wed, 30 Oct 2024 11:09:25 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: atmel-quadspi: Create `atmel_qspi_ops` to support
 newer SoC families
To: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Varshini Rajendran <varshini.rajendran@microchip.com>,
 Mark Brown <broonie@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20241030084445.2438750-1-csokas.bence@prolan.hu>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241030084445.2438750-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/30/24 8:44 AM, Csókás, Bence wrote:
> Refactor the code to introduce an ops struct, to prepare for merging
> support for later SoCs, such as SAMA7G5. This code was based on the
> vendor's kernel (linux4microchip). Cc'ing original contributors.

I think it's fine to split sama7g5 addition in smaller steps. But please
add the sama7g5 support in the same patch set, otherwise this patch
doesn't make sense on its own.

Also, if you think you significantly changed the code of authors, I
think it's fine to overwrite the authorship. Otherwise, try to keep the
authorship and specify your contributions above your S-o-b tag.

Cheers,
ta


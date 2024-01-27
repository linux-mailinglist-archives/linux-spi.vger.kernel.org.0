Return-Path: <linux-spi+bounces-888-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DB783EA8F
	for <lists+linux-spi@lfdr.de>; Sat, 27 Jan 2024 04:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89171C22D90
	for <lists+linux-spi@lfdr.de>; Sat, 27 Jan 2024 03:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72B18F40;
	Sat, 27 Jan 2024 03:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnLpS/g3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CFA125A3
	for <linux-spi@vger.kernel.org>; Sat, 27 Jan 2024 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706325798; cv=none; b=F5anUN68Dc8GMBXcq4gx5YRpCYUFyNHMLKG8gHwSKM7/7NcTIZM53+qNnLbOUSqXj4fDCVPh+alL8l3iF5lzsikiLCmp+IrOe7ZFFonbx5/nFuEFKW6Qn+mAUPnugR6vu1ParKK98xpg4vt6RgdabjivRJ/9fGy5h57Dys68KpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706325798; c=relaxed/simple;
	bh=Kb0XMqSBUcpz6qCJguisWNEL00WzSXbRz6iVTAk3Z4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozE0Ad0y2S1Jnz9In3Nl4vphEPNWYaysBhsL+ynoq5cHRhLkjW25s5hEoxYjoSJFJTggEkE6c7Aqj+1WCnhUZQ8P18r00qp9+/CNkska5Ix0Tdvs7puLdCmNEV/i6DKORErZqXGIjT+jRiuP71/wyoKgaJMhy/muG6yxWNtdamI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HnLpS/g3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a27733ae1dfso64159066b.3
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 19:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706325795; x=1706930595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pt47LbLd5z/icSoUqr3eyo65hOYLLZvgWj5xScb81fE=;
        b=HnLpS/g3rqqcra9NKVs88Ns/LOIEvDRWwJX0yfnE8tm9GzTy3nUccS9BML6SYQOKm7
         55jS4QD/iRTjvY1M9sDw7Ub1SQ1zA9XmFvwjnvcpsn15preeo8klIDUB+yVNaYy6UEE7
         ysdf9BEqB1r29iTq3rEoGbGu0BbDeDPk8mdvVN37dVLmS/17LkDknmZd03z6HCejTdPh
         z+L7QGulm20Tne79EyRJM+pldxWnTT6o+s0pF31CMzRmpxV+haxkzrgs+JfC2038+cge
         Gt2Dg8DekJyRHmlESt28wC7/tN5UEO/X335Vjk4qpkQbAHPZ3iFxHyP2OM8mH5ndoyVG
         yfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706325795; x=1706930595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt47LbLd5z/icSoUqr3eyo65hOYLLZvgWj5xScb81fE=;
        b=cJKc358Bt5eMBCG3Vm0maJpiGiAB1kmVh8z9aacNBhiHeGB2x1W7ycOYm4yi1Xu6yB
         IF5zoEoP8HeooTUJeDqPCIw/gUYURoSRR+f2u8hR0no2TJ+o5u/L7n67cb3JpjW5dIH9
         POM97l1fo49Ey3NbsTA9G6x7+pbxbn0uN6Ka0974SSXuBrvRRD+fnsJzVvbmV/Yb9Esv
         tSeX4R1nCuXmc0SCMwShvAvkSOxgBJtqJPqDZqQXxakoUfSvehgEaDNznxZwl8FLZmVm
         psQIDqQBB8zBrXRO0S5/1wCAc88hZKzXSnXgKt08xQvDFcPFgYnb17lTKaUK4bHX6Gty
         G+Eg==
X-Gm-Message-State: AOJu0Yy03Z4NXmtWpn5FLqy8wHTGa3Vs2+oXhIjN6OadNMpSAPDp77uI
	s0H04Rzi1o8cFVRVqvmyiHXaN+U2CowKTxI/Wunp4K2n/WX/XE+urXwB0VK30ok=
X-Google-Smtp-Source: AGHT+IGIL5nJBcg2ZAg068RZ/riuZeOED27pzyh23D0SIlAzm4sXluQ3G9MAwIwKWvP1vJpMBl267w==
X-Received: by 2002:a17:906:6716:b0:a2e:998b:775 with SMTP id a22-20020a170906671600b00a2e998b0775mr338522ejp.5.1706325795076;
        Fri, 26 Jan 2024 19:23:15 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id sf5-20020a1709078a8500b00a3543718f5bsm111358ejc.221.2024.01.26.19.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 19:23:14 -0800 (PST)
Message-ID: <b5ecacaa-8ccc-4588-b3be-4b5f85813909@linaro.org>
Date: Sat, 27 Jan 2024 03:23:12 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] spi: s3c64xx: use bitfield access macros
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 jassi.brar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
 <20240126171546.1233172-18-tudor.ambarus@linaro.org>
 <CAPLW+4nL6D7R88Q_kJjAT-bWTFBk8a=FT0vL+fyRgxaDeSyhNw@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4nL6D7R88Q_kJjAT-bWTFBk8a=FT0vL+fyRgxaDeSyhNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Sam,

Thanks for the review feedback!

On 1/26/24 20:12, Sam Protsenko wrote:
>> -               val |= S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD;
>> -               val |= S3C64XX_SPI_MODE_CH_TSZ_HALFWORD;
>> +               val |= FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
>> +                                 S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD) |
>> +                      FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
>> +                                 S3C64XX_SPI_MODE_CH_TSZ_HALFWORD);
> Two people complained it makes the code harder to read. Yet it's not
> addressed in v3. Please see my comments for your previous submission
> explaining what can be done, and also Andi's comment on that matter.

I kept these intentionally. Please read my reply on that matter or the
cover letter to this patch set.

> Also I think new patch series are being submitted a bit too fast,
> people might not have enough time to provide the review.

This patch set contains patches that are already reviewed or too simple
to being lagged.

Cheers,
ta


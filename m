Return-Path: <linux-spi+bounces-8361-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C716ACC2C1
	for <lists+linux-spi@lfdr.de>; Tue,  3 Jun 2025 11:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60543A5349
	for <lists+linux-spi@lfdr.de>; Tue,  3 Jun 2025 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED2F2C859;
	Tue,  3 Jun 2025 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGbqmQiC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0632C327E;
	Tue,  3 Jun 2025 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942215; cv=none; b=V59MC8LeEebvsaz53rjJDTsbIAZLLHsKiOfP6V6HYhwKCbP8yXq1uIVCd1mJsVebsoedRJveN6LWRPLgUph3j+/gdSwogsd9DTIA7KDOn8KwvfqyMM4PjLVGZJ3NkMbUgFeA8Kk6r7IFsRMO6jSnP4H/3X+pucx20X/8gmUdK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942215; c=relaxed/simple;
	bh=+1/2I1Os9ZNKwrX5iOOSp0mo0Ii54pjkD7fTn+LRgwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEyJyzWHZBh8DA8+pzxhs2K4QLNlT3CiRkpdUjF378ixpuGsQrwsvhFEMIbqz+a8IQwx4K3b2F7RulfoXwROfNPCJoqtOwnQVEWwmYmmG8UGGa+E9q9CI1OyY3FrIyfi6/O7fvB/oBnQaR6yEzFd9kDjpd0k+UsYO98piJa4Qfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGbqmQiC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a5058d46ceso1285591f8f.0;
        Tue, 03 Jun 2025 02:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748942211; x=1749547011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jh1UYwF4o07fYlh6QkTVYQ9s6WEqHiVdVyiHbQC+v0=;
        b=mGbqmQiCCGD8ZsdCQvI5Ue+485AT2IpgPq2PrFXC1tEuSG6iNGMxgmzlTcD2QD0c+F
         Tck28EB16hK0Sviah1Dwegtv0jqI9MVAp02+FUZVo2K9iiTjp37X+fxvVrS9WorDfAx7
         9t0Ko41L7Z4KNseLgHJbRoxeI/b1mcgsRnGFR+J0AWQjQwAkmOeAOzrXauFKu7guknAU
         +fK3liXdt9ANyrFQfT9cbXjlFCN/i2SlzVHaQl9CLFJ4OPZOFK3bWlXqPtUuUJ76cp/8
         Mac3B2F1KIHAYhYt5zJAyEUFdPIZvOxMpv73ft63zKiRwTNkriOD+otaOID1YqRiTsPK
         1DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942211; x=1749547011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jh1UYwF4o07fYlh6QkTVYQ9s6WEqHiVdVyiHbQC+v0=;
        b=FtbzF/RIlG+rWN5UYO+6Z7Bg54OUNE/0pVLHCW7t53Ewr1LrHo5TdbgoKvqlSMIGZl
         g+wFyAn0YscWspssI+n+lZaf0IA7gPbgIcXaqN4LZUPsUJZgQCEVGkiwsnTUyLGYDSmN
         ImeWF9ucxXH4tWqODDJHkFhTaJANVXpsLcjFZ2QsNEd1EYjF8MaUUep/E4UNJ9EErqO6
         StqmtP4ypoUvPApAMMfIeP/J1hgN8Wm2OEIGMAkNCiXe2lAvX/ap8AHvVPkRJfusSLFL
         685XDl3T/mDCuEsM5yu4VvVcQaGTp6yfboDao/s9dPmBeg/gxU7/a1rllxToR7UWWJuD
         i32w==
X-Forwarded-Encrypted: i=1; AJvYcCUMt0H3lA3//vmy0UEimVqwB84I9nZyiDSyL92AFzi9sSwuFz39XpMcYIuww0CoFr0oafoeDY9t4h2dieFH@vger.kernel.org, AJvYcCUrLTFhpt4n5Q7HavDbmSSVgq6BAGbrdz8/ceLnlN+dX1VpmTQRJIYwCF1d5y81uzmsABGL2uCSGVa/aSrs@vger.kernel.org, AJvYcCVSzvZ67z08lw9ePaM+AdoEf6X1AI3aW4CxrW0KVqG8jh9U5gMivBrUy/dojcwLlIo4J8JwIaVgFIbm@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/UfTJNSqJ4Wy89VCJzMLdV/QCmaR3Op34LWX3cYlkE++tN9r
	hX9OnSCY5JFAYyCWNtWu+i5xi3igF3FZXwrWNGBazD6xDYjeQr1rGJuU9FfDJA==
X-Gm-Gg: ASbGncsUpg1FkDGbPok8G+GHNYKXnKpFdTTUEWarDsctKvgnJ2QvM1ezcKQHMc6pYKZ
	+98N6KDFjeCVbT6dBP/RIc/PHO2N79urqsUYysXVrZWifYDBIjXdm0J3DKC80xXnS/udELNwWBh
	CBhvdvVsepM9cHiINYBfteUKMuDmF8rAotLZm6M6EAWuY1tEDoQ8wnFxS5HDKBzsR+ghtLEj0bZ
	JVtAu7wx0XlQn3KZvgk8SltizzunPxayMhPiKiU4B+zMzLT4Crj+GUTR+gC4s1gWUy3g/ASBIXb
	tZUFUj+B4qLAoPReys+lWasEKxdDyRyYRK6Ce7zZsfZRNA5Cq80SX+rBns/C3NjqNImfsST+ncB
	yLGqJ2LYWYBw7L/ZX
X-Google-Smtp-Source: AGHT+IE/MmCkDw7zCq3ur3i1vuJxdnSH1+it9qEiuWWWBKHTcyCC908pg1AngYiOBUPTs/E/DeZd6w==
X-Received: by 2002:a05:6000:2407:b0:3a4:e082:c8f4 with SMTP id ffacd0b85a97d-3a4f89e2ec5mr12889553f8f.47.1748942210472;
        Tue, 03 Jun 2025 02:16:50 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b8besm17789682f8f.16.2025.06.03.02.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 02:16:50 -0700 (PDT)
Message-ID: <08ef60a0-b78c-47a8-abb7-2de08303ae4d@gmail.com>
Date: Tue, 3 Jun 2025 11:16:49 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mtd: nand: qpic_common: prevent out of bounds
 access of BAM arrays
Content-Language: hu
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mark Brown <broonie@kernel.org>, Md Sadre Alam <quic_mdalam@quicinc.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lakshmi Sowjanya D <quic_laksd@quicinc.com>
References: <20250529-qpic-snand-avoid-mem-corruption-v2-0-2f0d13afc7d2@gmail.com>
 <KuueBg3qliXMt9QN9kV_5_on2xJV-BEWZAsktO_Ce-Fq1iBAPCFypbYUVZxlV4LjF0AUZG57KqiXZZ3uefQrXw==@protonmail.internalid>
 <20250529-qpic-snand-avoid-mem-corruption-v2-2-2f0d13afc7d2@gmail.com>
 <68c54d56-3e44-4f43-8bd6-f6b7fa1f379b@linaro.org>
 <28db650d-a911-4df9-9ad4-f926ea0683e6@gmail.com> <87a56qp7um.fsf@bootlin.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <87a56qp7um.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 06. 02. 15:54 keltezéssel, Miquel Raynal írta:
> 
> On 30/05/2025 at 13:07:35 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:
> 
>> 2025. 05. 30. 10:56 keltezéssel, Bryan O'Donoghue írta:
>>
>> ...
>>
>>> This one doesn't apply to -next
>>
>> It is because the series is based on the SPI tree, and -next contains another
>> change for 'drivers/mtd/nand/qpic_common.c' which comes from the MTD tree.
>>
>> It can be applied by specifying the 'M' switch for b4 shazam.
> 
> I suggest you rebase on -rc1 (when it's out) and resend to simplify
> Mark's life.

I will do that, thanks!

Regards,
Gabor


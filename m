Return-Path: <linux-spi+bounces-8301-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A16AC43F8
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 21:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32887A9169
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4C61DD0F6;
	Mon, 26 May 2025 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJXBuOTX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4921BF33F;
	Mon, 26 May 2025 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748286024; cv=none; b=j8hwwjT9LaotBYQ2T+uK2E6QBFqMXZplFIWpNQvMzK+wrO/mmkK/E4JnlUgkgTyUgRH7neeMO91m2xMpYYgWP1544yLM4K/+Oi4XS2pFmpOG6ZOyDEhHnljKBHnYxI36Ml/YarpKe/+hOucNcUDukp4FBZTtvHOJY6qO7U6JfMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748286024; c=relaxed/simple;
	bh=ePOfC29++ESggGuGKz+Psuyc+GPSsmDJXwxn5BhMFlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlBUaPARzzf0P98lYlQxPQdqlOqaNa3FVjoq2XICY0qMUwiYY8iv6OxdwMbsj7KJUmpOQQ6szrnQPoHEbeqFVyr+LGnuMDpG5vLKPRwaIUjYH4jxm8Ny+NO0Y8SBNuA4Qd0d8B1j2pmrTeac3r1Ry0+MqrJ+z6U1NzBTUNyMoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJXBuOTX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-601ab204085so6450465a12.1;
        Mon, 26 May 2025 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748286021; x=1748890821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7HLJjnq943t9tfBsG6nEO+BsP0zHoqnaSW8DhhOz60=;
        b=RJXBuOTX8ytqW/bqxivucyO4rLM7mTNTsJc2iKICEfnTtp33BDPrWuqgTHzBSuIZgp
         NOf66/xxJYrLobn1APukYi/f03QP8l1/XuxKvpkRwf25OLpdD9UotLSkgqomLHTBxjpq
         qEWX29fPbBuZMvtr/zzay8T73VbLvrN4fp+4mXd5Yxqciwawks4XSsApT85vIsp0Nh0o
         w8XcB9F+/t/VmO0AN2aW/uvEuAbbutzhiKnIjr8sxZQA6hIO441UaRs8ImfIgJkw2T/V
         VxsfjCtVWQuRClMdor0zEeGk7PP4wCdJ7qWjjTLWGcJKqPudumTHw2UQD2d+h3bDxpMm
         33/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748286021; x=1748890821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7HLJjnq943t9tfBsG6nEO+BsP0zHoqnaSW8DhhOz60=;
        b=O75kanv8l8l98SPbjQExe2zUWSpPq2JmKh5nH0Joo9FkSCtyTPN87Ctfn76F1Wz+Sj
         4JKc+JLSic/0CckJJaUYswUQ8htsFCyZj9IB+KlGdLMa6nKenWMr4sgwU6BqOBpCybRx
         zfOz331dLb6JW+rMJyoymO6jHib44hZ7ADsRHFTG24FJJBMgOgrahXWv++PiSdNC5tV2
         qV6BjJu7OXfJatu3Bz4dmuspMlEYN5vWJFIO/P1wExiQKjaq97mxJ8gGo2y1mB523Axe
         krWWYxjKqjniMRXr2D3qLZMANsSyM2L3x/Inj3u+6MuXx90rHGslKdz2f6bvIgU1+stx
         7XLA==
X-Forwarded-Encrypted: i=1; AJvYcCUTZA9o+n3O/6+PPRewEa4GJvyfllLWHubhNrulizth8VgUnSly2msiik5dnSi99aIX2sqJEGfp4iv6@vger.kernel.org, AJvYcCXOjBbVI1n8We8Sz5JApfj4PgKtOid6ekrjaHyqEhA/PcsDj499HsK5iHiMUn/QWWYAhp5S7yPzwLIZ7CeS@vger.kernel.org, AJvYcCXXH9NWdNHpukwO+OSmDE5dTYL/6KbkzE1B3/bt+5pVHbaK0Hu/qWjtb6CfPr5p/f4yAvpaZUizaF99Brk4@vger.kernel.org
X-Gm-Message-State: AOJu0YyLlQLRh2ZYw+RhfIpN08+L6J5Ww/Ts3xJiS0zZCLLgvPiGv+MK
	PxOznob5OP5qsH3gmQgMM4Wp5VX7V6zFhOFejmFE/PkhI5a9J9ypQCNu
X-Gm-Gg: ASbGncsOY9OzJijOTvmH8TftzDNXL2TraAdtSTNMpdf6qGDCxvBQvjul4vIGAmmymP1
	E4J/LDAYEgHd1nEhBJrZtQ120+bJg5YmKLQXeSlw9Nsuxs1ZoLIGqU9TKPbuFOpTizuACawJVB9
	ZaCNu/h2r1rukfkOW/vQc7tJgl8o1baHpy1Ybwqcnqg6ttztG/qVZRxZkiNTCr4dK0tIzOFIgmS
	06OeqkciF9miaOIxqe1vHsxKVyq56rfOKGEIqdY1Y2SSpZfef0sC6ITE/x+tSQ1cjR2XRXd8Hgl
	sNTSTC5bh00GN0r5ZdsdQtuc22oS86uJYz/kB2wgeg5i8sJ1mktPVU2dnhcsPcmWdd4V6DpAzHJ
	RVH4NybQW1rtbGJvY
X-Google-Smtp-Source: AGHT+IGIry+aoCgx9x9cr71iQ7GQxeXVX+GF2ustchqL5GOThY2B0a+6W4khGGch4NApD0EjZ99GJQ==
X-Received: by 2002:a17:907:3fa8:b0:ad5:6622:114e with SMTP id a640c23a62f3a-ad64e8e0ee1mr1213181666b.30.1748286021072;
        Mon, 26 May 2025 12:00:21 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8859d7411sm75220066b.80.2025.05.26.12.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 12:00:20 -0700 (PDT)
Message-ID: <acca434f-30f3-4992-bcf3-e389563b356c@gmail.com>
Date: Mon, 26 May 2025 21:00:20 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] spi: spi-qpic-snand: overestimate corrected bitflips
Content-Language: hu
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Md Sadre Alam <quic_mdalam@quicinc.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250522-qpic-snand-overestimate-bitflips-v1-1-35c65c05068e@gmail.com>
 <875xhr5r2y.fsf@bootlin.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <875xhr5r2y.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 05. 23. 16:39 keltezéssel, Miquel Raynal írta:
> On 22/05/2025 at 19:33:26 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:
> 
>> The QPIC hardware is not capable of reporting the exact number of the
>> corrected bitflips, it only reports the number of the corrected bytes.
>> However the current code treats that as corrected bitflips which is
>> quite inaccurate in most cases. For example, even if the hardware reports
>> only one byte as corrected, that byte may have contained multiple bit
>> errors from one up to the maximum number of correctable bits.
>>
>> Change the code to report the maximum of the possibly corrected bits,
>> thus allowing upper layers to do certain actions before the data gets
>> lost due to uncorrectable errors.
>>
>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>> ---
>> The patch tries to address Miquel's concerns [1] about the corrected bit
>> error reporting capabilities of the QPIC hardware.
>>
>> [1] https://lore.kernel.org/all/87h61e8kow.fsf@bootlin.com
> 
> Thank you very much for attempting to improve the situation. Giving this
> a second look, it will not work either and will be even worse, forcing
> wear levelling after each read. So let's not change the returned value,
> hopefully the real life is different as the test case and most bitflips
> will be spread and not concentrated in a single byte. However I'd
> welcome either a pr_warn_once() or at least a comment somewhere about
> this.

Ok, I will rework the patch. If it turns out that the current approach behaves
badly in real life, we can still change it later.

Thanks,
Gabor


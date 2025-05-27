Return-Path: <linux-spi+bounces-8311-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69624AC4EA2
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 14:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28075189C822
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 12:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C6C2561A2;
	Tue, 27 May 2025 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+j0uwaP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AFF1EEA3C;
	Tue, 27 May 2025 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748348625; cv=none; b=DDola1fGQy2zzojSKtjy7pbZyKn3XU3XdDKMJNCpUgpT4lLmok+WN8bhdgbDBlZBdtKXkL/BL/zXm66A1VwWh3EqzHof0hepafWOuoWeXJXQH+5OB2l25r4C7LEm45MX3SaPUiFl+MI9S1E5WJMOxN5zAcWx4N423yeFQiO0afA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748348625; c=relaxed/simple;
	bh=pe1OYalU8LhDHO+wita8AE7W2rRqrRbbyT9H7Lo0+bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQ4mueM5y40A3UpKmo+3JLAfw6eVg0TmW1U8lYYK9SjEmQH0vmyLTwZuOo1P7FRHS7FBWYEKKGq/Fb+eztAWXPVSOqFZuz8UkB/yT0SVADKchFs+ElLFspVMR/M6e/+yCa2WI/eR9oYrc7HvFLR+5mcQq4Ls6xTleCtWJOq8gtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+j0uwaP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acb5ec407b1so552147866b.1;
        Tue, 27 May 2025 05:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748348621; x=1748953421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sv4wuXSLD/+kZTuRxA6+oQJ5op5SeTKVQQWAFxZa5Rs=;
        b=C+j0uwaPeSAQaWSkwnj5TkBq0B7XlSZvjZ4Oy94ooW7ySL5XeIh9uCNj/bdPXlUjOO
         ZAVnfJz22WIRQ2Rav8cZk82JQZMuIQXdn4qwFPRRBbmqMI/6rjriSUpdjmdEEyyGFLSt
         lemrWbl7uM4guPj12vgJIOlcH9mm5SV2kL2h8TN4qvZ7VSSDNEYo8BLdaN4AbPCYatOE
         XzPTlRlC/vywbWszWNam7vv7OLl5hcZk4dIjxtrvpi0r8edncZRyzCc9XrGKmFtj2agb
         kIkfrYUSMfaxoeCF2yoq3hZrH1ru+EN0NmwGS3+JMfvYV9GfhWcKSNaJQEtNgri8aaeQ
         C5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748348621; x=1748953421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv4wuXSLD/+kZTuRxA6+oQJ5op5SeTKVQQWAFxZa5Rs=;
        b=IkmjLa9ReyPN4A7i/oCzMnMyyPhdSb/6GRbpec8XbqnIUKIZ6w3jb9AmK5Dnd9UWOQ
         KiHU6WUJgCpRku1NxLSPIBNbhfhOYFqt/othRGHSjA+t98Do52H48TYcvrUq5SjKsV6e
         5nPc69LNgb+ACJsn1WDIpDS2hcwK8YH9Jhtr/7Pq6cKfNUMQCe923L0jtcsx6iYy/ZHu
         RazCNjTWHCe18YsQlvc+DmQgjon67q9JAOBGdEyWRlGms2U49fqY4sCc2VOWY5C1Lnck
         AiuPFqkEfzmR600qnrBkmThzUN43d2qUtX0rzv+KMKwtm2NMzcvZ/ZRv+kB1L0sCuK5h
         I7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUB8DHKUkKoCSynWCN9IuTBJ1VgbIqQhHegFJcIrH4+0QL3vkAKs1t11eeXcVutSyRPmJOpuqp8QKNR@vger.kernel.org, AJvYcCUrfOP98u7nzUhsjrMMGs8MQ5wszzuRavMKq/ltDeUf+Cvcw0ZN1yAFhDl3L1lEnCcc+56Yj/gX+BbWGkTh@vger.kernel.org, AJvYcCVZpQGGL1YIpPdoQ/NVBPsVMyezSA4HYVAD3Ns44KWCKbrKng44gcicQutXQu2Tfv0gWq4mk9TD4wguduwF@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5UPr77ZLwbHuLkiVd2f5Aqg1CWDNDGisKdWNQH1NH7f57neR
	BYzpO564/jBnNI6j/em9StDb4a//IExRJPrMuh2Z0jEoxW0sXI8ou9eweFDv3rcL
X-Gm-Gg: ASbGncsHMMFEcg1ILacvMs/pF1TugnZ/WAAo/c1h65P3wWz7aVLTnmZZWTIiB4aHDDN
	DDuaTYzjYmPKrolAc2qseTX8yWByo4wCYB/suOX/9tBQe846qxr6Z655K+WBr7IeWHNsLX0UfHw
	VUtslPUjhEmXRrf0NHqJjw+5O/9Z1BiFMNStyaMJNKxflzSbyAFTGwOaxKck61r+nhsHw9GPcKY
	co62tKs1A5lTqrHxtv6yWQ29WVg5ECfaq6YmzHqYkec8BoXEmMN+NPjBTNGl0IGeglHDVgHtF+P
	FBxIpNLi6fmcVP1fXaX/H02mhD4PGZKeyzpdOOaYZ1zcHNUVHt8B6Eg6rq/XL0CXAoHAvKSloI5
	87NbJaD58aV1eIGO8TILy/AkeNP8=
X-Google-Smtp-Source: AGHT+IEurTuNxs4HzYvVoUQ2BdVp3evbNEzGLhzi7LgW1gOpzZB71RBOTVuWo+KUBIsoZlub08X7Ng==
X-Received: by 2002:a17:907:7ea8:b0:ad8:8c52:d61f with SMTP id a640c23a62f3a-ad88c52d729mr228815466b.35.1748348621226;
        Tue, 27 May 2025 05:23:41 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4ca3bdsm1826986466b.160.2025.05.27.05.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 05:23:40 -0700 (PDT)
Message-ID: <831876a9-4f2c-47af-aa4d-3151e13b6bef@gmail.com>
Date: Tue, 27 May 2025 14:23:40 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: spi-qpic-snand: reallocate BAM transactions
Content-Language: hu
To: Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com>
 <20250525-qpic-snand-avoid-mem-corruption-v1-1-5fe528def7fb@gmail.com>
 <cc53dca0-74d1-42d2-936a-adc383bd571a@sirena.org.uk>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <cc53dca0-74d1-42d2-936a-adc383bd571a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 05. 27. 13:28 keltezéssel, Mark Brown írta:
> On Sun, May 25, 2025 at 07:05:35PM +0200, Gabor Juhos wrote:
> 
>>   # reboot
>>   [  877.178844] Unable to handle kernel read from unreadable memory at virtual address 0000000000000078
>>   [  877.178913] Mem abort info:
>>   [  877.186767]   ESR = 0x0000000096000005
>>   [  877.189508]   EC = 0x25: DABT (current EL), IL = 32 bits
>>   [  877.193312]   SET = 0, FnV = 0
>>   [  877.198780]   EA = 0, S1PTW = 0
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.

Sorry about that. I try to avoid doing that in the future.

-Gabor


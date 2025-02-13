Return-Path: <linux-spi+bounces-6802-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E043A3388F
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 08:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F89E188C219
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 07:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94812080D6;
	Thu, 13 Feb 2025 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="um1hTdoP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB131207DFB
	for <linux-spi@vger.kernel.org>; Thu, 13 Feb 2025 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430660; cv=none; b=OX4yUqRGfWDlAEEdkXtFIzLI4JocZgRLDCSu/pismPRR5/D6/TtcsJR4ooq1iaUj9rPFZox2XPJeQjZa9Fnsj27IGhl6t/uqlHdSEsYoH09AmvyUONCZm2KRl0gs6KAp50E3ciwIcXzGt4tBb322CyzAvyxacJ2uyby+jshJwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430660; c=relaxed/simple;
	bh=1JzLXGxL0QmiLI5Q7L2Av98JRC5DJw0hUHJfC6Qg2Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZEzSZ3JuYsDtuIdXkP16WtUWm4B8IpN2JvJOSEJySVz44Lfm8qzKJD6uMOVlOTMG8cbz0iTMUKq1r3187cFXzeljhM+cFtvpZXHd3tPsthyW9cUx0uYGRG8idP/9h1ptKqYxNwXsUBcZUV5L3JxX1cNhRRilVHZErhAuzPmKnUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=um1hTdoP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaecf50578eso118796766b.2
        for <linux-spi@vger.kernel.org>; Wed, 12 Feb 2025 23:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739430657; x=1740035457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fM8nRNJfG7rUd02T8erTfV5HvN4Rbdhc15q2XjlMewU=;
        b=um1hTdoPBVMHAK/ZiGthqfaEd0BOvHcMehdhyGzNN+ELhG8nX3Q+kt3fSJ+4jMuN1W
         14UgncLJRs71GaPq/kRoZ9MFvParFrkUvKnRC3aa9ZRDiOYGsSJZZiKYqlqaWE81sF+I
         Frfj2avDxONZP9QTmKgXCAND2AAJQiTLtreLza8ti+GeLfHuX24jPqEHFWeKCoekWnE1
         awRAfC5weqdh+orzdee16f3p9X8Bfc9uIpd0ia46JMAa2aRishrNo4tx3T8nOoBc63ln
         oBPnrxrAOcKAlxlaSraoHGr6d+pSY5Ab4E4GJ+NL1HXvy7chia+tqOPQP9Uy2gUn9JiT
         jIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739430657; x=1740035457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fM8nRNJfG7rUd02T8erTfV5HvN4Rbdhc15q2XjlMewU=;
        b=jzwmsfIQUXOz86P9GVA+/rklwhfVxBnJ5VDhiHTW/Go4xMz/QIdSpbtKIzjxRb2UuK
         txgdheDNsci0z0vOo1LEH+8517MvG3jjQKscu1KG6qc6iYPxwUs3/wrrhunUKFEb/3go
         x7cSEqLAQdKoIS8ytHtAXh1cVhEW8FDxPprE8L6PpS3Nh3BN3s5MAFHfFFeb/hqmm7W5
         eGcKo3ZZnny1cfai2FIkAKWxlsg3fPgnVY0rtMpTvxt77yZfxVvOMkrbbbsCLTcP0Tdm
         vfnOsq4SB1LHPI4VbZcRzcMmGs7QC6yyAt4PpeYyKBmq+TcMmrCnGFZSxh/o7q4El2/t
         /DhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVniVoeITVaec2ZjdYuTfwicC5OwT29pbrZOZrvzb0Mb1tPMrqx14BN1i5d51IssIUdJINIbaHFbSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/Nxf0nj9iNHIrTQMn5l89U2HiL3sP5M946JeWL/paUraUtkA
	7Q3DdOlhZNwyWIFqt4xspu0IJX4hsEJeH43akmCHH1ubi//+gvk78kJCHFRp/I8=
X-Gm-Gg: ASbGncu+eqJOMZ1iOCCzICzeWD9XB/UVw5uM/FMkAFGhhXbLgJAlCIJOE6C4j0PFV2A
	fBOss6vooJc+J6tLDXsKnjdeg8UCVbrMWMcOYVPPHiRbctYkKfkggCDZL2KC74lEzcjxNO/2ohN
	gZiigLn/0G2B20uofo6jwm+gu6SzVaB6RYm+Jtqaak1GRFEP6423zzJQwiUAFBphXyUDXuCCXDG
	3CZsqGKe4l+q7mH5OEOAItC+T8/xHU/6NB1e5P1fCErMeEJNeIzLJGCMIlGZmSkerpn/24SxDBQ
	Oq8NM6YwZr7vLc8O/GHsmBCx
X-Google-Smtp-Source: AGHT+IHtrPRE46nXKkFCt4DHjiN8hmdANTLc5iX661OAdX/npX13cIu7Ky0HIkuVU57aNRMuRQab9w==
X-Received: by 2002:a17:907:3d93:b0:ab7:8520:e953 with SMTP id a640c23a62f3a-ab7f34d4f0dmr512307166b.55.1739430657085;
        Wed, 12 Feb 2025 23:10:57 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d349esm659748a12.33.2025.02.12.23.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 23:10:56 -0800 (PST)
Message-ID: <feefbcf2-e441-4cd1-a3de-40bfd4d7197a@linaro.org>
Date: Thu, 13 Feb 2025 07:10:54 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] spi: s3c64xx: add support exynos990-spi to new
 port config data
To: Denzeel Oliva <wachiturroxd150@gmail.com>, andi.shyti@kernel.org,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, peter.griffin@linaro.org,
 andre.draszik@linaro.org, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250212191241.280-1-wachiturroxd150@gmail.com>
 <20250212191241.280-3-wachiturroxd150@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250212191241.280-3-wachiturroxd150@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/25 7:12 PM, Denzeel Oliva wrote:
> +static const struct s3c64xx_spi_port_config exynos990_spi_port_config = {
> +	/* fifo-depth must be specified in the device tree. */
> +	.fifo_depth	= 0,

have you tried testing without specifying the fifo_depth in DT?

You'll probably hit a divide by zero at:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/spi/spi-s3c64xx.c#n664

I assume the controller can work with 0 sized FIFO depth, and if so, the
driver has to be updated to allow 0 sized FIFOs.

btw, how did you test the set?


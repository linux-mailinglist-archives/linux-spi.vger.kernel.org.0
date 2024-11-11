Return-Path: <linux-spi+bounces-5665-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73329C3FB4
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A652428297A
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 13:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142DB14D70E;
	Mon, 11 Nov 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSIjxrPw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B21865E0
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332558; cv=none; b=l9Lx4PTbGyyMBenTGt3wIoS2LKQbKHnK75+kh8x5aXp3ThTApZAWd5PdP/2divDuDiJoURdTKCHtjm4yoInww8Vk/T43OcErc0/hDdvTdgNtLjr4dT+rPjBgIYZzLtaCYsA2mT2CTEQWCycaZm/MlwhBdXfv/nUmgwtJU0ty0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332558; c=relaxed/simple;
	bh=Y3zflVzs4zmU12WLOrosHNsReIIhJZ12xrnPAPnQMdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFcXxZmk+98NTTA9e5vsVC4haMu2YXUxuI49UfIS/uTnlupG2lV7tLpWiP/UpCfEy3RcvXgYhRtOUrtd7mL9NGNtaW/ZXjrsMX2hBBoibDLKPt2EdgDgViPvvUcpdKUeYwIZid1OEKCIplxSx2dODno1qAzUw7GCqbXHf6bRDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NSIjxrPw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so39667005e9.2
        for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 05:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731332554; x=1731937354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFFB4p9gtjjqP0ylPmDfODC3qKl0n8dAQXHFfxJE1Lk=;
        b=NSIjxrPwvhCTTxmAThkRYhW3u7iytP9GmzX8gBpRzTNLXppTk4fjMqgmFtLXP68CZ6
         WYGYNdM+5BVj8b0VtkehLzSMs54BgW2I6ZX9s9NhWbaFawH/xT+JnljGZe8QraYks8ok
         av3g+qdN7Ntlj/ceae4gWyvjbOYeCuORhiDJUvt9AmoiTGBCRj+qf+jgY1btrdbdkXhK
         +4eOlQ3SvRmIk1Yw/wUCoIkVsuiKhlmIec2qtkQkoRU/qb78mSCy37sg/nhTO0tikeTH
         sKcPI65N5r02SJT0JiQZJQ+1MpsIgKn8z9px61AVfr464Cg8TP/jUOQatSsvkU1VTt/o
         M+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731332554; x=1731937354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFFB4p9gtjjqP0ylPmDfODC3qKl0n8dAQXHFfxJE1Lk=;
        b=o3V91NReI+8BiPS/Eu2XcnUgWhqsnPORLi4y2LaWrMhuaysgSBpXM7xJTOlxf/iczk
         AdstmT4FNmWxNON3t9+EMyHr7Sl89mk3vwgRP/dxg3Q7sQtEYoSOAkbX0hvZJBN6vdp5
         i1bxfv2+r4BjWzRDtwKbk0vbFJBx5uKdkO/CjwNHdjK4B+FSHpjFRyaFAfG2Q/3K1LIn
         6re0igEdJ8TT1l5Hceh3yF0q+/3pHY/sxQihDEdmJ98t1xa1CjukeuZqArbPXwTvdmzr
         zRwHifbSlnEhN3ziqiInnIRmYTNV4ssVzr7svORtZadGRGh1ul0rUrRB2hcPK5aU/onM
         FGmw==
X-Forwarded-Encrypted: i=1; AJvYcCUgSFmw1U2dhiIxmjpZci+FgNE9ypHrO75kH1htTwYWjUOX/dtOf6L0E9dFW6DOhvjkKXI5rEboGR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8WOG1oJfsidq4eSI0wIhZwjn1a4HACK9lhMDixS0nM2rqCC4O
	iAsm6r7inBUP1NXoxZJLs6btEpFUWGoMrhLivs5GW9LzvoZtnLVfOfPseOPPRSQ=
X-Google-Smtp-Source: AGHT+IHFp5IW76ae0+ug0Yg3riirx+YgM0J4mYik8o2ZcaxazUwINUADaWThHKkUZHiOHvo7i0nQ4Q==
X-Received: by 2002:a05:600c:3b82:b0:42c:de34:34c1 with SMTP id 5b1f17b1804b1-432b74fdaa1mr101737845e9.2.1731332554429;
        Mon, 11 Nov 2024 05:42:34 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c1a13sm175792135e9.29.2024.11.11.05.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 05:42:33 -0800 (PST)
Message-ID: <9e942bdd-6ade-40a7-ae4a-104ed288a09f@linaro.org>
Date: Mon, 11 Nov 2024 13:42:31 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] spi: amlogic-spifc-a1: Support per spi-mem
 operation frequency switches
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Steam Lin <stlin2@winbond.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-5-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025161501.485684-5-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 5:14 PM, Miquel Raynal wrote:
> Every ->exec_op() call correctly configures the spi bus speed to the
> maximum allowed frequency for the memory using the constant spi default
> parameter. Since we can now have per-operation constraints, let's use
> the value that comes from the spi-mem operation structure instead. In
> case there is no specific limitation for this operation, the default spi
> device value will be given anyway.
> 
> The per-operation frequency capability is thus advertised to the spi-mem
> core.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-amlogic-spifc-a1.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
> index fadf6667cd51..18c9aa2cbc29 100644
> --- a/drivers/spi/spi-amlogic-spifc-a1.c
> +++ b/drivers/spi/spi-amlogic-spifc-a1.c
> @@ -259,7 +259,7 @@ static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
>  	size_t data_size = op->data.nbytes;
>  	int ret;
>  
> -	ret = amlogic_spifc_a1_set_freq(spifc, mem->spi->max_speed_hz);
> +	ret = amlogic_spifc_a1_set_freq(spifc, op->max_freq);
>  	if (ret)
>  		return ret;
>  
> @@ -320,6 +320,10 @@ static const struct spi_controller_mem_ops amlogic_spifc_a1_mem_ops = {
>  	.adjust_op_size = amlogic_spifc_a1_adjust_op_size,
>  };

I see the driver sets ctrl->min_speed_hz = SPIFC_A1_MIN_HZ;

Do you want to introduce a struct spi_controller_mem_ops.supports_op and
check that the spimem op freq is not below the controller's minimum freq?


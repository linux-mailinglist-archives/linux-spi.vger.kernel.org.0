Return-Path: <linux-spi+bounces-5662-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995F09C3F41
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E8DB2596D
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD2319CC0F;
	Mon, 11 Nov 2024 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3vczwsm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2519DF41
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330437; cv=none; b=VWC6ikP4AsedRLHTi1cWrbAL0MeN4tkAlxKzHvnkfr8KfxAWfvv+p31w27/bg6QqZOiTmWb7UlwoUHTjM1XTmKKCtmkXltGNHPEnu/ZeDMx7Ew080CgBh+ZM/hih6OtSLGEsR67bNuqpfvkoNXDYPUarE9H/2gcRJX/5/ve2dAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330437; c=relaxed/simple;
	bh=Bdt6gXFXA/3lu1myocZQUXx1p7DBPPkF8hzbx9fuG6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UimRJrm5cGqfjvCv88dHlEF5EpdZV0MxNvaU5+nApEKVGM06T5boZMHaaSeC7sn80jxC6upQ38T4CSKwqA/Z+gi17TA8XTNWv+47YVLlG7YsOA6/4kJo2uCQILENQiJU6CugZVMp0js2vhTGDgYcxdn567K+Jz5w86VeWLq3Uwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c3vczwsm; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99cc265e0aso713943466b.3
        for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 05:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731330433; x=1731935233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NuqbWEUKeRUyLa/FoT+dFXMmWuM2evJHexwWQ7irf3o=;
        b=c3vczwsmvTdtFkC1g+yRlm2BYJQg4uo/DiTf/9js3odq+dKIUBW9hymaIYbaJCJTYG
         Vc58s37I3tm8mtdXUMmzElXdKldAoCOr3lkub9+ffWMZVMTT/Uld4UotHB/rc6iIJFao
         RySM5P9fAZeO2os+S1rDzDZ4ew5UesKDYXp7rn+SlImtSCQcUNigCpyu9mDvzk8tqqHR
         mUo9pJTtvCzmnkQDx0FujbtrrAsObQ5mXabRkV1L1KnPWloMo4ZAcnqYXLLbssOdVhpe
         msX2VoPnvRJ93oBVFe+23wK0qblbHFtB97Exaav8Xqc4u0yyOptjyk1t/3JkiSB5Q6N0
         cVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731330433; x=1731935233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuqbWEUKeRUyLa/FoT+dFXMmWuM2evJHexwWQ7irf3o=;
        b=XlWSzlED8qr7PWvk535Vs/BB0MUQv7GT7VENgyUS7Q5shMVq2zSOWLbuAhn4zFNYRs
         m3DTCcsudrxmj3ckatpypso+uIZw6215KCxAFjvEVMvv270SfwkXZblhz8BrdP5L5VJ6
         1IS/g88EKMDGA6IBtKYGwK2CkD4G4G+BUfAZsGsGGekPJFy4NZi/3NBZwmR4Hga2Gvp3
         sA6zq21XVFAEPA6nfdFSqkBNO8rQaC6XwKvESjNwTfs/TmLL8sgS5p1cd5gcdWSa9+3P
         0KQhaffVNjFOm5LNTsShjGteJAlANEn7Gg/6XCXM97jrLNh995lNhYqOW7UhkWWTeLIw
         bRaw==
X-Forwarded-Encrypted: i=1; AJvYcCWXTvd4a9TgkE8yw/lzaCbSQ2WFZDQdmemhxUlHvZASjHy5TVh8iXlXxjdMiajXvnitxqi1/QdkCmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYVAdPcxFncf8Ar9cZjY9tAK8J5iodp+a7x7SHVSGS9Q+4Am9A
	H/bL1x12l93OHx/QdDFRP5jtHqJjXvfECxiUHhZ6pg2lZf4L2Wlv4YJLa9VD/oY=
X-Google-Smtp-Source: AGHT+IEnb9jV9y5YcXAyyhZyx653iOkhdQJRgdvB95DAl/f1lUVteBRKumj4+CzwSQbTSU2R/No6gQ==
X-Received: by 2002:a17:907:3f14:b0:a9e:380b:8ce with SMTP id a640c23a62f3a-a9eeff44e9amr1235984466b.35.1731330432898;
        Mon, 11 Nov 2024 05:07:12 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2e92esm597386666b.182.2024.11.11.05.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 05:07:12 -0800 (PST)
Message-ID: <e76ff30b-342e-4e4c-aa84-40312c3ffc72@linaro.org>
Date: Mon, 11 Nov 2024 13:07:09 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] spi: spi-mem: Extend spi-mem operations with a
 per-operation maximum frequency
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
 <20241025161501.485684-2-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025161501.485684-2-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 5:14 PM, Miquel Raynal wrote:

cut

> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 17b8baf749e6..ab650ae953bb 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -356,6 +356,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  {
>  	unsigned int tmpbufsize, xferpos = 0, totalxferlen = 0;
>  	struct spi_controller *ctlr = mem->spi->controller;
> +	unsigned int xfer_speed = op->max_freq;

be aware that for controllers that don't support SPIMEM ops, you pass
the frequency from the upper layers, without adjusting it with
spi->max_speed_hz. Was this intentional?


>  	struct spi_transfer xfers[4] = { };
>  	struct spi_message msg;
>  	u8 *tmpbuf;
> @@ -368,6 +369,9 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	if (!spi_mem_internal_supports_op(mem, op))
>  		return -EOPNOTSUPP;
>  
> +	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
> +		((struct spi_mem_op *)op)->max_freq = mem->spi->max_speed_hz;

not a big fan of casting the const out. How about introducing a
spi_mem_adjust_op_freq()? The upper layers will use that were needed,
and you'll still be able to pass a const op to spi_mem_exec_op()

cut

> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index f866d5c8ed32..8963f236911b 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -68,6 +68,9 @@ enum spi_mem_data_dir {
>  	SPI_MEM_DATA_OUT,
>  };
>  
> +#define SPI_MEM_OP_MAX_FREQ(__freq)				\
> +	.max_freq = __freq
> +
>  /**
>   * struct spi_mem_op - describes a SPI memory operation
>   * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
> @@ -95,6 +98,9 @@ enum spi_mem_data_dir {
>   *		 operation does not involve transferring data
>   * @data.buf.in: input buffer (must be DMA-able)
>   * @data.buf.out: output buffer (must be DMA-able)
> + * @max_freq: frequency limitation wrt this operation. 0 means there is no
> + *	      specific constraint and the highest achievable frequency can be
> + *	      attempted).

nit: you close a parenthesis without opening one

Looking good,
ta



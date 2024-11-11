Return-Path: <linux-spi+bounces-5675-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C79C411D
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 15:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8082B20CC2
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E730D15A84E;
	Mon, 11 Nov 2024 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+9oqFSG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117EB14EC55
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335939; cv=none; b=NNqX2Oi0JzLV/Axf/2ntOKK6FCoD67cwr37HceeTV8KUFkNqMWFywvJ4bUWA7T1vb8JddrrD8nqU7Ra8IqBqYOYvIXQlL5C2JUFaPyJJGrwU98JtCDbeXUXp8yfOLltjmBvV/fGk3HY1CAUwAVsXX/NJKHB5mZVkqNu3ofFH/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335939; c=relaxed/simple;
	bh=dha46m4BegLU3c2ofXUasDkypJcFuw0dKGCIjNNtdrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEsGtySH343FPN+gEy56U4oghsfQO9FIZEdEWWzWv3/F6SEZz5UintRpUgFOk0iRH8sSqUE5OcMzppVEqGvh+LuRapfvZ/CEk8N5uwz5xqC4U6Mgre7wRNIHh57MH14yodIf/3D/654erSlW2hhKwdoWTrIO1jLevqT5zCSlcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+9oqFSG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso56829341fa.2
        for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 06:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731335936; x=1731940736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q86RIhAO7LM/N1jsUJRHeBTO+9FQwZpmv/PNBndqJwU=;
        b=P+9oqFSGCp4WsJwtHRtcvqjwEopcMatz944QpG/R6B6RiIrIyCneqc0fhvEjpefRt7
         YLF4dqp4+joSr0yMtfzM1s+4kvdEocQwi/QievUno80AYO6Vc+/yMdBtCWXUcV09/9g5
         K5mBgasZnzRwZmmYIgMSZB9Z7CBQxMztnZ/ExxSvGIL//DtjzguMrMPqRRnzQLM6sCla
         VO5O+87HQbs6mjyi5AUgkNYQxE4jo/fkVS9c2nw1ST7tf8o/Doe4Bsem+0NGt8Wdm2QU
         2UV7MWAHr053uH9G9LMPlJNiaWuTKdgMbB3p0qRDGf6HqMsch4lNGnSZP4U5N/gcZH8+
         KkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335936; x=1731940736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q86RIhAO7LM/N1jsUJRHeBTO+9FQwZpmv/PNBndqJwU=;
        b=Q//7+QMYVDSFLxI4wEKGvjw8KN8gta/DeIYU1MIckfMImhDFKMyVsD7F3SzfDWeYp3
         uYuyq+ZTufHhThWA4o035uN9Y4eTpgWegkmzL9o8GgXAbYX1Tiu1nWuzYthe4SELImLN
         VTMgATtLUU2ZjQareQ6AvwQZZ4GXCe8JKpauObpIiI62/bafrVKTGF2yiQej4IuPEh0f
         Zf9OWUUJhH3M0SlMhrGqTWHM43/R+qyooaTpxkzegeftCRDuVgUqqL4GTmT2eD0vUSrS
         Hn9rVR6TSwNWeav1+cYXAzU7feMS2RN/EcqJB5lrfZgabQbJRKRf0kS81FYx5M1tzUGY
         K4/w==
X-Forwarded-Encrypted: i=1; AJvYcCVujD80N0AEcYEIbKX1GvlvFWBTEsPeYuaoxcQssRzyDoKwCV8VKD2iTiyh1BYTVaMT+84nGY7QiYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUiq/OKYmif+7WTsp8qm14MBE5PfGb+2f62HkbuRZKlFeV3fQc
	hgq6fp6KPcmHtGXUMPc3XzcuXxtdaTlu7HGCA+Q/fEwumVzsAPNCHaAj3DSMgZf5mvx9DNJgwcf
	b
X-Google-Smtp-Source: AGHT+IFeOtl3DkD8EMuB8gc8RFfdxKgMEnHE3y6HRa4hffxk49A510G2oJUaW3J9NxQK5kJx3a5BMw==
X-Received: by 2002:a2e:a995:0:b0:2fb:5206:1675 with SMTP id 38308e7fff4ca-2ff2028a9a5mr82305981fa.27.1731335936065;
        Mon, 11 Nov 2024 06:38:56 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a184dasm598568166b.30.2024.11.11.06.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:38:55 -0800 (PST)
Message-ID: <71d0cf83-6866-46be-b76f-291a8a6a1346@linaro.org>
Date: Mon, 11 Nov 2024 14:38:53 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] mtd: spinand: winbond: Add comment about naming
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
 <20241025161501.485684-24-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025161501.485684-24-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 5:15 PM, Miquel Raynal wrote:
> Make the link between the core macros and the datasheet.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/spi/winbond.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
> index 686e872fe0ff..9e2562805d23 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -18,6 +18,11 @@
>  
>  #define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
>  
> +/*
> + * "X2" in the core is equivalent to "dual output" in the datasheets,
> + * "X4" in the core is equivalent to "quad output" in the datasheets.
> + */

doesn't help great for an outsider like me. Is quad referring to cmd,
addr or data? Or maybe of all? I need to read the code anyway.
> +
>  static SPINAND_OP_VARIANTS(read_cache_dtr_variants,
>  		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),


Return-Path: <linux-spi+bounces-5663-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F26A9C3F6D
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261391F22E5C
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2B115746E;
	Mon, 11 Nov 2024 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhSW0acv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E2E15575E
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331122; cv=none; b=ZufbJjGKLCJ9EHwi22bNPkvX+izyZM9tbxlI96BqVElyHYzuBS51mSMnraO04pxYDnOxJ4psVPsGoSuPhiKqr0eGi+Mas80h2lbaiEkALEx0NDza3Y8tUukEQk7mt372WO95zigi/csotOz957WqWvCFtd1oggnEgsQXZA8T1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331122; c=relaxed/simple;
	bh=9OevzXz5YzK2f6iob82WOWXvjALxSy78gb4/hBEnH74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8WVkAkPDHbmBtHQMYrfNeA5poDjvzHXvUJ69BvbDvX2zEOuRoFm9POn+a36BdpALNvf6ac8M6LN3grS7QM3CYnApfMv7iHRcs2oAI92fDg0A4nrqNsKD860by9deXMhYFFWEnImtDFYcLRI0pANuYq/v+yT4oAq8Oj7gEKv9Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VhSW0acv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso34739695e9.1
        for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 05:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731331119; x=1731935919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBYsUQyuGnUCxPYNsjjy6hHWkk9kZSJSWORjW+FER9U=;
        b=VhSW0acvk9BfoQVTXtF9qy3sX+Em+T4XD3kyiO7au12YEIxeoEzrSy4rUrOkxwxzvR
         qZZnz1CS75TQzEitai8ytQh3EoMwz7/bfS4YlC6qVUkaCJLSvFkoQ92Rj2kRoI2rGBk4
         2SpkCy4rqnH1hG1IWdabwkKEyty6gCVpEJugav8j3GWkDU7oMkVAawueYbYzlP3TOyrl
         n7MzAUGLkmxPmCazi0oKnv1zgFPQViBIihC/2N63S5hyYAQ4THBdnAAO8WIbmzu4jdDM
         VmkzVfek3MJKNcztWUECIHcPRbc3UtE07h2lsHQZdQ6TTjM44U3BcExHTKWdluUjhTHV
         IT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731331119; x=1731935919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBYsUQyuGnUCxPYNsjjy6hHWkk9kZSJSWORjW+FER9U=;
        b=kJG6JOmqGmHQolDalLi6hz0g95OwRd63k1MT7vXSQO3GlYwD5ckTqB78Im/mpKL6LG
         ZYlHkQE3iFCPRUJHVmEtZWYZInL8wRdLbsM8IxzBk0+MF2gtp8+aswVOxYHTUgbY6Mdl
         PgT2JBYbV9aocxJ77VjqYxbAz2n8nF6Iio+oLzpI4alqTmuawqYCZirz14EFXNj/fsuA
         LVoSKJy3N6Bm5Ra5yQyAS9dDqXIMUvCN0BTFgp2egr7z9nR14rDA7DakVlCN8wkMDzNd
         uPy3Du28lAqegky9vlXupfJNtIinJzs7YtiENKDyal9YY649o06eYRxouoxPhUVGjLfv
         5lxA==
X-Forwarded-Encrypted: i=1; AJvYcCU4H4GtKFyDjmE0hQSfYA2YD7MdIxa2i8FNF4QNlGMgjAOYQwcXiMv0J2y02uZhuMQh1MHVU6+0T98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVBQBWCjLH6Y6AxPYOSoHzZVmTAJ0lklnIfZCZO6gbrw6i6ZD
	5yxlLfeWNLh/0i8+qmskvEclnn7JfZUI+ypoQqLpXvxp31UwV1rUeQ+Qp5c6ADPJKgLpaNO2/7D
	X
X-Google-Smtp-Source: AGHT+IHSKsyvNkcwhxPa212FM3ImPi89yRwKdA08hu4iTpCOmYpdNo98cNklwU6XYrZmAtlwh2MDGQ==
X-Received: by 2002:a05:600c:4507:b0:431:5c1c:71b6 with SMTP id 5b1f17b1804b1-432b750a433mr117114625e9.17.1731331118929;
        Mon, 11 Nov 2024 05:18:38 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b0562860sm175494425e9.22.2024.11.11.05.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 05:18:38 -0800 (PST)
Message-ID: <59d350f3-73f7-411a-9ab2-0b2eee5247b0@linaro.org>
Date: Mon, 11 Nov 2024 13:18:36 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] spi: spi-mem: Add a new controller capability
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
 <20241025161501.485684-3-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025161501.485684-3-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 5:14 PM, Miquel Raynal wrote:

cut

> 
> Among all the spi-memory controllers, I believe all are capable of

nit: SPI memory? or spi memory? but no "-" I think
> changing the spi frequency on the fly. Some of the drivers do not make
> any frequency setup though. And some others will derive a per-chip

nit: s/per-chip/per chip?

> pre-scaler value which will be used forever.

nit: s/pre-scaler/prescaler?

cut

> index 8963f236911b..379c048b2eb4 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -306,10 +306,12 @@ struct spi_controller_mem_ops {
>   * struct spi_controller_mem_caps - SPI memory controller capabilities
>   * @dtr: Supports DTR operations
>   * @ecc: Supports operations with error correction
> + * @per_op_freq: Supports per-operation frequency switching

nit: s/per-operation/per operation?

If you fix the bug that you identified you can add my R-b tag,
regardless if you address these nits or not:

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


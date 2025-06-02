Return-Path: <linux-spi+bounces-8354-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B39B0ACABD1
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 11:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04A41894280
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66021E5207;
	Mon,  2 Jun 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1vYtOdE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B411D5CE5
	for <linux-spi@vger.kernel.org>; Mon,  2 Jun 2025 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857534; cv=none; b=ZetWHkfB5mz9edAUnjoy1A4kIIk5N00wujVGNN8jKT7jRukweL08VCRfRnLYKL61Wp4J63J59YiiVSxB0/tOdZH97T5/dBY/B4q7zVI6yWv25un6qXaWeFq/J3Pw0kqZVwm6AzQFk5f7INXomapjX1APdiKdecq9TmiQ2aaai4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857534; c=relaxed/simple;
	bh=Nn+ovUN+eo2RAdkKZosYkpGwR94TOa708SfgIOsgDbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2P8HlFZl5Y7CvU9rK/orEmLPYSW2g+gk9WhAXScUN39M75VIHEtwP+atv4GYfiaqGndqzxM1xSzViNZTn7SdIDyx8BRMnnNlPyKJXo8fXGfTpbE+XfkIyCLTkXdG41NKdar4ccXVQ28yvmufFAVUE02xvRJc4B5nMVE8GfmNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i1vYtOdE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a5096158dcso656350f8f.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Jun 2025 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748857530; x=1749462330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xbKU9W5xheDX9GZKVqgHJ+55CDve1/9ll10Ovwv/o7A=;
        b=i1vYtOdEZmAEXSy1DxBkRf8BLFvbQyxa91vzcAUpVl77qrELZtkJBqH2BIV36fafsX
         MwtpgsDaBIAX0hSiK1RkVTnwiLlc3APsc2lg/VHLH8l1mPcc2MobfOEQ26J7ieQvIDHD
         gGMGV68CaL2a0DTyMNmy6ou2ogLrEszit7ucY6hAOHaBMhTLI2mDGhLUfEx17u1wBdg/
         EqkwevOwQ382bz++1TRAcv48RffpdJ4+fJ2BrZ4D8F6cp8T/TgWxRTRHaLUUZ8T1Bs5F
         R7TyPy5SnPnnfEgIIUYQjPqVse3oMQIykAhZT7ucEO5E3GR36JFFtOJR2UhgpfaZgAw8
         xLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748857530; x=1749462330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbKU9W5xheDX9GZKVqgHJ+55CDve1/9ll10Ovwv/o7A=;
        b=rvcLaDS7BmDHQX/TSempsh/BL/aqicyMWZehVcQtjqi2dcna3FyWIABQacSOlVifwL
         Kvk+lr91xvqopquDExl5blASVzmywxXSZlsZ1AOqFNawsDOR6MX77t5r2rlk8StvooLp
         KzwTtsMnNQ7hUuL/F4N6+lQWHdYWvyd3DUsYeqrWSLaCElFByJMhBXhv2V1gpDA4hqZ2
         nXMsBF9KJrPxq+FubaUQSQxlvNV1DHCVMsB8UBNSjA1QEPMr8DwlGJMBKvBJNwo/7JBN
         LAnJHfi8it+blGRK6KnLPIUVBvxDK0p9JjtPE7I03KPuVOkFRk1cZs4LsyUyUvxSljhG
         XaQA==
X-Forwarded-Encrypted: i=1; AJvYcCUnvPNb6yy5kBwZae0n0WbWS0VzHy5kfbIXdftL+Bexo+Peo8sQl9affAdgnwsF8o+Lhh6rxWl6+2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YypvPBIPj65hXFpUjNwpu6wmnI5iAl1fhzK0YjQiL+IH19Ha42v
	7ISfDQLn1MrC+8qz6jy3GXbOz5/ipnjnrIHqTMmQ6O5LMJpVFOmf04Gmsr8/mo+3A0k=
X-Gm-Gg: ASbGncuFxSUmER6NxEkGIQua/22nAPiSM7KucA7JI2pCd0PTSzdIRasSikyW5Ry68N3
	TQP1nbyJJS6GOa8XtuxpJyQVUvgmu2+EG+1b/Hv6GDbVGvz0SRvClkVSfnG5cueCyttd/u2GMxv
	jyaA42+wP5XISmDfyqt2lDGb0o6hh1wSq3FL+Ean14ljb4RsKg2L1CmtPol0ik0EgAlPhms7iMm
	uTpYSWuSD/BTNR+XDkj5cQ4X8+ksZfkJ5MBFm1dKg88GkZW1hHZmbJ8eGXmmi09fl4w4SRmM/xj
	vk0QJBf61i85UyxbNTJ8IiQITfN4GiPtk0JyYNZ/ftvohKUkaGC3eYw=
X-Google-Smtp-Source: AGHT+IHPnVtWrDel++vKl3QQEDHSr/37CxtTyJhCw23iebOkRyXNSgDsVfvNb1+gbFuTQxbT8lg0KQ==
X-Received: by 2002:a05:6000:25c4:b0:3a3:648d:aa84 with SMTP id ffacd0b85a97d-3a4fe154c68mr6288485f8f.5.1748857529926;
        Mon, 02 Jun 2025 02:45:29 -0700 (PDT)
Received: from localhost ([41.210.143.146])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450d7fc1a84sm117403015e9.35.2025.06.02.02.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 02:45:29 -0700 (PDT)
Date: Mon, 2 Jun 2025 12:45:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>, cve@kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] spi: spi-mem: Add fix to avoid divide error
Message-ID: <aD1ytV8kiWP9ssuv@stanley.mountain>
References: <20250424121333.417372-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424121333.417372-1-Raju.Rangoju@amd.com>

On Thu, Apr 24, 2025 at 05:43:33PM +0530, Raju Rangoju wrote:
> 
> Fixes: 226d6cb3cb79 ("spi: spi-mem: Estimate the time taken by operations")
> Suggested-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
> Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  drivers/spi/spi-mem.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index a31a1db07aa4..5db0639d3b01 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -596,7 +596,11 @@ u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
>  	ns_per_cycles = 1000000000 / op->max_freq;
>  	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
>  	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
> -	ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
> +
> +	/* Dummy bytes are optional for some SPI flash memory operations */
> +	if (op->dummy.nbytes)
> +		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
> +

Hi,

We were reviewing "CVE-2025-37896: spi: spi-mem: Add fix to avoid divide
error" which was issued for this patch, but this patch is a no-op.

If op->dummy.nbytes is zero then the original code does:

	ncycles += 0;

We don't divide by op->dummy.nbytes.  Was something else intended?

regards,
dan carpenter

>  	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
>  
>  	return ncycles * ns_per_cycles;
> -- 
> 2.34.1
> 


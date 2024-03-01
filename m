Return-Path: <linux-spi+bounces-1607-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7B086EA72
	for <lists+linux-spi@lfdr.de>; Fri,  1 Mar 2024 21:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFBF1F2339A
	for <lists+linux-spi@lfdr.de>; Fri,  1 Mar 2024 20:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984DE3D560;
	Fri,  1 Mar 2024 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SEUoTPHn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA53D39B
	for <linux-spi@vger.kernel.org>; Fri,  1 Mar 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325723; cv=none; b=PjMfc+KCHXq++NEJlOIHtUbfs8b0cvvLV2wLLWemTHaLNzMO5YOfM29b5PHS2zzGfNGJtfkVii6iSJdz55vQN5HehQVhU32205pGSdxoGVU7eqLJ/6zSyCKE4MHgow9yP9wMjsWvZCDMFHwiGPrTySvVCjCn6MomdqpiVlm3Jfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325723; c=relaxed/simple;
	bh=b00h7L6AGlfaD5kvd71sZ7vd6gXSPpX60QhiF/qhUzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+h2ZUmfGuwu3wYnWDYaQwLxRS7lkWgaTIiF1THLnFresw2zXlDA1RxnVNhABQR1xBLT3mEp3A78HkzS0Pz2ds77kIuHJVo1L0qGGreEjdoS46w/cgh6zPRgyc+vTcqJGqxxeGk1RBvTcyF5YL7HndEDn/vif6MOPwHCpI3JQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SEUoTPHn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e5675f2ca2so1676363b3a.0
        for <linux-spi@vger.kernel.org>; Fri, 01 Mar 2024 12:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709325720; x=1709930520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l8fnGBiVDyvj0+sJf46kp+vk3quKyy9Lc46ziSRLCxE=;
        b=SEUoTPHn2JRwBvVhJO/3HAb1PqWgDpVUy2Y6wftKnM9qb36vU1yO0P5JAoLtHIz39g
         Vhx/PL9u1UfMVRrDa/e3wy2YAZOx6ZQgmWNJEvImR4WQtuNNyL4fde10ppdyFYelSRyZ
         8aKheVPSidhC9OZxizwRDS86gn1jvyQYULShA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709325720; x=1709930520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8fnGBiVDyvj0+sJf46kp+vk3quKyy9Lc46ziSRLCxE=;
        b=Ye73LNcQc4+bufLhbvWQfo4Ps+AoVn63C/GGergUe0pt8qgCVZ0Is+dDdozJt5g6M/
         0HZf714NDx4WUyodeX4oPwEJFkGS/6UQmS/U3Gvk7gppom5GZ8YWNYmm27Waze8U8pxy
         mpFds2P2ojZ6tb5S2vpsY/om8Nk/O+DMT2+pHTxRpH1ADGIaHUq4UHBdZdKmEEAJ7Zzr
         MR0RzDg3euPmqZh2ZyVT7wnZG74+wt9dXWEaL4XEH6AKH5O876zTJuSwgsz7Pbt1J2SX
         JRhmcqYnQ8IypkO/1Oc2TuPh4RfsuCxBTW/+SVf+e+VSRjvZF43gX18jdDiHqdmxy5zY
         nkJw==
X-Forwarded-Encrypted: i=1; AJvYcCVVhgp+joi22VGnvRzRKUU8Z0sE0wtIH/gUKXNyX2zOxJCtv/y7Bv9JirZlsHyactymqSKnjx7+y3D1aw55y38bxH391J8nO8+U
X-Gm-Message-State: AOJu0YyU+xeuavK7MJBquSKaf6vBv19uCap5topTlC0oSfFIfbS3ov5T
	VHDMTe+4W5sgk/QdxFmlCzkafYZq5XHidkFXHXYybGBZYkfy3bZ9/gQap+3PRg==
X-Google-Smtp-Source: AGHT+IEi6FI+IEbwGBctosMmFcuCICddCBpYdWwOsgDnXRw+Iqlkx7u/X41Y65hzbIQOLhuXmk2gFg==
X-Received: by 2002:a05:6a20:299e:b0:1a0:e4a6:2d86 with SMTP id f30-20020a056a20299e00b001a0e4a62d86mr2273919pzh.59.1709325720658;
        Fri, 01 Mar 2024 12:42:00 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r6-20020a62e406000000b006e0416c42c3sm3375303pfh.198.2024.03.01.12.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:42:00 -0800 (PST)
Date: Fri, 1 Mar 2024 12:41:59 -0800
From: Kees Cook <keescook@chromium.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: axi-spi-engine: use __counted_by() attribute
Message-ID: <202403011235.C326E3D46@keescook>
References: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
 <20240301-mainline-axi-spi-engine-small-cleanups-v1-2-241dfd2a79f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301-mainline-axi-spi-engine-small-cleanups-v1-2-241dfd2a79f7@baylibre.com>

On Fri, Mar 01, 2024 at 02:25:19PM -0600, David Lechner wrote:
> This adds the __counted_by() attribute to the flex array at the end of
> struct spi_engine_program in the AXI SPI Engine controller driver.
> 
> Suggested-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/spi/spi-axi-spi-engine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index d89f75170c9e..e801eed820df 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -75,7 +75,7 @@
>  
>  struct spi_engine_program {
>  	unsigned int length;
> -	uint16_t instructions[];
> +	uint16_t instructions[] __counted_by(length);
>  };

You'll also need to change places where you deal with changes to
"length", as now accesses to "instructions" will be bounds-checked
by the compiler. For example, this change:

static void spi_engine_program_add_cmd(struct spi_engine_program *p,
         bool dry, uint16_t cmd)
{
         p->length++;
         if (!dry)
                 p->instructions[p->length - 1] = cmd;
}

-- 
Kees Cook


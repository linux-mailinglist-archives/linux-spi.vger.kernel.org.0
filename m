Return-Path: <linux-spi+bounces-7017-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EB9A4DCEE
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 12:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C763AA701
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 11:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1877D1FF7D7;
	Tue,  4 Mar 2025 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt8zuhVF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2233D561;
	Tue,  4 Mar 2025 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088953; cv=none; b=XCMdHJl6MUrFIY4El15wkabsYtg4L0ejicmDOrRXJRdCu9kT97PLgkxqJ+VLdgloxtyQx0Uh0kukWJlLKBuaVWWO1fTH98xt8GcLTxeaI8pvP8Iu1gb1fx2ULEIr6PVJOjqEWjVApQn1NE9MgPMxqs22ms2gIfF+ylNgdDzPdEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088953; c=relaxed/simple;
	bh=RCtg6YfWfyeXEbzX98sv0AzTk9Z0mtgYMGtnNpm0zgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ7HSdAICpAG2mhrE9fkHK4B/ri/MUMeUJvTmkZtdO2j4rKEewPrXYwiN8BpBn0hniTUEhl+DJpSZdfPbZ4NvFlkiSNkS+1zF8dTBG9STjCFnvIVjrDGsqhuZV8fmFudRaGppNJHWNsWBj1LjX806g13Rxsp/qwfeyOdFGZGGvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt8zuhVF; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be8f281714so653530485a.1;
        Tue, 04 Mar 2025 03:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741088949; x=1741693749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=onMdlp2f8x1LxPV52MNcce+I2AyQq4Iol3MJODJ2GE0=;
        b=Pt8zuhVFN4dKXm4KTAHwsNSw54tGXi0lUiXzBXY428V1aX973EtDgX1DI9bCnT4RLB
         Nbvx3/eJvUSLZYKYtB30wNvsLYrt2Fao1Qs3M7DIuBrySZY82pnbgE+6+Ji0QP+MEW7u
         XWmcWMIrvQJGwfzULfflN64m4S9ky+vcVljfqZnSEUbijXjuxiimB+wPBRCUkgjoQ7WP
         imeVIISXtGHKTaLDgdUcj8IJPvBwZSvoxG1HZGYSE+BossIPYpLNuFs9oxTHDtBoy3DR
         vPWXjxwL72YB9PvsrG2fdd/OW3VY3kQ29eYnM712H8q2KGso46uqKYYDz/nZalPmjydU
         eCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741088949; x=1741693749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onMdlp2f8x1LxPV52MNcce+I2AyQq4Iol3MJODJ2GE0=;
        b=WA1ZTQLQlknt3JQM5nNU4eElgG+pfq9aS1nzRYQwg2v9xiGOg0W0ZAf9PJF08RG9Ct
         TTRve578kIOri6kwXrhrUszui09Zw9NZbr5ZSzyB/CRDTI/4w2gu/lbT9V1gPnqDf7qv
         x/yq1j/JQyAV/dpQ9BxDYMUe9b0SWM6OTEX91FJRk9alM9u/KXvvv7TxOnAc6nBtUfC8
         tQtOJC+clUSQnCp7rBB8fDzz/w0Au8Fl9Jznxj+ZFHJPndHosQJJT+4fPWvNBfcobWFH
         VLr/fnAKamDTSRNh4y8XmGh4JTBmXxyNZRRBzAhFucy6UKrHWbJPQPNY0z/vKygTJcdi
         yQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIxjwN5V0rP7FZQpCBqtXy5kHZ0spKYdxrbElJTuNiy0FWqA9fTgdQUn23JRVXNod/TYfk4fEfW6py@vger.kernel.org, AJvYcCWnkoABtVbPUmIy0xFJ/6eizwu9HYTccuWkIPjbCiAgFHgeNF5DMupY5J0nchLz3SM0tk7THb0K29ESKk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZBgF+OAcrz5+BaXVsUyqMLoXjbUT+14Cp2I056f58qEQlLDrj
	YLBSNYUqlW9jz0cTTAhnkRi7iz7/5rBXIU+/pYYS9m8Kdjz41beO
X-Gm-Gg: ASbGncskQm7dJMnOR8SgRVPeytZrfSQ9W2TOdQIqlzad8iAwCAb6I5fNHLQqPOXW9vq
	4L29MzA38JIcXZN5gydaK5vMu1QzDRElUrh0usTtnWIpFc7araBInoiX8VrLtcQfROTbnjkCJQK
	Y53WSDjltk669Hg66eB7OEteSKCiMSZeotQlHv9JXze/LxkHaonyO+dn+gV+R8jv5tlRzi37c+E
	KaZdXKP9BTxrSeq3BYoBW/7FHa3AfQPyb04o3iI7ER6ppDdKpxRrcRRGVxm0/KSaZKJMkJspQa5
	wdQfwbq0CjPx2Qj8d2QE
X-Google-Smtp-Source: AGHT+IHqpua1AnMLXzWu+IhdWI6r2Cd/qFZvYWoxIEa4UPjyLGrwl6Anv4vk3oJ5Ez/Yyh7+uPRoaQ==
X-Received: by 2002:a05:620a:f14:b0:7c0:a3bd:a787 with SMTP id af79cd13be357-7c39c4b6eaemr2636434085a.13.1741088949526;
        Tue, 04 Mar 2025 03:49:09 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3b2fb20f0sm329018585a.107.2025.03.04.03.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:49:09 -0800 (PST)
Date: Tue, 4 Mar 2025 19:48:42 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Inochi Amaoto <inochiama@gmail.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] spi: dw: Add ACPI ID for the Sophgo SG2044 SoC SPI
Message-ID: <nvym76w7ezhsugmno65m6jnt54ts5at7jcnn3jfrhlorayjlya@jyl536p2435u>
References: <20250304070212.350155-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304070212.350155-2-inochiama@gmail.com>

On Tue, Mar 04, 2025 at 03:02:10PM +0800, Inochi Amaoto wrote:
> The Sophgo SG2044 SoC can enumerated its SPI device via ACPI.
> Add ACPI ID for it.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index f0f576fac77a..70fdc4b6de9e 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -426,6 +426,7 @@ MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id dw_spi_mmio_acpi_match[] = {
>  	{"HISI0173", (kernel_ulong_t)dw_spi_pssi_init},
> +	{"SOPHO004", (kernel_ulong_t)dw_spi_pssi_init},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(acpi, dw_spi_mmio_acpi_match);
> -- 
> 2.48.1
> 

Drop this patch for now as the ACPI id is not registed.

Regards,
Inochi


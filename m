Return-Path: <linux-spi+bounces-880-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2562E83E329
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 21:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1FFB20EB4
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 20:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C2322618;
	Fri, 26 Jan 2024 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t7NCqmhm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3022EE6
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300048; cv=none; b=LUaTsD3G6xgGzVS1L7n3UIVvPa0N+z7+6PGiUumx0DDwVFvULW3wHTgZ2c7+fxpRZwZyeft1Ej+VB3XzuukSVfy2jsQ1QGVfujkalBzdVTbTuJqnKdbDYBY2t4GlIjOlABzQLMmgteX0Pru8BRBFm7Nl7RgdxsHiFixsI24xPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300048; c=relaxed/simple;
	bh=EWXfgYyY233KrFoVngtHQ2H8WU91gix4UTTnVtfOnRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/yLU2V2xwaynBk5EpMSPVS4IeSPsuvhazXz8W8JdYikIX+vkpViialUzHwzRiaZG5v407qVNlfw1/0qZFk6c5+8L1mieV8oPtL90aGiqxTzQoR26b5nDLZ7dQw8UtkvJ1SSRhZn6/fRyPhb0qBL6NK6h532udOFRWrV20/1zww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t7NCqmhm; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8b276979aso158831a12.2
        for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 12:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706300046; x=1706904846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+krPZgrbztjZGtgVWHsodIOcgc9YnMVDe6Yn4wV9Ec=;
        b=t7NCqmhmb1t7WhXgwSU7iv4dJzbnzPFISvCeZOD0BxbIpFAG0ZwW4Fp5+x6Z7MApwf
         fJMmEgqev+Aj3dVJ1rYj+8plaIskj3MlFl9JB+//Ihi5EPSjZeVLXW4pydR5axvWA6OM
         OKRtR7xduCQvofjfwPNCjkb903dqsU0eGuJJ3d+06pXCO4jpFJL/3S9hkdnfObs1GQWe
         dHtNGMEV75M8KRrWvwLSLq0XvZHQFK5ttzZYND1e8l3oI1Lw6TqCAXeWgvgyEf7ilMHZ
         6sPQ3QM5ChCZcYA6ibm2LCIjGZ6jU58q+JhHgPiz1kXbhr2rfXuG6GsRBqqhOljW070f
         fZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300046; x=1706904846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+krPZgrbztjZGtgVWHsodIOcgc9YnMVDe6Yn4wV9Ec=;
        b=SYcr2qYVGjOqR/Abavfr39E+ezloB9oNjcZ9bL8RQL98d3ES5ZmICu2usbaoOJCceV
         xiwlaPd7yuHMz0TIKMTdnjb3RqFGrj0ypA3vmbkOXYVmwWbgIQ2kO7rAG/7yq3Aarhz9
         nLE24XjmLg15khGL/kZeiNc1bnbT5OopHQVcwlJr0LQc9RkTMF7N8vSKAPQ3+i1MxTv+
         Lu3cqn+NrIOGBn1tW+D+oFBzgTEbeEhxZsP9bULWRaOMj/4Vq0nRH0vQysaOYLHfcV0C
         kTFVKLU3lR0a6I1IOwLCTRVuM2wkKpx7kP9qaUPIiXnkL/JDuytYLcEt38gvdiuwcb+9
         ErxA==
X-Gm-Message-State: AOJu0YxGu/Y19knbTfhH91CwAVH+/01/iCXLaCp89PPJgKMXqU+98HIm
	e6jJ9RCSpRhHRiERSfmuNSM4KYh3OBLM73QcprQPmnlNnYc7guHJnKNFfzgAccGLf3sfAsMnoeS
	emm+PPK0ZyJpggrkZm+Yk6oGdwc0ckiSvGCP2kA==
X-Google-Smtp-Source: AGHT+IHkH6VgrdBcnkureZXbmqsHk+CBes2kmRke/KfdVBwbOv3cLHa2b/1GnpdF/y2eh7NA+HTo/vfv1KdRgUfmHe8=
X-Received: by 2002:a05:6a20:30d5:b0:19c:2be8:4a24 with SMTP id
 21-20020a056a2030d500b0019c2be84a24mr239548pzo.60.1706300046132; Fri, 26 Jan
 2024 12:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org> <20240126171546.1233172-13-tudor.ambarus@linaro.org>
In-Reply-To: <20240126171546.1233172-13-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 14:13:55 -0600
Message-ID: <CAPLW+4nipUTRek7_=0uUt32kvN4QDSMAMAAzD5Nx_zv3seEgHw@mail.gmail.com>
Subject: Re: [PATCH v3 12/17] spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, jassi.brar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:16=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linar=
o.org> wrote:
>
> ETIMEDOUT is more specific than EIO, use it for
> wait_for_completion_timeout().
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Looks like you missed my R-b tag I added to this patch in your
previous submission.

>  drivers/spi/spi-s3c64xx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 76fa378ab5ab..2f2c4ad35df4 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -526,7 +526,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_dr=
iver_data *sdd,
>
>         /*
>          * If the previous xfer was completed within timeout, then
> -        * proceed further else return -EIO.
> +        * proceed further else return -ETIMEDOUT.
>          * DmaTx returns after simply writing data in the FIFO,
>          * w/o waiting for real transmission on the bus to finish.
>          * DmaRx returns only after Dma read data from FIFO which
> @@ -547,7 +547,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_dr=
iver_data *sdd,
>
>         /* If timed out while checking rx/tx status return error */
>         if (!val)
> -               return -EIO;
> +               return -ETIMEDOUT;
>
>         return 0;
>  }
> @@ -577,7 +577,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_dr=
iver_data *sdd,
>         if (use_irq) {
>                 val =3D msecs_to_jiffies(ms);
>                 if (!wait_for_completion_timeout(&sdd->xfer_completion, v=
al))
> -                       return -EIO;
> +                       return -ETIMEDOUT;
>         }
>
>         val =3D msecs_to_loops(ms);
> --
> 2.43.0.429.g432eaa2c6b-goog
>


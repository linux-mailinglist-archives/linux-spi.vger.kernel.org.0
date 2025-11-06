Return-Path: <linux-spi+bounces-11086-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E95C3B7C9
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 14:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CBA564C80
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0612822D9E9;
	Thu,  6 Nov 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejVjKxAy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C46214813
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437019; cv=none; b=oyoGjFyRoJDweziEN+YA83+g2HufUNIA9BJsWC9DLPxExnEjLtMQVKBOloQtmD1fyCqPvLxjEd5YpYMQcDXjXMSOXbeNr8xj6A9RM8yOJCeljXf160VY4m4nzq0WPEtGJWcwlJytJ+EnmDNZI8a4S9QJtpMkk3KzA8l2IhmtwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437019; c=relaxed/simple;
	bh=6iPYaqTYTS9k2S7cNA0i2JDeTIZLY1IgSdPtcBgSClU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1Xt/XVzDpOQpZ2Ts+lJLQWm7Rdd2jQZAm+GyhK+BdIABRnR1Q4K4tTEVj7sGzX1HAk85DiVhkDGPq/DPwPDQCqo5Cl0iPtfLvTvCR3vIjSyu86msfYScFXzKYMMBEiFA2IzQC7ajtuF+aEQ+/KwlHqe5Abu5rRuy4LLjDNG3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejVjKxAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696B6C19421
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762437019;
	bh=6iPYaqTYTS9k2S7cNA0i2JDeTIZLY1IgSdPtcBgSClU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ejVjKxAyRvxb0U810S7W1Z0w1RhU76J//8rPmANSOZ43xkXf8yo0ShAl1U/IH6D9+
	 Bn/bh+fRXzw7VCFd2lfBZqyOR4+YtA46rNIGgO/ygZLJ7dJCzXiENnBSaZvhblbicL
	 7PgtSPVNEFwQhr4Rg80lDD5v4NaNgVzPNXfymyJDfrPlQC9QsoMfXt8U6qBLF6dhg1
	 PyzxIHn6Tn1P6ddbKLl3nBgtZChMDGxJS59XspkEDvk/HZcxswDzBEL3cbKuwQP6/E
	 qXcbvZBEm2rWbNp3+HduR9zVn6L2FhHoB6YNvxyHP/YIlITl+VALGrTmbqFmu5L+Xa
	 mzeFQHlMhDyiA==
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-932f654eaaeso523451241.0
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 05:50:19 -0800 (PST)
X-Gm-Message-State: AOJu0YwNLpq+IFydaFMAclu5jZpDMgoaxYqs237gTYO5b9Y60QL9jfuq
	U+IpPb1+WpyviwbvxB+Taht6QHPw6V92/wxp1nINu0ZyjEso14HXzHomKAj/DlzSfqE6TvKeaQ4
	HIebI2S/BX2dD4aHTt+rmjP+BKlY6oXc=
X-Google-Smtp-Source: AGHT+IFqvK10xgKYKcmwUgGgRDJOkrJofNlCzREecbF+WNopwZjIyl1wg5knQwX4J61P5g8B2APgVilDRgm2PCVQxoU=
X-Received: by 2002:a05:6102:2ad5:b0:5db:23d4:feb1 with SMTP id
 ada2fe7eead31-5dd88e93df4mr2840152137.2.1762437018456; Thu, 06 Nov 2025
 05:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106134545.31942-1-alvaro.gamez@hazent.com>
In-Reply-To: <20251106134545.31942-1-alvaro.gamez@hazent.com>
From: Ricardo Ribalda Delgado <ribalda@kernel.org>
Date: Thu, 6 Nov 2025 14:50:00 +0100
X-Gmail-Original-Message-ID: <CAPybu_0CnMQtt9+j+fUrDmT_-2m-aU2ZyFX_yGB7djmXYwPR5w@mail.gmail.com>
X-Gm-Features: AWmQ_bm3pKzDBitsJG69IJJFVnhgiLOZFOYjZXkfspu-3L9vG1EAr_pzEpEHOa8
Message-ID: <CAPybu_0CnMQtt9+j+fUrDmT_-2m-aU2ZyFX_yGB7djmXYwPR5w@mail.gmail.com>
Subject: Re: [PATCH v2] spi: xilinx: increase number of retries before
 declaring stall
To: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc: linux-spi@vger.kernel.org, Michal Simek <michal.simek@amd.com>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the new version. It worked against linus/next

HEAD is now at df5d79720b15 Add linux-next specific files for 20251106
ribalda@ribalda:~/work/linux$ b4 shazam
20251106134545.31942-1-alvaro.gamez@hazent.com
Grabbing thread from
lore.kernel.org/all/20251106134545.31942-1-alvaro.gamez@hazent.com/t.mbox.g=
z
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 4 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
---
  =E2=9C=93 [PATCH v2] spi: xilinx: increase number of retries before decla=
ring stall
  ---
  =E2=9C=93 Signed: DKIM/hazent-com.20230601.gappssmtp.com (From:
alvaro.gamez@hazent.com)
---
Total patches: 1
---
Applying: spi: xilinx: increase number of retries before declaring stall

On Thu, Nov 6, 2025 at 2:45=E2=80=AFPM Alvaro Gamez Machado
<alvaro.gamez@hazent.com> wrote:
>
> SPI devices using a (relative) slow frequency need a larger time.
>
> For instance, microblaze running at 83.25MHz and performing a
> 3 bytes transaction using a 10MHz/16 =3D 625kHz needed this stall
> value increased to at least 20. The SPI device is quite slow, but
> also is the microblaze, so set this value to 32 to give it even
> more margin.
>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
> ---
>  drivers/spi/spi-xilinx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index d59cc8a18484..c86dc56f38b4 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -300,7 +300,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *sp=
i, struct spi_transfer *t)
>
>                 /* Read out all the data from the Rx FIFO */
>                 rx_words =3D n_words;
> -               stalled =3D 10;
> +               stalled =3D 32;
>                 while (rx_words) {
>                         if (rx_words =3D=3D n_words && !(stalled--) &&
>                             !(sr & XSPI_SR_TX_EMPTY_MASK) &&
> --
> 2.49.0
>


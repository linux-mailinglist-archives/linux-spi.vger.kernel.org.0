Return-Path: <linux-spi+bounces-11080-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA8C3AE45
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 13:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745B63AAE35
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 12:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E830C2D9ED9;
	Thu,  6 Nov 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt1uYfJ4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E01EA65
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431899; cv=none; b=UFf5BMLpgkvVaN2LLO/O2+vr6xmeBFMmewaFB1YzT4+fkZklL5dEyoSgCFZaPU+IQAHTCVPtZcUYMr0l+UIW3J+DkrI5N4kcEjIeHOimGCIJbYj7KIeb1cMtbbgeCvGfZqpEQ2fCh5+kjH8mvLugiiVJWG4iR0gOffmkg0xrd54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431899; c=relaxed/simple;
	bh=U0Q1/esYcLi5flqtALMMhZNpIoKxngVZ+KDz0KcEYk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGZPfqAEEuj85eG0eWacEnkYzrZhLBHq0HfuEosTbZSOMJp1e2bDvD1mSIRTOtrVqlgpsq20ZHhHFp7mu4ai2LzStlQ+yBQ9RtKXsfyTyAOI3od2vRfxSWOBlQ5WoXGxzkjiwh6QlFsIA4aCIuPrv7ZPGEFQbtQ8EUH7W+1SEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt1uYfJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0DAC16AAE
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762431899;
	bh=U0Q1/esYcLi5flqtALMMhZNpIoKxngVZ+KDz0KcEYk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xt1uYfJ4L4ZVrgqbmytPwusBP87accEvhDFdtjFevxV0Eb/FqaLRc58VrCwavQNAg
	 oz7bED1EFcYa/aTNybLj5UfMtQMQW84Zc1TcnPQWlLmTG+RyC/phKwvYwg/WROTmtr
	 qjQVal7/UvqWDXKjRVZWNfdmar3aRLkvX7QHC/NwYFxkJp2rfCQMdydbw3plFm2bjE
	 Ov6gkBXGSZMbFOdPSn+Qf3OblezabIiDkVxw8gqCd+DkIZjswaUcKzKOrIIpI600yi
	 j3lFxwDl2S8SO9fFfIIFfbJa273ktVfyelcvkOE8gE84BJtYsXpSFjtgSbpVgaXIrf
	 dc7RhFYF5wLGA==
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dda7c61f16so345617137.2
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 04:24:59 -0800 (PST)
X-Gm-Message-State: AOJu0YzFJaCK8E1wlIO1VCnBw+saiJjEVrE5wkvypFkbZyKQxhYBj5bl
	HAwTDckcDJ7CRxlPH/7S7PC3XvcI/c7fo5IoDDSA5qhpWE2gm9/Tdj4lRSZgpIVRvdStg+OknJp
	GKRZqggq6NmkhIc/zlWmGNPhMp8Td1BE=
X-Google-Smtp-Source: AGHT+IE0dvCOZm6qU8IFVBqPFr2ojy5qmxkXeQc7nHg0CFI1biEp5OmnZWJjTK2VmFeI2ozw52qtmfWSFjls8XMj5dc=
X-Received: by 2002:a05:6102:a49:b0:5db:c9a7:bdef with SMTP id
 ada2fe7eead31-5dd88ef0593mr2452336137.14.1762431898767; Thu, 06 Nov 2025
 04:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40ca72b63d52d2db4d03ed45d17edd1000290c3a.camel@hazent.com>
In-Reply-To: <40ca72b63d52d2db4d03ed45d17edd1000290c3a.camel@hazent.com>
From: Ricardo Ribalda Delgado <ribalda@kernel.org>
Date: Thu, 6 Nov 2025 13:24:39 +0100
X-Gmail-Original-Message-ID: <CAPybu_2Oi48xAPjoW-rTYvfz14Vnoco+APRBY64qbH+gPhg5qQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmU6l5pixXhHjo7SHYUEnqYnyx672mzZJZ-TS7Jrd2jcI-V2r8NO5g7_uY
Message-ID: <CAPybu_2Oi48xAPjoW-rTYvfz14Vnoco+APRBY64qbH+gPhg5qQ@mail.gmail.com>
Subject: Re: [PATCH] spi: xilinx: increase number of retries before declaring stall
To: =?UTF-8?B?w4FsdmFybyBHLiBNLg==?= <alvaro.gamez@hazent.com>
Cc: linux-spi@vger.kernel.org, Michal Simek <michal.simek@amd.com>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 1:14=E2=80=AFPM =C3=81lvaro G. M. <alvaro.gamez@haze=
nt.com> wrote:
>
> SPI devices using a (relative) slow frequency need a larger time.
>
> For instance, microblaze running at 83.25MHz and performing a
> 3 bytes transaction using a 10MHz/16 =3D 625kHz needed this stall
> value increased to at least 20. The SPI device is quite slow, but
> also is the microblaze, so set this value to 32 to give it even
> more margin.
>
> Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/spi/spi-xilinx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index d59cc8a18484..c86dc56f38b4 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -300,7 +300,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *sp=
i,
> struct spi_transfer *t)
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


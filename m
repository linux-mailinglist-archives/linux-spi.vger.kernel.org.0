Return-Path: <linux-spi+bounces-6106-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B552B9F6339
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 11:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30EC1896595
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141E419D072;
	Wed, 18 Dec 2024 10:32:33 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249019CC14
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517953; cv=none; b=RNYPeeHgNMOpvIpIpAat+nr2INJ0lGlbdtV9EJYIc0K9dQMAwlytqUrqYMm7qk5dvz0Svs3rvk02dgWFAzFT26fY/69JFIpaSttGLAQzpnoXIgECY30OVhILtQG2/ZIlemme03XwMf6gq6+PYY2r8sJK6RQ5GOvsSpSl5SwczfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517953; c=relaxed/simple;
	bh=GwzpAN7FhnbUsqiP4kk0J/odJNsuCEB54Go+fdauHjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGMhg6bqDYy5pa0RNPvg1W6wx7VMxqd2YXBKG8Z+7LyeSlS+8rAbB8+IAz3uok0q/r5Q28zmZDc2UGQ9G8T9q+NgCckhUj8U/0hO2Ty8eqd13/SaU3xK5FefrqyRVaUtYOWEJeWu0ICtxgvoJ8od0kdLEd+lESVXjyZfYKxdWhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85bc5d0509bso1237071241.1
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 02:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734517949; x=1735122749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGkE4xcxumwqqZnWe507VEYGyooxaaryp5uC4wNPxH0=;
        b=wt6iBTExqgv2rhmsAnjkNjEz5mYgkLew8UjTicPHZHoGzHLQCqKAyrC+2dEhHt68t8
         Dgq2X1EgXU9E448//F4Qd+dBfjzB0wwNtXnFwzZKV1KB0dMg/1sVC4X/rlNE5mGGSyxn
         8mcFqGEiMstEJWvAkvjeUBiq1rNoBU1tlOklsTNLcNglNUG0cUiGz2wN233J27jcNOVF
         8cEi+YjmKgLU9g810fpZfl3uc2BeolJAbdrN4xP4+VAvb+Ro+DBGXmWy3PNHQmMwDvIy
         5/hI9R5rVUrUZMBtpsCeblqcaE2/SmwsRWYn/T2ugNlseUH7INH5h7RU8ivMJl1l8iky
         SKDg==
X-Forwarded-Encrypted: i=1; AJvYcCVYGt7p4NE1deQrdiLD3W7cbgMrV1GztkQby68kO1wApP6MpwIuiCcT5HOtnwnPbuUL9BjaC4qAKEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSsXCUedGYUnyJeKYfMtHwngeJb+z48wqxkDcIW6qwx3fzYYOu
	oKubOjd9lPw/vHKJLjxyDmh42DQ5X3v+03FiVWi1/JUWX2jB/0eEX4FXcA9t
X-Gm-Gg: ASbGncu0cOqM7qJzwEU9F/DjvweGzaSoi/3oXXBEA31fTmQjPVBjNeD9pjGoY4WNf9C
	OZF1a8oaZtGw6GrDtYLm3Xf/4h0ZojNZpKHYZ7E9CV5tXWQ0glvQvDsX/AEmrAZyD1VIsfQ8kIG
	uQQBNitdFOMYjH+1KY5lICL5E3PexyfCBOc0a3MZ2mZAJ3Wb3tpSHnAVxAYvEBzmO3RH+Dd5YDq
	rzMw+971ilsXlYxF+EvyX1N4s0zBLoC3CjSFYcHbVLLeGlfSVgLpfmcN+1ke0gZelvtzbiMSiAK
	wLH/J94G5DvEMZdDyDs=
X-Google-Smtp-Source: AGHT+IHE08RpPpToMG+ph29Zue/RznyWTNh8CH7TIn/yK+cOU7lYQm5DC39K00atX3ZPv7Jv/5zikw==
X-Received: by 2002:a05:6102:304f:b0:4b1:3409:93dd with SMTP id ada2fe7eead31-4b2ae84df51mr1397992137.18.1734517948658;
        Wed, 18 Dec 2024 02:32:28 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-860ab7167a3sm1513737241.33.2024.12.18.02.32.28
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 02:32:28 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4afefc876c6so1772775137.2
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 02:32:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXiRpwBLUn1Zowc8pjo0oDCQd0KeAsOZmHyt3uIcBRSHXrKekUeIhnlu5zNLgSEp/X5h4yBjdNnhvg=@vger.kernel.org
X-Received: by 2002:a05:6102:941:b0:4b2:5c72:cd55 with SMTP id
 ada2fe7eead31-4b2ae705cc0mr1527619137.5.1734517947926; Wed, 18 Dec 2024
 02:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217114226.1223724-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241217114226.1223724-2-u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Dec 2024 11:32:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVzyq6L+9iNhtSdGpAJOKyu2vkzvveHXt0in9xUhD6mLQ@mail.gmail.com>
Message-ID: <CAMuHMdVzyq6L+9iNhtSdGpAJOKyu2vkzvveHXt0in9xUhD6mLQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spidev: Align ordering of spidev_spi_ids[] and spidev_dt_ids[]
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Tue, Dec 17, 2024 at 12:42=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> There is a 1:1 correspondance between the list of spi device-ids and the
> devicetree compatibles. The latter is ordered alphabetically by vendor
> and device. To simplify keeping the two lists in sync, mention the
> vendor in a comment for the spi device-ids and order alphabetically,
> too.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Thanks for your patch!

> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -698,20 +698,24 @@ static const struct class spidev_class =3D {
>         .name =3D "spidev",
>  };
>
> +/*
> + * The spi device ids are expected to match the device names of the
> + * spidev_dt_ids array below. Both arrays are kept in the same ordering.
> + */
>  static const struct spi_device_id spidev_spi_ids[] =3D {
> -       { .name =3D "bh2228fv" },
> -       { .name =3D "dh2228fv" },
> -       { .name =3D "jg10309-01" },
> -       { .name =3D "ltc2488" },
> -       { .name =3D "sx1301" },
> -       { .name =3D "bk4" },
> -       { .name =3D "bk4-spi" },
> -       { .name =3D "dhcom-board" },
> -       { .name =3D "m53cpld" },
> -       { .name =3D "spi-petra" },
> -       { .name =3D "spi-authenta" },
> -       { .name =3D "em3581" },
> -       { .name =3D "si3210" },
> +       { .name =3D /* cisco */ "spi-petra" },

Pity we can't use

     { .name =3D strchr("cisco,spi-petra", ',') + 1 },

else we could do some macros on top to keep the tables in sync...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


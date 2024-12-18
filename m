Return-Path: <linux-spi+bounces-6114-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADD29F6DBD
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 20:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C61163A68
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 19:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA47C1FBC96;
	Wed, 18 Dec 2024 19:03:01 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602021FA828
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734548581; cv=none; b=cRP8dsWoIsGIHQLi+mKn9hg74kZqOjJBHmpOxyPyfcgA1zLegLtGcnPLFNhbr3O97dpj0IFOujspiN2rGRnpWMqZLoydMAP/MevFKTUn1p9Du73y/kKYKWQkbSJrUe8vWB8KSHo7bX4HhzPEAJ49Yr6giHqqUqseLT05diipQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734548581; c=relaxed/simple;
	bh=a4P2aNpfqv+7lX+XfTZe1VWJtsAlRUg0jf7GskDakbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khdgIU7nKAI5hQcj/aSTkZoPpOAJnNfWwiGeBfzoQ23mmm/T38axYhcKs+paRh2vIVyXxC5mD2D+GkC+dxaV1sGjzpQl7/y4KhG1G9YALvESuVgg08mpmW/lnSLbRGJoAS4p/d+nwBjz25GSMbs8n4+gs2fEMCyQV4k2srAuTYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467a63f5d1cso54688931cf.0
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 11:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734548577; x=1735153377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNd34XU8aNLDZlxIJv9iaXP4x5EO2XO48cl6rZwdKwU=;
        b=wMAT5j6txWO+2iuo3zl/viciui3ALLfy4pYn8Wc1I4wZIHpn1aIu4Uff5iraw/W4Cs
         4on8H6jX8+Q7aqa0Mmf0S/YipRgmNaAnT5qsJmIE+/8J0DAvedDpBzxL/htE/0V0gh1G
         MiXFcSIiHS3vKujfRBc7+IDX3ZGJ058iSCDyLhF/VS2tJHtLM6dUjxVI+30yk3jJLVa6
         6MgfeALyyD3SNYKfIpO10hNvHLcSIs6+0kJhzf9BIdNJoJ+lnS1WZF7h5hDmcrbSGfWP
         9l0+14ycIz8hubRgknkHWa73oYeUX5c+4SvUoFsej7N0qFBw/BBiUBNOckY50LyQjvTW
         ORBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpE/ukWfXqU9ERUQ8+8YfoEgKiA+0Eqr7/6g4hRJ/HDSNMQE3LjySF/ZtO77e4sH5E1Rrtd2NifKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPi6RQ04xfDcsvqptG0wRDAB8ad/4iqYhWku7B9d56/l8UkWmc
	qmCbRQm07cJFloUJsWzWE9iQHb0ZTHxDlxlpf9022BezZDv6FrxQZGMRfDrM
X-Gm-Gg: ASbGncs4hnW2FmkSFq4BHRJ23fxOFtdKplY+eIbKOuJTX6Nw9LVHXuozfzLdaKjryzS
	5jCXL4As9RrLYZQzgj2/iFFwl+aA18mxnJj2LLXn0RbRw68oZSMJIjw6BuWbtMd4zSgkUweWeNo
	bJLd4zm024EIPxK0GbV4oDb+Fp7f5f6YtG/ye3ZO6z2UmtVOe4WOVUpOBVmWrAvRquJ08ITh1mb
	MNwnYn9DP+bNDaYzMjxblHRsRoSECdrRtBe6AeM0PYHjf/GKrXjm9FC1Ia1Gtq/wX0303BBwkN4
	AfeixhQPUv6A1Ge5ViftDTc=
X-Google-Smtp-Source: AGHT+IGKws/6xZNECnbvG5J3MGqIKA1O1UVEPFJdzStBmRm7E5rlrkaiwyRwIbL6RJXQeU6ghJpX/w==
X-Received: by 2002:a05:6214:3019:b0:6d8:a48e:a027 with SMTP id 6a1803df08f44-6dd14b77a88mr14996586d6.2.1734548577521;
        Wed, 18 Dec 2024 11:02:57 -0800 (PST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd257bf7sm53333646d6.47.2024.12.18.11.02.57
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 11:02:57 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b1601e853eso524362985a.2
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 11:02:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXE3LMv0PY3RxfZ5UBrIhqG2m+BegRFFLz2GGYfh+Z6UjDjWgr7xSQOxp8gx8oBB8a4L0dFP0zXDEI=@vger.kernel.org
X-Received: by 2002:a05:620a:24c3:b0:7b7:5d6:37fa with SMTP id
 af79cd13be357-7b9aa9b5a10mr61152385a.41.1734548576963; Wed, 18 Dec 2024
 11:02:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217114226.1223724-2-u.kleine-koenig@baylibre.com>
 <CAMuHMdVzyq6L+9iNhtSdGpAJOKyu2vkzvveHXt0in9xUhD6mLQ@mail.gmail.com> <tk6wlbylk7aqfd3sys2jitpnbdz4xomdg2yr7hsppxyptgbek5@3vtvajq7krun>
In-Reply-To: <tk6wlbylk7aqfd3sys2jitpnbdz4xomdg2yr7hsppxyptgbek5@3vtvajq7krun>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Dec 2024 20:02:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0FjXBgFLUxxvQeODPsU8xf+LAdQCg4xpAn_omJeA9WQ@mail.gmail.com>
Message-ID: <CAMuHMdU0FjXBgFLUxxvQeODPsU8xf+LAdQCg4xpAn_omJeA9WQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spidev: Align ordering of spidev_spi_ids[] and spidev_dt_ids[]
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Wed, Dec 18, 2024 at 6:17=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Wed, Dec 18, 2024 at 11:32:16AM +0100, Geert Uytterhoeven wrote:
> > On Tue, Dec 17, 2024 at 12:42=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > > There is a 1:1 correspondance between the list of spi device-ids and =
the
> > > devicetree compatibles. The latter is ordered alphabetically by vendo=
r
> > > and device. To simplify keeping the two lists in sync, mention the
> > > vendor in a comment for the spi device-ids and order alphabetically,
> > > too.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/spi/spidev.c
> > > +++ b/drivers/spi/spidev.c
> > > @@ -698,20 +698,24 @@ static const struct class spidev_class =3D {
> > >         .name =3D "spidev",
> > >  };
> > >
> > > +/*
> > > + * The spi device ids are expected to match the device names of the
> > > + * spidev_dt_ids array below. Both arrays are kept in the same order=
ing.
> > > + */
> > >  static const struct spi_device_id spidev_spi_ids[] =3D {
> > > -       { .name =3D "bh2228fv" },
> > > -       { .name =3D "dh2228fv" },
> > > -       { .name =3D "jg10309-01" },
> > > -       { .name =3D "ltc2488" },
> > > -       { .name =3D "sx1301" },
> > > -       { .name =3D "bk4" },
> > > -       { .name =3D "bk4-spi" },
> > > -       { .name =3D "dhcom-board" },
> > > -       { .name =3D "m53cpld" },
> > > -       { .name =3D "spi-petra" },
> > > -       { .name =3D "spi-authenta" },
> > > -       { .name =3D "em3581" },
> > > -       { .name =3D "si3210" },
> > > +       { .name =3D /* cisco */ "spi-petra" },
> >
> > Pity we can't use
> >
> >      { .name =3D strchr("cisco,spi-petra", ',') + 1 },
>
> My suggestion is nice enough IMHO.

Sure.

> > else we could do some macros on top to keep the tables in sync...
>
> I thought about that already before sending this patch. The best one I
> came up with is:
>
> static const struct spi_device_id spidev_spi_ids[] =3D {
> #define DEVICE(vendor, devname) { .name =3D devname },
> #include "spidevices.c"
> #undef DEVICE
>         {}
> };
> MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
>
> static const struct of_device_id spidev_dt_ids[] =3D {
> #define DEVICE(vendor, devname) { .compatible =3D vendor "," devname, .da=
ta =3D &spidev_of_check },
> #include "spidevices.c"
> #undef DEVICE
>         {}
> };
> MODULE_DEVICE_TABLE(of, spidev_dt_ids);
>
> where spidevices.c looks as follows:
>
>         DEVICE("cisco", "spi-petra")
>         DEVICE("dh", "dhcom-board")
>         DEVICE("elgin", "jg10309-01")
>         DEVICE("lineartechnology", "ltc2488")
>         DEVICE("lwn", "bk4")
>         DEVICE("menlo", "m53cpld")
>         DEVICE("micron", "spi-authenta")
>         DEVICE("rohm", "bh2228fv")
>         DEVICE("rohm", "dh2228fv")
>         DEVICE("semtech", "sx1301")
>         DEVICE("silabs", "em3581")
>         DEVICE("silabs", "si3210")
>
> I didn't like that enough to propose it.

Indeed, splitting vendor and device names hurts grepability.

Further improvements could be:
  - Generate spidev_spi_ids[] from spidev_dt_ids[] at runtime
    during module_init() (consumes cycles :-(,
  - Teach the subsystem matching code to strip the vendor prefix,
    to get rid of spidev_spi_ids[].

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


Return-Path: <linux-spi+bounces-7233-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D47A69805
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 19:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3048A7104
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 18:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1661F099A;
	Wed, 19 Mar 2025 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMfRN337"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F21DA60D;
	Wed, 19 Mar 2025 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408818; cv=none; b=HDFBoTaWRQB9F5oFwr9gmx+xdzKkvwH6EPMZoM1/Uvh943JBCED5Zu4pdGqyI32Wr9q4UrpBNjJ2KVDPro2gm+sNDCpY6hQfEISEqsR9NTYCx1lsu0jbyvPZmMvKNtduMN0UWTl+sY1hr68Y5rM1GqAdxYhUfHGniqDA6g3J9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408818; c=relaxed/simple;
	bh=c8KJbqyFeOXT1W0A8M6QD8rxISSyoKopzevMnMHTX4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABkjuLjskdG4HjfL4/svC4UDVUhnRLv7KOIWGl/gM7WOmcOyeg+6HuK34Kttid6PGGvcNbk7v+ccyqHz9haXhpwSUo+rWnynQDuVADZLfYiUJR49F3vYi1Smm0iPW+59gh/H0+7u5Y6LIMg3GykswP+BVyrBgpJUqqxC1lTdaHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMfRN337; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so49248055e9.1;
        Wed, 19 Mar 2025 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742408815; x=1743013615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lhykt64jTkBM3zw9HlR0nEGp0CgKH+Gr/6bGbuJ3YG4=;
        b=LMfRN337NliNo2kUTTnNdBeUU14nsuwo9qhyKWjDMqDbZaU4BYiflKihHsYuIk85EE
         5ZWDCDLSAza00u1Y5arohkJxWh6R+o/uk55b1xQ3eMPE0eKHSu8KB6jgJSjZOMoNgU0D
         j7Dep3ZUCcfYUSLIW6jgK/wmu4J+ppThD17H5Vroz56W8pZ79yd7ZXD44sQ1SV8kZkgO
         KOSVJzFvSuE4ceUS4HPkJS2jCHk/juzNQsd1UrVuzYGhNU8b1f5JcXdVCRYJ9tXyvIH3
         SxjT4RvI6UfKL3ISuNWQ5dsFTSJU4r28hPRx/DbebaFgQCzfnAVN0HyhyjeIZwLzLgve
         +tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742408815; x=1743013615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhykt64jTkBM3zw9HlR0nEGp0CgKH+Gr/6bGbuJ3YG4=;
        b=gfzAgTPM7MXI7hrWFiO4n3GYKh+LJqlElgqoHIZYXP+475EHv9CxgAWvhCSWanch5t
         vBrphAUAo7E0ojO5fuKxbca3UBYq+yvbTeJxQUQgjlIQA43iqeEbAcycHQbzkIbYynNB
         nQnX8eHhGbCAUmykz+ngvAjjWSB9lyrGaj6t5/zptY6DDrWChvVvQWCCe2YTXE/yYsBB
         F8HIq6NDNhji0cnekRKkp8RqlUbgP0ejzwaTRuroHx4D3SzgHaXoBTbPOIE84GvN04PU
         YjIIwjO+Ykiy9hR7WHJ0MJP+q1aKWOQj4zgWEKHs7owCFqeX5c2gDULKpyuTCh2xyr4F
         MhVg==
X-Forwarded-Encrypted: i=1; AJvYcCWOVUU7qZpc0WB9zTC0W3oXOIdX70Ejo9ZHP02TOUBAiAUDY5BfEQo/DadaDe+X/FAkmiWkC9fu09DP@vger.kernel.org, AJvYcCWzFsHdn71jgOYklDzLWBGLSahF0mp/NmmKh8M0MdRs9E0btAAYnl8ydkdslRhoi1TmEz3H4Z+GGilhWu8=@vger.kernel.org, AJvYcCXPQ3oWpneh5zle3ZC6VyzHsfUgf+0Ww/i1KxmmrAUPnfJRw9c0oDcAY4ttiRZSJ+jBDZvVVfEWXKJ6YE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJD5Yi0ylebJHDFOF4U8LjcoSsDLZLj/oV9G5Iq9AbuwH/77+o
	ydMvcvbFKmehbOyo2CW16m1KBpizH1jGx19ytTExBgQg09I1oOFm
X-Gm-Gg: ASbGncu1sqbfrw8KCHlTbKqKaPTPT8OR9/IBZNFUA+4n4BE8yxRqL0l0Z3211YsVGle
	Pc2oqvVR1StgMG0/iXp/NLBSl3+7ngPsiGHh7jpzZYU10ZQyJ5Mv3DrM9voDffE7JsvKhUaGHyD
	J88kiQwEbM8FkLq/Aut3jLMHE94EinIYu+Gtd1/vkR1vGX1/W32wwu4KAUDc2c/uB5KdYzTJkst
	x3Qs0CaMmoxvGByYzNqolS/SvApYkoEA0VQl2j0hRufdlWxU7kgjDxbq19vYn5HZwt6anDXcmFe
	Rilxynk2Yy+5G8Zli6TlIxzgp/V3ezfddPFs6ZWuaGrltGl7QT8GsT7rMEYjOpOLmHprchJCJdw
	C7qBvpLF8kk+WU59LIU9WsrwbQnb7eDw=
X-Google-Smtp-Source: AGHT+IE5djeXIfkhhx/3/CZ7BtZ4I/Qfy9MihH/y+m8mB9v6onJocrLIBYe97asPjAw8ioCIfm3tPQ==
X-Received: by 2002:a5d:5889:0:b0:391:1213:9475 with SMTP id ffacd0b85a97d-399739c871fmr3389404f8f.24.1742408815046;
        Wed, 19 Mar 2025 11:26:55 -0700 (PDT)
Received: from orome (p200300e41f3a9f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3a:9f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df344dsm22271780f8f.10.2025.03.19.11.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:26:54 -0700 (PDT)
Date: Wed, 19 Mar 2025 19:26:52 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Arnd Bergmann <arnd@arndb.de>, jonathanh@nvidia.com, 
	skomatineni@nvidia.com, Mark Brown <broonie@debian.org>, 
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, noodles@earth.li, Jarkko Sakkinen <jarkko@kernel.org>, 
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <5doq6itaz6uicvqcn37q2dkaxyzy3etz5qgv6wlsyd5troqlag@yqs6ltjp3gsz>
References: <20250318-cuddly-translucent-teal-e2ac2d@leitao>
 <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
 <20250318-furry-piquant-orca-da28c2@leitao>
 <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
 <20250318-boisterous-adorable-chowchow-cea03b@leitao>
 <20250318-psychedelic-thundering-guppy-22bba2@leitao>
 <b3da27ce-161b-4462-a608-c36f4b0696ce@app.fastmail.com>
 <fbeca9fd-38a6-49ba-bb5f-6df5302d139d@sirena.org.uk>
 <6cf8af69-634e-40fa-af45-912540b29aac@app.fastmail.com>
 <20250319-aloof-rottweiler-of-perception-4c1ad4@leitao>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xdslpcvgl4x5phod"
Content-Disposition: inline
In-Reply-To: <20250319-aloof-rottweiler-of-perception-4c1ad4@leitao>


--xdslpcvgl4x5phod
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
MIME-Version: 1.0

On Wed, Mar 19, 2025 at 03:09:57AM -0700, Breno Leitao wrote:
> Hello Arnd, Thierry, Jonathan, Sowjanya,
>=20
> On Tue, Mar 18, 2025 at 09:07:28PM +0100, Arnd Bergmann wrote:
> > On Tue, Mar 18, 2025, at 20:13, Mark Brown wrote:
> > > On Tue, Mar 18, 2025 at 08:00:05PM +0100, Arnd Bergmann wrote:
> > >
> > >> That does sound like the easiest answer: if the spi controller driver
> > >> knows that it needs a reset but there is no reset controller, shutti=
ng
> > >> itself down and removing its child devices seems like the least
> > >> offensive action.
> > >
> > > In that case it's probably more just refuse to probe in the first case
> > > without the reset controller.  Given that the device isn't working at
> > > all it seems like the hardware description is broken anyway...
> >=20
> > Right, I see now that it's doing a rather silly
> >=20
> >        if (device_reset(tqspi->dev) < 0)
> >                dev_warn_once(tqspi->dev, "device reset failed\n");
> >=20
> > after which it just continues instead of propagating returning
> > the error from the probe function.=20
>=20
> This would be another option, and I would be happy to update this patch
> with this suggestion.
>=20
> This patch was attempting to address the issue the other way around,
> where I was expecting that the reset methods are optional, thus
> marking the device_reset() function as optional.
>=20
> It appears that on certain UEFI machine types, the ACPI firmware doesn't
> implement the _RST methods, and device_reset() will *always* fail. It's
> unclear whether this is due to a broken ACPI table or if it was
> intentionally designed this way.
>=20
> Tagging the driver maintainer (Thierry, Jonathan, Sowjanya) who might
> have a better understanding of the design in such cases.

Can you specify what device this is and what software you've been
running (including firmware, L4T release, etc.)? I can try to find out
if this is a known issue, or if it's even intended to be this way.

> > This is also broken when
> > the reset controller driver has not been loaded yet and it
> > should do an -EPROBE_DEFER.
> >=20
> > In case of a broken ACPI table, this would simply fail the
> > probe() with an error, which seems like a sensible behavior.
>=20
> Do we agree that the device reset methods MUST always exist (on both DT
> and UEFI hosts)?
>=20
> Anyway, from my naive view, we should:
>=20
> 1) Mark as required, and fail the probe,  if this device_reset() must
>    have available methods. (Arnd's suggestion)
>=20
> 2) Mark device_reset as optional if device reset is optional (as the
>    current situation suggest). =20
>=20
>    a) If the requirements are different for DT and UEFI, then should we=
=20
>       create a "device_reset_optional_on_acpi_but_not_DT()" helper to
>       handle such cases(!?)

I'm not very familiar with the ACPI side of things, but my recollection
is that essentially ACPI talks to BPMP in the background, much the same
way that we do using the BPMP driver if booted with a DT. I wouldn't
expect there to be any functional differences, so the lack of _RST for
this controller seems strange.

Again, if you can provide a bit more information about the set up, I can
try to find out more.

Thanks,
Thierry

--xdslpcvgl4x5phod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfbDGgACgkQ3SOs138+
s6FCuw/+NrSBnVKcOJalwt+lfgUb0j/Kfwgp6ctoxRdhshHwdVI10hh522B5bysT
6aEx+vczVSnQYW6/PIhbHHLXiRnzE6WHW6I/PkxYyDEo7Qva7ODrmGPrBQhW/Do5
UGw13+uoYQbG85feknSBLMtz3o5uYZGZkWqWWoETU24LF9M41W4C/UIizdHyYCl1
CeqYrD9AM4K8jrvuJQZhATfXbEwZge5ihyU6bMbewEQVTFDrvit8LtyYJVCYW8v/
G9EaeqWTmqywBZX2ugzSVLBU/9KekTx0sH9ddZ9AKg/j9ZM2xVZz0M7oWh+4ap+p
BT9JOhBN6ZuqYjN88yw8DvJ3P/K6CrF+n4yF6nZbJ0X4fbHeCDFMrpluOCrgw7vA
zoSdQRGfDdauVHa/YGer9LqDnUESMTqdCPnS8hsi0fIBBr5yhVGyf1yEZhBC0f4f
RvDFy47C+9wHu66d81TzGpLXcdfdCH2mXQGmkQTU9LAhdGe7Pvzoo4yMJq+E3ujr
6Vbj7VWoVFVhZymOAEPqehwqLrzYI0rjBPvqmvgmUtD255BOKSVDkc5pHX4G7WbH
XsKfHd7CbdpHYQRbKAMA5zBFzW0GatGIz66wISZg19NhYC/BpcJFoxJSfdgjGgMY
PfSN8E/DwebH90KPvdEcZ2nZmC241QJjeRomMMed/oQRZ0S/3n0=
=Aoq/
-----END PGP SIGNATURE-----

--xdslpcvgl4x5phod--


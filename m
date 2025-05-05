Return-Path: <linux-spi+bounces-7879-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A86AA8B15
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 04:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233AB3A5D38
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 02:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5021714C6;
	Mon,  5 May 2025 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jn5pkhgF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD728EC;
	Mon,  5 May 2025 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746411074; cv=none; b=OPFWVfdHiaqEaev5VyusfS2AFV0eICYTJJhl5p4hDID4C8D5osdCQj6gQdfkB4+r2J+nmBg2aCqyqvnO4Ynw2pWV3pp2s2DuEfOL3902FrjoTWFq4TtONEzGovrSivivtx46+3WvrHDFTyHOR2ye0tfBUGFktbraNyZ6y44UgJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746411074; c=relaxed/simple;
	bh=kaVa0+0jmdVEQ9iQi0G7nb1ryjIAg58pD+onw5iRXO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHQ5ovBFMfoeIRjb3dspRNUSopgrZjWYRILWNU3rGDk0NsBM9WkvO5ECT6H59RJYto/jaCpZrWfE8ACs66lB9udRyFOG+W9HDqywFCxyce8k0LiUgULxjKMH1EaOJPaM9hf1sulW9FqE1+R84bHXC5rjwBsXKahroGOF2pGvmzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jn5pkhgF; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54e816aeca6so4883119e87.2;
        Sun, 04 May 2025 19:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746411071; x=1747015871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bui1DmvKzNelJxPJh4uEj6L44YLQiE/cbpdtnye8WZI=;
        b=jn5pkhgFxOrbb9LSNgHTFO78SurnF/8kyp8W7fzIyCxANiRWGNi8PUY5uteB4h4+6b
         8eInBHIav8eZkDRIH+a3UMF3zKDwCimL2Jp5oVb+/aazwDZIAol7/ZVxt+NxPt5ZynVP
         hwniATtP7bb8LJ9UUe4naQcIfcHZ3sOyz1tHOiw3nRQbU3Lb2uS73e2uH/POJS2teiC6
         3EoklCUo0TUk7gDs5GoYtuTV7/2tcFoTFzBXEG37Aib7gyV3mZsAjXpgdNctzQ+758Hr
         0r5mfVOUDZvAsmEqSU4BWGlTZ0Z9APdCGhSuQ5OD4CwC5xcz9YCqf+SddMaEJThVZga3
         vp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746411071; x=1747015871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bui1DmvKzNelJxPJh4uEj6L44YLQiE/cbpdtnye8WZI=;
        b=aCxzVqW7ixsZEwolDJhDfVUwlcs6HsPPZKIHXIz8W71b0xumw/ZO6gq/T8VqnIqb/L
         +13IrpFoOVny7LbZW3RKFh3AMk5NrG0Kiun+IfGcR35NQvE5RiJCwZKDwA+hhRxp+CAP
         pF/Hu8ytsMPZIe0olZnY1fl1ihiAWzIoUZvVpLVqwYLFchC5iXDvJbsYX/XAUbbsGr2T
         R3gc86cbe4bX7VC8Yw3jAy87SuxDvQLdoRCzlYEBn2qpwIT2az64gDi3fyDXcknvp1d8
         staM6XXT7yHECmuUDgwIaaXvi1kcXq+sK1hZwT2Bh43db8Jab8yTER9JdPPoB9Z4arTZ
         c7Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVY+S/NVRsithlrayBv/uAFqvcQ0rm+S6lrQHCbss+ZbeG5jgGOC8Myz7lfT9GjW6bR7DuO9bpAZCXo@vger.kernel.org, AJvYcCVs4eHLfDF8NMB1t+9e1/eP7ntuijwNFiSrdQapp/nRZ1s0K3GDyh9POmJkMoHntQcfr8gODw29dcILdxA=@vger.kernel.org, AJvYcCWaeLssP+EViDVWNaced1fmJnhsxX+cFsYcUe2QfTYHBNy0KaMyfLLx+0NbnSPfa4ialX2Ljt555VFAJqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmkQz3bc8sSsqJigI4HWJ9keDlmVK7bK3mNTJrwzVmold9phWm
	2iNn3uQVQljMUFCKfnKJMGWmtRNUoAYxWwDDq324hhjXerZsI0EhgDgcTdRoh0Jr4K/fx8w+/DP
	5d+Gkk9YIWIDkTOav+rXcPGtVRbg=
X-Gm-Gg: ASbGncso6weuyt1B2YUOA1/AclSPDZeSVJ2GEaXr0jUbpwtsH5iTlkLPFHaUusoe81Q
	ZQf/CL8ArVTV3TzWwH7UP0vC7FJXy7evQGquW4+nBQUz2J6LGIBywd90WhP3AoChMqaCXsHTpBg
	KvpXmejja6CCkmnwWVfCr3HA==
X-Google-Smtp-Source: AGHT+IGddcgL980DNS0oAgQz0dnJ2Yu7+FSs56R3Jf4UGASK7x3+jZMSA8ZLQf2vFlTIhwuiy5S6rLmnNsJ9Opz51dw=
X-Received: by 2002:a05:6512:2313:b0:54e:85c8:ab75 with SMTP id
 2adb3069b0e04-54eb2466e9dmr1688591e87.44.1746411070773; Sun, 04 May 2025
 19:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aBdOMUhuUqbZm9w1@Red> <aBfsJpId0Jrcz228@finisterre.sirena.org.uk>
In-Reply-To: <aBfsJpId0Jrcz228@finisterre.sirena.org.uk>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sun, 4 May 2025 21:10:59 -0500
X-Gm-Features: ATxdqUFenVAKyQ7kX30yHVtcs6y9neQX9nE2c70USztaOFqi9CiEakuDLUvon90
Message-ID: <CALHNRZ-At4WmJXoNs_x0XD=bRTRsKMBm1qOQGkFcNOvFfVDaMw@mail.gmail.com>
Subject: Re: [regression] jetson-tk1: spi do not probe anymore
To: Mark Brown <broonie@kernel.org>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>, ldewangan@nvidia.com, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, linux-spi@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 5:37=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Sun, May 04, 2025 at 01:23:29PM +0200, Corentin Labbe wrote:
>
> > On my jetson-tk1, SPI do not probe anymore:
> > [    1.330681] spi spi1.0: Invalid delay unit 2, should be SPI_DELAY_UN=
IT_SCK
> > [    1.335185] spi-tegra114 7000da00.spi: can't setup spi1.0, status -2=
2
> > [    1.341643] spi_master spi1: spi_device register error /spi@7000da00=
/flash@0
> > [    1.348637] spi_master spi1: Failed to create SPI device for /spi@70=
00da00/flash@0
> > I tested 6.14.7
> > The SPI probed perfectly in 4.17.14
>
> That's a pretty big jump in versions...
>
> > I tried to debug a bit, and the driver requires units to be SPI_DELAY_U=
NIT_SCK, but it seems there is no way to set it.
> > Removing the "return -EINVAL" in tegra_spi_set_hw_cs_timing() lead to a=
 successfull probe and the flash device appear.
> > But I agree, it is not a correct fix:)
> >
> > Since only the test made it fail, I think the driver is bad since commi=
t 810593668468 ("spi: tegra114: change format for `spi_set_cs_timing()` fun=
ction")
>
> Adding Alexandru who wrote that commit.  Assuming the delays came from
> DT (I'm not actually finding them, I didn't look too hard though) and
> are therefore in units of wall clock time I think we need to add a
> conversion helper for the units which the driver can use to convert to
> whatever units it actually wants to use, we do need to accept units of
> wall clock time given the generic binding there.  That gets a bit
> annoying if the bus speed changes, though that's quite infrequent in
> practice.

This should be fixed by a patch [0] which was recently picked up. I
saw the same issue on a tegra 210 device and submitted that to fix it.
Can you verify if it fixes this case too?

Sincerely,
Aaron

[0] https://lore.kernel.org/all/20250423-spi-tegra114-v1-1-2d608bcc12f9@gma=
il.com/


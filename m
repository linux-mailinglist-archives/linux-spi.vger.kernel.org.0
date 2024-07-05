Return-Path: <linux-spi+bounces-3759-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B479284E3
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 11:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B29ECB245E9
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1213145B1B;
	Fri,  5 Jul 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRQR5UUS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE613665A
	for <linux-spi@vger.kernel.org>; Fri,  5 Jul 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170826; cv=none; b=Whu2XH60jPCpm0wy0RS+h9KgOCLNtLBYYezg1smJE/aOKmYeuf5PE2sTZudaWc1tNaWQ84XUNmdThFt+jA4hoKMQJKFlWwGgV6xUTS9Tf7BWyAenf5/0KJj0UQBSkqn2HCRzlasNqWp7uJS9fWsBgMY1DUzzmQP4vzYOBSvYAFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170826; c=relaxed/simple;
	bh=oRE5MJRKoGxUR2bV5Odak0vAmsjjOPDpFPoP9Pnu200=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MGt8S18+ZtXrEadopjIKSXg47k8QeWdW50uTeWk+2V+8EYCcOTWihbXwMhM/By2qt9rWSk7SIj+ey2kRDrdZuC17hF9646bGLEoLluhEOEMeiAWFC78I3bS/XxyBDwgGkNOQnjL3AEeJjMLF7mcMEfpuFBwnh0wE6kAyClJP6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRQR5UUS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso1828670a12.2
        for <linux-spi@vger.kernel.org>; Fri, 05 Jul 2024 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720170823; x=1720775623; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sqju7EaSVY933l0wIyJIs+JZcPRGjVvJmv+G76QYauA=;
        b=HRQR5UUSzaBP4npE1RceXdF1EmHKazSt9hSCqI5yTD220SpvoAvDp2gmNIpvZZqKy/
         oBVZssDtP278+Cl2fiImPWDk2c/mPY76ziZTCDEfig2//EUDLtKdxCnc1yVGCKWJtmM0
         IoUatqSKnn3bM7daXsSZXiE2iZ7upfSx5bOoNYHKp280R8wDhXSQnh9sQH7/OkdRXly/
         sNDmX0u2pgVTS+3UK1qTOUOP7S0t3MRmf43JA7q4oQeBPFcVnLnAy0hehNmYOT6qEZzs
         TFHy6G+ZmQEFiDqMGV7gFrQ+oKUW+m4ngpsqkY0/KvqR+apDV4uCSrCXh2pZauK/UB4P
         388A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720170823; x=1720775623;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sqju7EaSVY933l0wIyJIs+JZcPRGjVvJmv+G76QYauA=;
        b=g2Dv8PyblG5lQmIdXhM+aslyp8/uolR4EzdTbTE30xKMWA9mRoYSTXUJsgLVbYuMbC
         yil7OCFur0C+hPy+6yIyNWQ2nYSAjQ5WW4dyXYrFUn5PTtCfvtT7TpE+1Z1UTz3Rrb2H
         U7VP1cDF3LDfV/Cr8D5hdH0g53OFOh+s8Noa1EIkGLoklbtthpcpUmQ5ml8Cpqn2Eu0m
         RPgShj+xWJyxvzIajcjOTwckP0WtnL1a5Ve6J7AcsXi3u/ODuvlK+CvAOJP+gutIIH34
         IOWD6pfL5717Vi6r8/iX0sTz2cBb2S6aQSbC4qwqvZtw2MypoX/nZ3E+UMd//vhtxpkL
         xJZw==
X-Forwarded-Encrypted: i=1; AJvYcCXO92wljuJoVc7HXHv232omS5vNQf2eD3LmV+fgXylWfc5dpHxXmQc+9UlVb7XO798xuODo1CM8SICA4pRB+heoFGmN4BMT4Ivl
X-Gm-Message-State: AOJu0YwqxKaqh5x5is8KsT6ZSnbSXbIQRM0eKrbwVZxl1D4a7HiSnrNy
	roocSlNrzcKGuT/0XbBKE6mOmlwhjg2cA7+hhkaFcayhBkoxhFcfO0oQvTsn
X-Google-Smtp-Source: AGHT+IFnY48J7Cp/5Qxb3xNBFudY+JUJX35DJY+cVOZ6ONebg7AHBVzz74rrd/mtZzRQ6zkv0hmkIg==
X-Received: by 2002:a05:6402:2788:b0:582:8078:b44a with SMTP id 4fb4d7f45d1cf-58e5629553dmr2800288a12.0.1720170822987;
        Fri, 05 Jul 2024 02:13:42 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324feb7sm9536199a12.37.2024.07.05.02.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:13:42 -0700 (PDT)
Message-ID: <dc0d875c35913c6d718de3b2f77b2539d63e862d.camel@gmail.com>
Subject: Re: [PATCH 1/4] spi: xcomm: add gpiochip support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-spi@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>
Date: Fri, 05 Jul 2024 11:13:42 +0200
In-Reply-To: <5e72252f-09c6-44c8-9f69-a6f8228da980@sirena.org.uk>
References: <20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com>
	 <20240704-dev-spi-xcomm-gpiochip-v1-1-653db6fbef36@analog.com>
	 <3ca36d0d-581c-4e24-9466-fb30a3a22d71@sirena.org.uk>
	 <76970371e32a30b774fd6d12fc38e8355d950ca7.camel@gmail.com>
	 <5e72252f-09c6-44c8-9f69-a6f8228da980@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-04 at 16:45 +0100, Mark Brown wrote:
> On Thu, Jul 04, 2024 at 04:00:15PM +0200, Nuno S=C3=A1 wrote:
> > On Thu, 2024-07-04 at 14:53 +0100, Mark Brown wrote:
> > > On Thu, Jul 04, 2024 at 03:49:12PM +0200, Nuno Sa wrote:
> > >=20
> > > > +static int spi_xcomm_gpio_get_value(struct gpio_chip *chip, unsign=
ed int
> > > > offset)
> > > > +{
> > > > +	struct spi_xcomm *spi_xcomm =3D gpiochip_get_data(chip);
> > > > +
> > > > +	return spi_xcomm->gpio_val;
> > > > +}
>=20
> > > It seems like the hardware doesn't support input at all so should the=
re
> > > even be a get operation?=C2=A0 gpiolib appears to cope fine with omit=
ting it.
>=20
> > Just following recommendations :)
>=20
> > https://elixir.bootlin.com/linux/v6.10-rc6/source/include/linux/gpio/dr=
iver.h#L336
>=20
> That comment is for get_direction(), not get().

Oh right, sorry. For some reason I assumed get_direction()... Well, get() w=
as mainly
to not get an error when reading the GPIO value from userspace (eg:
/sys/clagg/gpio).=C2=A0

That said, we're just caching the value in the driver in case the i2c trans=
fer does
not fail so I guess yes, we can make this even simpler and remove get() and
'gpio_val'. Userspace apps can very well cache the value themselves.

- Nuno S=C3=A1

=20


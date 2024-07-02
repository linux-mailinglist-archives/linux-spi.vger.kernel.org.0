Return-Path: <linux-spi+bounces-3724-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7B9924229
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2024 17:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C750BB28AB2
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2024 15:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD9B1BBBDC;
	Tue,  2 Jul 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6snYiGe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE51BB69C;
	Tue,  2 Jul 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933483; cv=none; b=A8w+BVcTB7V1BopZbLct4UY+39JjekaGypxz/S+rHH61DjKv+RidDWsuSc6iLb0OXVjXB0MnE0wcqLKS8aGCKXoY+12RRqTzfOib9BMU0lbkee1duVW+rKPb2cb9C7j1gvja5iMwMZ/C8q6uP1vVAqrZk5TDnnRg6lqRRXO8cp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933483; c=relaxed/simple;
	bh=0TTPDgoTlftH5Xx9Yej6Fvq0f2C1Wrvm/WNEckwSl1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5N5p7V+/Qvt8c4CSwOyw6iq4oYitcEDNxd6NAVbzMQLDoJB5lRirmam24Cc4BRCTSTtcLYMrgorjpmMRrd/qTxsSiWAPM/hAWM5MApOUATof4s/aPUfF9C52faHeKB1e4MZcziQRrentOd+uFE8DdXwAmMj//vM2fro+abm8lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6snYiGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7741CC4AF07;
	Tue,  2 Jul 2024 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719933483;
	bh=0TTPDgoTlftH5Xx9Yej6Fvq0f2C1Wrvm/WNEckwSl1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y6snYiGeve5Jm3Ob/2+M+oOqaX3AR+gwf56AjTnwH3ADblqkTJ+TuP/Ta95UmHPK3
	 VZp3WIrCT3z3EhVQjPhbEJuBnXgL5Sfcf+78UwIClyiBViIByTWi+5r/K/5HBXgfxr
	 pR6quB7zBXTQuhVuYVmg91/L9CyWbMoJLwb9afE7YiLpR8iq6zCNbC2q9V1CnJLFsP
	 yVsmX+1UJZ0tB0wmE9Fm2/vUze3O/FvnjxfzB8Dpltupw7OR4FyArjHKgWzfzBp6My
	 DbI9UiKHc+z1c52nsE8+Tqwb48qBoy5Mwza0YCAd41//DOaHe+Ywom55dOXe8jzNoM
	 XL/hePPaz03ew==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ee7a1ad286so4391141fa.2;
        Tue, 02 Jul 2024 08:18:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyrmnVQ5cYHUHgLSwesVDFcug/ilBskPzzPc49CnjlY014qYETK4ko9mmNx2OeYtpdd55KPJzcgSOlPzvH9/B+TF9UOHPrTrvoir3lqg0Jspr0DLtjOdgtoh9WObuHueeWzuht0XorBNWgAMj2v59/DgQyDn0fqNVBMdDYWdOiErVzIQ==
X-Gm-Message-State: AOJu0YyJcnxsQhmtzp+Y6Ob0G8uMJtJm0Rrv69PTPpmrMVFGo8CbnuzZ
	6SXCgVuuuGXCUz7Vw+us5TF+WwWHmrV25s41hmjzOxMwIuU5rzE4M0IwkZNUMCXM4JrKH14cVBg
	WN3crlP8ZbosxTHnwOp8vnoe8pA==
X-Google-Smtp-Source: AGHT+IH0Yy1gkO6ZKfqNqogCDjZRVek+6RMQmG2JeWbBttUSQOmDTm3VP16BG9r2eRHRNTZ0qjfbPTNWdPI6mLcA83k=
X-Received: by 2002:a05:6512:ad2:b0:52c:df4e:3343 with SMTP id
 2adb3069b0e04-52e8266ee75mr5683563e87.16.1719933481802; Tue, 02 Jul 2024
 08:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>
 <20240628162847.GB3143032-robh@kernel.org> <61649bee-f7dc-452c-beb5-cc8ee2179b99@beagleboard.org>
In-Reply-To: <61649bee-f7dc-452c-beb5-cc8ee2179b99@beagleboard.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 2 Jul 2024 09:17:48 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+mxxStZLwUbk9An2pA+Uce+QFjDnnNTMb24m1iMg7B+A@mail.gmail.com>
Message-ID: <CAL_Jsq+mxxStZLwUbk9An2pA+Uce+QFjDnnNTMb24m1iMg7B+A@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] dt-bindings: connector: Add mikrobus-connector
To: Ayush Singh <ayush@beagleboard.org>
Cc: Mark Brown <broonie@kernel.org>, Vaishnav M A <vaishnav@beagleboard.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 9:14=E2=80=AFAM Ayush Singh <ayush@beagleboard.org> =
wrote:
>
> On 6/28/24 21:58, Rob Herring wrote:
>
> > On Thu, Jun 27, 2024 at 09:56:11PM +0530, Ayush Singh wrote:
> >> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
> >> developed by MikroElektronika for connecting add-on boards to
> >> microcontrollers or microprocessors.

[...]

> >> +  mikrobus-gpios:
> >> +    minItems: 1
> >> +    maxItems: 12
> >> +
> >> +  mikrobus-gpio-names:
> > The GPIO binding does not work this way as the name is in the property.
> > Either drop if you want to keep the array or you have to do something
> > like this:
> >
> > pwm-gpios
> > int-gpios
> > rx-gpios
> >
> > Really, the intention was for connectors to use gpio-map property to
> > renumber GPIOs relative to the connector.
>
> Can you point me to what you mean by gpio-map property?

It is defined in the DT specification.

Rob


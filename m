Return-Path: <linux-spi+bounces-2940-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2678C8D42
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 22:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112A01F23646
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 20:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A614C6E;
	Fri, 17 May 2024 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlL1C+Mt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E15C65C;
	Fri, 17 May 2024 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715977206; cv=none; b=e4jz0TxTqMFd54kWk9Q8TiR8HIiWCwJhx/oqG9sOX9JbaacBgIldbDKovFaEG6ebPuu4b2JZyApyr37E22g8w126/nXk3Ms9C766wRoJOyrZ5aGR0pLrNL7W2FB4cNDtOJa1AEA9riXrnO3yBs59mddFgzF6JqnDiegOveCTojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715977206; c=relaxed/simple;
	bh=BGwNRIISgQSkHmoJSBhmrJrk4vCNSWwuXR4DAyTef54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQZDnUdCDRTEslaNfZZbA1kRhRyAX1HSxus0tIjVHiR1AExU9RYaoSH9iL9vrY71cg+VodSisdxZmPufFh/gA6GOedhUue5i8rqR9Tseiwr7C7zjGLBD4oEhO6xbph5P2j9OCofx9Wt9uDVrFOIZe/JjDzaU807hiLp4hVe+9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlL1C+Mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EA8C32782;
	Fri, 17 May 2024 20:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715977206;
	bh=BGwNRIISgQSkHmoJSBhmrJrk4vCNSWwuXR4DAyTef54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MlL1C+Mt1DHtArvmks8rMrGPGlLmFUY6LrvweiQXmY1q7TdqQ+pxQNvPpeE+e28wW
	 /JiFz0xGlmi/XCpG5dy9HAPdmWCeLq0qKkEuyl2mExnrp3kw73ozfFw5QdP7+my/x4
	 8g0ZS+z7+wikeaYLkvKjVPS+xLLVdD+sZm4tpvnt5bx7K1V8IDsImagEiHExOe6Tni
	 uIqiPz1SArZ92Luxm+YzhsTYlM6tY+dlZFbX69FPKHLetgGzBae9sFkM+JenFQFJ2v
	 jcW/p3QtAZZSIMAKFFpipRuhzpEwIXJ0vFWDBGw9tLCKXH88mK02xjDoTyyNmNOyF0
	 R4GF6XI+YNWWw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e4939c5323so30491931fa.2;
        Fri, 17 May 2024 13:20:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNythbaiK2OPZJnVcqMVi6LI1zWB+DHb/2cUjb9k292hZIgFGMC0/lU+EiMvRExVkyzxAad4G4Qalqm9JOLCmeO58m9reIZ9kLRN6Rrpz7Sa9VEJggOFH/TZuoPlCoOHQlFn0NQl3hHBcOc/ddBCauv9uJ32149v2JY09QK9Bo+MsDlZesXW6MlnR4WKMu+RvZJGizPtLCbYsvjP9dvDy4QA==
X-Gm-Message-State: AOJu0YzZAnMO4ns1FTn5W0gPukIvANLeT8OOD3DroNCZWf1quc+us3pm
	UjxGcFBwt0yTLyVsVl2jPA6wtr0KAUct7Ixny0eoM22L8JGPvQ+lRnOSFIzh2AHGVI8K9+C3giQ
	8ZOrdBYmYtqRNzVP8fr7Jf9o7Bg==
X-Google-Smtp-Source: AGHT+IFk8AjiL1RWAIi95XurBPNyz5qdQJF8LP4PkZuThVdVGLwtwTKQfKkVOXDZgkpoqwIbIwtecqPeys5N59CT7Bo=
X-Received: by 2002:a2e:a54c:0:b0:2e2:9416:a63f with SMTP id
 38308e7fff4ca-2e5205ec6bamr234086661fa.53.1715977204296; Fri, 17 May 2024
 13:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517171103.221856-1-andriy.shevchenko@linux.intel.com>
 <e81d43f8-a3ba-41b4-a86f-af2d6943e917@sirena.org.uk> <Zke2yG-WPkaWg5PV@smile.fi.intel.com>
In-Reply-To: <Zke2yG-WPkaWg5PV@smile.fi.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 17 May 2024 15:19:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKA7AnY7w3sjrT+khrat348v7uNpAP1+FZ=mdYMhJkf3Q@mail.gmail.com>
Message-ID: <CAL_JsqKA7AnY7w3sjrT+khrat348v7uNpAP1+FZ=mdYMhJkf3Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: Move PXA SSP bindings to the correct folder
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 2:58=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, May 17, 2024 at 06:24:37PM +0100, Mark Brown wrote:
> > On Fri, May 17, 2024 at 08:11:03PM +0300, Andy Shevchenko wrote:
> > > SSP stands for Serial Synchronous Protocol and has nothing to do with
> > > UART, also known as USART, where 'A' stands for Asynchronous.
> > >
> > > Move the SSP bindings to where it belongs.
> >
> > It's a serial device which is also used for other applications (the
> > other one upstream being audio) so I can see where the current binding
> > comes from and it's not super obvious that spi is especially better
> > here.
>
> Hmm... okay. Then it's question to DT people. Consider this as a report.
> Because UART (aka serial) is definitely not the place for SPI/SSP binding=
s
> either.

Move it when it is converted. Until then, I don't care too much. SPI
seems better than serial at least. The sound part is its own
binding/node (something we wouldn't do today).

Rob


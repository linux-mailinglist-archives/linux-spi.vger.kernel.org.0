Return-Path: <linux-spi+bounces-273-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5148129BC
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 08:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E240B21207
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 07:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D329912E78;
	Thu, 14 Dec 2023 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I1XyL+8U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B3iBBKze"
X-Original-To: linux-spi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A703CF;
	Wed, 13 Dec 2023 23:50:04 -0800 (PST)
Date: Thu, 14 Dec 2023 08:49:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702540201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BasXHu44qmBA5Lb6x6s0xu3ntXxrQ9dJsYh6ASf+5Q0=;
	b=I1XyL+8Umpiy9xMRIoBCQ62mE3dH8MfkDsiuVDOIX9s52SmeBk40yLE3RUWaNyeTmlPAeu
	a0lMiZ8zgboWaH8c5zFSJZg6JxG4a2jBjCwC07T1eXGs9BL+i/L0sBOY0UT/pYrATfz4wb
	m+jbZNQleTYY71EeSRWJcsH8r3Z4SqhH13GorZ+4ndAF+NDrMFQibzb0VLoNf3nfKUnjt4
	FPrBh5rvIhhBPHRGqZdWTLiQr3rELljQMSVABf6gpnJ5lfUuTQ81mRvVX/3Kc/biwb16Td
	ypmHf4ZDgDRGSE8gVpYY8laEoAfrdUb+KEj7tqXzT8NQpyuG0IZjTjfuIjwFkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702540201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BasXHu44qmBA5Lb6x6s0xu3ntXxrQ9dJsYh6ASf+5Q0=;
	b=B3iBBKzeI2ZOWXjfJoRXt5xHT7NGKzWazSfux1I/Ezs7thV7PH8w4K0FS5X+IIkvFgai7R
	7JtWNVDHY78RQpBA==
From: Nam Cao <namcao@linutronix.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: spl022: switch to use default
 spi_transfer_one_message()
Message-ID: <20231214084955.7245c538@namcao>
In-Reply-To: <CACRpkdZfuKmg8gY1J+prF0L0=S7PSW+0ZuqM3HhNrB1sXcNG5g@mail.gmail.com>
References: <cover.1701274975.git.namcao@linutronix.de>
	<ae1940abd6ff6a9e77b4373cff60007c641a0c6c.1701274975.git.namcao@linutronix.de>
	<CACRpkdZfuKmg8gY1J+prF0L0=S7PSW+0ZuqM3HhNrB1sXcNG5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Dec 2023 01:19:04 +0100 Linus Walleij <linus.walleij@linaro.org>=
 wrote:
> On Wed, Nov 29, 2023 at 5:32=E2=80=AFPM Nam Cao <namcao@linutronix.de> wr=
ote:
> > Except for polling mode, this driver's transfer_one_message() makes use
> > of interrupt handler and tasklet. This is problematic because
> > spi_transfer_delay_exec(), who may sleep, is called in interrupt handler
> > and tasklet. This causes the following warning:
> > BUG: sleeping function called from invalid context at drivers/spi/spi.c=
:1428
> >
> > Switch to use the default spi_transfer_one_message() instead, which
> > calls spi_transfer_delay_exec() appropriately.
> >
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > Tested with polling mode and interrupt mode, NOT with DMA mode.
> > Support with testing very appreciated! =20
>=20
> FWIW I tested this now on a device using DMA for the transfers
> and everything works fine like before.

Thanks for spending time reviewing and testing!

Best regards,
Nam



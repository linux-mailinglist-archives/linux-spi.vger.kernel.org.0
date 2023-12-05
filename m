Return-Path: <linux-spi+bounces-144-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BD7804B6C
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 08:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41710B20C89
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8782C1B4;
	Tue,  5 Dec 2023 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S7yI7KQ6"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2571611F;
	Mon,  4 Dec 2023 23:49:59 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9DC62000A;
	Tue,  5 Dec 2023 07:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701762597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VA0tqXTE63GTnfTbjsTp5UsmdDBx9DmZQVAyVq9gSLQ=;
	b=S7yI7KQ6BDavv2+aW0TNeM2LqKLKePGKoZBBP4+p9onTB7qSzumhSQRytDyZxBwhaW7/UF
	hsCSLCpuGcIhvVq6grxXQmxpUGqLsibXtZtdR8plOKDKrCu6oHAmAvZI+t6+gK6lW1P92S
	NrI7cjjqnZOJ3efkGmBGe+Adr1bKWu21+n9KBN8XGrehjDyATi+MpAEz+i7GBnZcCG4TBB
	IjnYl/1dqv7pkfbedXlnEqHsehiTH46Xx4AUIkJntjprRrDTrR8COHQk5em2B58WfmKjrx
	TR4uCto3Hz2dj/2mWeNPQ8bkMmVjkJiobUrjNc4AF1/pSsgQkVQZ1BJmfsap+w==
Date: Tue, 5 Dec 2023 08:49:54 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Richard Weinberger <richard@nod.at>, Mark Brown <broonie@kernel.org>,
 linux-spi <linux-spi@vger.kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Ryan Wanner <ryan.wanner@microchip.com>,
 stable <stable@vger.kernel.org>, Richard Weinberger
 <richard.weinberger@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any
 signal
Message-ID: <20231205084954.42d78f61@xps-13>
In-Reply-To: <d4ffca97-bb5d-4c42-a025-69b308c24f82@raritan.com>
References: <20231127095842.389631-1-miquel.raynal@bootlin.com>
	<a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com>
	<0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com>
	<20231129094932.2639ca49@xps-13>
	<723263313.45007.1701348374765.JavaMail.zimbra@nod.at>
	<1192504136.46091.1701368767836.JavaMail.zimbra@nod.at>
	<20231130211543.2801a55b@xps-13>
	<d4ffca97-bb5d-4c42-a025-69b308c24f82@raritan.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Ronald,

> >>> I fear this is a jffs2 (summary feature) bug. Chances are great that =
yo =20
> u're able
> >>> to trigger the very same using a sudden loss of power.
> >>> =20
> >>>> It's not just spi-atmel, any spi-mem controller might be tempted to =
us =20
> e
> >>>> interruptible^Wkillable transfers just because the timeout values can
> >>>> be really big as the memory sizes increase.
> >>>>
> >>>> One solution is to change the completion helpers back to something
> >>>> non-killable/non-interruptible, but the user experience will be
> >>>> slightly degraded. The other would be to look into jffs2 (if it's the
> >>>> only filesystem playing with signals during unmount, tbh I don't kno=
w) =20
> .
> >>>> But maybe this signaling mechanism can't be hacked for compatibility
> >>>> reasons. Handling this at the spi level would be a mix of layers, I'm
> >>>> not ready for that.
> >>>>
> >>>> Richard, Mark, what's your opinion here? =20
> >>>
> >>> I *think* we can remove the signal handling code from jffs2 since it =
ma =20
> kes
> >>> already use of the kthread_should_stop() API.
> >>> That way we can keep the SPI transfer interruptible by signals.
> >>> ...reading right now into the history to figure better. =20
> >>
> >> After a brief discussion with dwmw2 another question came up, if an sp=
i transfer
> >> is cancelled, *all* other IO do the filesystem has to stop too.
> >> IO can happen concurrently, if only one IO path dies but the other one=
s can
> >> make progress, the filesystem becomes inconsistent and all hope is los=
t.
> >>
> >> Miquel, is this guaranteed by your changes? =20
> >
> > Absolutely not, the changes are in a spi controller, there is nothing
> > specific to the user there. If a filesystem transfer get interrupted,
> > it's the filesystem responsibility to cancel the other IOs if that's
> > relevant for its own consistency? =20
>=20
> I think yes. But the only thing the FS can do is stop any writes from now
> on which is not a useful consequence of killing a process.
>=20
> Anyway, the whole issue started with commit e0205d6203c2 "spi: atmel:
> Prevent
> false timeouts on long transfers". Citing the commit message here:
>      "spi: atmel: Prevent false timeouts on long transfers
>=20
>      A slow SPI bus clocks at ~20MHz, which means it would transfer about
>      2500 bytes per second with a single data line. Big transfers, like w=
he
> n
>      dealing with flashes can easily reach a few MiB. The current DMA
> timeout
>      is set to 1 second, which means any working transfer of about 4MiB w=
il
> l
>      always be cancelled.
>=20
>      With the above derivations, on a slow bus, we can assume every byte
> will
>      take at most 0.4ms. Said otherwise, we could add 4ms to the 1-second
>      timeout delay every 10kiB. On a 4MiB transfer, it would bring the
>      timeout delay up to 2.6s which still seems rather acceptable for a
>      timeout.
>=20
>      The consequence of this is that long transfers might be allowed, whi=
ch
>      hence requires the need to interrupt the transfer if wanted by the
>      user. We can hence switch to the _interruptible variant of
>      wait_for_completion. This leads to a little bit more handling to also
>      handle the interrupted case but looks really acceptable overall.
>=20
>      While at it, we drop the useless, noisy and redundant WARN_ON() call=
."
>=20
> This calculation is actually wrong by factor 1000. A 20MHz SPI bus is not
> really slow and it will transfer ~2.5MB/s over a single lane.
> The calculation would be right for 20kHz but I think this is a more
> esoteric case, isn't it?

Please, I would appreciate if you would adopt a more constructive
approach. Yes I am the ugly villain who broke your setup and I am sorry
about that. But let's face the reality:

- Filesystems being sensible to user signals is probably not an ideal
  choice but this was made a decade ago, so there is no blame here,
  but IMO it was not straightforward to think about this case.
  Anyway, as rightfully pointed out by David and Richard, there is the
  coherency problem of the filesystem, with which we don't want to
  play.

- The introduction you point above is indeed wrong by a factor
  1000, as the throughput should be 2.5MB/s and not 2.5kB/s, of
  course. But then if we transfer 2.5MB/s don't you feel like a
  transfer of 4MB is actually going to be interrupted for no reason?
  Sorry for messing the commit log, but the problem is real and the
  diff is relevant.

So instead of nervously insisting for a global revert, I believe the
right approach will be to accept 'big' timeout delays for now on spi
transfers and the final fix is probably to remove the
'interruptible/killable' keyword from our waits. And as (the other)
David said, maybe at some point we will decide to split spi transfers
if they are too big, even though heuristics in this case are not
straightforward.

Thanks,
Miqu=C3=A8l


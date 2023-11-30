Return-Path: <linux-spi+bounces-109-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51A97FFC52
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 21:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFCB281A09
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 20:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ED853E27;
	Thu, 30 Nov 2023 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kx7uiucP"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE931985;
	Thu, 30 Nov 2023 12:15:52 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 379661BF20B;
	Thu, 30 Nov 2023 20:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701375350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIbIFfrn5l/35BhQp4MbDdbDxlcbSPBpb9WWg24uDPY=;
	b=kx7uiucPrUVYV+YkZUGY0OF7p0jdMHfxgJ4v75gTrlIn+8GniiSyfnWoFXjww2F9llLD8T
	ugapChnaDaqMxKvJbKINlumrAY7hGm0dlDLYcBkeZkB8d+Gaf2GYhFPadUbSCfdgvDn12g
	mJhNK9ge/tJNDFXjsA175ZeZwrm2LVtsEWakxitVwaGfNurHrkfY7jTXU2QllAHDbVWGWH
	ZhqHpHuNe8rLwMCD5hBISv3ivM9SRbmWFx+1B9+v0vW/D/5utQOQjjOzwUnqTQx7QaGHv0
	kS7p8N3oqMJ2BtFqdCOafwgoA0C/Szdj+DsmfxrriEvVsO+u+p2oyCQcc/74MQ==
Date: Thu, 30 Nov 2023 21:15:43 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: Ronald Wahl <ronald.wahl@raritan.com>, Mark Brown <broonie@kernel.org>,
 linux-spi <linux-spi@vger.kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Ryan Wanner <ryan.wanner@microchip.com>,
 stable <stable@vger.kernel.org>, Richard Weinberger
 <richard.weinberger@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any
 signal
Message-ID: <20231130211543.2801a55b@xps-13>
In-Reply-To: <1192504136.46091.1701368767836.JavaMail.zimbra@nod.at>
References: <20231127095842.389631-1-miquel.raynal@bootlin.com>
	<a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com>
	<0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com>
	<20231129094932.2639ca49@xps-13>
	<723263313.45007.1701348374765.JavaMail.zimbra@nod.at>
	<1192504136.46091.1701368767836.JavaMail.zimbra@nod.at>
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

Hi Richard,

richard@nod.at wrote on Thu, 30 Nov 2023 19:26:07 +0100 (CET):

> ----- Urspr=C3=BCngliche Mail -----
> > Von: "richard" <richard@nod.at>
> > An: "Miquel Raynal" <miquel.raynal@bootlin.com>
> > CC: "Ronald Wahl" <ronald.wahl@raritan.com>, "Mark Brown" <broonie@kern=
el.org>, "linux-spi" <linux-spi@vger.kernel.org>,
> > "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Ryan Wanner" <ryan.=
wanner@microchip.com>, "stable"
> > <stable@vger.kernel.org>, "Richard Weinberger" <richard.weinberger@gmai=
l.com>
> > Gesendet: Donnerstag, 30. November 2023 13:46:14
> > Betreff: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any =
signal =20
>=20
> > ----- Urspr=C3=BCngliche Mail ----- =20
> >> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> >> + Richard, my dear jffs2 expert ;) =20
> >=20
> > :-S
> >  =20
> >>=20
> >> ronald.wahl@raritan.com wrote on Mon, 27 Nov 2023 18:54:40 +0100:
> >>  =20
> >>> On 27.11.23 16:10, Ronald Wahl wrote: =20
> >>> > On 27.11.23 10:58, Miquel Raynal wrote: =20
> >>> >> The intended move from wait_for_completion_*() to
> >>> >> wait_for_completion_interruptible_*() was to allow (very) long spi=
 memor =20
> >>> y =20
> >>> >> transfers to be stopped upon user request instead of freezing the
> >>> >> machine forever as the timeout value could now be significantly bi=
gger.
> >>> >>
> >>> >> However, depending on the user logic, applications can receive many
> >>> >> signals for their own "internal" purpose and have nothing to do wi=
th the
> >>> >> requested kernel operations, hence interrupting spi transfers upon=
 any
> >>> >> signal is probably not a wise choice. Instead, let's switch to
> >>> >> wait_for_completion_killable_*() to only catch the "important"
> >>> >> signals. This was likely the intended behavior anyway. =20
> >>> >
> >>> > Actually this seems to work. But aborting a process that has a SPI
> >>> > transfer running causes ugly messages from kernel. This is somehow
> >>> > unexpected:
> >>> >
> >>> > # dd if=3D/dev/urandom of=3D/flashdisk/testfile bs=3D1024 count=3D5=
12
> >>> > ^C[=C2=A0 380.726760] spi-nor spi0.0: spi transfer canceled
> >>> > [=C2=A0 380.731688] spi-nor spi0.0: SPI transfer failed: -512
> >>> > [=C2=A0 380.737141] spi_master spi0: failed to transfer one message=
 from queue
> >>> > [=C2=A0 380.746495] spi-nor spi0.0: spi transfer canceled
> >>> > [=C2=A0 380.751549] spi-nor spi0.0: SPI transfer failed: -512
> >>> > [=C2=A0 380.756844] spi_master spi0: failed to transfer one message=
 from queue
> >>> >
> >>> > JFFS2 also logs an informational message which is less visible but =
also
> >>> > may rise eyebrows:
> >>> > [=C2=A0 380.743904] jffs2: Write of 4164 bytes at 0x0016a47c failed=
. retu =20
> >>> rned =20
> >>> > -512, retlen 68 =20
> >=20
> > Ugly kernel messages are a normal consequence of killing an IO.
> > Chances are good that we'll find bugs in the upper layers.
> >  =20
> >>> > Killing a process is something to expect in certain cases and it sh=
ould
> >>> > not cause such messages which may create some anxiety that somethin=
g bad
> >>> > had happened. So maybe the "kill" case should be silent (e.g. level
> >>> > "debug")
> >>> > but without out hiding real errors. But even when hiding the messag=
e in t =20
> >>> he =20
> >>> > SPI framework it may cause additional messages in upper layers like=
 JFFS2 =20
> >>> . =20
> >>> > I'm not sure whether all of this is a good idea. This is something =
others
> >>> > have to decide. =20
> >>>=20
> >>> ... and now I just got a crash when unmounting and remounting jffs2:
> >>>=20
> >>> unmount:
> >>> [ 8245.821105] spi-nor spi0.0: spi transfer canceled
> >>> [ 8245.826288] spi-nor spi0.0: SPI transfer failed: -512
> >>> [ 8245.831508] spi_master spi0: failed to transfer one message from q=
ueue
> >>> [ 8245.838484] jffs2: Write of 1092 bytes at 0x00181458 failed. retur=
ned -5
> >>> 12, retlen 68
> >>> [ 8245.839786] spi-nor spi0.0: spi transfer canceled
> >>> [ 8245.844759] spi-nor spi0.0: SPI transfer failed: -512
> >>> [ 8245.850145] spi_master spi0: failed to transfer one message from q=
ueue
> >>> [ 8245.856909] jffs2: Write of 1092 bytes at 0x0018189c failed. retur=
ned -5
> >>> 12, retlen 0
> >>> [ 8245.856942] jffs2: Not marking the space at 0x0018189c as dirty be=
cause the
> >>> flash driver returned retlen zero =20
> >=20
> > jffs2 has a garbage collect thread which can be controlled using various
> > signals.
> > To terminate the thread, jffs2 sends SIGKILL upon umount.
> > If the gc thread does IO while that, you gonna kill the IO too.
> >  =20
> >>> mount:
> >>> [ 8831.213456] jffs2: error: (1142) jffs2_link_node_ref: Adding new r=
ef 28b
> >>> d9da7 at (0x000ad578-0x000ae5bc) not immediately after previous (0x00=
0ad578
> >>> -0x000ad578)
> >>> [ 8831.228212] Internal error: Oops - undefined instruction: 0 [#1] T=
HUMB2 =20
> >=20
> >=20
> > I fear this is a jffs2 (summary feature) bug. Chances are great that yo=
u're able
> > to trigger the very same using a sudden loss of power.
> >  =20
> >> It's not just spi-atmel, any spi-mem controller might be tempted to use
> >> interruptible^Wkillable transfers just because the timeout values can
> >> be really big as the memory sizes increase.
> >>=20
> >> One solution is to change the completion helpers back to something
> >> non-killable/non-interruptible, but the user experience will be
> >> slightly degraded. The other would be to look into jffs2 (if it's the
> >> only filesystem playing with signals during unmount, tbh I don't know).
> >> But maybe this signaling mechanism can't be hacked for compatibility
> >> reasons. Handling this at the spi level would be a mix of layers, I'm
> >> not ready for that.
> >>=20
> >> Richard, Mark, what's your opinion here? =20
> >=20
> > I *think* we can remove the signal handling code from jffs2 since it ma=
kes
> > already use of the kthread_should_stop() API.
> > That way we can keep the SPI transfer interruptible by signals.
> > ...reading right now into the history to figure better. =20
>=20
> After a brief discussion with dwmw2 another question came up, if an spi t=
ransfer
> is cancelled, *all* other IO do the filesystem has to stop too.
> IO can happen concurrently, if only one IO path dies but the other ones c=
an
> make progress, the filesystem becomes inconsistent and all hope is lost.
>=20
> Miquel, is this guaranteed by your changes?

Absolutely not, the changes are in a spi controller, there is nothing
specific to the user there. If a filesystem transfer get interrupted,
it's the filesystem responsibility to cancel the other IOs if that's
relevant for its own consistency?

Thanks,
Miqu=C3=A8l


Return-Path: <linux-spi+bounces-104-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCCE7FEF73
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 13:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE4E1C20AFA
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781328E8;
	Thu, 30 Nov 2023 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E59D50;
	Thu, 30 Nov 2023 04:46:18 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D72266413F6E;
	Thu, 30 Nov 2023 13:46:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 3LnPvv4jQdaJ; Thu, 30 Nov 2023 13:46:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 208F56343783;
	Thu, 30 Nov 2023 13:46:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wbcgb4kmcsrJ; Thu, 30 Nov 2023 13:46:15 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id ED0E86413F6E;
	Thu, 30 Nov 2023 13:46:14 +0100 (CET)
Date: Thu, 30 Nov 2023 13:46:14 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Ronald Wahl <ronald.wahl@raritan.com>, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Ryan Wanner <ryan.wanner@microchip.com>, 
	stable <stable@vger.kernel.org>, 
	Richard Weinberger <richard.weinberger@gmail.com>
Message-ID: <723263313.45007.1701348374765.JavaMail.zimbra@nod.at>
In-Reply-To: <20231129094932.2639ca49@xps-13>
References: <20231127095842.389631-1-miquel.raynal@bootlin.com> <a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com> <0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com> <20231129094932.2639ca49@xps-13>
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any
 signal
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: atmel: Do not cancel a transfer upon any signal
Thread-Index: NUX+aeuXSFektAI71KkStBMryS5HyA==

----- Urspr=C3=BCngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> + Richard, my dear jffs2 expert ;)

:-S

>=20
> ronald.wahl@raritan.com wrote on Mon, 27 Nov 2023 18:54:40 +0100:
>=20
>> On 27.11.23 16:10, Ronald Wahl wrote:
>> > On 27.11.23 10:58, Miquel Raynal wrote:
>> >> The intended move from wait_for_completion_*() to
>> >> wait_for_completion_interruptible_*() was to allow (very) long spi me=
mor
>> y
>> >> transfers to be stopped upon user request instead of freezing the
>> >> machine forever as the timeout value could now be significantly bigge=
r.
>> >>
>> >> However, depending on the user logic, applications can receive many
>> >> signals for their own "internal" purpose and have nothing to do with =
the
>> >> requested kernel operations, hence interrupting spi transfers upon an=
y
>> >> signal is probably not a wise choice. Instead, let's switch to
>> >> wait_for_completion_killable_*() to only catch the "important"
>> >> signals. This was likely the intended behavior anyway.
>> >
>> > Actually this seems to work. But aborting a process that has a SPI
>> > transfer running causes ugly messages from kernel. This is somehow
>> > unexpected:
>> >
>> > # dd if=3D/dev/urandom of=3D/flashdisk/testfile bs=3D1024 count=3D512
>> > ^C[=C2=A0 380.726760] spi-nor spi0.0: spi transfer canceled
>> > [=C2=A0 380.731688] spi-nor spi0.0: SPI transfer failed: -512
>> > [=C2=A0 380.737141] spi_master spi0: failed to transfer one message fr=
om queue
>> > [=C2=A0 380.746495] spi-nor spi0.0: spi transfer canceled
>> > [=C2=A0 380.751549] spi-nor spi0.0: SPI transfer failed: -512
>> > [=C2=A0 380.756844] spi_master spi0: failed to transfer one message fr=
om queue
>> >
>> > JFFS2 also logs an informational message which is less visible but als=
o
>> > may rise eyebrows:
>> > [=C2=A0 380.743904] jffs2: Write of 4164 bytes at 0x0016a47c failed. r=
etu
>> rned
>> > -512, retlen 68

Ugly kernel messages are a normal consequence of killing an IO.
Chances are good that we'll find bugs in the upper layers.

>> > Killing a process is something to expect in certain cases and it shoul=
d
>> > not cause such messages which may create some anxiety that something b=
ad
>> > had happened. So maybe the "kill" case should be silent (e.g. level
>> > "debug")
>> > but without out hiding real errors. But even when hiding the message i=
n t
>> he
>> > SPI framework it may cause additional messages in upper layers like JF=
FS2
>> .
>> > I'm not sure whether all of this is a good idea. This is something oth=
ers
>> > have to decide.
>>=20
>> ... and now I just got a crash when unmounting and remounting jffs2:
>>=20
>> unmount:
>> [ 8245.821105] spi-nor spi0.0: spi transfer canceled
>> [ 8245.826288] spi-nor spi0.0: SPI transfer failed: -512
>> [ 8245.831508] spi_master spi0: failed to transfer one message from queu=
e
>> [ 8245.838484] jffs2: Write of 1092 bytes at 0x00181458 failed. returned=
 -5
>> 12, retlen 68
>> [ 8245.839786] spi-nor spi0.0: spi transfer canceled
>> [ 8245.844759] spi-nor spi0.0: SPI transfer failed: -512
>> [ 8245.850145] spi_master spi0: failed to transfer one message from queu=
e
>> [ 8245.856909] jffs2: Write of 1092 bytes at 0x0018189c failed. returned=
 -5
>> 12, retlen 0
>> [ 8245.856942] jffs2: Not marking the space at 0x0018189c as dirty becau=
se the
>> flash driver returned retlen zero

jffs2 has a garbage collect thread which can be controlled using various si=
gnals.
To terminate the thread, jffs2 sends SIGKILL upon umount.
If the gc thread does IO while that, you gonna kill the IO too.
=20
>> mount:
>> [ 8831.213456] jffs2: error: (1142) jffs2_link_node_ref: Adding new ref =
28b
>> d9da7 at (0x000ad578-0x000ae5bc) not immediately after previous (0x000ad=
578
>> -0x000ad578)
>> [ 8831.228212] Internal error: Oops - undefined instruction: 0 [#1] THUM=
B2


I fear this is a jffs2 (summary feature) bug. Chances are great that you're=
 able
to trigger the very same using a sudden loss of power.

> It's not just spi-atmel, any spi-mem controller might be tempted to use
> interruptible^Wkillable transfers just because the timeout values can
> be really big as the memory sizes increase.
>=20
> One solution is to change the completion helpers back to something
> non-killable/non-interruptible, but the user experience will be
> slightly degraded. The other would be to look into jffs2 (if it's the
> only filesystem playing with signals during unmount, tbh I don't know).
> But maybe this signaling mechanism can't be hacked for compatibility
> reasons. Handling this at the spi level would be a mix of layers, I'm
> not ready for that.
>=20
> Richard, Mark, what's your opinion here?

I *think* we can remove the signal handling code from jffs2 since it makes
already use of the kthread_should_stop() API.
That way we can keep the SPI transfer interruptible by signals.
...reading right now into the history to figure better.


Thanks,
//richard


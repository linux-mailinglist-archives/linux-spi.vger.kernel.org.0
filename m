Return-Path: <linux-spi+bounces-146-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EABD804DB5
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 10:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED22B20C07
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206F13E485;
	Tue,  5 Dec 2023 09:23:07 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269DD1700;
	Tue,  5 Dec 2023 01:23:00 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8C01E6435FE5;
	Tue,  5 Dec 2023 10:22:57 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id uoAS2t4MeggD; Tue,  5 Dec 2023 10:22:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 20FE66436003;
	Tue,  5 Dec 2023 10:22:57 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 18FfdAYlCNUA; Tue,  5 Dec 2023 10:22:57 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id ED2F16435FE5;
	Tue,  5 Dec 2023 10:22:56 +0100 (CET)
Date: Tue, 5 Dec 2023 10:22:56 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi <linux-spi@vger.kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Ryan Wanner <ryan.wanner@microchip.com>, 
	Ronald Wahl <ronald.wahl@raritan.com>, 
	David Laight <David.Laight@ACULAB.COM>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	stable <stable@vger.kernel.org>
Message-ID: <1788823860.72909.1701768176780.JavaMail.zimbra@nod.at>
In-Reply-To: <20231205083102.16946-1-miquel.raynal@bootlin.com>
References: <20231205083102.16946-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH] spi: atmel: Prevent spi transfers from being killed
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: atmel: Prevent spi transfers from being killed
Thread-Index: Quru2fECYqrOtaULSEivNT3zKaeElw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> All being well, it was reported that JFFS2 was showing a splat when
> interrupting a transfer. After some more debate about whether JFFS2
> should be fixed and how, it was also pointed out that the whole
> consistency of the filesystem in case of parallel I/O would be
> compromised. Changing JFFS2 behavior would in theory be possible but
> nobody has the energy and time and knowledge to do this now, so better
> prevent spi transfers to be interrupted by the user.

Well, it's not really an JFFS2 issue.
The real problem is, that with the said change anyone can abort an IO.
Usually file systems assume that an IO can only fail in fatal situations.
That's why UBIFS, for example, switches immediately to read-only mode.
So, an unprivileged user can force UBIFS into read-only mode, which is a
local DoS attack vector.

JFFS2, on the other hand, dies a different death. If you abort one IO,
another IO path can still be active and will violate the order of written
data.

Long story short, aborting pure user inflicted IO is fine. This is the "dd"
use case.
But as soon a filesystem is on top, things get complicated.

Maybe it is possible to teach the SPI subsystem whether an IO comes from sp=
idev
or the kernel itself?

Thanks,
//richard


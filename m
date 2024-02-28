Return-Path: <linux-spi+bounces-1534-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD35786A811
	for <lists+linux-spi@lfdr.de>; Wed, 28 Feb 2024 06:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C2C1C20F2B
	for <lists+linux-spi@lfdr.de>; Wed, 28 Feb 2024 05:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEE120DF5;
	Wed, 28 Feb 2024 05:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JwSMTu/c"
X-Original-To: linux-spi@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E920B22
	for <linux-spi@vger.kernel.org>; Wed, 28 Feb 2024 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709098649; cv=none; b=E8rTJrigFwmrxvcKblm/b7qySIunMA6bHFBGkJC/E0CrPQgh1AF4DecZwiQ1TS3KWZfW4kmAyQ4DYuorEEulm8qBu/OiB2NuCpvgc/N8UFaRDcHLTm9+eRIYEwY3grhdgS9OLGNQKH4JAa4cULIki3dxB7ShMXj8XOgZNlNK8p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709098649; c=relaxed/simple;
	bh=WrzBRPEbMC6sMsS/NGeRTcI4E0TvRn8j9WzB+h+U+0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H+rmz9+Crth4c37RTmXsbFr9jBPa1iDWq+RSBhnAIxZcSwQ5+6DjOlcoCBCJuLtmquZX5QfwRrYTf9M+/NLwU647OOU3FQt0lXYD7O+VOsgZjzvgEsQrpMhNflW8/QLhTjdTEK65QmejEHn4o5i0aRkT0mnVYqL465kHLRelth8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=JwSMTu/c; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709098644;
	bh=WrzBRPEbMC6sMsS/NGeRTcI4E0TvRn8j9WzB+h+U+0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JwSMTu/c4WXVmSxe+KfxYctgyIYeFkLJJpIjLQ6SkHSqX20oZRSdbxZDFKV6K/1KQ
	 6C3rUOI7G73yyvXygdHNiXAikpA4tLd7kosG3yXCldb3iTl1NT4C6IYHLATqgi0NVh
	 kAr6Z+VEKKbMV6IuyY9CPD01RX5J0d3g5oCWLKumDL4dO0oOi9+SlufVquN+SKFuGH
	 94e3wPuva+BzHfNUmLHBk9iV/f9LFu6N9NhNp3FjqFJSV+8HK9TSwQf7mkUPcQ/SqI
	 wS+CAkb7AHHnImKmBI5rUKRorCEL/+0QK9IZ167FKlgqVlaHXYC19ieT09pRti+WlY
	 j+4OW7j3/UihA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tl35Z2kBSz4wc6;
	Wed, 28 Feb 2024 16:37:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Uwe =?utf-8?Q?Kleine-K?=
 =?utf-8?Q?=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N.
 Rao" <naveen.n.rao@linux.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: Increasing build coverage for drivers/spi/spi-ppc4xx.c
In-Reply-To: <a9d99374-a118-4f7d-9e31-8cb7db657212@csgroup.eu>
References: <qvuhez7vrcoui7i6s4yohd4ednneuoejcp6tw6iwzeefgpyvd6@fkwwtwozhakf>
 <6fab09e0-1f21-4ada-b5ae-472bf71a1225@csgroup.eu>
 <7ah7rzijbwkvr3hmtqfjh7syxave756usevumrypqspn27wgyv@ln42tyqxo5ai>
 <2fe58bc5-2f1b-4f51-8f01-fa397a1c9291@csgroup.eu>
 <645ngchmigftlvbvquprqqjcn2frogkihdplbmngnz6hvywefo@rvthwy2epwg3>
 <a9d99374-a118-4f7d-9e31-8cb7db657212@csgroup.eu>
Date: Wed, 28 Feb 2024 16:37:22 +1100
Message-ID: <87cysh1759.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 27/02/2024 =C3=A0 15:00, Uwe Kleine-K=C3=B6nig a =C3=A9crit=C2=A0:
>> On Tue, Feb 27, 2024 at 01:52:07PM +0000, Christophe Leroy wrote:
>>> Le 27/02/2024 =C3=A0 11:58, Uwe Kleine-K=C3=B6nig a =C3=A9crit=C2=A0:
>>>> On Tue, Feb 27, 2024 at 10:25:15AM +0000, Christophe Leroy wrote:
>>>>> Le 27/02/2024 =C3=A0 09:46, Uwe Kleine-K=C3=B6nig a =C3=A9crit=C2=A0:
>>>>>> recently the spi-ppc4xx.c driver suffered from build errors and warn=
ings
>>>>>> that were undetected for longer than I expected. I think it would be
>>>>>> very beneficial if this driver was enabled in (at least) a powerpc
>>>>>> allmodconfig build.
>>>>>>
>>>>>> The challenge to do so is that spi-ppc4xx.c uses dcri_clrset() which=
 is
>>>>>> only defined for 4xx (as these select PPC_DCR_NATIVE).
...
>>=20
>> The reason I'd like to see it in allmodconfig is that testing
>> allmodconfig on several archs is the check I do for my patch series.
>
> I think for powerpc you should really check ppc32_allmodconfig in=20
> addition to allmodconfig

Yeah.

arch/powerpc is really ~7 separate sub architectures.

Building allmodconfig and ppc32_allmodconfig at least covers the bulk of
the code. But it doesn't include 4xx, or several other platforms.

I think the best/easiest option is just to enable this driver in the 44x
defconfig. At least that way the auto builders should catch any problems.

eg.

diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/p=
pc44x_defconfig
index 8b595f67068c..95a1e7efb79f 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -67,6 +67,8 @@ CONFIG_I2C=3Dm
 CONFIG_I2C_CHARDEV=3Dm
 CONFIG_I2C_GPIO=3Dm
 CONFIG_I2C_IBM_IIC=3Dm
+CONFIG_SPI=3Dy
+CONFIG_SPI_PPC4xx=3Dy
 # CONFIG_HWMON is not set
 CONFIG_FB=3Dm
 CONFIG_USB=3Dm

cheers


Return-Path: <linux-spi+bounces-5893-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C054D9E3B3F
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 14:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B87285414
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81351B85FD;
	Wed,  4 Dec 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="S7s1XsDe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE91714B3;
	Wed,  4 Dec 2024 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318866; cv=none; b=gfdUpwcgGXz+sXDYzyWzK99Rqna5sZl86VVGdMZuKaw4Djjf5Lqn6nBs5a/+o7KB2PJ1+YdwpNbelbJv6JDqocdTO9NFxvpHFelX//svTaPW2g+tqdggIbO2BLh9w7rIJrtnlfs6XEPS21+TEmpxAB8WWXEhwwR2aUOQ6J80X+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318866; c=relaxed/simple;
	bh=sE23B4ttHCwF11SMH/4cQGZLTPJosFh75fu9WJI1yRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/RDRAqzKcDCu9ytrIxqNazmBj46Z+ttFrdQ5QEflQ4ViK6s9HVTj5OSe1k1ZSNOJ+5huPd8puNKauLnYGjHB3MXMXvsZ3a/g4ywALadQOlaZUX4tFcTrla9P8gM3e3gns7c7r0ElCfFkmtYrKLdrI9UHZKI/VwbtJ1nHtPAmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=S7s1XsDe; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1733318845; x=1733923645; i=wahrenst@gmx.net;
	bh=sE23B4ttHCwF11SMH/4cQGZLTPJosFh75fu9WJI1yRg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S7s1XsDeA9AwZId04CoS+4zfCsuHwmpDQUsxAEFF+CDyauoaxLwu3cyFeku+btkr
	 nSUwCnHHXO7kOaQxZqfEL0eT3n3ySX0uS7lpgW+e6N4P1sGwGVA9rzMgvLbqZWBbR
	 siw4DqIAsVB5qy4xfq8G99px0uxrdV3aiQCKV3VnJJFtpt1E8LOb/UjyMyhlD6QbP
	 HY5F4+tJgrNtnh3PDdELp2dnUDH598gGnz7qgKDzgLWJL2blRc98DXLlspw6zJiKm
	 qEErLTZcD9+sv7iHO5L1cKUp8DQfV6sGfsF8XcfsCt/Pw+YtgcpBbfARobUKc46CI
	 tJ4rmERt7OR8onrPiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.106] ([37.4.251.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O6Y-1tMfxb0lHq-0036dg; Wed, 04
 Dec 2024 14:27:25 +0100
Message-ID: <5ab9b62a-6577-4a3f-9dfe-c7362bf725db@gmx.net>
Date: Wed, 4 Dec 2024 14:27:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] spi-mxs: Fix chipselect glitch
To: Fabio Estevam <festevam@gmail.com>, Ralf Schlatterbeck <rsc@runtux.com>
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240202115330.wxkbfmvd76sy3a6a@runtux.com>
 <20240213170657.puwlx5pjl3odcs2k@runtux.com>
 <CAOMZO5CD7+E_BBH+oQ8HUdBeRFZxWW7s2uJgS5eaQAW_Fe4CNg@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CAOMZO5CD7+E_BBH+oQ8HUdBeRFZxWW7s2uJgS5eaQAW_Fe4CNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G4xJvxn9JxBbFBtOCBgaPWVT/H5beKdM/r033wNOSnEfcHMS4uR
 kP50qLZwHr/eS++qjjefOovIiAMdSxwRdW7R39dQQcAclLnAEK2A6AXIpxWvfSG5tWJIM45
 5DsoOZSUoAnGuog2Klzv8mDYPC3LoLesgHuf52WG+9XY9ajGvQrFT1FRq6gAZLz3bD+33Rl
 4Gut2eCbMwAdMEbJBZdZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n7ckTBxpn3Y=;meKGvBZSvoTceDyMUxt1Uwb/XKi
 EfnkEIwv36g25zdscY73nH7gKor1Xdd++wVXwrrbJphgiQHkTLB/dpViCk7rL0WKgegZHl3n3
 buOUlrbi9zY+oyTKNpma7+PR4OcO8DCO25qpReW3vRqIECTU9JmpAlYSliAu78WI0o/mcCMRK
 z4bKQdS7cXHc8maddHaiGfvGCCKePGEv9XP2fmjLBAiJCjFJUlezo8IrA32lvXP03UzkyNc3S
 0bsvVGgCuWVNXEQXtDHn9mB+2s5sD+pcE0q9UPc2xxz7ZO5X1M5MQ/4PklFynXj90+Tg7KB8c
 YkCQHWJX7nE2ryUxdmD1+X4xcJ4YJJoldXRdX/jPn08Fv957uyB5Ie9PDpYHyVFF+hN9Iil2u
 +lrcXgbHUYMAyq+iz1bslZDvQORL29LurfiB0i1q6ZnsUF490H0Fp/WRPc4QaDlCf8QqsLlaG
 UQzNBzpx3IEezahZpBgcYNyRGrlKrIb7mH+1GIIOGMO4DCqIHG1b0X0u+r4PZ+AkpzA+FtzLm
 DW4wpF5BQ8UEuUoJMCDjXXza3EDXtjZFeES1EJoxv4IVNSThMn+amekm7KS5SbJetUdznGYUk
 egl/M0Jmu57HNU7l5DCKZumFTTCWF9at/IRYiXtF70KXc9+mMDf3qf46J1fhks7W+ypBqoYtr
 lscVVFEvdhPc1D44LLVsogWrUcHg16GSLT0wig8f9CB2hbeM8h8ADuuWS4Q/4dUtVczRqx640
 KoiGL6+WG8CJkpyXrUoUfGwrTlIXqYpe4uT5oj82UE9Hq1uu75YaPjiLnSBuujAUCdx9SHqjo
 Fb92h43dQo1fpsMk7HzHLuVUHD/ZbwU+3qBRh2JZuKKTuIj+WUZ7E5v6Dpkwf5mt5S0FC7SiT
 e3Ep8IyPJOoOYQnzu5OxRB+d2xwr+P/2J6Swdizslf8KW0RTPptvaMIa4QvsP9co2hyRSgpFQ
 8wN+kBLhHm1dvKd9TQLNVxTEXFk0um5APrLQQ7NUpo1mPkhyCDHTGYf9WiiqHiHTJjhY+D7rN
 ihehpC8JfNMM7413lT+32ZeU07xNbqCU7TzCnJE3i54Jb0MECcLdT9+AER2Kjtx+hdZTnFYff
 3dV+7L6DCkIEW/jcOdFDtD4wDRjn3q

Hi,

Am 13.02.24 um 18:22 schrieb Fabio Estevam:
> Hi Ralf,
>
> On Tue, Feb 13, 2024 at 2:07=E2=80=AFPM Ralf Schlatterbeck <rsc@runtux.c=
om> wrote:
>> On Fri, Feb 02, 2024 at 12:53:30PM +0100, Ralf Schlatterbeck wrote:
>>> There was a change in the mxs-dma engine that uses a new custom flag.
>>> The change was not applied to the mxs spi driver.
>>> This results in chipselect being deasserted too early.
>>> This fixes the chipselect problem by using the new flag in the mxs-spi
>>> driver.
>>>
>>> Fixes: ceeeb99cd821 ("dmaengine: mxs: rename custom flag")
>>> Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
>>> ---
>>> For oscilloscope screenshots and a verbose explanation see my blog pos=
t
>>> at https://blog.runtux.com/posts/2024/02/01/
> I suggest putting the link to your detailed explanation into the
> commit log as this is useful information.
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
I noticed that this patch hasn't applied to stable yet.

Are there reason for not doing this or is it just because the patch
missed the Cc: stable@vger.kernel.org ?


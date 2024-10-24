Return-Path: <linux-spi+bounces-5377-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF7B9AEB3E
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 18:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A319B23AB8
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7041C7B6D;
	Thu, 24 Oct 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="aXOTD4Oe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWZoFGWX"
X-Original-To: linux-spi@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB568614E;
	Thu, 24 Oct 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785675; cv=none; b=KVpyp89Rju7SUsqTznDzMFfbSD4QVfAb5+aTo5CXGDdbNyY1r4UlILxqXi63Rq9wPyfsFCY2WxIZ1AM4sCfLkV7R4Q694z7d71Rmw4/bP43Ez75eSbBcpp/nl9TmKVUkG7Q1dQN6UwTvz/Z+P7uzj/QkzKH7dcsfFQBUyup8q7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785675; c=relaxed/simple;
	bh=ZnN092/uqHw1eYzx7adrt8EsAcrScv3pParyGaS6g9o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hJy9ANecoCHZQtL0sc4Lybp+dpUMzhn7DBfrQj9ZEywokSv2/ck3jo3pLVqU9mv5Ha2JJHyR/X/ggUtMu00sHzTAs+l/HKmpIH4awg4EbfVNggyvL6kMUFGHo/lIbdtVv1Y31ELvBlY1xNKEXchPzRIVfj7UOWDk8Sa2Y3DqZx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=aXOTD4Oe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWZoFGWX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id B15CF13803A7;
	Thu, 24 Oct 2024 12:01:11 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Thu, 24 Oct 2024 12:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729785671;
	 x=1729872071; bh=TMl54/iBi871VKim9IIS4u83CKXUQJ/FyOD1Xg77P7w=; b=
	aXOTD4OekjsjgFCj+/giQqkUrJAHcrxA7NfodWHRuc18tp4u0CusZsPaOd31nzJ5
	OC4MdbNEc/zb5AcgQbJxfYIHy2Ao/d+61mcTqFJhly29noDbeO4wmmdJxE+NUQ2+
	isqoOh6zH+Pca8kJgQ45OEK1sWZYu+FC11avGLdTjeBbaSxkon9qHJBB2j1oGfQK
	+nSp6+O5nRzu0gQ893UPvmTMNbdbDUJ+KLXJ4WPg+Y58a1bBxAYudejrjPbPOs+N
	wxqqyFgexfUumOaXRVPsmJwWxtl+Y7AWDM6zHn70GY+vkDQOg5qyX3SLn/FfeWqA
	smKg0fk5TQltzqCIXZ7uHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729785671; x=
	1729872071; bh=TMl54/iBi871VKim9IIS4u83CKXUQJ/FyOD1Xg77P7w=; b=I
	WZoFGWXyH7KRT1xsSzXSo2wFJ8jbh/BcfWZj08qNrhlFXUdsFJ4/ZXsydTb9rgEK
	p5mr0xmQ6miU/NZByDL+0+gQtj4vDNv102f4lSa//6sfwDxR2sk9jI8G7HEap9gp
	tSiglYdCAExA5lkCfEAmjBMQFYUXzhWXrUI+x9qZgxtPA3HVhIZTh4CNFjfshi+s
	3TRNJPsem10pA6QVZ8+pOdOx0M1qhQXxGiL0GE2bZPATG2ZHyToyW0k/SJB22mdm
	LkiBCoTtcyirZeVS/S9zG744NZDoHOodmrMGsRBfI1FUkx8bSgMnfL1Lxx9gN07e
	ueOEHsuoyxelrTqFnGfDQ==
X-ME-Sender: <xms:R28aZyOuRBKINyVfUESATLEyMoQxt0QVBkLgmHBepXt8dIyd9UfrKw>
    <xme:R28aZw-z66VSoQKBZOqQA504ThlgNiF9UX8twlW600tz_w2-YHr4xvIJGI0rRQXXX
    Ei_egaFLqydEg343-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlqddutddmnecujfgurhepofggfffhvfev
    kfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuc
    eojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghr
    nhepheelkeetgfeftdekgfevieegfeehleeihedvffefgfefgfeihfdtkeekjeefkeehne
    cuffhomhgrihhnpehtrhgvrghsrdhgohhvnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
    homhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    lhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvg
    htuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:R28aZ5QPb3P6cydM06UlSPhz7gHQT2V-ffrWAqpBWkagS3jls8ZUng>
    <xmx:R28aZysGnOcq-bmzG5ticPI0qDEvlXX_-6owiJbR7oXECGcDrn6ynQ>
    <xmx:R28aZ6cG4QDwJsU39of7DuJggxyN2QpxE5GUgOAbHoOtNUAxCXILWw>
    <xmx:R28aZ217pABpKlfuKeN6NwZO6kTihaZhYtC2guoqVqQNLVOa1_tQkw>
    <xmx:R28aZ-GLf3fSOcvHKoaHJl7RN3_h8BhydO-eKMMjY7nzaWtmlsLZU-pO>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5F2561C20067; Thu, 24 Oct 2024 12:01:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 16:59:36 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Serge Semin" <fancer.lancer@gmail.com>, "Jon Mason" <jdmason@kudzu.us>,
 "Dave Jiang" <dave.jiang@intel.com>, "Allen Hubbe" <allenbh@gmail.com>,
 ntb@lists.linux.dev, "Andy Shevchenko" <andy@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Kory Maincent" <kory.maincent@bootlin.com>,
 "Cai Huoqing" <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
 "Mark Brown" <broonie@kernel.org>, linux-spi@vger.kernel.org,
 "Damien Le Moal" <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 "paulburton@kernel.org" <paulburton@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Arnd Bergmann" <arnd@arndb.de>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Andrew Lunn" <andrew@lunn.ch>, "Russell King" <linux@armlinux.org.uk>,
 "Vladimir Oltean" <olteanv@gmail.com>,
 "Kelvin Cheung" <keguang.zhang@gmail.com>,
 "Yanteng Si" <siyanteng@loongson.cn>, netdev@vger.kernel.org,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Guenter Roeck" <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 "Borislav Petkov" <bp@alien8.de>, linux-edac@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org
Cc: "Andrew Halaney" <ajhalaney@gmail.com>, "Nikita Travkin" <nikita@trvn.ru>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Alexander Shiyan" <shc_work@mail.ru>, "Dmitry Kozlov" <xeb@mail.ru>,
 "Sergey Shtylyov" <s.shtylyov@omp.ru>,
 "Evgeniy Dushistov" <dushistov@mail.ru>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Sergio Paracuellos" <sergio.paracuellos@gmail.com>,
 "Nikita Shubin" <nikita.shubin@maquefel.me>,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <753d203a-a008-4cd3-b053-38b5ce31281b@app.fastmail.com>
In-Reply-To: 
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B410=E6=9C=8824=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=883:50=EF=BC=8CJames Bottomley=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, 2024-10-24 at 07:27 +0300, Serge Semin wrote:
>> Hello Linux-kernel community,
[...]

Hi James,

Sorry to chime in here, and thanks for making things clear.

However, I have some questions regarding this statement, please see belo=
w:

> Please accept all of our apologies for the way this was handled.  A
> summary of the legal advice the kernel is operating under is

In what capacity this statement was made, i.e, who is "our" here and "we"
below? Are you representing any formal group in this case?

>
>    If your company is on the U.S. OFAC SDN lists, subject to an OFAC
>    sanctions program, or owned/controlled by a company on the list, our
>    ability to collaborate with you will be subject to restrictions, and
>    you cannot be in the MAINTAINERS file.
>
> Anyone who wishes to can query the list here:
>
> https://sanctionssearch.ofac.treas.gov/

I did a quick search and found the following entry:

HUAWEI TECHNOLOGIES CO., LTD. Under CMIC-EO13959 sanction program.

Although it's a Non-SDN sanction, it can still be interpreted as
"subject to an OFAC sanctions program".

How should we handle it?

>
[...]
>
> Again, we're really sorry it's come to this, but all of the Linux
> infrastructure and a lot of its maintainers are in the US and we can't
> ignore the requirements of US law.  We are hoping that this action
> alone will be sufficient to satisfy the US Treasury department in
> charge of sanctions and we won't also have to remove any existing
> patches.

I truly appreciate that someone has finally addressed the underlying iss=
ue.
I understand the importance of protecting infrastructure and maintainers=
 from
potential legal threats by ensuring compliance. My intent in asking these
questions is not to place anyone in a difficult position, but simply to =
gain a
better understanding of the situation, so I can take appropriate action =
to
keep everyone safe.

Disclaimer: I have no connection to any sanctioned body, and I'm a resid=
ent
of UK.

Thanks

>
> Regards,
>
> James Bottomley

--=20
- Jiaxun


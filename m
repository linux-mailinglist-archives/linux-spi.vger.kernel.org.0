Return-Path: <linux-spi+bounces-5383-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8D19AECEE
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 18:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1C11C22274
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E45F1FAEE3;
	Thu, 24 Oct 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="cxBTxKea";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cbGlugOU"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E8A1F8195;
	Thu, 24 Oct 2024 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789150; cv=none; b=VdMEWgS5pqpRWunJyPmNpFJC1sjbmN6NyH5uEhTY9ZfhvKmZOQ2S3TSCe/agoDyR6t+sYqBNwC5vIlydTI0RnKv+rjdqCFhT0Wq73D1ncmcR7B9/QkzZCh2zgkmzEJvSQFpYeyk7vQ1vwbyVyEhghfQhcvB0YRCJnNsPFMdkdSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789150; c=relaxed/simple;
	bh=1D9MXsAVWcNpk072yB1qs3fINFV1pE9hhttXGeJgq0w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YBSaORGyiCSSumVHQY7wiwSHfqHY8DjcdJdf5V4yK7HEcit4lYHcCrwpbQVCKk/l5A9RyklPChTPoMyjTDiFmto1cLvgqlLL0GmL7B1PxERARj7EmhS+TbN5L8JdgKXAUlZHDjQzMzAXqAF+eS90plni0/yL0a1XX6LVr+HEmnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=cxBTxKea; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cbGlugOU; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 783C61140198;
	Thu, 24 Oct 2024 12:59:06 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Thu, 24 Oct 2024 12:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729789146;
	 x=1729875546; bh=SG3wwx+g/r6vJORvVjNOrsa8CYeWjsvioBIcUqvZ0Gc=; b=
	cxBTxKea8RPf2jlrM1D6wxexXn5vE6Xj//laaXmXFjCGxWbPu6xANhQbzZ5QoL0E
	ixToHxmhkxEGpzLv7BjCXUn2OTgnKH04lfOnY2B+CD2PW9vQgfkA8WtsI3UP62E9
	8RcBwxeTXFHzDv+LJvsG8fhJyLCU6YD2ejjfKB++MLgPCFBfN2DqWq9ZvyKIiv8p
	F1uJDciPNrkuiWKgYFtEJSKTgf67Nr7aScnqXE47Hi0Et0olBmdZSBlC6gaGeLpD
	JTR8/WStnKExjJD826l+H/IxpkHEdgNadk+OJ26bZyVlYZCPsYsWsv2WU/803W4X
	C3OjUor3j17hDFuxKVdTVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729789146; x=
	1729875546; bh=SG3wwx+g/r6vJORvVjNOrsa8CYeWjsvioBIcUqvZ0Gc=; b=c
	bGlugOUXH5ZBeyeaY5Oezi+nuczo7orALTFLPa/uZ7myChfORdcCuRMKjj1Cn2dS
	YuEGubMQ+5eApaNSjFIRU9XGJ2zNWQFM4xtb4SnXLC+PtVHnVthS8J4/5+o0w9hO
	WuQtY9VrzR212nLOfd2C2GRf31hDEILaQZXUoPSRt1BXNAWsMSfP4LSPfsBWaTVv
	7phmzfDkz4I3eKvm4fNgbdP5HpjL8MM27fUq2IzfSoi52Anb0l/IQRZK90cDvIjm
	+2FKZt2z43RNyk1qK0FKEu3W0MD/pUkHGzEi/uXIOz58qlYNpdPMPOTMoWWnWAG4
	cIaiojrVQzfcLvHGesJ8A==
X-ME-Sender: <xms:2nwaZ9di9pcf1ltxSDIdzKw-YZloXhGxo1-8dJROD8pMbiUkMruhuA>
    <xme:2nwaZ7Nb3-hStk1NEJEIEYiNuG0yt11T1Y2hK1Z6h-QJaGJ6LPVgoU2g9JBzsmNYh
    P6OqMhV3UakBUkgPVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
    hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
    thdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2nwaZ2g14Y01JmG-33WPQCjxC3JPyDQnpJ43p21zYZSOdaLsUaXOPw>
    <xmx:2nwaZ2-Zom9-ZlISL8yiAminBt1FT0kNBPP5bnKWzLZtQxZAU9B-NA>
    <xmx:2nwaZ5vSrI7WdW3RUNEFaMHpwUODsoQQaB6drPUgSmDNacOqpMnF9A>
    <xmx:2nwaZ1GKlxbdiEQ_UKAIUG_Pp5B2CkL1lzP1gTK7ypoYoD77w-KUNg>
    <xmx:2nwaZ6XDo5rKPgHgtwIoNTBEoGd_7cON6yTSVNLZ5qlZMpakkq3Qj5x2>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 37E8F1C20066; Thu, 24 Oct 2024 12:59:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 17:58:45 +0100
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
Message-Id: <2f203b14-be13-4eef-bcb1-743dd9e9e9bd@app.fastmail.com>
In-Reply-To: 
 <f90bba20e86dac698472d686be7ec565736adca0.camel@HansenPartnership.com>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <753d203a-a008-4cd3-b053-38b5ce31281b@app.fastmail.com>
 <f90bba20e86dac698472d686be7ec565736adca0.camel@HansenPartnership.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B410=E6=9C=8824=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=885:27=EF=BC=8CJames Bottomley=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, 2024-10-24 at 16:59 +0100, Jiaxun Yang wrote:
[...]

Hi James,

>
> It's Linux, so no official capacity at all.  However, I am expressing
> the views of a number of people I talked to but it's not fair of me to
> name them.

Fair enough, I was hoping that it's from Linux Foundation but it's still
good news to me that it do represent some respectful individuals.

>
[...]
>> How should we handle it?
>
> A big chunk of the reason it's taken so long just to get the above is
> that the Lawyers (of which I'm not one) are still discussing the
> specifics and will produce a much longer policy document later, so they
> don't want to be drawn into questions like this.  However, my non-
> legal-advice rule of thumb that I'm applying until I hear otherwise is
> not on the SDN list, not a problem.

Thank you for sharing your insights. I'm looking forward to the document.

While I remain quite upset about how things were handled, your message h=
as
helped restore some of my confidence in the community.

I agree with Peter Cai's earlier comment that steps should be taken to a=
ddress
the harm caused by the initial reckless actions, particularly to those w=
ho were
humiliated.

It is also important to put measures in place to prevent such drama from=
 recurring.
A formal procedure for handling urgent compliance requests may be a sens=
ible step
forward.

I hold our community in high regard and would be heartbreaking to see th=
e reputation
of the Linux Kernel undermined in such an unfortunate manner. I would ap=
preciate it
if you could convey those thoughts to the relevant individuals.

Thanks
>
> James

--=20
- Jiaxun


Return-Path: <linux-spi+bounces-5390-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC199AEE3E
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 19:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22BF1C23FE6
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AB91F9ED6;
	Thu, 24 Oct 2024 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lywpdKPr"
X-Original-To: linux-spi@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC051FDFA3
	for <linux-spi@vger.kernel.org>; Thu, 24 Oct 2024 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791320; cv=none; b=d0vWFlyzn1kn0tmZXlr1mOioV4+Weh2gW/k7m1EH903+V2LRHT/rn0dyDAkFpxODRUi7csv0jC1VU4WNDHIbjrnkeotBjZt8Ga3th5SdnkZ9wVbt+XTBtnRBIAimHcO2lO2UEwldOqxW8nAW2LbIDfsN5VF7S4ukb4wS8x8RlHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791320; c=relaxed/simple;
	bh=dxDEy3Ofp3BOYT0Im+CkYgv7qvt95bsEmjU7sRJ9nQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/aF3Cj0ybDLOyGhdX+XhByy9SdJJUduV9r7H6Et+dySxx+xhm/DRtKtLb/tIwjwjETGnzOqmXko3QVq+wJRtNiOweiq9oWPUZNl1nIiw8OV8gb7rVhDONErjz6gTOkUypsoe/7Tussi+D2uHoBMr/iLWuae8w4Ip8Xu2Cdg6hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lywpdKPr; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49OHZ5EN029614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 13:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729791306; bh=THgZTjgepZWEIghS4JPw/+y40a1os2Kh9HRPApjh/t0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=lywpdKPrC66vtufIFAhSkiaAn4gKYzeIrHFw9mZRsd5RncMll/SGI/E3YJgUnY7Xa
	 ykp0s7TZhnNKCUeULcD8bf+MSLRBDpPNgEg4pGwZhQjEmoWTPH0uqeoTBCTeCEp48x
	 e4wAS50XkH9kEvzwDHEUc2D4rzXgVbKgMFOHCDnnw7F13gChzWg7KVEM5/LhKN9xl3
	 d4Jh4fm19vN+UhCElBSOCuwtN4pIbXUYk1kbjkjCQvRDBa/j4Ob+sH6NhYFtMVauIQ
	 VHlIrbk5K6dNa4wpqdhV8+3n3s/0gqeVevLiZSPYDKXY01LqMm+lMDpC+xcjesw5aN
	 aDdgj3YClK0QQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E584815C0329; Thu, 24 Oct 2024 13:35:04 -0400 (EDT)
Date: Thu, 24 Oct 2024 13:35:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hantong Chen <cxwdyx620@gmail.com>
Cc: james.bottomley@hansenpartnership.com, ajhalaney@gmail.com,
        allenbh@gmail.com, andrew@lunn.ch, andriy.shevchenko@linux.intel.com,
        andy@kernel.org, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
        broonie@kernel.org, cai.huoqing@linux.dev, dave.jiang@intel.com,
        davem@davemloft.net, dlemoal@kernel.org, dmaengine@vger.kernel.org,
        dushistov@mail.ru, fancer.lancer@gmail.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, ink@jurassic.park.msu.ru, jdmason@kudzu.us,
        jiaxun.yang@flygoat.com, keguang.zhang@gmail.com,
        kory.maincent@bootlin.com, krzk@kernel.org, kuba@kernel.org,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux@armlinux.org.uk, linux@roeck-us.net,
        manivannan.sadhasivam@linaro.org, netdev@vger.kernel.org,
        nikita.shubin@maquefel.me, nikita@trvn.ru, ntb@lists.linux.dev,
        olteanv@gmail.com, pabeni@redhat.com, paulburton@kernel.org,
        robh@kernel.org, s.shtylyov@omp.ru, sergio.paracuellos@gmail.com,
        shc_work@mail.ru, siyanteng@loongson.cn, tsbogend@alpha.franken.de,
        xeb@mail.ru, yoshihiro.shimoda.uh@renesas.com
Subject: Re: linux: Goodbye from a Linux community volunteer
Message-ID: <20241024173504.GN3204734@mit.edu>
References: <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <20241024165650.174-1-cxwdyx620@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024165650.174-1-cxwdyx620@gmail.com>

On Thu, Oct 24, 2024 at 04:56:50PM +0000, Hantong Chen wrote:
> 
> For People???s Republic of China, there are about 500 entities that
> are on the U.S. OFAC SDN / non-SDN lists, especially HUAWEI, which
> is one of the most active employers from versions 5.16 through 6.1,
> according to statistics. This is unacceptable, and we must take
> immediate action to address it, with the **same** reason.

There are multiple sanctions programs, and at least in the US, for the
sanctions program which Huawei is in, there is an exception for
conversations and patches that take place in a public mailing list,
such as LKML.  As a result, as the ext4 maintainer, I am comfortable
taking patches from engineers employed by Huawei, and I consider them
valued members of the ext4 development community.

However, note that China is *not* actively attacking Taiwai
militarily, while there are Russian missiles and drones, some of which
may controlled by embedded Linux systems, that are being used against
Ukraine even as we speak.  Hence, it should not be surprising that the
rules imposed by the US Government might be different for Huawei
compared to other sanctioned entities that are directly or indirectly
controlled by the Russian Military-Industrial complex.

There are also other sanctions regimes imposed by Japan, European
Countries, etc., which might be more or less strict.  So in general,
if you are not sure what you need to do as an US, European, Japanese,
etc. citizen who might be subject to civil or criminal penalties ----
talk to a lawyer.

The bottom line is that it is a false equivalence to claim that
sanctions involving China and Russia are the same.  They very much
aren't; one country is engaging in an active shooting war (or if you
prefer, "special military operation"), and the other is not.

Of course, if China were to militarily attack Taiwan or some other
country in Asia, circumstances might change at some point in the
future.  Hopefully Chinese leaders will pursue a path of wisdom and
those consequences won't come to pass.  Ultimately, though, that's not
up to any of us on this mail thread.

Cheers,

					- Ted


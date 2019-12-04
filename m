Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18B7112A10
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 12:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfLDLZg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 06:25:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52960 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLDLZg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Dec 2019 06:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hdUxh+e5zga2P0izFHRNT+NvrTWWB1D5/zTtECXmmq4=; b=JTagQtuptdU5UemcVWdOQJIEh
        OFH0vts2gKpQ1iiBkapQsyR1uePy39eUQAY7BJ/+fB9bAUDO2VYQODwUMn71zG6WIgJfX6qRmpZf/
        1V9HQRS4ftqviYmdfALJmhYlBruoSZe9S2aCE53/83tgZxOxHKBdTUZ0ksbJ5QycveCPo=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1icSme-0008Ib-VB; Wed, 04 Dec 2019 11:25:28 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 33793D003B4; Wed,  4 Dec 2019 11:25:28 +0000 (GMT)
Date:   Wed, 4 Dec 2019 11:25:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 4/6] spi: Add SPIBSC driver
Message-ID: <20191204112528.GQ1998@sirena.org.uk>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-5-chris.brandt@renesas.com>
 <20191203141944.GI1998@sirena.org.uk>
 <CAMuHMdXk5DDebriHxmtz0NWF_zDhBK=fBZugdUfmEAyU0O4zMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tuFXEhzhBeitrIAu"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXk5DDebriHxmtz0NWF_zDhBK=fBZugdUfmEAyU0O4zMQ@mail.gmail.com>
X-Cookie: Cleanliness is next to impossible.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tuFXEhzhBeitrIAu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2019 at 07:29:45PM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 3, 2019 at 3:19 PM Mark Brown <broonie@kernel.org> wrote:

> > > +     pm_runtime_put(&pdev->dev);
> > > +     pm_runtime_disable(&pdev->dev);

> > There seems to be no purpose in the runtime PM code in this
> > driver, there's no PM operations of any kind and the driver holds
> > a runtime PM reference for the entire lifetime of the device.

> It matters for the clock domain (assumed the module clock is not always
> marked as a critical clock).

That seems like a problem with what the clock domains are doing
surely?  The default is supposed to be that if runtime PM isn't
enabled we get the behaviour the driver is manually implementing
here.  Besides, if this is actually impacting power management
I'd expect us to be letting the IP idle rather than holding it
powered up all the time.

--tuFXEhzhBeitrIAu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3nl6cACgkQJNaLcl1U
h9Afawf/eQgbC66Cwx3RMeN7sk9wUXZAUk4TZVle+80Hk2LVcIERFOsvc+2dW0fI
3ABYuDo501oIhvMzblGlvwwGaiTwLE6RQRgI0GKdfo5YFUB6FxfoCWYvXeqebpSi
V/jasYVMSHF8/dBRx9zfQFQeBgLxNAjDUH7x0qMFuLJcU8XzpKXylnmt29xG3SzU
4v4hlYGlI5Wiz0HqS11737iiGbyn485NEZbUoIl8lMgVQeTEBjSYRb2zJdGAv2He
Wnq1FqodOSaXgUZPDAOAE62whmZT3nc2R3B9mnakoeDrW/CvRhSYuqeZxwxBH0II
j6EcEn5PVMY3Dj9hqZH/mAHn1eY9tQ==
=SEvO
-----END PGP SIGNATURE-----

--tuFXEhzhBeitrIAu--

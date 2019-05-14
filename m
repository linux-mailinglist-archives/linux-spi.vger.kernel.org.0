Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E079F1C610
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 11:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfENJan (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 05:30:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfENJam (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 05:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ogUgaaH2FccQD+ItDmWrUWM6+03M0Do2XSZMnpUHceY=; b=CJ3twDJ4Ss3i508fdPmdK/zRj
        R7w67ibexGoEp29YCWd9SiSVlvTj16CEgFg2trAJl1h1ZwgmIrK363txkHxSuF5/DNZi1u2TvqUNZ
        iSig4jcBBeg/ZVnrzkBv8EXUH95t3/LhNkfA3b8QWtDIC2eyWjNhReN3DdBZEu7C66eIQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQTlf-0000a2-Bf; Tue, 14 May 2019 09:30:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CB7981128518; Tue, 14 May 2019 10:30:38 +0100 (BST)
Date:   Tue, 14 May 2019 10:30:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 1/4] spi: For controllers that need realtime always use
 the pump thread
Message-ID: <20190514093038.GB8665@sirena.org.uk>
References: <20190510223437.84368-1-dianders@chromium.org>
 <20190510223437.84368-2-dianders@chromium.org>
 <20190512073301.GC21483@sirena.org.uk>
 <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
X-Cookie: Information is the inverse of entropy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2019 at 01:24:57PM -0700, Doug Anderson wrote:
> On Sun, May 12, 2019 at 10:05 AM Mark Brown <broonie@kernel.org> wrote:

> > If performance is important you probably also want to avoid the context
> > thrashing - executing in the calling context is generally a substantial
> > performance boost.  I can see this causing problems further down the
> > line when someone else turns up with a different requirement, perhaps in
> > an application where the caller does actually have a raised priority
> > themselves and just wanted to make sure that the thread wasn't lower
> > than they are.  I guess it'd be nice if we could check what priority the
> > calling thread has and make a decision based on that but there don't
> > seem to be any facilities for doing that which I can see right now.

> In my case performance is 2nd place to a transfer not getting
> interrupted once started (so we don't break the 8ms rule of the EC).

That's great but other users do care very much about performance and are
also interested in both priority control and avoiding context thrashing.

> My solution in v2 of my series is to take out the forcing in the case
> that the controller wanted "rt" priority and then to add "force" to
> the parameter name.  If someone wants rt priority for the thread but
> doesn't want to force all transfers to the thread we can later add a
> different parameter for that?

I think that's going to be the common case for this.  Forcing context
thrashing is really not something anyone else is asking for.

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzair4ACgkQJNaLcl1U
h9DoXAf/fzz5EFthAbXe19mb473HQldgqE56pd7CBSi1QQH5k+puSKto+29/CYoj
aZR8w3Cn56+X0xB3rPvvkQzvpr/Och2AYJ2EX4lbrX/YnLEPjlZwaYUbZWFh/mLi
5lgWO8TLgLafUNknlatJCG/fh3MTBOxKtKNi8awjM7ucNn+/h0COCeml9nPe6IGg
x+FlA7n4W4jrUbcndTHtUeW0JudK6IP4+eGImK6alhoz0YiIsmo1lWUPzDAtW2zC
iOMaS3WleNJRO4VS5wmQMAmmjjvg/fKLbeZLQRDcRir6eiHZbwCW5R/b3K7aMNh2
AXHNWcOHpgqSOu3CNcqik6IZyox8vw==
=ktFw
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--

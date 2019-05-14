Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E47A1CB55
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 17:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfENPGM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 11:06:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52172 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENPGM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 11:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NQhfVy0qFNuvDpdRYcvkTlDsVD03kBM9D8DvgCnqBPc=; b=Dl5/ocQVDpG/+WUNiJvVsFRBD
        +ZkCa4teBLvzobqhtymTMHwRMN1560TtLfuX8i3hGHz4nH+aHwmDrQig/arE4f8Em+vwjmiclnVGl
        axaSq2p7TChHq11t36ylMJH87h10VU4zL8+zHyONdqsNUd+YcPZIwuVXIdQZS4Oswg+7w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQZ0K-00015Q-Ac; Tue, 14 May 2019 15:06:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 85DBD1121EE8; Tue, 14 May 2019 16:06:07 +0100 (BST)
Date:   Tue, 14 May 2019 16:06:07 +0100
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
Message-ID: <20190514150607.GA1917@sirena.org.uk>
References: <20190510223437.84368-1-dianders@chromium.org>
 <20190510223437.84368-2-dianders@chromium.org>
 <20190512073301.GC21483@sirena.org.uk>
 <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
 <20190514093038.GB8665@sirena.org.uk>
 <CAD=FV=UXhQg2CuNsTCkSe1BuEvkGMj6qeUB2iF=Qfj=Z0fLiWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <CAD=FV=UXhQg2CuNsTCkSe1BuEvkGMj6qeUB2iF=Qfj=Z0fLiWw@mail.gmail.com>
X-Cookie: There is a fly on your nose.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2019 at 07:42:38AM -0700, Doug Anderson wrote:

> ...but I guess you're saying that you don't want to guarantee that the
> SPI core will happen to have this thread sitting around in the future
> so you'd rather add the extra complexity to cros_ec so the core can
> evolve more freely?

We need something to support spi_async() but what you're asking for is
fairly specific implementation details about how things are currently
structured, and we do need to be able to continue to make improvements
for users who are interested in performance.  Ensuring that the calling
context is also less likely to be preempted is going to make it much
less likely that any other work is going to cause some timing change
that creates problems for you.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlza2V4ACgkQJNaLcl1U
h9BdzAf+KMVQaYP9/vNw0i0uGrveiVFMzejKMkn1HLO53K5CGl+UPRj+Y2OYUy/4
o4zonygqZNCkn+XY4BVZHOGInN1sb2Vzp6Ky1kuw76YxxwL+xKsLuua7+HQ9bCQM
oVh1Okwky0twqGK78DMtZpfRrYyetWfXA6teiW7G3LZ9+eEd0hXuVVGamq9lzDlM
zYR8ar3mdRRJmW8JGkJSE0t6Q03CMoeVPoNT8TUs41QnLfNOi/shVZ5kRwbuyoTA
PZGyAEjbIEYmMe7UR09ePu685ymCtrO9KjqplYeBQBOaUm6KqjURqrJBGWhVyLqF
sRSuDvQVfjGjiNbqlpfc7QsEj0HaLw==
=RN96
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

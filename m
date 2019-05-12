Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10651AD5F
	for <lists+linux-spi@lfdr.de>; Sun, 12 May 2019 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfELRGV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 May 2019 13:06:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49570 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfELRFt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 May 2019 13:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JGyDpXs0z4qP/VLm+QIIvl6tLAm7ZejvyxnTMOgb8/o=; b=kPQ9K/GcuDxCVWrz7TmQZp9qq
        uWbtRKu5SSeuFIwTtJ5d4MgiHwpuqoLAndskrb2iTEFu8Oy0KiEKGW9bJtjSm09or+/MMBizPkRjh
        xZ80jRTm/E1gPRhYoiX0p7977HVfVdo76T9WcZCaiG+QNMAvdXQlpqpb2QcZ/OGfCksrw=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPruu-00044g-9y; Sun, 12 May 2019 17:05:40 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 44E0644000C; Sun, 12 May 2019 08:33:01 +0100 (BST)
Date:   Sun, 12 May 2019 16:33:01 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/4] spi: For controllers that need realtime always use
 the pump thread
Message-ID: <20190512073301.GC21483@sirena.org.uk>
References: <20190510223437.84368-1-dianders@chromium.org>
 <20190510223437.84368-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <20190510223437.84368-2-dianders@chromium.org>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2019 at 03:34:34PM -0700, Douglas Anderson wrote:
> If a controller specifies that it needs high priority for sending
> messages we should always schedule our transfers on the thread.  If we
> don't do this we'll do the transfer in the caller's context which
> might not be very high priority.

If performance is important you probably also want to avoid the context
thrashing - executing in the calling context is generally a substantial
performance boost.  I can see this causing problems further down the
line when someone else turns up with a different requirement, perhaps in
an application where the caller does actually have a raised priority
themselves and just wanted to make sure that the thread wasn't lower
than they are.  I guess it'd be nice if we could check what priority the
calling thread has and make a decision based on that but there don't
seem to be any facilities for doing that which I can see right now.

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzXzCcACgkQJNaLcl1U
h9AjOAf+MXPHyjoQyfbJn08k/H8FZGylRFAxKaq4gxN0q4GV4ErRQ4izUJ80gQ5U
sCbdavMU+2u2yZ8yl/uthfJzXlmpViMGmi/nnHwRcPunHFz1nBmA9sZ4/ODkIj8N
cCWjLrCRxeE9e23yjIInTgiMkgg2DgSeA+0kVbtg4S0gyIM+POpLXtN6thC9bi0N
+ZVukER12euMeuVoruZ9jAo52XBhVjj2tpFK18N+bbgIMKB1T2qrd1Fp2r3H6+ty
GQsyEb/f1XN0NXaLDI5wunSFe0EiUe6P6rZuu4p9ZTyPhg663C+JsqU72Rj8EBXA
qT+vCFKYWKPzapEj1LDuT9p+DyPnyg==
=aJHR
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--

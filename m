Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E64C332D54
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 18:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhCIRdG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 12:33:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231684AbhCIRcu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Mar 2021 12:32:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D16065243;
        Tue,  9 Mar 2021 17:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615311169;
        bh=VFbScGeAoDdj2Sh9Zvk1ZnWvGSEooiTDYdh4v3EdTWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NszFLNeF/pDGY+H5QiGM0FO7BfyH4eZpunjoFN1PcjVWvCbG9H0Bd5acI5xK+cO3v
         u/N5y0zyoXYiUOjU//S10K6VUMOjKabaWptQPOoAgzQJDMpUIefP4d5BexFgvi4qNW
         ZMo9zLVnRLV1RnJygGt8ZKmkTxSPAy7bTkfW4xFI6/bWLV6Ix6GoA0h7Kw+su1X0Gj
         MPCyqZZVr3nTUPQ3F5lxXP7Q2IIz1DzyCNjVvTDKFbYSOMJ6jsiOq042O3Sx484Ll0
         HApciLxYmyuzk/YdnKdyLmrO6kl1zz/yaeE+/OexJEXrC1XAmSsiO+jWD+pSRDl3Cg
         ibHCIUGal4iow==
Date:   Tue, 9 Mar 2021 17:31:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: Re: [EXT] Re: [PATCH] dt-bindings: spi: Convert NXP flexspi to json
 schema
Message-ID: <20210309173138.GC4878@sirena.org.uk>
References: <20210309103528.3538910-1-kuldeep.singh@nxp.com>
 <DB6PR0402MB275834FAF7CEF44AB7F342B2E0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
 <20210309123601.GA4878@sirena.org.uk>
 <DB6PR0402MB275840529A4F50EBFC723E1AE0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB275840529A4F50EBFC723E1AE0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 09, 2021 at 05:30:00PM +0000, Kuldeep Singh wrote:

> > Binding patches generally go through the subsystem tree so please send the patch
> > to me.

> Thanks for letting me know.
> I have developed the patch on top of your tree and also sent to spi-devel mailing list.
> Please see [1] for more details. Kindly let me know if I need to resubmit the patch.

Like I said in the mail you're replying to please send me a copy of the
patch.

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBHsPkACgkQJNaLcl1U
h9Az/wf/eRSnvQaBrTQNzpUWfZ+Vn/6SldK3FKgsQfqXA2i4wUMLQd0Uap2kfDR0
Gk1BzIwBrKlPcE05W+IJqOrGc/SGWsyT/PHzSCWAa2N8TmC8DKRl4AeeyWr4Uary
2kJhRfLsdjkcLPAHqF+GqNRldk5GbzhlELh19P+ZeS9cnzWEm0gkTXa10rLNJ9vb
fH6yQB3EVjR+wT/TsEt3vaCnx6on8zB4892+8IbL0b5RtWIP7G4wcsBacWloMPR8
KR/a8aIOPiFmTZuwvJkeV2QLmGYoVIKzsT4yKD0gTvd2MrLu7WJrwMme5lIEWlMI
1HpkA+46Lo+8ctoeiw+DIv7OCmxntQ==
=vQjl
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--

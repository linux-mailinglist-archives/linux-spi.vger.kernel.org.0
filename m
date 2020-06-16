Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381431FAC7F
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 11:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgFPJeu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 05:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgFPJeu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 05:34:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BA020707;
        Tue, 16 Jun 2020 09:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592300089;
        bh=sOTSecSDlMQMDoFHDdpFc3ktt3G48k6VVa+1SlZBWHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ae6cBzzlyjBwtU7AYEbViH6fHd7Z+VZkZNM5+Y2b4l5YPPryaZpav4tmxYdNywuW0
         mEsO9wbSpPKMiYafcHBUIJ9vVUjcTN75NlSvWneF2Ykw+RVxDfAtYzMd2tn3sjoCPv
         JEBDJtyTKSrmIzi+JtbwkSv4Pvpp3raKgUz5+TA0=
Date:   Tue, 16 Jun 2020 10:34:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-spi@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-renesas-soc@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>
Subject: Re: [PATCH v4] spi: add Renesas RPC-IF driver
Message-ID: <20200616093447.GI4447@sirena.org.uk>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1ece0e6c-71af-f0f1-709e-571f4b0b4853@cogentembedded.com>
 <159226448570.27735.17453498854310254061.b4-ty@kernel.org>
 <6fd4533e-c548-5d14-2d21-96efa0c58a0b@cogentembedded.com>
 <20200616083856.GF4447@sirena.org.uk>
 <4c78964b-92f2-ac02-e2f6-a76cfc844b8a@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p14GW7TY4DvKqgVo"
Content-Disposition: inline
In-Reply-To: <4c78964b-92f2-ac02-e2f6-a76cfc844b8a@cogentembedded.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--p14GW7TY4DvKqgVo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2020 at 12:26:46PM +0300, Sergei Shtylyov wrote:
> On 16.06.2020 11:38, Mark Brown wrote:

> > Those aren't merged yet?  There was no mention of any dependencies in
> > the patch, no feedback for months on the patch and I've not seen any
> > ongoing discussion.

>    I thought the below passage was speaking for itself:

> <<
> It's the "front end" driver using the "back end" APIs in the main driver to
> talk to the real hardware."
> >>

>    Sorry for not being clear enough...

That tells me that there's a back end driver, it doesn't tell me that
the back end driver isn't merged yet.

--p14GW7TY4DvKqgVo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7okjYACgkQJNaLcl1U
h9CX6wf5AU1untLzfJ0FhjpLVjkXeyBMek7W7fWbE4oYRr5To70RpvbvTY9elPet
Yva/CkEj+3jFbLwYdgYlozkthi/m/yaJaAVaKmbPEoAjvZQXztq+UW5rkXEDWrVZ
GVSKgVEpqx7qcW1d+vVSz8JTUMXOFZCnOoAMIt4hjUenIHlHIEVUWWyKiDXDfjel
afqJnYJj/+YEPM/dCnPGxbF2mXjiWK9vdF7OfKwiQu8BW1EikdnY0TQsfqNCBhi9
ZVevqVDVRCoveWkgLITn8reoECDCthA+pKXrcezLr7JNeXGpzx7Ag/T7HCotrykr
Sa/XnfMWkuhkARQ98PV1+Mb9gVLSsQ==
=6+DT
-----END PGP SIGNATURE-----

--p14GW7TY4DvKqgVo--

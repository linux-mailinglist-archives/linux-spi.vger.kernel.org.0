Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAED23EEAD
	for <lists+linux-spi@lfdr.de>; Fri,  7 Aug 2020 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHGOIT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Aug 2020 10:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgHGOCT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 7 Aug 2020 10:02:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20F822224D;
        Fri,  7 Aug 2020 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596808938;
        bh=Nq2JecjJJ2Z47G+FHeaADlyOH9UevSA0HjMpAG9yT1c=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=cTdICk+EnK0Kj6gH8d7mfPrKW+er46oVHRtYd7mBBErr1mld4c1pFeiyNl7xR/F1D
         G6FSSuWv+tXQsZx4KXMIHeKTqMVNQHSToiTHjROKhMNGAPp2iNUzdo9GA+kVR+JVMq
         iztElsuG0IBOfqHXKU/guabRk3b3fr6J9ZNzT2BM=
Date:   Fri, 7 Aug 2020 15:01:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     amelie.delaunay@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCH 02/18] spi: stm32-spi: defer probe for reset
Message-ID: <20200807140154.GK5435@sirena.org.uk>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
 <1596610933-32599-3-git-send-email-alain.volmat@st.com>
 <20200805104906.GB5556@sirena.org.uk>
 <20200807134254.GC12946@gnbcxd0016.gnb.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wRokNccIwvMzawGl"
Content-Disposition: inline
In-Reply-To: <20200807134254.GC12946@gnbcxd0016.gnb.st.com>
X-Cookie: Disposable, use only once.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--wRokNccIwvMzawGl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2020 at 03:42:54PM +0200, Alain Volmat wrote:
> On Wed, Aug 05, 2020 at 11:49:06AM +0100, Mark Brown wrote:
> > On Wed, Aug 05, 2020 at 09:01:57AM +0200, Alain Volmat wrote:

> > > -	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > > -	if (!IS_ERR(rst)) {
> > > +	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
> > > +	if (rst) {
> > > +		if (IS_ERR(rst)) {
> > > +			ret = PTR_ERR(rst);
> > > +			if (ret != -EPROBE_DEFER)
> > > +				dev_err(&pdev->dev, "reset get failed: %d\n",
> > > +					ret);
> > > +			goto err_clk_disable;
> > > +		}

> > This will not provide any diagnostics when deferring which isn't very
> > helpful if there's issues.

> Do you mean that a message when deferring would be needed ?

Yes, if for examaple the reset driver isn't being built then the driver
will defer for ever waiting for it to instantiate and the user will have
to have some method for figuring out what it's waiting for.

> I am worrying that this would lead to having too much noise during boot
> since probe deferring is kinda common. Of course it can also be due to a bad
> configuration of the kernel as well but having looked around I think that
> usually driver are rather silent in case of deferring.

This is not something that should be open coded in your driver.

--wRokNccIwvMzawGl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8tXtEACgkQJNaLcl1U
h9BqXgf9FVvSpPdiOACOZ2KYlaKp6j56CVuoPUPAXXzIt71nFzRazygx93NK217I
gUi15e+61Sq2l+aZwLTsp709lQeMPW7PfwAh/hnpKMDuIgnJ6jczJBJ7d6qW3xWC
xvavGmDtGplrRboW7gKWumFUqbionYJCJHgS1hT0mHbmmabyzPRoyAhfhVGXdMV0
xh7ROAKKV2TmT3UvlcA1f8RDK9BkikFCP40l/waqnNMRli5dqEZ9jIywKb8+Ifo2
ePtCPrbzssFSMy2QxA8YvgWYuAuTY40nE85v7JCJMcCnfvpCIwU4g7NEevdiZsAp
ft3H/L+jZnGX3fLrE3sx1NWJf7Md8Q==
=7mj5
-----END PGP SIGNATURE-----

--wRokNccIwvMzawGl--

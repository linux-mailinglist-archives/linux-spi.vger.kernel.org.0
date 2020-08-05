Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA93823CA2E
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 13:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgHELKR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 07:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbgHEKt3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 Aug 2020 06:49:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6197C2173E;
        Wed,  5 Aug 2020 10:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596624568;
        bh=TuD7rFAbWeXGXfO48w+uANMpsm8+3sr+qVMoZIj74Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mznLBtYSdMwh7Rxb/WqB+6kygGvOEhGgtGchcIiA5nuPKrsZvrCMIk247BwdWV6GP
         4gm+EBZY8HCesibxRB/KHu2NGYSyhprYQk17/JkgBIHtxRB4ZzmZAQFrwTD1STA0vj
         pBJ+ur/kPc/lYpZhzjRvd241Ozw3HBi+xm+v36yE=
Date:   Wed, 5 Aug 2020 11:49:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@st.com>
Cc:     amelie.delaunay@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCH 02/18] spi: stm32-spi: defer probe for reset
Message-ID: <20200805104906.GB5556@sirena.org.uk>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
 <1596610933-32599-3-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <1596610933-32599-3-git-send-email-alain.volmat@st.com>
X-Cookie: Fast, cheap, good: pick two.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2020 at 09:01:57AM +0200, Alain Volmat wrote:

> -	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> -	if (!IS_ERR(rst)) {
> +	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
> +	if (rst) {
> +		if (IS_ERR(rst)) {
> +			ret = PTR_ERR(rst);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(&pdev->dev, "reset get failed: %d\n",
> +					ret);
> +			goto err_clk_disable;
> +		}

This will not provide any diagnostics when deferring which isn't very
helpful if there's issues.

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8qjqEACgkQJNaLcl1U
h9AfFgf+Mr4pGgE8brqH0oVCwN0GR7P/KHKjoEu7C48dCVJ/Lafn8xQ56JOQEt2Y
QtnuobjoB+Aki1qqzYB7AdBhSbcGzn7nn11us2yX9l8mfTEEabJzpjGRVvWEazYq
pQAm0glN9EyuWJXFu8Fhi/VKCAHVJCuQ3oPovefH1zqgO9iF0nVGmq0BFYUR4aGI
tggDXwwrdiEZYcsgvdQjLc3SV+sur+7rgnRyLcZXYyfuWCrQVDbH88TdzpuZAjok
TCMjGsG0hg34iAYLI5+5W0TQyFvGyc9IVrLOC680ApM4xsJAJhDeXugzRqKDpYIv
zvam9f0cn5IjneizIVbdkkKzvfsz1g==
=0sVy
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--

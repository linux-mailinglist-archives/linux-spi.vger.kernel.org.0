Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E1219F05
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jul 2020 13:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGILXD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 07:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgGILXC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 9 Jul 2020 07:23:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C72D206DF;
        Thu,  9 Jul 2020 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594293782;
        bh=GZsuUdV2fR+cexBuBiwATZKR9qC/pImyIYyN7vUt0pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5JnIcYPUUv6cgvWNYHxjV0AGnrzOtGgawN20DWXQ/mJXoDfP3SIJODtTaRKnYLAY
         j12Q1Gofg6uptdq+dAJzd5rYijGgIDBFLgV1VahuSQvpUxO6N/d21LtWQ795fnwYtt
         wBvQnHqlfHB+V/KewhYAr4Z+5sz0MUs73mg7Mqq4=
Date:   Thu, 9 Jul 2020 12:22:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, akashast@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        georgi.djakov@linaro.org, swboyd@chromium.org,
        mkshah@codeaurora.org, ctheegal@codeaurora.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Set the clock properly at runtime
 resume
Message-ID: <20200709112257.GD4960@sirena.org.uk>
References: <20200708163922.1.I0b701fc23eca911a5bde4ae4fa7f97543d7f960e@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline
In-Reply-To: <20200708163922.1.I0b701fc23eca911a5bde4ae4fa7f97543d7f960e@changeid>
X-Cookie: You will be married within a year.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2020 at 04:39:39PM -0700, Douglas Anderson wrote:
> In the patch ("spi: spi-geni-qcom: Avoid clock setting if not needed")
> we avoid a whole pile of clock code.  As part of that, we should have
> restored the clock at runtime resume.  Do that.

Acked-by: Mark Brown <broonie@kernel.org>

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8G/hAACgkQJNaLcl1U
h9DnAwf/SUxH1GBgcKZnVJlYTtC7aB9YAOL9mr/WFDRoHJML8jpX7HfaybGJdSml
MPTLvdHIw5W4f3/o2PdhEzgGT/x5eFsxvDnyiwiSLM53hVJpnMBtWG0DRxCeIpct
PeRNtSqVsk/VfqHOSMwpwtsE0m1C3CAywDhsw8/6F2AIvDhu083EWK+O9KyHtNaM
Rl4FyMKX24j9bjGn7madZXnFil8/7Z0JcS0eQ0fqyV61Qwl5HErpkiEAsKyO3HnL
nJdheDl93MC/lQcqqRoFkz7dAcbdhIRwoCehgxOQID+AHsaLqOlielJAQeTLPpQ9
Us2Dw5+HjsqZBmVflkGZFLwR9t4t1g==
=gQBC
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--

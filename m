Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB08207B22
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jun 2020 20:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405901AbgFXSAI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Jun 2020 14:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405538AbgFXSAI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 24 Jun 2020 14:00:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B05320823;
        Wed, 24 Jun 2020 18:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593021608;
        bh=2UitKT4K/Va+jamxjwCKoZ96M6fFhFnTIM3vNCb7ews=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jxGGDXD+7FCXVcwlZhZqXBvq1DvyW+uYJzZaxydTJA9wNhMM48Hg5B07C2qbyhUL7
         0N81zxTi7/Yc7UgSCqScAA9ETzJLN54jI09xUJuyiIkWZKqd6Sj+Nu2lk8uhLWH+GT
         PyW14MTtkb3MRiWt9bG4/hf0QASBtnHr7eLWoP/Y=
Date:   Wed, 24 Jun 2020 19:00:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, bjorn.andersson@linaro.org,
        agross@kernel.org, robdclark@gmail.com, robdclark@chromium.org,
        stanimir.varbanov@linaro.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v6 6/6] spi: spi-qcom-qspi: Use OPP API to set clk/perf
 state
Message-ID: <20200624180005.GO5472@sirena.org.uk>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
 <1592222564-13556-7-git-send-email-rnayak@codeaurora.org>
 <20200624170933.GB39073@google.com>
 <20200624171537.GL5472@sirena.org.uk>
 <20200624173948.GC39073@google.com>
 <20200624174417.GM5472@sirena.org.uk>
 <20200624175536.GD39073@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oJAv8lSwuaQsYd0G"
Content-Disposition: inline
In-Reply-To: <20200624175536.GD39073@google.com>
X-Cookie: So this is it.  We're going to die.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--oJAv8lSwuaQsYd0G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 10:55:36AM -0700, Matthias Kaehlcke wrote:
> On Wed, Jun 24, 2020 at 06:44:17PM +0100, Mark Brown wrote:

> > Wait, so *some* of the series should go together but not other bits?
> > But you want them split up for some reason?

> Yes, this will almost certainly be the case, even if not for this patch.
> I brought this up earlier (https://patchwork.kernel.org/cover/11604623/#23428709).

I'm not really reading any of this stuff for the series as a whole, as
far as I could tell I'd reviewed all my bits and was hoping whatever
random platform stuff needs sorting out was going to be sorted out so I
stopped getting copied on revisions :(

> For the QSPI patch you could argue to just take it through QCOM since the SPI
> patch of this series goes through this tree, up to you, I just want to make
> sure everybody is on the same page.

If there are some part of this that don't have a connection with the
rest of the series and should be applied separately please split them
out and send them separately so it's clear what's going on.

--oJAv8lSwuaQsYd0G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7zlKQACgkQJNaLcl1U
h9CrTQf/Vg2E6duvaq65qFsFKS/aluS0uK8RMRY4XebTQ8EzKerzfY2M5BG+G78p
rXdzGDqWdLhmofORK0GP8dFjJO8SQPuGs1yMyQSSNom7oe816OOF3H4zP0y3g09u
teC+rFX5q4vtZlqsiiLkO7dscWNR6Ee2ezUWFVNIfIpQR8xTzL63shWO5dYTWsI6
+fYLfWPWRQkTUxTP6R46j4SoTIikF6clMqsXocztZG+UapaLlf5ttfQTRyNv+fGU
IK1TOePE14Cb2f47WxSnccI6BE+Pj7V/ixQHF9JMjR2veIYzKQ3poRoSNj+OiN3j
sv2FJuPzEyc4agZNugHJlMZvCPvDfA==
=ZMZQ
-----END PGP SIGNATURE-----

--oJAv8lSwuaQsYd0G--

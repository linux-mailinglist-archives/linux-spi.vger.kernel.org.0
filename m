Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCBF213DDB
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jul 2020 19:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgGCRCA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Jul 2020 13:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGCRCA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 3 Jul 2020 13:02:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64A2920870;
        Fri,  3 Jul 2020 17:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795719;
        bh=AVJrPOjfhMUmYb1TDhafBafhvg6rnvMe4npAxWh18Dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wkf3VcfsBj9P8AZjTyoNjuZOMdIVGUF3QYBhfuog8lBLpeBBntWKfEPEu1bASEQcR
         BcoEJkf3pROoo8iPLK5oTahEk/gw05ZLqnPjBVvlILijD7ZL3jE8CpwVCFHD5M/pz/
         tM0gR1Y5pf+hEwIO6g+OnYxtG3Z8cxzC+i9Wi3nw=
Date:   Fri, 3 Jul 2020 18:01:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mka@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH 1/3] spi: spi-qcom-qspi: Use OPP API to set clk/perf state
Message-ID: <20200703170157.GA54804@sirena.org.uk>
References: <1593769293-6354-1-git-send-email-rnayak@codeaurora.org>
 <1593769293-6354-2-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <1593769293-6354-2-git-send-email-rnayak@codeaurora.org>
X-Cookie: Think honk if you're a telepath.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 03, 2020 at 03:11:31PM +0530, Rajendra Nayak wrote:
> QSPI needs to vote on a performance state of a power domain depending on
> the clock rate. Add support for it by specifying the perf state/clock rate
> as an OPP table in device tree.

This doesn't apply against current code, please check and resend.

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7/ZIQACgkQJNaLcl1U
h9Aj6Af/dYdA3cL8GaheYWhZs8vCjA6NUcA4NrW+BJ5F/+4RGRN47h4pPc6eXiEI
Ppr5ZbEPhkJg5s/RZLbQDZIXZPMlnW+pUY+XuUcRu9iSuSv//YMOfr2q/jkwE0c4
TIRj73HH6jK49Mfwlf5tNYuzyjGyN7Sc80yc7TnSuczz03KAnWWUUKXVS2ZwXW5z
BB4dOtfgSzr+r/KlS1kmaI8+FwbkRAelhSWstX3tMxcYs4XZ4I+SQESx0sGVRLzx
g8R5TmM2ksb1gvF7FySNqQ2Pgdgh0rsdoYP6lPMUjYyCTIgOLzMNGlhrDuVICRL/
IZJT/Id+JEFVxnHBKWmeOHJXT/wnYg==
=0VKA
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275F01E1FDE
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 12:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbgEZKjX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 06:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgEZKjW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 06:39:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 095D8207CB;
        Tue, 26 May 2020 10:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590489562;
        bh=mixvD35IMO/Rax98V2E/ba8PwGROnQxp9SkSn8T/kTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Str6dfmPduJDJXafCVdmwQqKiJ/g+CwTRg2EU02IYz5WFCVKbX188v6VTXmjxnCO/
         E0nyCRmnGtx5tRCE/WHvoVd2A7dEsFQ7+bw1KgjT4NdlDOS1Pbd1T/gQEyOBNOlPvY
         cf67M5T16DMfjhGo1RYru5FiMmVlkq2Gi6i+xoIE=
Date:   Tue, 26 May 2020 11:39:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v5 2/6] spi: spi-geni-qcom: Use OPP API to set clk/perf
 state
Message-ID: <20200526103920.GB4607@sirena.org.uk>
References: <1589368382-19607-1-git-send-email-rnayak@codeaurora.org>
 <1589368382-19607-3-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <1589368382-19607-3-git-send-email-rnayak@codeaurora.org>
X-Cookie: Hailing frequencies open, Captain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2020 at 04:42:58PM +0530, Rajendra Nayak wrote:
> geni spi needs to express a perforamnce state requirement on CX
> depending on the frequency of the clock rates. Use OPP table from
> DT to register with OPP framework and use dev_pm_opp_set_rate() to
> set the clk/perf state.

Acked-by: Mark Brown <broonie@kernel.org>

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7M8dcACgkQJNaLcl1U
h9AA7Af/eQFdEMfj/wjfDByXeXLMghZROs9DaeBA+hnwGHWeWlAMxKXoWgr/ThqN
/oYU3Ra27+X5oBe8Ip7E6rOu4/QmFtrpvGfHFpIevuDamu+pQ5/UptGhE9s10qwn
EI2F34O1rQn6jqUYEUoj5Uj/+gGkj+vFR1FHCxGIcoe5/BO1PzzcQ0j5TZSr5bxu
x79QGRhAGnaa0whEKKkZrvLJ1GPDoS2DQfrrWZNYN/LP50WRf29ECvfs1VOQYXJB
W+hlimqN7f1IMU8wmKafkqB0A+Jhmw1WCfcHq58+45D3yBC7Yo7yZACIbMGG3R1w
nNeB9mDiPm2lSgIam/HrciOVpURVsw==
=5vEv
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

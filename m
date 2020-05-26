Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CFD1E1FEB
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 12:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbgEZKjw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 06:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731926AbgEZKju (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 06:39:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26017208B3;
        Tue, 26 May 2020 10:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590489590;
        bh=5gjdy3zdIFAHFH3E0OlYsRR+Kr+jjc41lUKizdEpGtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BiQxHMwM9ZLyYCcKy5wxJbCSERs+V/1Elq8p1pBWTVY10aTBPZP7RGZy+NwDEIkOg
         QQPTje/MgXEq8WJBc/wTCE0H9d+oiAnoa2oLQgrBBSpsfa6dIMzej3a9zjmX7BK77/
         HpbJQh6ScHg8ONbhOTXZUtZng4qWCKWB4qd87h2w=
Date:   Tue, 26 May 2020 11:39:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v5 6/6] spi: spi-qcom-qspi: Use OPP API to set clk/perf
 state
Message-ID: <20200526103948.GC4607@sirena.org.uk>
References: <1589368382-19607-1-git-send-email-rnayak@codeaurora.org>
 <1589368382-19607-7-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
In-Reply-To: <1589368382-19607-7-git-send-email-rnayak@codeaurora.org>
X-Cookie: Hailing frequencies open, Captain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2020 at 04:43:02PM +0530, Rajendra Nayak wrote:
> QSPI needs to vote on a performance state of a power domain depending on
> the clock rate. Add support for it by specifying the perf state/clock rate
> as an OPP table in device=20

Acked-by: Mark Brown <broonie@kernel.org>

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7M8fMACgkQJNaLcl1U
h9Adtwf+OsQ/ZUzZotNl0m+k49yzVj4SaOO1TlO+3JAdwe0XB6d3CO1v0j2WkMha
3IFzaZLC7FUoRT4WpR2kVZlhyZSwBAR0c06LTxiAgvNRl5ok2BRSYBwTIc2AboLm
Ca3n0WHnrR2ihPawh/cFt7cko/gB3eICfkaqGo+JC9gb4uVpgekDAF3fUryIM183
vwir5lvV2a4a6Td84kwo0jY5j15vrt9DNYuPHzb6EDH+NeC/qCx8C2mGnhtgpRn4
T6ZRb1uk4VLIvPUnJ8Kc6qN1IlfxWGqpo98dPJCMB2426K0ZlLbjBhiKI9pwFqO6
z/Ecrwd5xiYki2AIhF5DFxAtsh86iA==
=kVNc
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--

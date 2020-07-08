Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AE3218489
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 12:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgGHKBQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 06:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgGHKBQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jul 2020 06:01:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F2DA20775;
        Wed,  8 Jul 2020 10:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594202475;
        bh=eWguZ7iA6CR6XugdM8gMDgLLmOOqHrkrKvyaH3OCGr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0pXdgmMnzEE3t/wPuHUVp9Gakn1Z5aUR0qZMaUGULh3uFP97KH/cEc0rdPDHQcyz1
         NH68TFR7eYXI1MP9JJrKwIU1UPPt/9pBDQyg7GP7ESX0cO3ytxCmbsmtlggDCAckbo
         6sPoy9oiZn5uhk+pC8gOzu8VrhMcm4WwnsCDy9dY=
Date:   Wed, 8 Jul 2020 11:01:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        ctheegal@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Avoid clock setting if not needed
Message-ID: <20200708100110.GB4655@sirena.org.uk>
References: <20200702004509.2333554-1-dianders@chromium.org>
 <20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid>
 <20200707120812.GA22129@sirena.org.uk>
 <CAD=FV=U5RHh_QuZ1tv9V5JtcsrhRONSa_CerYwUFsHhDOhEqdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <CAD=FV=U5RHh_QuZ1tv9V5JtcsrhRONSa_CerYwUFsHhDOhEqdA@mail.gmail.com>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2020 at 05:53:01AM -0700, Doug Anderson wrote:
> On Tue, Jul 7, 2020 at 5:08 AM Mark Brown <broonie@kernel.org> wrote:

> > This doesn't apply against current code, please check and resend.

> As mentioned in the cover letter, I posted this series against the
> Qualcomm tree.  The commit that it is fixing landed there with your
> Ack so I was hoping this series could land in the Qualcomm tree with
> your Ack as well.  Would that be OK?

So I didn't see this until after the patch I applied was queued...  it's
looking like it would be good to have a cross-tree merge with the
Qualcomm tree if there's stuff like this - is this on a branch which
makes that practical?  Otherwise I guess...

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8FmWUACgkQJNaLcl1U
h9Brigf+NtxtMnd5Q+sFaPvV1B3d04EtHnvRknkpKOXu6X+b/7QtETUk5rNT3cbW
53ch01DuhdIzfyyTxckQrE377xaxxjW0SZ8z+zFbIdL4xetvzUfaXsCyJ8qhAy4F
iuBQinw8b8+T7kMgL2HhxivrPnb4IFk0OUucMpMIaHbDYC4kseaJ8nZJEzuFfQpu
josB/UwKCZGt4VZ8jZO0TI3ElsyKba/LABPhY7AP8ExRzGxeg8GgGFM85neHrWek
hcuiR0jCYo8e/GQI2QYDgShXfmwpziFF5smouo6W9hTsQOogVtv+nfCI1IAXQh5W
KKLtDlWIDFi6pizHvGD/ljgAk3JUWw==
=J/+f
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

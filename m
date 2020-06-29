Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B275E20E4FC
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jun 2020 00:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391131AbgF2VbK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jun 2020 17:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728814AbgF2SlR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A881B23CD3;
        Mon, 29 Jun 2020 11:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593431599;
        bh=QifnuQ3OqevnySCb9bfo+3KcLPSxAMMMZIagAZ6227s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e0aWtAUPAo87GHfZKyQbhiRqWa3TOxxpCGs+PthoYpE3SRwz9IL9vDqQ0KlAdyPtP
         n4ZFnebis5MOWojN2HFXlCLy1nXDZPuw/hP353dnE/d0Vo0OSHmufFYbQ0YJ6uT7E/
         vhLIv/zXwk8VMLcqD1NnztBgdw/i1JRu28SeW2RE=
Date:   Mon, 29 Jun 2020 12:53:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        Dilip Kota <dkota@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Don't set the cs if it was already
 right
Message-ID: <20200629115316.GB5499@sirena.org.uk>
References: <20200626151946.1.I06134fd669bf91fd387dc6ecfe21d44c202bd412@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <20200626151946.1.I06134fd669bf91fd387dc6ecfe21d44c202bd412@changeid>
X-Cookie: Real programs don't eat cache.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 26, 2020 at 03:19:50PM -0700, Douglas Anderson wrote:
> Setting the chip select on the Qualcomm geni SPI controller isn't
> exactly cheap.  Let's cache the current setting and avoid setting the
> chip select if it's already right.

Seems like it'd be worth pushing this up to the core - if we're
constantly setting the same CS value then perhaps we ought to just stop
doing that?

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl751iwACgkQJNaLcl1U
h9AU/wf/bpfHFtT9ACyBIK96npjnnQz/vQ3t3lRL7uqyIfHIA/19K26V0j6Dbvwd
aBYPo5xPqYDwqUHbobABbdZ5O1N6trSA8IO0I9+9MvV9vH0velLuDQIcsGEkVv8p
8U+JrjDe2kjr7hRrqlYJvvFpbeT81Rcii6tN8cqz/Ek+eaRl7+ZOwOvanyYnzC8Y
P5GZaxID2aTSx31RjkXiTsVzivPbZdRpQ8bE2MqhnGgyOsBVSpqOqYxLy6laSITN
DCEwaCo+0FK+B9Fwy1/CjR4DAprkpm4tC1C3yw9Lyw1JVA9asTU4f8cG5MmiEDTT
4XADNhyWNp+53XX+tudxCtkO84nsfQ==
=Hcvu
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--

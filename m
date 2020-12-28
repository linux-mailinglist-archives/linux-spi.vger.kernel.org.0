Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A7B2E4025
	for <lists+linux-spi@lfdr.de>; Mon, 28 Dec 2020 15:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438096AbgL1OV7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Dec 2020 09:21:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441454AbgL1OV6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Dec 2020 09:21:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF8F920791;
        Mon, 28 Dec 2020 14:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609165303;
        bh=D2abN+BGCVNoRVeFwmhCa/J9SOwo9jqt67aqXhhpcRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIB2T2W+VVz32jMmNbjnPktsP40H/CgUiSB3ygzVQbe5XMh88BrjNjHfqK7F4gfwN
         G7Uuj2F0rp+wzdLrpaD/0Tw0xKf1mRnyW7Ah3cKKfvm4cr72XFM6kJyaU+jHSSDX1a
         rFMxTkYP1kGYJG8ATvuh7w6zHl9EEPhIykixVpo4AKPJZUNC9CmHxuVowofm3T2AN9
         RAi0Lzz05M52P5zYOffgl3kPN6wyzoxXByZwFpknRlvMqaDCCir+UX7wAt1b5bmw3g
         STWmzX3TPu5t8uR2tY9GaGBqrBNBySNsAm2Bq+jcMMyODNTxYzHraeuhbGefcCZSpY
         6rYM6BAu08d2g==
Date:   Mon, 28 Dec 2020 14:21:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Mukesh Kumar Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH] spi: spi-qcom-qspi: Use irq trigger flags from firmware
Message-ID: <20201228142121.GA41730@sirena.org.uk>
References: <20201213052948.308263-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20201213052948.308263-1-swboyd@chromium.org>
X-Cookie: See other side for additional listings.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 12, 2020 at 09:29:48PM -0800, Stephen Boyd wrote:
> We don't need to force this to be trigger high here, as the firmware
> properly configures the irq flags already. Drop it to save a line.

This doesn't apply against current code, please check and resend.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/p6eEACgkQJNaLcl1U
h9A+TAf/Xys8t4O2NMWZgRWkX01/ozK0OBqCGyCXYZvQ85QabwZ8n6uEn3/YeeTh
GP31oevOw0JrpyZgxSn3/jOPkdd6B4ycjG2iHhA3RfiK+XOyXi8rJ4k8NbH6SuCQ
OUsNZZockUjxtF6LRba2kr8nFNejojyyFS4pdYc6CsH1/gEbUHvxZLlMcKT8bqt5
2MN/0+mVeIYAk6fHETeznIXbErTfhTxv/3Qc4XzQUlg0PuD5+2fepEHw/7spb+QC
kMmXLinZjRbEw2iamUa61L2nDiWD/vcW/ZXM0K6nli8MkTaUb2ZnaE4E8YCJI1L+
SQi1R0C7nXYTqYdaAqnL+M8z9dOgyQ==
=ki4Z
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

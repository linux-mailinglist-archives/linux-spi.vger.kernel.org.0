Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92B5218800
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 14:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgGHMtN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 08:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbgGHMtM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jul 2020 08:49:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B4A620775;
        Wed,  8 Jul 2020 12:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594212552;
        bh=Uqa5Ixx9A8DkN2H2K4w6mWtGsN4oJbAFIYsvEF105uM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKbE2oFg2VMewf3p7Ik1zsK0oPUYm+PwxqnkQ3WyNwSaGQ+vK8bZ9pf7YiB1ykQXH
         XU3WCRTnd/8w1PxUBPh0r2Sq+WwCReWyrIGJMMqt77XDx21WOrQ4qLYv3To6Ef4nbj
         c5RMeN5svZBNGIr/TZziTEiSoPwEkXfcdR2Eldbs=
Date:   Wed, 8 Jul 2020 13:49:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        akashast@codeaurora.org, linux-arm-msm@vger.kernel.org,
        mkshah@codeaurora.org, swboyd@chromium.org,
        georgi.djakov@linaro.org, ctheegal@codeaurora.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: spi-geni-qcom: Get rid of most overhead in
 prepare_message()
Message-ID: <20200708124903.GN4655@sirena.org.uk>
References: <20200702004509.2333554-1-dianders@chromium.org>
 <20200701174506.3.I2b3d7aeb1ea622335482cce60c58d2f8381e61dd@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xb8pJpF45Qg/t7GZ"
Content-Disposition: inline
In-Reply-To: <20200701174506.3.I2b3d7aeb1ea622335482cce60c58d2f8381e61dd@changeid>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Xb8pJpF45Qg/t7GZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2020 at 05:45:09PM -0700, Douglas Anderson wrote:
> There's a bunch of overhead in spi-geni-qcom's prepare_message.  Get
> rid of it.  Before this change spi_geni_prepare_message() took around
> 14.5 us.  After this change, spi_geni_prepare_message() takes about
> 1.75 us (as measured by ftrace).

Acked-by: Mark Brown <broonie@kernel.org>

--Xb8pJpF45Qg/t7GZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8FwL4ACgkQJNaLcl1U
h9D4Rgf/Uva2syJm8KRxZ3zqSrynarhaL0MlZwq4rb26hTPp7LnZs8TIOfboQ2aP
ReLvfYszSbgQhhIFxtZAnJAVpwEz2twAVROsnO0/K26NmqaV5/p0Z1KyPCPfgQfW
N7LN4MOtDh97n84llxMtJJG8P8Tqoje0YRAuQdwSIC9LkcRCvNe02yRdJ9cnPMzX
OTOYc4avIDtmWA+t+K7nyDJ1RoQmAqDyejMsUEy32LO1UmlW64hZ8njrNyZRisUu
+8XdZqLO/aiQOTxuvxXbTH7ZltyFd+kkwlksVqDVVto2THb5RDJ20/+MdU8arQYF
sN8xdQTvufuZYgkETqAeW5REBVttHQ==
=/s94
-----END PGP SIGNATURE-----

--Xb8pJpF45Qg/t7GZ--

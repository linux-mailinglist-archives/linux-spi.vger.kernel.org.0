Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1974C207A06
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jun 2020 19:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405280AbgFXRPl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Jun 2020 13:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405292AbgFXRPk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 24 Jun 2020 13:15:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E53F20823;
        Wed, 24 Jun 2020 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593018939;
        bh=Muq+h5RYuFlDZVPELmKhrcpkrd1VTQiWegUXOVEQr1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwnifoCn7+IjqF6gtLKCpT85y16GjBg4C1wB0knqp9+yOWx/tzQoxANfVG/aLwPIu
         +5REGHHF03iRm70UHm/pZ05+JxovR7H1Zp0D9a12TcHDhXbX/ItF5FDLzH0Q4yrLBO
         01oaDGxcfWHjBatC8wBwrm85pmI1JrV00GwTqdlI=
Date:   Wed, 24 Jun 2020 18:15:37 +0100
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
Message-ID: <20200624171537.GL5472@sirena.org.uk>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
 <1592222564-13556-7-git-send-email-rnayak@codeaurora.org>
 <20200624170933.GB39073@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5LiOUhUlsRX0HDkW"
Content-Disposition: inline
In-Reply-To: <20200624170933.GB39073@google.com>
X-Cookie: So this is it.  We're going to die.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5LiOUhUlsRX0HDkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 10:09:33AM -0700, Matthias Kaehlcke wrote:
> Hi Mark,
>=20
> do you plan to land this in your tree?
>=20
> I know you hate contentless pings, but since you acked this patch and
> usually don't seem to do that when patches go through your tree I want
> to make sure we aren't in a situation where everybody thinks that the
> patch will go through someone else's tree.

Aren't there dependencies on earlier patches in the series?  In general
if someone acks something for their tree that means they don't expect to
apply it themselves.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--5LiOUhUlsRX0HDkW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7zijgACgkQJNaLcl1U
h9BO2gf/QRx6r/ogT5x8Wf/Nod0og1iZ+SvUc2La5+7SYbzUfNrPdN5YM07zphJH
hRFrjNyxG1fBSG8P2ZxAgMMyjdpN2KPnLfvRmMwGqh6MfdyOcABDFLYiqKh2aLj8
QkhwAsGCf3VI2EPmXzmCSxpEQirBs7wMZIt0X+OouO1oGpXvTFAj/4mSbrTtqo3+
37uCx/ns42Bkypc0svYcZ+ysll9gzUGiUCe+tUkcydTCnUwxbZeNCjQ078VbJ+wu
7k62lSnNucReS+menq32Cy6mHBY3v7iIkhaqJjIEqmhamRQ5WqUogFSkOACKGB2r
Jm8gJ0a2KsJuJ2Oy8AE0Hj+izo/Eqg==
=BWYp
-----END PGP SIGNATURE-----

--5LiOUhUlsRX0HDkW--

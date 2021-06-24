Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6352A3B2F0E
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jun 2021 14:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhFXMg2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Jun 2021 08:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFXMg1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Jun 2021 08:36:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 652DB6054E;
        Thu, 24 Jun 2021 12:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624538048;
        bh=Er8ubAq/u/gMOKagrmoA7/dlBihkdrrliqivnhX7g40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0+yeM1Rgyx+FBX0sCsPHZZqpJGJvNCT2flya3NglKDuBV8GbApWxOI80HrcZzSwx
         2/CW0Tdod3ArxyWy9L04kR7GrU0qwnbO1gp97QdNLL3b2TwlvKlAZLpJeXqzyUtfz+
         DhPm2oU5LDRm7QMeW0qLXLbXaUUxB60XQw/UBt/KS4mE1ny9u8jGEg1IRd5R92W2l/
         6uPIYkC1kTytoUdO+7RxXTv+F8Uv9ChQOFKq9Y5FHvKG/Opc1py0DQ6rZplSMx4CW+
         gtdQg9rxaM5g8LEtbKEmTXshxAZ0ZNJbUHf3cMMJHjWxzXFkQvDapUS9tgmDRFkjSL
         xg1fgznNOZs4A==
Date:   Thu, 24 Jun 2021 13:33:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] dt-bindings: spi: Convert NXP flexspi to json schema
Message-ID: <20210624123344.GC3912@sirena.org.uk>
References: <20210428102417.1936520-1-kuldeep.singh@nxp.com>
 <DB6PR0402MB275878B7DE63625FC5E05DDEE0079@DB6PR0402MB2758.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB275878B7DE63625FC5E05DDEE0079@DB6PR0402MB2758.eurprd04.prod.outlook.com>
X-Cookie: World War III?  No thanks!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 24, 2021 at 12:31:19PM +0000, Kuldeep Singh wrote:

> This patch has been in queue for a long time. Could you please help in pi=
cking this up.
> Please note, this is a resend version and previous version[1] was already=
 reviewed by Rob.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDUe6cACgkQJNaLcl1U
h9AW5wgAgD+wDR2Gp6/PRpKa1NKzJDt8uxtSVIUZuEF2fdTuMYnHHWwSPenmos+H
yLf0Ns1XpuDRELJzTnqxWolyojLQq66RBu2vJP8eAl8rEuzr+r/kCHNwkbbYyJWH
D1gf2u3YceaviJXoHZ0D9p8UjJ+LhZSabBmTKt8VOTd2klgjvfvy6Pyfl9eN1P3F
z64diq3W9AMZhlhA1UjD4jyqCjNIbjTGBHypHx8T0NLv1gVyx/SG5SFRpkAuWQIH
mg+VKZCIXLeXW7ZB+ixiIegjSzsWAlkrIUelOMQbiIVJGkuLZrTjGRF61akcm/EE
5ePaS6zjUnpXBZCtg5qfE/GR713cKg==
=nn/M
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF10A120903
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 15:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfLPO42 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 09:56:28 -0500
Received: from foss.arm.com ([217.140.110.172]:58014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbfLPO42 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Dec 2019 09:56:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42CAE1FB;
        Mon, 16 Dec 2019 06:56:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B689F3F718;
        Mon, 16 Dec 2019 06:56:26 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:56:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        xuejiancheng@hisilicon.com, fengsheng5@huawei.com,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH v2 0/3] HiSilicon v3xx SFC driver
Message-ID: <20191216145625.GF4161@sirena.org.uk>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <65a6d94b-95b7-b11b-2234-c091ba3f671e@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline
In-Reply-To: <65a6d94b-95b7-b11b-2234-c091ba3f671e@huawei.com>
X-Cookie: Backed up the system lately?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 02:52:23PM +0000, John Garry wrote:
> On 09/12/2019 14:08, John Garry wrote:
> > This patchset introduces support for the HiSilicon SFC V3XX driver.
> >=20
>=20
> Hi guys,
>=20
> Just a friendly reminder on this series.

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

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl33mxgACgkQJNaLcl1U
h9BkyAf9ERzOEHkj4pm1zcqytpYhQyLc/XjXH3fGYXrtycjyRGjH0+FOGFxRKFKz
fSKqN7QBU2dWuPvKqvB43G/eIMrD0FR7Dg+SkbzW1761xgy0r3TWVF8Fgt+WtMki
MpZisGQmpcWjVkYkwsd7FqMPhSxSNkpSQjYDGvuvJfJ+DALzTjwawoDDVECeNuRj
P4gZscc2m79ff/24eTtmktjjzIIwT+Zv6qrjSx2e0LCqueLNzudNgL6ToP5QppU7
zRgzI6MefT64/ffpcGa6yr7kBBWX9I33uuOAcgmY3NIQrFvDc8cxCfZZ9346e1wK
Nrp6zKYgFjmfO3gYYW1cP8XJqd3OgQ==
=JPvu
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--

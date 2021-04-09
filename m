Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7996D35A1BE
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 17:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhDIPL7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 11:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233974AbhDIPL7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Apr 2021 11:11:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B9BE610A7;
        Fri,  9 Apr 2021 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617981106;
        bh=iJlwV9Pd9Pl4GnE2mK4mEArko08tDPv9FW2tNL2mixI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wqwq1UwhOj30ehy1LQErHVuUZMMZWGdfg3vkTSnd7uAkj9nJe1IX+Woh/Gi9r+JO6
         n3MKswAdWa9gW9R0tdFf+IN/1m4Mfto6lMy+5sUPx4aFllTmufWaQfUVa0SF6gOec6
         8u1IRACBp9Sp362cYcWpDeKqiKxVjuHXQt3SmeSakLwWg5qv1xwbB751ImkCMyAbb9
         tDdL4ObBPDQL9uxggih2+dl5zyIQV1WebGLBVftY/3b6Odmw+TO6zZ3meVrAzU6EpI
         SNyXxeKXJoHag3BIcz02VfHlkkskoaRrHZQXJ8FykzKOj6mrYKJA4xOePu1lOn2dJX
         vYGzSdW+bQz5A==
Date:   Fri, 9 Apr 2021 16:11:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Yicong Yang <yangyicong@hisilicon.com>, linux-spi@vger.kernel.org,
        prime.zeng@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 2/2] spi: hisi-sfv-v3xx: drop unnecessary ACPI_PTR and
 related ifendif protection
Message-ID: <20210409151127.GC4436@sirena.org.uk>
References: <1617881505-51552-1-git-send-email-yangyicong@hisilicon.com>
 <1617881505-51552-3-git-send-email-yangyicong@hisilicon.com>
 <20210408135155.GG4516@sirena.org.uk>
 <26fad983-9e06-333c-c1b9-332c6acfddfa@hisilicon.com>
 <3869ef5f-eda6-907d-7565-29ae0bbf5dd0@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <3869ef5f-eda6-907d-7565-29ae0bbf5dd0@huawei.com>
X-Cookie: I'm shaving!!  I'M SHAVING!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 09, 2021 at 03:25:49PM +0100, John Garry wrote:
> On 09/04/2021 08:17, Yicong Yang wrote:

> > yes. we're not using any acpi function in this driver. What ifdef macro
> > and ACPI_PTR() protects is struct acpi_device_id, which is defined in
> > mod_devicetable.h rather than acpi.h. It can be built when ACPI=n.

> I asked the exact same thing, so another version with an updated commit
> message with this info could be useful. Mark's call, though.

Yes, please.

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBwbp4ACgkQJNaLcl1U
h9DZUgf/fbruyrERXt28skjKZpqslXWafOy4UPenI/sVpOZfRFPdRIZdFuWShl1V
nBbAfnAMxBoXJKupgViuXQuAx7WwvuXYcEn2Vud+HzRbbuvbXJMYqCj4sgT7tSFZ
5cwNGl16BHa/EPomvSYvL35CIJ3IfsSMC08gYG7zo0b9zIdS7B//ueaYLOeXkm7t
1QB/Rx9APs/wiPnlzAKSpgXgLRBWesLbb2dzI4rxL+xDKPucWdcRmdXzZx2wqjh/
L/6crDvqux4yY5koC6aKsBQR8DbGcJoJXq4yNXYkNEEZ0H1Z0qiHGFIbbUa4CF1G
bT4X8TU5Aalsim+z1e0uMJs9aEINJw==
=QhXN
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--

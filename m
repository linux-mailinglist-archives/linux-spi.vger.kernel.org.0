Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34E4215BB2
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 18:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgGFQWw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 12:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729372AbgGFQWv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 6 Jul 2020 12:22:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A3EB20720;
        Mon,  6 Jul 2020 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594052571;
        bh=Zesy/gCYGkgqDAKOfdGWivDxmHPtIcr/6/UXdNtI6j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZIErwXpdKK+CJDW6zA0O9KL+OxADjW3VDT39dhwKtMbjuIfNpZj50RYd5mQu+gnMf
         tHpPTOLEYnNTLWueaktiwMowlN3pBkMwZG/6XXZV3KQw/UULZBXnKODW6APfkqqfBH
         km4OAf6Gbs8D5CsBPULcgo99wuWAMDUDPPe4j/I4=
Date:   Mon, 6 Jul 2020 17:22:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Adrian Fiergolski <adrian.fiergolski@fastree3d.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: Add documentation for SPI daisy
 chain driver.
Message-ID: <20200706162246.GC6176@sirena.org.uk>
References: <202007040833.xIqR5rAw%lkp@intel.com>
 <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
 <20200706092247.20740-2-adrian.fiergolski@fastree3d.com>
 <CAMuHMdW_aTKtrUnGqf3DB=fr0ZxTsjoEjMmwSpPqhwjs-Tz7ig@mail.gmail.com>
 <d80b1b85-ee23-3244-9bb0-876986f6ff17@fastree3d.com>
 <CAMuHMdUV_2DbbUqp+0=XARyLCwPya1RqFCrr6VoTJjVAZiKJzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUV_2DbbUqp+0=XARyLCwPya1RqFCrr6VoTJjVAZiKJzg@mail.gmail.com>
X-Cookie: You will be married within a year.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2020 at 05:32:51PM +0200, Geert Uytterhoeven wrote:

> However, that information would need to be added to each driver only once.
> With your proposal, it has to be added to all affected nodes of all DTSes
> of all users.

Right, these are fixed properties of the silicon which we know simply
=66rom knowing which device we have - there is no need to put them in DT
at all.

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8DT9UACgkQJNaLcl1U
h9AdMQf8CPLSrHKUudLZQMm6Vt8Js3FhfOfXz0nI3WhVqYA//SpkS8p4LIgH42v/
YkJJxsehBDQpM1leejTUhrYfV8nq5JlJHMf4y2iVuJx9Oc+/HneV9urnFT2ubUlc
n/NN3HBsz2lajS+ZJrhIQZdo/NUbh+GvnuUGXXt0aoJd1oRIgackpNz0OuSp8tpC
+k0jCYYNkn6L1xZnQfnwP3HloL9X1lt2HnQgGPFWn30sc7ckUORptE+pqtzDzOfh
Tw/pHMZusSusP5cXX+8/k0lApuO+dpbK0KgGcBQM5D7KwWAZ0f15BT+dQa4DOxK0
oOcuKT9cbFF7NeTq+tLHWUJXzwoT2g==
=eyDJ
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--

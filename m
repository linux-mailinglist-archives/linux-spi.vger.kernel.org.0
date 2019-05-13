Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BD61B9AB
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 17:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfEMPO4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 11:14:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50214 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfEMPO4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 11:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nUnk8pejhcO5Z924FZ0roh4pW5qijEZRFlwLliQ8Z5Q=; b=O9OhftS0n18P/X9QQ1hEFyijp
        V8Q1F/1sBt/n7I6x+S+giQqNwNgXGyWlY+k/yHe2N/Squ/r93RroVmi10pzYuPhtbKaG+1vSpeFrA
        qxLMRte6kxc608EZK8b2P4VI5g9ZjVQQfJSmzJd6Xm5h3Q1EMVz/soT99bHZudAK29/LY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQCfE-0006rg-AE; Mon, 13 May 2019 15:14:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2D3FD1129232; Mon, 13 May 2019 16:14:50 +0100 (BST)
Date:   Mon, 13 May 2019 16:14:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kernel@martin.sperl.org
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] spi: bcm2835: support effective_speed_hz
Message-ID: <20190513151449.GC5168@sirena.org.uk>
References: <20190223084952.14758-1-kernel@martin.sperl.org>
 <20190223084952.14758-5-kernel@martin.sperl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <20190223084952.14758-5-kernel@martin.sperl.org>
X-Cookie: Must be over 18.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 23, 2019 at 08:49:51AM +0000, kernel@martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
>=20
> Setting spi_transfer->effective_speed_hz in transfer_one so that
> it can get used in cs_change_delay configured with delay as a muliple
> of SPI clock cycles.

This too.

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzZiekACgkQJNaLcl1U
h9BSTwf/TAxVYCmKUlukCF4emOMZMaTxRry36W4e1gJaSpAzWTMypCBKOwx32o0R
DRGb4z0ZX8smadkw66yG1vu4wB9ZtgxOR0bD4OQi7b0uAEiK0nt1fVosXTnpnhcB
Pi9Vv1vUlNchha8WZ8VXpF4mY1SgxHtn82b1OJ8FX9eXgS0RUuLgVTIZGXaqLaBb
oLoURMHmAPkkKGZ1cxfWuYbxC0w4ufc4qsieqbdwROPb82GQVdzZWkuY3ZRDiFzj
BOpO7pZbiIGmwoVVYMgnssB2v2zGQMoiqzMgWD3695PVfnRnqnjdsX1BibwsegD1
kCc+qEMQA5gKHAUZMNHqQxc6cVAedQ==
=tSRe
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--

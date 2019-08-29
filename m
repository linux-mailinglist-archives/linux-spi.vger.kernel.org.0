Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3BF5A1543
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2019 11:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfH2J7K (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Aug 2019 05:59:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41514 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2J7K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Aug 2019 05:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sKNGJgskVU2h6NM23G4S9/q2Ekegj9NAfOsLWDG6p8s=; b=oc/fu4RL0Nhis4gwaVFIPmpmG
        QTjTPN8ky2jvTnmVTGtD9IMz3TXadL+6t5U1veh+55rc2sRRYTYq2woZG+mw6zWDcIWDvbY3taiyV
        KGBRlzeRENeatP0Y4RRI6gp8qtwzclt/5Ap4e1zsZaqjplijtLKwW9BRL8vMkVstX5HSE=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3HCt-0000qE-SC; Thu, 29 Aug 2019 09:59:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 167EB2742CDC; Thu, 29 Aug 2019 10:59:07 +0100 (BST)
Date:   Thu, 29 Aug 2019 10:59:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/1] spi: bcm-qspi: Make BSPI default mode
Message-ID: <20190829095907.GB4118@sirena.co.uk>
References: <1567052173-10256-1-git-send-email-rayagonda.kokatanur@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <1567052173-10256-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Cookie: Lensmen eat Jedi for breakfast.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 09:46:13AM +0530, Rayagonda Kokatanur wrote:
> The spi-nor controller defaults to BSPI mode, hence switch back
> to its default mode after MSPI operations (write or erase)
> are completed.
>=20
> Changes from V1:
>  - Address code review comment from Mark Brown.

As covered in submitting-patches.rst inter-version changelogs should go
after the --- so they don't end up in git.

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1noeoACgkQJNaLcl1U
h9CUYAf+M++ibN/14SNtvLXhF5fpC2dh40Q9FTVy7OsuIlbVuVpy7PFeKvnciNwp
eCMACa5b1BJPR/fsQO/XOuJYaOl6zxI3eQqN8jT44zGq61NX42nncJappFDr75we
Z45dLAMqxHcmZQ3U5SqlZVLn+m8jhgasIggPzPvpgUllrObaKmjf2ODqyf1McaHZ
GiloqwCmG+i1H2sWR9qlbbqUSuoNbLaRpeS8E3Qi0ebHf/e/N7eVaUhwLLfJQLCd
WHjr6gh/xRujyDPf//XPvTSXwQMAx25LhuQKI13Ml2Tpk62WnJjrcmS3hjJ594mb
MjDGMh4SN7qA9OEQnajSjb9pfx+P9Q==
=iSMZ
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

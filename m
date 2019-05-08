Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE8173B6
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 10:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfEHI1Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 04:27:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43590 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfEHI1Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 04:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uH22Ss7RWa1Q/gLr9LVMt/zwsM4rNt9ZN5QuG9Xr+HQ=; b=VIoluLCzbRQb61te7trrIBk5N
        Iawe4mLoXIo4W63kFGGE1pt7ay2Yyu+aZ7h2/uCsvBOoh/mH8eu2+zWtErOKQMmK0KCzIcfZ6CM6T
        P72EC2d7rUDWTWCyMmUkqRPMgmySZppX9U6so6AYgJGLmdIYZVtV+FwKIPsoFaGHH42dc=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOHuo-0007Te-NX; Wed, 08 May 2019 08:27:05 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 3415B44000C; Wed,  8 May 2019 09:26:54 +0100 (BST)
Date:   Wed, 8 May 2019 17:26:54 +0900
From:   Mark Brown <broonie@kernel.org>
To:     kernel@martin.sperl.org
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/6] spi: bcm2835: bcm2835_spi_transfer_one_poll
 remove unnecessary argument
Message-ID: <20190508082654.GB14916@sirena.org.uk>
References: <20190423201513.8073-1-kernel@martin.sperl.org>
 <20190423201513.8073-2-kernel@martin.sperl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o3dU+gdzLtSIP39w"
Content-Disposition: inline
In-Reply-To: <20190423201513.8073-2-kernel@martin.sperl.org>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--o3dU+gdzLtSIP39w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 08:15:08PM +0000, kernel@martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
>=20
> Remove the unnecessary argument of xfer_time_us when calling
> bcm2835_spi_transfer_one_poll.
>=20
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>=20
> Changelog:
>   V1 -> V2: applied feedback by Stefan Wahren
>             reorganized patchset
> 	    added extra rational, descriptions
>=20
> ---

As per SubmittingPatches the changelog should go after the ---.

--o3dU+gdzLtSIP39w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSks0ACgkQJNaLcl1U
h9BY0Qf+IN1cU8pA4fu4aeFzAF84gtxCwr7OTUKaDZsjCl3jHXWSPZW78sYMFWgJ
n0Dl4xw8E+iC+pk+JBMJ6yu8CzPN8bo4lHUHVsTTm0l0zRaYEXGDxd7PRMBnF/Hq
7fzwbDCqDMxXIqdZ8zWIG6X02G9JPyHHD7QICSXHK8vgJU0hL1EC9wiA+vGgZhRR
9FEhpt4+//JzSx8mghV76CKtdyeX2L19xuTfYfdzOqt9yI87DjVpeox3rJuNNNAh
pQ0v/JMW1t23Btzlxegpe870L9LBzOLCkiCAyPKcMNKZEfkYMmxc2gldgmDVeuDc
YStYnC0d+5bPIKklfVMc4FDZ0/XSvw==
=aPRu
-----END PGP SIGNATURE-----

--o3dU+gdzLtSIP39w--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8A202DC
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2019 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEPJv6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 May 2019 05:51:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38698 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPJv6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 May 2019 05:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c/NBuWWZd4GyOvb7I7QglGhxqPLW/siTEQ2OiVvxGgc=; b=o/E7kp80rtZdglpp+KyVcjjmd
        5Wz3qP8eDNxCIUlcBvuyWcFYqOds6ruU7a3BH+ijBlOLUQzIunOBYqJS7TdO9vCS8w0gDcJ4Olj0A
        Ptql52sVsabI9E+mpApT1nwl0LJsqAzLSwTKSNNtB9LHEjFLoG5USz2rW39OhloNGVoQs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hRD3H-0005zn-Vq; Thu, 16 May 2019 09:51:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2C1221126D3F; Thu, 16 May 2019 10:51:48 +0100 (BST)
Date:   Thu, 16 May 2019 10:51:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     axel.lin@ingics.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, albeu@free.fr,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] spi: bitbang: Fix NULL pointer dereference in
 spi_unregister_master
Message-ID: <20190516095148.GA5598@sirena.org.uk>
References: <20190516075656.25880-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20190516075656.25880-1-yuehaibing@huawei.com>
X-Cookie: <ahzz_> i figured 17G oughta be enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 03:56:56PM +0800, YueHaibing wrote:

> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> Call Trace:
>  dump_stack+0xa9/0x10e
>  ? __list_del_entry_valid+0x45/0xd0
>  ? __list_del_entry_valid+0x45/0xd0
>  __kasan_report+0x171/0x18d
>  ? __list_del_entry_valid+0x45/0xd0
>  kasan_report+0xe/0x20

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdMrEACgkQJNaLcl1U
h9Doewf+K76sAzp7td0Y2CoC7hSukwmSOre0w2Wt2EXD6tsKKYSDOVdYgV8I/xEY
hNSGzI1Z/lZd4czcoBu4WlQrmLvd1vO/uw8XdAza+8HmuHmDrm71RWKgKkhTzEev
Fz0TwZv2QM4GsFXE42n8ho3HN50etes/tfDNTckilFDzHH/op40t6xC8s15aI3Fx
CXX/sVet6R3DFfe0vIl14uVPvc9jCghKiYl3I0Ot5Al5AsbCARstc5Luoh+Z7BgJ
o1kytR5QrZU16e2MW9DF6rYOCvwcbMA7tTFyjB82syRu3O6H2MN2U5h9dK2iPKiQ
3KFKnJq5BgFlau9haZKJK4/Fc5/4Cw==
=D/EK
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

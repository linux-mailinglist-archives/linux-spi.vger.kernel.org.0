Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E135D139046
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2020 12:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgAMLnU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 06:43:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49584 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgAMLnU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jan 2020 06:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g2n49SGBTNUtqISjbMsN587xlnonpg3/x81aMuFYk+w=; b=GTD5rauEfghSV4/oUex1iEqWr
        bX8wCRdUTchQ9oIAMcrz4sIGn3JnxNCtq+wW60KqPFqZSICTwL3tIrQ7F6KujZQnv/KIr+dTFxgEx
        2RnydC2JGjuxtyhPcvTjXyDaBRFVz9nAE/nUW1P3drRG5QBr2MLXfRghZC11aZPsOJUs8=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iqy7V-0001fp-Lj; Mon, 13 Jan 2020 11:42:57 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id EF79BD00AD6; Mon, 13 Jan 2020 11:42:56 +0000 (GMT)
Date:   Mon, 13 Jan 2020 11:42:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tudor.ambarus@microchip.com, linux-kernel@vger.kernel.org,
        chenxiang66@hisilicon.com, linuxarm@huawei.com,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, xuejiancheng@hisilicon.com,
        fengsheng5@huawei.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, liusimin4@huawei.com
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Message-ID: <20200113114256.GH3897@sirena.org.uk>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
 <20200110193119.GI32742@smile.fi.intel.com>
 <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X+8siUETKMkW99st"
Content-Disposition: inline
In-Reply-To: <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--X+8siUETKMkW99st
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 13, 2020 at 10:09:27AM +0000, John Garry wrote:
> On 10/01/2020 19:31, Andy Shevchenko wrote:

> > PRP method is only for vendors to *test* the hardware in ACPI environment.
> > The proper method is to allocate correct ACPI ID.

> Yes, that would seem the proper thing to do. So the SPI NOR driver is based
> on micron m25p80 and compatible string is "jedec,spi-nor", so I don't know
> who should or would do this registration.

The idiomatic approach appears to be for individual board vendors
to allocate IDs, you do end up with multiple IDs from multiple
vendors for the same thing.

> BTW, Do any of these sensors you mention have any ACPI standardization?

In general there's not really much standardizaiton for devices,
the bindings that do exist aren't really centrally documented and
the Windows standard is just to have the basic device
registration in the firmware and do all properties based on
quirking based on DMI information.

--X+8siUETKMkW99st
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4cV8AACgkQJNaLcl1U
h9C/cAf/f3KqQoM3kgbWl0MgRMi2T0mY02dvLgcINSfWU08s8WPRzo3zWZ+2Bnwy
EtoOy7yu9z4hC9RVNYaA3/FibeE10MJHizzwRnxzzxmu3MjPDixmON8GO+hsKPd6
DYhpptH+23ceLUX3O7l8v34vvslFYKaUeSJkTlCR0OxxEkTCxwnWnWo/wKBYTRer
T58Cj6e/WnAl2qZ4Yl4qJF2TpNTC7T5tHki/I72eEZfiaNylIKxERV27zddbrgHE
dyOKFqftALoJvu2cf/ddKpXKNt1ceMDNGhu3bIBJuoSdYAedtvWRs9TPRigY5bvZ
IiypAujroXyiqSqmQq+3FBBNH9tTXw==
=w5W/
-----END PGP SIGNATURE-----

--X+8siUETKMkW99st--

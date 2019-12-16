Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E464A1203A8
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 12:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfLPLUj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 06:20:39 -0500
Received: from foss.arm.com ([217.140.110.172]:50650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbfLPLUj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Dec 2019 06:20:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA0091FB;
        Mon, 16 Dec 2019 03:20:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 493DF3F6CF;
        Mon, 16 Dec 2019 03:20:38 -0800 (PST)
Date:   Mon, 16 Dec 2019 11:20:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-spi@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835: don't print error on clk_get() DEFER
Message-ID: <20191216112036.GA4161@sirena.org.uk>
References: <20191212231213.29061-1-jquinlan@broadcom.com>
 <20191213114138.GB4644@sirena.org.uk>
 <CA+-6iNz4WVJzfntJ5CUXBYvqQG4kEj8g8g_HOxZN5rFWTUvv3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <CA+-6iNz4WVJzfntJ5CUXBYvqQG4kEj8g8g_HOxZN5rFWTUvv3g@mail.gmail.com>
X-Cookie: Backed up the system lately?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2019 at 10:33:41AM -0500, Jim Quinlan wrote:

> Understood; I could do a dev_dbg() on -EPROBE_DEFER and dev_err() on
> all other errors -- would that work for you?

Yes, that sounds good.

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl33aIEACgkQJNaLcl1U
h9AC6wf/R5j2jqumwfRVO/ylQSKn8tJJydGHwHAhVQa0OkQU0O+BqOeMBYdKfgJO
bN4q07uuvPEXt/IAhHh3RGvlQmVjCjmsh4fi+cErbP94Vq4RQKk0C8Oz43mYDAdd
N0L0RT3ZaL3Lx8VB9zpBOcoVIlnvxp5NsadklXFomNw0jPODBmZigQ2JozKGrQJg
JNPxPpJZbSm2CIiX+mov8XYMYY65n5RGj2VN2EfN2vlkoLyCG5KG81OwC+dfj0UN
+5pC/lfxyOh7mLgdPOpbN8JyGBp+ZmZQCMVMI9VXohBg3O38xiKoc/VX3kmhxGER
diLze8h6JB5EC49xjFrPPHxauD0IQw==
=rvrz
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

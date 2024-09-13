Return-Path: <linux-spi+bounces-4808-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9247978620
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 18:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D51C28637C
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC182D052;
	Fri, 13 Sep 2024 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ts7mG/+C"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EE7A15A;
	Fri, 13 Sep 2024 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246085; cv=none; b=QbZvpspozM8bKLdNUlUFF5KOXJZElUaaJv57So8dRotJg1cJapl42Rq0ssBleeec7h2MEPCwkW91L/+SQvgbj+oddii8LHaZgxKcZCjwXh1mkuLCYEPGqzqPgVOqtjmtIINoiA7UiExZfv66Q5XweX8CVYrzQCgt8xp1MGKjISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246085; c=relaxed/simple;
	bh=TC4nHFRLA8eECDLTbY7KqYrdwzmF4RwqGAix/PG6lko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qudF4hUeUykGDDIMYef5XpK4XMbFOGepGIwtYLdCBLuq3nPsa0dhoRHnR1c2N0rSq6U6ym2GofczSPz26F0W4sRQDbjxGGKDAXe29nRssdtpaOVpWLp75NhbpGzDmeFmvr3FvfmGaiPLcFbrCS5mcqHqOwdh31Q3kAsCFb9qqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ts7mG/+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEB8C4CEC0;
	Fri, 13 Sep 2024 16:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726246085;
	bh=TC4nHFRLA8eECDLTbY7KqYrdwzmF4RwqGAix/PG6lko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ts7mG/+Cne9PraIsDXfjGAjbutIC/bnNHbaxbTx87Q29UOBN97xtf/WM3mijSGIVR
	 ODaDSLD04yVzUWIOKrcgZ9IAkBFFsneuaJY131+pTl60HT1bzzxZK/9K3m/XRXKl+J
	 Jr3sU2EiL8vQ4UGTNJ5I2dsfuSHGdP1gVn4ZIgQxkYhcnxlTn8PD1QhR7JkI87Ii16
	 FwLkNTqlQLXMJNX/1mtK2PSXYsIqaHP7XQVLOxz1dowaoYFoN4Cn8Rz0Gng1qq1ZO+
	 K5D6oqVw79attVgCZTIWKfGuRaaaQQLc0UdCKU9nCTBHnLwW+uyPhMd89zxyVuDpoV
	 ke5aecnYNxVcw==
Date: Fri, 13 Sep 2024 17:47:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Yang Yingliang <yangyingliang@huaweicloud.com>
Cc: mchehab@kernel.org, Jonathan.Cameron@huawei.com, rmfrfs@gmail.com,
	vireshk@kernel.org, gregkh@linuxfoundation.org, deller@gmx.de,
	corbet@lwn.net, yangyingliang@huawei.com, liwei391@huawei.com,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 0/7] spi: replace and remove
 {devm_}spi_alloc_master/slave()
Message-ID: <0155d213-479f-42f4-ac32-dab3796eb47c@sirena.org.uk>
References: <20240902125947.1368-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7y+9/EfmGewzbeWu"
Content-Disposition: inline
In-Reply-To: <20240902125947.1368-1-yangyingliang@huaweicloud.com>
X-Cookie: In space, no one can hear you fart.


--7y+9/EfmGewzbeWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 08:59:40PM +0800, Yang Yingliang wrote:
> From: Yang Yingliang <yangyingliang@huawei.com>
>=20
> Switch to use {devm_}spi_alloc_host/target() in drivers and remove
> {devm_}spi_alloc_master/slave() in spi driver.
>=20
> Yang Yingliang (7):
>   media: usb/msi2500: switch to use spi_alloc_host()
>   media: netup_unidvb: switch to use devm_spi_alloc_host()
>   spi: ch341: switch to use devm_spi_alloc_host()
>   spi: slave-mt27xx: switch to use spi_alloc_target()
>   video: fbdev: mmp: switch to use spi_alloc_host()
>   staging: greybus: spi: switch to use spi_alloc_host()
>   spi: remove {devm_}spi_alloc_master/slave()

Unless someone shouts about this I intend to apply it at -rc1.

--7y+9/EfmGewzbeWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbkbL4ACgkQJNaLcl1U
h9ACHAf/V+tig0AJ8wJ/Dgs3qTnfDL7oHEbnzCZLYf3r/rGL9w/kv96ock0/jodh
SPokoZs08HKXZj4ftY8EcjksNzVE/T9UJCvQ5aHTMvNUikctnuh5HlyWr6WlLl8h
TZqZpruOSoOJ8S34NkAJLPrt/m8z+VsE1Y2tM+uJcbv5rK+3zdKD6VnyyrC135XG
5lcQYVqg+1KvnYL1ETqcuqEnl1KExekzlhhfyZLwGMuQzDfMnfSmDeryaRNy6OwT
HPQJrlnIRqTFGISadGAPZICNURvy3+u3IK9NlZEv1j/DJ9jJOBsBcL81/giVAWy2
INSW+X8/fddyN9C0lLm5bfJ2vFznNw==
=6zNx
-----END PGP SIGNATURE-----

--7y+9/EfmGewzbeWu--


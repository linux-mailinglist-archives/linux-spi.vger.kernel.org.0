Return-Path: <linux-spi+bounces-5848-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69A99DAB72
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2024 17:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB73164C48
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2024 16:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC32E20013A;
	Wed, 27 Nov 2024 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xmwbv1xL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D7200132;
	Wed, 27 Nov 2024 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723766; cv=none; b=lYjNy6z7CCK6+MeLBM5DcSNDtYN/vLR66eZv32mtT/HxtOJi0KrwQcbvhP5ZMldl+/Mo1Lz1kYl+Wua+4Pmg79RMIraI7hoKXVgup1caywJGQ7fiA3s1zPNrhz0jbHFVUeXkVQj5+daxrK6e1xCqDJmv6mnDp2JCHTSmvbUIafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723766; c=relaxed/simple;
	bh=DRKrGOw5BSxuk51x97WSzPhMhh1HNqqOLM3bU3XYKJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFzLjIU7PxMBCIeRi4M2CAFhFXALnT8FqeFhJD92ZN8ELLVOIrPUxBM5ikE3tVvakmCDWL/3dcyjGv9ug58z+FuyYsIR449pKz3ltpIFLDDD/9fyxSUX2ovFqSSOhu68eqZqMH0CZAar0Xx47wj5Q1Jxjrg2UN6zcG47/aDA2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xmwbv1xL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8EEC4CECC;
	Wed, 27 Nov 2024 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732723766;
	bh=DRKrGOw5BSxuk51x97WSzPhMhh1HNqqOLM3bU3XYKJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xmwbv1xL9QyVmxOqV4kpG6Ft0p31odkXazRfanqrWrtb+XXfzwzZ+TDyxUJOTY2PO
	 UN5Eo9FV/YuSftcIWnNO+bM4T3R1J5gG6DczyHkNa+nP94mc/w4q/DrjC3ROpK1NQC
	 a4cjvx0Eyme9z73LEViGjjecWCGhUk2pjRzDsTUPIN7mYYTdQL/k4n+eFn45ysd2q6
	 aFbTYvg9yW99ypGMANun1vsyxM0dPM9BJnXy8vWUXVwhguzWvQMCoWstlaQmCzFEuO
	 S3Y61cs3gZIUcu5h9df27IevhUu2K4WfzLa0dkIj5KXd+OnPwMP2K8n5TQkItwXKuQ
	 IOE67Pe5vljZQ==
Date: Wed, 27 Nov 2024 16:09:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Vishwaroop A <va@nvidia.com>, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
Message-ID: <59ec100f-1915-447b-98fb-3cbe2ca53a1f@sirena.org.uk>
References: <20241126134529.936451-1-va@nvidia.com>
 <20241126134529.936451-3-va@nvidia.com>
 <a1278046-038e-4825-b029-1b478f28cb7c@sirena.org.uk>
 <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xSJsZwQohazWReDV"
Content-Disposition: inline
In-Reply-To: <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
X-Cookie: Every path has its puddle.


--xSJsZwQohazWReDV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2024 at 03:54:52PM +0000, Jon Hunter wrote:

> On the Tegra Jetson boards we have a 40-pin expansion header similar to what
> is found on boards like Raspberry Pi and allows users to connect various
> cards to. By having a pseudo device we can interact with different SPI
> devices.

> Yes by default nothing is connected and so there is nothing to talk to.
> However, this does enable us to do SPI loopback testing for example.

> So I am wondering if it would be acceptable to having some generic dummy
> device-tree compatible string for this? I guess it does not need to be Tegra
> specific.

I understand what he's trying to accomplish, it's the same thing as
what everyone who wants to put a raw spidev compatible in their DT is
trying to do.  The way to do this would be something like a DT overlay
that describes whatever is actually connected, or just customise the DT
locally.

--xSJsZwQohazWReDV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdHRDAACgkQJNaLcl1U
h9Dbnwf/Ss0gT82LnRlTNAy5MVbrqZyYFdiagdjD3IF/qIlkw3chuhdUcQqJIxAV
kzvmkYuaFQ5D1LoSu9taRJki1pSXEpBb1/PzIoz2mrvdbHGZDFVMjCRKHkLBX3VN
mo5k/xoCIVcPI5GsOetPjvZ0HaCYbyANiYM4y8u8MVR3FKh6Vt1LzFMNzoJRF79a
sB29VIkDOuML+XKRAERHtI+j8H1PNAXC3yQFraKpGTVbLKmxc+jvBTjo8+StpEws
eM2RJ2MmOelEQ69IiviDC+neO5HqmPBWpW7rbwFLTBSkA/kLJWEpj712ksWFCX+u
x/U5/X2xCMzKkH/zIoTYG4bBOyvCzg==
=ubS+
-----END PGP SIGNATURE-----

--xSJsZwQohazWReDV--


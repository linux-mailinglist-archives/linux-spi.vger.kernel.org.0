Return-Path: <linux-spi+bounces-3388-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5639058F6
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 18:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7BA3B22DAE
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5572E181332;
	Wed, 12 Jun 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onyhj8Vn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A7716F295;
	Wed, 12 Jun 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210444; cv=none; b=TCV+sDWR8F2eWL/BmBt/0uQ/Mp/bByOW+C7VzYJfT+9lxcoYmkIPoJgGvgs++WEqdu7gqG7OiMj6JQ48A6+WzHJWT+P8D5jUoQLgK6RyilOBXtCqTpLfwR1lghPX5czW5dfoHUfKkuhLvAXCxsyrfU2elZSWreZQUnfT9ABp72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210444; c=relaxed/simple;
	bh=85XKwtq8lgNQ9l2YL8a7SauGQb3hZbNGMy8WU/0vk1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2+qwRS+R7ZTYSAqZ1aJKYGKK5c66Xc5l99EXcQ4oRs2EvBkojqaWlvTLEybNL0CggFUGGOVq0FCT6GJpSVcyp2JjuAbVv6OYRzaIHCYLOHHLdnqm/9rS4mr1U9ILNf1n1soVEKZ+cqUgwg8dKHjOEd8YcUUdXl1xN0u0Gksfhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onyhj8Vn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E9AC116B1;
	Wed, 12 Jun 2024 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718210444;
	bh=85XKwtq8lgNQ9l2YL8a7SauGQb3hZbNGMy8WU/0vk1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Onyhj8VnaDXMhsbCz7cO+Y8QwfDHUHrbPdQuUwf3RtVAPOQVp6hFN36QZkn8UZyjj
	 z1QiIOV9ySHhisFsBLEpfP2/jcgqX8ctchnG4WmeDsX3PaGsAEOnBNpF2HF8tMjpVI
	 wD+mXurj7sKz1FUlW6atUkUhBcvK35uqQ0c26t3unHt78YjVQJVoj7018kqF8S5LHR
	 LBWVa0N2JqW9XnK4rGJZskhVQOStjDYwhYUASlE46Z8ljlljsy1dHvta3r4ja0vywE
	 cEK/TmxyBAu12SgetSgLfa+6PAMVBdf4AzaMXC8ia2LsIELW/GWOx4VmHhJS1NWL/C
	 heUprjyrZFDQw==
Date: Wed, 12 Jun 2024 17:40:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-mmc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, cyril.jean@microchip.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: Re: [RFC v1 2/3] spi: microchip-core-qspi: Add regular transfers
Message-ID: <ZmnPh39YyfS4ocNU@finisterre.sirena.org.uk>
References: <20240612-brigade-shell-1f626e7e592f@spud>
 <20240612-uphold-dinner-a47b4c44be18@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MdwxjcRzQ3pyUpUj"
Content-Disposition: inline
In-Reply-To: <20240612-uphold-dinner-a47b4c44be18@spud>
X-Cookie: Your love life will be... interesting.


--MdwxjcRzQ3pyUpUj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2024 at 04:48:32PM +0100, Conor Dooley wrote:

> +	//TODO: questionable robustness if both cs_change and cs_off toggle
> +	list_for_each_entry(t, &m->transfers, transfer_list) {
> +		//cs_change being set means we need to re-enable

Is it not possible to implement prepare_message() and transfer_one()
rather than open coding all this?

--MdwxjcRzQ3pyUpUj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZpz4YACgkQJNaLcl1U
h9AVQwf+MGtExjI/bWW1yGC4RO+HV4ZjtGV3c7j96NAiLdf+87svqV9in+GrvgRZ
Gv3J0UZoID/NR9sJoPYXZ1j9KR7cD/ps2pScjog4b8t7K1RKGzO1lck5WOlh+c4E
D9WThX1LgACsUO8N0tplHE2OK/86wJe6LiSrJttKezDV+RpuvevMMAFs1vv9M+CV
abVC0AHa//7OZ9gYfzg3tLeclZCtrnHSvfG6ftXwso1glyYK3ky6sR+JN0BwvoXV
4o8mXO6+SyWkx7p/8FVVZ3qM21w3UHodxvslwMKAlXmAIdXes8c4v1wlUUuzr4sK
sSThubOWebv8HG4Pc3SfyEldXQ6CHQ==
=pdjw
-----END PGP SIGNATURE-----

--MdwxjcRzQ3pyUpUj--


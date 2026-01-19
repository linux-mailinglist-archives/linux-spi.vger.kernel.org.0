Return-Path: <linux-spi+bounces-12499-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 748E1D3B698
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 20:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20AF53004ECF
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 19:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFB136B075;
	Mon, 19 Jan 2026 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDM9zGN6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFEF31A7E1;
	Mon, 19 Jan 2026 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849303; cv=none; b=iuN834oL/CctyfMt9lrcsQShb5FXyQjsgOMeCDTdxSRbHtTuKVEatesjxkS9B9gsF8Gi6YXc+GAL0aA0XPxlet62mKRTVMo5sSY74Bq6J6Y5UPvm0bS02PyghW40SNNDQ02eO816UGcmlVjzrSRV4SmeaLdfsSbEy1VtdrsR8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849303; c=relaxed/simple;
	bh=tKjeh8msjClsQYtO0ds3L7yaxHdHnzKWgNBka2GGlpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VS0JdyG47dUIXYOKRhlEd64iU3zavKqxKNV84UdSaT6Va9ktEfZXTqdhJ2y4LTJdCOwppejWs5D7fmdm1Z2IBYimWcT63Wy9Y2vay4Awu/T7A0alkEY3V5NtTladUZ9JC5h8nrlMLdD1QoaKuH6e0buSD5TCMwfolHiNj/N3nJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDM9zGN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326CCC116C6;
	Mon, 19 Jan 2026 19:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768849303;
	bh=tKjeh8msjClsQYtO0ds3L7yaxHdHnzKWgNBka2GGlpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CDM9zGN6ef387sGofUwWTbNxfAljGcEMhxVcuOi9BV8Ee7FvL0Ji4Q3d54EDVytbJ
	 0wt0ipJf4U73Nj7aJdTKl5/k7ZjWwm+wAEuxoZirUpBAYEvJzKHe7HOU5kh87ITVqJ
	 yhh2QNEgWAOB3Xkicm8VV/Uswl7OovCgy5O6PNYqXtgw2gR2U803+0xN29BHLjIduF
	 8Hpg3+JM5lOjlpdmrqq5ZmEqYSziCKh6/nDVMKKbeKUO7nvuldK3H55OOxQXmwrhjN
	 awuXmXS2y9hfxrSAd3cIIOyMBrjMIQFJnL/u9u8sqMRK3cgH19b6ELxgJbfcJFnyZ8
	 zkkRBhF29DYcA==
Date: Mon, 19 Jan 2026 19:01:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
Message-ID: <b03307f7-93f6-4680-9241-cf28b5456fd0@sirena.org.uk>
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
 <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
 <8436e914-429f-40b9-8e6f-ec3b02702cad@sirena.org.uk>
 <69F83558-4675-4FC2-8656-BC6E3481AD65@nexthop.ai>
 <9e559e33-4f2f-40d4-a15f-584548bd6057@sirena.org.uk>
 <05D2CC15-DD6B-40F0-BFF0-3264D4FF96ED@nexthop.ai>
 <b1b79de0-a078-486d-b3e9-96899354407c@sirena.org.uk>
 <3D1B59A7-6E57-4C8C-AA95-EA7AA115264F@nexthop.ai>
 <b9ad8ab8-7985-4c89-a82b-c7f31d32c167@sirena.org.uk>
 <a6d57890-89c1-445e-836c-d8239d20c621@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KsDaClmaKXt8A/4a"
Content-Disposition: inline
In-Reply-To: <a6d57890-89c1-445e-836c-d8239d20c621@amd.com>
X-Cookie: Does not include installation.


--KsDaClmaKXt8A/4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 19, 2026 at 07:52:35PM +0100, Michal Simek wrote:
> On 1/19/26 19:38, Mark Brown wrote:

> > This was specifically targetted at some embedded x86 systems where there
> > was a goal to reuse device tree bindings for things that just can't be
> > expressed well in ACPI.  _DSD is generally considered tasteless for more
> > server style systems, AIUI the general approach preferred by ACPI
> > forward OSs is to use some combination of DMI quirking and registering
> > with a per-device ID (like the per generation fake PCI IDs that Intel
> > uses for all IPs on their SoCs).  Just blindly accepting _DSD can end up
> > with something that's not used because it's not what the ecosystem
> > wants.

> Is it a better way to use auxiliary bus as was recommended by Greg in past
> on drivers/misc/keba/cp500.c review?
> https://lore.kernel.org/linux-i2c/2024060203-impeding-curing-e6cd@gregkh/

The driver there appears to be doing runtime enumeration based on some
EEPROMs on the system and creating platform devices based on what it
finds there so it's a bit of a different thing, the aux bus suggestion
is about what the code that does with the data it got from the EEPROM.
This patch is for something described directly by firmware so there's no
way we'd create an aux device, that's purely in kernel.

I have no idea what the hardware this series targets is (other than that
it's using a FPGA) or if there's even a motivation for the change other
than code inspection.

--KsDaClmaKXt8A/4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmluf5EACgkQJNaLcl1U
h9Dy0gf+OS2LP3VmrR5J7irzVl+DrTdrNVc/qZ+Xm5xSwwFK2D6u7RRJhQ8xgcAx
iHEP+TS/bw3H8HEQWFn9Y9GirDBLpvXxr0Rg5srdFx53048pCof1x0CzDwRekz+Q
vmLgOARyRJci5gZbBiDnwATkqJeIbknBZT4NQFSAE+Ur8calXl0IxeiJOx8K/XWk
/JFMCs1/0Yh/3ztvEEslbriwoaJoK8z69qeAE+hK2dofOv8x9P4POTbGUPTRDWlz
pixLn8kL6gA9+8q5cEziBYo77DkFaSRApdFYCD2iEVnyfzrr99p4/uY4gFTt5wKA
vvpUUoRUVUA0PotpMy4bcOwk11EWZg==
=EJtx
-----END PGP SIGNATURE-----

--KsDaClmaKXt8A/4a--


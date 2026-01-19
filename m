Return-Path: <linux-spi+bounces-12504-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FEED3BBB3
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 00:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F8E73029575
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A915329BDAD;
	Mon, 19 Jan 2026 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QufClxow"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A6119CC14;
	Mon, 19 Jan 2026 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768864861; cv=none; b=pUFZ15ftPRlQq3n/87tmndkx+NBfQ9Ka33kVv3TWdm57jBfZv8Ktg6juZAMN3bXT0Kq6ozW1CETtHJcOkeytN7Km8lxsNmmDndjKH+h/T36mL0F3OsJRoXDYO8ddX73+1z4nk2L5Xewe6Jjzibc0xZOBGQnvoury8gbXgr8EAZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768864861; c=relaxed/simple;
	bh=ldLjdaVRt8rwNaafRAJAtJekxk0qF4a8CqmI6RgXLP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/q+rhrzCS/dS6aXTan4heyR7dkxnxaWb/mRvTtFlSedwJlGxKXw8Oe+z1lp5SdlJLJqzP9EWkjLAIbprfO7YU5KWPV64wLnvvPTLSIZgXCC3yQmo2uFsdNG/A1ZpatF0/ebia/1PvQuIVV3mNt4EMqUqDGde6sG6QHD0Xi/KJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QufClxow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BEAC116C6;
	Mon, 19 Jan 2026 23:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768864861;
	bh=ldLjdaVRt8rwNaafRAJAtJekxk0qF4a8CqmI6RgXLP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QufClxowfNM78ARGXteTtwI1/Bk6k5rols0Y9Rvf+gshIOGPFMZ3/kfTOMJlC+V29
	 U3d+BFii0ggeRi8TgHIYCjM6Wa6nhwPRa5azSaJIkLlGkoj2F32T7a22MN8HW7iJRP
	 NkHRskFPa1mihS5fi0NsajP3YPOZOwWe6ehaiPkLhAkE5gT3aB9cb8OI+bG73NggTU
	 DDYeIdIWzBcDov0gRzYnGtGC/87wlFLOQGe3yalZOahhjnRhfVe7DMn5fBOYGx9Cl2
	 xpmFm23InrF5Deh86XaTwz8oPs1nuNDse1M6atJXR9lKljiJdfjPiTggG/LhD0TLNo
	 Pf1BPxKGQFyEg==
Date: Mon, 19 Jan 2026 23:20:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
Message-ID: <6e06696e-09a4-46e0-98fa-252690b888e0@sirena.org.uk>
References: <9e559e33-4f2f-40d4-a15f-584548bd6057@sirena.org.uk>
 <05D2CC15-DD6B-40F0-BFF0-3264D4FF96ED@nexthop.ai>
 <b1b79de0-a078-486d-b3e9-96899354407c@sirena.org.uk>
 <3D1B59A7-6E57-4C8C-AA95-EA7AA115264F@nexthop.ai>
 <b9ad8ab8-7985-4c89-a82b-c7f31d32c167@sirena.org.uk>
 <a6d57890-89c1-445e-836c-d8239d20c621@amd.com>
 <b03307f7-93f6-4680-9241-cf28b5456fd0@sirena.org.uk>
 <a3fcef3a-d1e9-4b46-b114-3a82575e052e@amd.com>
 <980ad372-a2c7-417c-91f9-4958d3d1aaca@sirena.org.uk>
 <4831B269-DFC1-40E0-96B7-67981AC72562@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="atl+bvCru4JN8H0k"
Content-Disposition: inline
In-Reply-To: <4831B269-DFC1-40E0-96B7-67981AC72562@nexthop.ai>
X-Cookie: Does not include installation.


--atl+bvCru4JN8H0k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 12:30:43PM -0800, Abdurrahman Hussain wrote:

To repeat what I previously said:

| Please fix your mail client to word wrap within paragraphs at something
| substantially less than 80 columns.  Doing this makes your messages much
| easier to read and reply to.

> > On Jan 19, 2026, at 11:56=E2=80=AFAM, Mark Brown <broonie@kernel.org> w=
rote:
> > On Mon, Jan 19, 2026 at 08:17:46PM +0100, Michal Simek wrote:
> >> On 1/19/26 20:01, Mark Brown wrote:
> >>> On Mon, Jan 19, 2026 at 07:52:35PM +0100, Michal Simek wrote:

> > None of this looks like something intended to add ACPI bindings,
> > it's not clear to me how we'd even get the device instantiated on a
> > normal ACPI system.  There's no ACPI IDs defined (and there aren't any
> > existing ones), just a conversion of the property parsing code.

> These "random" cleanups make the spi-xilinx.c driver work on non-DT platf=
orms.
> Which is what the cover letter says.

The cover letter just says:

| Transition the driver to use the generic device property API.

| Additionally, make interrupts optional to allow the driver to fall back
| to its existing polling mode on systems where interrupts are either missi=
ng
| or broken.

which doesn't mention any motivation for this, it's just a statement of
what the patches do.  It's very unclear why this is a series TBH, the
interrupts changes have no visible relationship to the device properties
conversion and should have been submitted separately.

> We are trying NOT to introduce new ACPI IDS, or fork the existing drivers.
> But rather, to re-use the existing drivers as much as possible by relying=
 on the
> special DT namespace link "PRP0001":

What is the goal in avoiding using native ACPI bindings?  PRP0001 is a
workaround for cases where you have things that ACPI has never dreamed
of and can't abstract well but which have already been handled by DT,
it is not something we're aiming.  The hardware you have described
seems like fairly normal server style hardware and like it should fit
well with normal ACPI.  Adding ACPI IDs to existing drivers is pretty
common and standard, I'd class that as reuse.

As far as I can see from the example you posted the devices are all
fairly standard and just need IDs assigning to work naturally with ACPI.
There's possibly an argument for using PRP0001 for the flash given that
it's not especially idiomatic to have OS visible flash on ACPI systems,
usually flash would only be visible to UEFI, but equally the description
would trivial and systems wouldn't have to use it.

> > You should use whatever firmware interface is sensible for the platform,
> > if that's x86 that's always ACPI.  For other architectures there's a
> > split with servers using ACPI and more embedded platforms using DT.

> Which is exactly what we are doing - using ACPI on x86 to describe the ha=
rdware.

There is the bit where there's a PCI bus in the way and you don't use
ACPI particularly idiomatically...  I can see the dodging out on the PCI
bus description, but the way the devices behind the PCI bus are
described seems confusing.

--atl+bvCru4JN8H0k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmluvFcACgkQJNaLcl1U
h9C/sAf8D/AWHIpwscNsYjs1nRd2HhBRgc22hUt7u4LRBmLMxi+3HBMCvum4Z9kd
y6BPE0bKqyoxv4xk0dF/dsYTGD6bg8awUFlxyBF2hzvooAmQrFqzz5N5y/WqJRSB
mB4MJ25kI3628smmPFgi5TPOoSmANs+cyyWNsVo5MK4KmISEyLfYkre59cg49jUY
KAmiSFBjQoslcaOREtPAhybgifHIzIPgmmieX8owbmyziUpO77XKHQ57OweE0W0z
nlY9HhDDMTu/pQMHjfmUwpCPNUIeKFSedWw039j97Jq2oOUGTLSO0eI5PyG8XZ0B
S/7YhqqpYF+ND2oz6iZf9JmYzq8P4A==
=mcAY
-----END PGP SIGNATURE-----

--atl+bvCru4JN8H0k--


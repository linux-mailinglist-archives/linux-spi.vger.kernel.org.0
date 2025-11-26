Return-Path: <linux-spi+bounces-11588-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 31219C89AA1
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 13:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26C4A346F9A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7AC2ED853;
	Wed, 26 Nov 2025 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPJ1douQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D914D26ED5F;
	Wed, 26 Nov 2025 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158624; cv=none; b=N+BiJwsM1engkuTp/hRoj4rE17yaL/pfRShUAUd/6eBLsLY5z07DH9qZYd3dI7oTAc8gOqZzlllO/xyQqiA9J60OaziL6j/qSkRWKauJ5VfPDwgT9Kuk3LdccXx6JF/Mr5y8HBU7RMvy3Obmfc3vcdxqML96okXUo2bC6qZ2zBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158624; c=relaxed/simple;
	bh=AJX990TL2Lzy37GFauxayUAAQy0YTLRCXavdQ4ir430=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuH9QHS9VItU3PZk1qL/rlYym+cRAOodAu9YukmELfCUy5doNZsQqnvBghzySSHRaxsUEBPzOyjV32kuNB+UslRLkDP95KuRcTP+hOLfta4xnPKBzDsOksK+ELAUZSv8tS3vm1BBCKOSQTUV/gUEzgWR+td7sYJZR2RVrBa4aAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPJ1douQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43113C116C6;
	Wed, 26 Nov 2025 12:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764158624;
	bh=AJX990TL2Lzy37GFauxayUAAQy0YTLRCXavdQ4ir430=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPJ1douQ7kEbjTqU5pk48NP69EaEygB8yLVeZbmvWQfpQSs/agjwAP7btm0S82kZv
	 pmvIXZwKEu775hKsfWc2zEQ9RkljEhhrr8hoCmZK/TAsXUT72Ya9dbtr+Wn4E49KZj
	 Wrlx2J74ohgHxNrQtuQPvJtX7FNY1iD1I305g9hRw6sP22TJb6l5UTpmLdb8kO6boZ
	 fZHXELw2tiAZrNU+SRa1beC3w6gym6o7sUAI6qJ6ca0MMWeBHdZTlPsfAfaI+uQqSL
	 evsUO/qskoRYXU6d+Hnfz22Mp+ptrn7zkM54AU67dsSRgwOJ/+Px1BZVDM0Zje490X
	 jByUgN6uNlAig==
Date: Wed, 26 Nov 2025 12:03:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Conor Dooley <conor@kernel.org>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] spi: microchip-core: Make use of device properties
Message-ID: <72130514-d9a6-4cbe-ae7e-7e23abc95286@sirena.org.uk>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
 <20251125201700.1901959-3-andriy.shevchenko@linux.intel.com>
 <8d4c9c21-63ea-4217-9579-c8a3bbb58946@sirena.org.uk>
 <20251125-cricket-disregard-581e5b722d91@spud>
 <c9248874-7380-47ae-8b1c-33037b7beeaa@sirena.org.uk>
 <aSafnlEbZt-yFzbv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qg0xmQiNKArmgkTS"
Content-Disposition: inline
In-Reply-To: <aSafnlEbZt-yFzbv@smile.fi.intel.com>
X-Cookie: I don't understand you anymore.


--qg0xmQiNKArmgkTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2025 at 08:35:10AM +0200, Andy Shevchenko wrote:
> On Tue, Nov 25, 2025 at 11:19:22PM +0000, Mark Brown wrote:

> > I really don't think it's a good idea to just do it as a thoughtless
> > default given that there are cases where we actively want a different
> > interface on ACPI or don't want to see a device used at all.

> Okay,I think the commit message is a bit misleading. There are two ideas behind
> this change, one is to have agnostic APIs in use, second one to make code
> shorter and cleaner. Assuming we are targeting the second one as a main point,
> does this make sense?

I'm still a bit dubious TBH, I didn't spot anything super obvious in the
patch and there's the whole should you actually use anything other than
DT question still.  It'd seem better to make the OF APIs better if
there's some big win there.

--qg0xmQiNKArmgkTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkm7JsACgkQJNaLcl1U
h9DVTQf/R6zInaGvVl3GSBnxp4MidlbnAE0s8aivH99An+qmZLMkjOBEgjjjC3Dt
wLauUk0SeygJfrNJaOu8Ji5aGxadvjn/J4A/9CnyzuEtW+M8fF6EHF4li++gjFFl
C3J/0O08k5JHRkMEedVQJ+KjWaTyNpEKJYp3OS0Ou5W/vL6L2F26WZ9qiJ9RUOhT
R65QlgYvGPDxniv67XtUqn/iSB6dMuNWYskUzClcQqD41rnrHm/OL/JFFkzz5PSX
eE/pVOt7K7H+kBctlcYjc6R94aHT674QNlbUtoRdm/wTT1zC0IYD/erPYFdR1mZx
dQpAcpGRhKXxYnNVPoF0zEEzwcxX9g==
=r9ge
-----END PGP SIGNATURE-----

--qg0xmQiNKArmgkTS--


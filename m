Return-Path: <linux-spi+bounces-4877-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BA397C81E
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 12:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1C71C24845
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9D919AA5F;
	Thu, 19 Sep 2024 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU7zbATy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6195194C61
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742605; cv=none; b=ZjG4a0HOb2HA2p0VSGiuTlTpAOCWJricvzAoCLUwLCU1JmujXPPFZlFIjuUrWjYWO1YyONsXOxqJVcHQkuunmPNjDEQ3yRV32RiJyBtXW69YFH59ApUiCttn3SkagcpmUQ1QhBtkoF2JAB/6GwXcXmqviB+RS7h/7RgwU7K/9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742605; c=relaxed/simple;
	bh=EHtny0pChaI3F5c8aTKE+T8QjpjMZEXc+nsAx7uwenA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIs6iJ84NINUM9xqDgLH4YrbDsuDPd9i/eWd1KBN+wJfXrT3edS4KfbRnI00YYFxH4BRcFyhKAHrtzsIF1P6v1LDuOtLo57DoFsqmBQYPyEd/KG2gdJQV5KgG+1j1OXmJ8GxY6uC5CRauIjRwYKUVfqgzgH8wZJ/t3lP+8yKBpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU7zbATy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2292DC4CEC4;
	Thu, 19 Sep 2024 10:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726742605;
	bh=EHtny0pChaI3F5c8aTKE+T8QjpjMZEXc+nsAx7uwenA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sU7zbATy/klDP0d68H+TlJgnIWUgGVSiTim/rxcCaqr+Gefv4swwBqM9CJ2Nw/G6V
	 sgZVCQyRDgPMcK6bq213wrEVossqlxrS+I+47Y5bMP2VSPMQvioeaOzElhZOfge9mj
	 F2J4oQo88ngYsmE8SPnSVGVVRiiY18UsyMG7KkOzFlsiirtPhmkmOHglz+7LwDEafq
	 Rpz2i+bAXp2pbs73KZH0WexL5Nd4X2OVu3yLD2RK2AB7GsXeXTRRk8Hwizd2P5aLQf
	 JkN1qm336+osA/IFZYVw+FycXvYRDTnHQTXFUZlYZczIH1mkPFmDT6KhlOC/ca/iki
	 FNFj3wKShba1w==
Date: Thu, 19 Sep 2024 12:43:22 +0200
From: Mark Brown <broonie@kernel.org>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"De Marchi, Lucas" <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	"Lubart, Vitaly" <vitaly.lubart@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v6 04/12] spi: intel-dg: spi register with mtd
Message-ID: <ZuwASoMtyWvZIFNg@finisterre.sirena.org.uk>
References: <20240916134928.3654054-1-alexander.usyskin@intel.com>
 <20240916134928.3654054-5-alexander.usyskin@intel.com>
 <ZurX4xcy7TK45Omq@finisterre.sirena.org.uk>
 <PH7PR11MB7605B60D43732A60C0A32D46E5632@PH7PR11MB7605.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tIkx8wPTo++rhvtv"
Content-Disposition: inline
In-Reply-To: <PH7PR11MB7605B60D43732A60C0A32D46E5632@PH7PR11MB7605.namprd11.prod.outlook.com>
X-Cookie: Editing is a rewording activity.


--tIkx8wPTo++rhvtv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2024 at 10:01:06AM +0000, Winkler, Tomas wrote:
> > On Mon, Sep 16, 2024 at 04:49:20PM +0300, Alexander Usyskin wrote:

> > > +static int intel_dg_spi_write(struct mtd_info *mtd, loff_t to, size_t len,
> > > +			      size_t *retlen, const u_char *buf) {
> > > +	return 0;
> > > +}

> > If these functions can legitimately be empty they should be removed.

> Those are place holder so the code will compile and implemented in following patches, this is compromise on not making too big changes.
> It use dot be acceptable compromise in past.

If you omit the functions you should obviously entirely omit them
entirely, including putting them in relevant ops struct.  As things
stand this just makes the code look buggy which doesn't help review,
you're adding functions which obviously don't work properly and not even
noting that in the changelog or code.  Just add the assignment of the
ops when you add the implementation of the ops, that way there's no
partially implemented step.

--tIkx8wPTo++rhvtv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbsAEkACgkQJNaLcl1U
h9BZlQf9EIUQoyUf37isOsOSa9SY28Yxwp4HgDn+oa/Vitp0xd1jVdZLhUs/Z0df
9gGnJBY8ih/cUYS0B5lfsO3xn2GYshDXgKext4X/F+WuCSs0LVJ19ZWJo/C0JcaR
2MPUQ+h3QjpL26Ug0vq08iXnZCWo5/dXYbYMZJB/Oj6ReSG4rDF8m8WsqYr4JcPn
nUkMM60rId1d59bb7dvgneR+ljIEnBvrc1QfzM7xwmkKZ2ftx/z4zhh4JaCYTkdS
aGbxDDXFauHdx6H/n0RgfUOKnRbl8TKWYJwG2SS6XBqXGaBO66u4oTlYjQD6RdTG
8jpm3WiJW3j3MAvX8gy/gUFUOyJeiQ==
=+4K1
-----END PGP SIGNATURE-----

--tIkx8wPTo++rhvtv--


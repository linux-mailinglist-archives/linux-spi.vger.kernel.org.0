Return-Path: <linux-spi+bounces-8953-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E94AFAEFE77
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808E2188D427
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38893279DBD;
	Tue,  1 Jul 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3RweiDK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7C5279795;
	Tue,  1 Jul 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383859; cv=none; b=cOSUazs9W/0bLWOJvfIy7JJ/JerBWr4CHzvlBhfWxW019yRklaVWVd2vAIC85xiunHsNAtLZEu+OK0OEp1cl0n2nAQHHYPcD6U6qc0WTWVNhSQOE7rjm5fL3pOKrHCjcRGX/i37uDilRX5e33Ap48mwyH8lOMzuGvPZ0YXNvXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383859; c=relaxed/simple;
	bh=iQj/zPT+jV/OpLNW2E0l3eLxBgFKFwdXuIzFbY8QHx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeHIpClnAjogiVaKDkXu/iWvlRu02z0WHQWXx2TXXRv3sHee7wVXBlPwzKk6TqF9uBqrKyxC/7pXO3EsIiZigzSAlveEfGUC2Zx2l14EQ8O2eV/mCQyM+KEJtE1B+om+B60TBgpMexqpqLSxbM+k/RzLpQCS4BB7rKcID1Te/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3RweiDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56A3C4CEEB;
	Tue,  1 Jul 2025 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751383858;
	bh=iQj/zPT+jV/OpLNW2E0l3eLxBgFKFwdXuIzFbY8QHx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3RweiDKCi26++6p3MRCraKm7blPX7uUFzX3z56uJwSb4OKTpfjRLgVMWJFMMpwcV
	 kHmVgtUenaqrLED1VTkH96f+rR0F20AdcCq1kaPYz8DiyUpNokOCCyJ1dxioAzNbJ0
	 1lrGTLhJvbHD47IKvkLCYuPIaItUSj4fTI5f+7lwQZnjJrRHriMzUPvIgV9OpVKi/H
	 b5fbYi0CShJwMJaV+MV4BKTGy5WQQiTZtPpA8vz0gJq5VkQrO+WyP92D2bAyFlHBn4
	 3xBERr4aSUeCEit6tr2jR1f8r5TZJpCZS2Igrk7ELcOk407fgCJ1uPb1ULSXe2rRGk
	 O23fufwQMMaSw==
Date: Tue, 1 Jul 2025 16:30:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: James Clark <james.clark@linaro.org>,
	Vladimir Oltean <olteanv@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] spi: spi-fsl-dspi: Target mode improvements
Message-ID: <578e01d9-20bc-48f1-aada-579276f6a9d1@sirena.org.uk>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250630152612.npdobwbcezl5nlym@skbuf>
 <c9bf945b-9fc6-4829-addf-2fb7a7d4eb36@linaro.org>
 <20250701135747.mns6emamtmxwgpyu@skbuf>
 <3c3c912c-1f33-4f63-9a37-fe4db5d23527@sirena.org.uk>
 <20250701145312.zx56ji4vvaoxwzkc@skbuf>
 <dd41f014-79e8-4567-9617-754b93e2c12d@sirena.org.uk>
 <20250701152433.4m54y2rkjzfe4kag@skbuf>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2FxrJs+8WJHxk+HO"
Content-Disposition: inline
In-Reply-To: <20250701152433.4m54y2rkjzfe4kag@skbuf>
X-Cookie: No shirt, no shoes, no service.


--2FxrJs+8WJHxk+HO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2025 at 06:24:33PM +0300, Vladimir Oltean wrote:
> On Tue, Jul 01, 2025 at 04:16:50PM +0100, Mark Brown wrote:

> > Switching between modes is incredibly common, usually between PIO (for
> > very short transfers) and DMA, that's no problem.  Factoring in
> > timestamping seems like a reasonable signal I guess, might trip someone
> > who was trying to benchmark things up but probably not normal users.

> Ah, ok, I vaguely remember something being discussed about can_dma()
> on previous iterations of this patch, but in a different context.
> Then that's an avenue to explore, I guess. Looking at that method's
> prototype, I suppose dspi could simply return can_dma = false "if (xfer->ptp_sts)"
> (timestamp requested), i.e. no core involvement in the decision process at all?

Yes, exactly.  It can base the decision on whatever amuses it about the
transfer.

--2FxrJs+8WJHxk+HO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhj/y0ACgkQJNaLcl1U
h9AA4wf1HpKIPW+LJH8rPfjIBT9odSSTNv12AYDc1i9DdflTO1rvB7Ye0vjzEb8X
ASCf8RLUsYTE/3uGBFNZC0b0OpfkYGwVfTapks+RM3t/i9HdVzK23loy1UyodGA4
JNYXSXVgPJLXl5+QBnUKkR8IOcaNqVC0Zz+jW+rBBQf4+EmDoJ4jAymS0ZSy0cMo
bXo/9QeIgGUcwUEMlQg7ACyjuUgwEZWd8bhKaUQ2wl54zSGe7ngt6Wb+rwtZFNjB
4WIc+DPcI8xMHs76pcn3rzi3dS8sKhGzdGHniTp4PF3xTNVgJFIIYS3XzxKF2m3S
TjC8nGA/rgAJnUcZYdKcALl7msMK
=ZbKC
-----END PGP SIGNATURE-----

--2FxrJs+8WJHxk+HO--


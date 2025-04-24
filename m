Return-Path: <linux-spi+bounces-7743-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D02A9ADCB
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 14:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9223A913E
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 12:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6381527A927;
	Thu, 24 Apr 2025 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZ5Bi8SJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F9627A91B;
	Thu, 24 Apr 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498667; cv=none; b=q9pQa6rrL0nLbFYKzD6E2aHJ9rxIH1Q+MMSnrkon6acxCBt41Qf+wMeMXzIEZueYXh2c/IduYloIsPCeRrzo7FjEmgU57b8q4TJ1XklUTppgjTi/yn+BhmoMVc9sPvAGdgJMZNN8W4FJzNImaFQ0rG4OY+3Xedh6DRCoeimch2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498667; c=relaxed/simple;
	bh=FjKNpcQc9BxoQrc8qLiybgg9bV0aMoIQoFX5+p7pPcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1HFHBORJpaA3Yr3RG/Cl+nBIEm5wDGmhfET9TKtwcpIQhMf+Z7O2t+yIJnebtFg3cXfbIPEWkU33pzp+RMK1VL8mez+sahE3PXJPFp5iMlzVZYT8nDNP6w9k4vCUjNOxtl7WqmsXPF+c8ubn+zgiWwVA0v0BQx9PVWU+bbHOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZ5Bi8SJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63668C4CEEB;
	Thu, 24 Apr 2025 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745498666;
	bh=FjKNpcQc9BxoQrc8qLiybgg9bV0aMoIQoFX5+p7pPcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZ5Bi8SJI3zD7ZDiBbeAdyBfvmmRCjTGuuP5Eq/zS4E9WpNvu1K6W2oQpe60/ij6f
	 dlQ6I+amaFMBeezKGWPYL4c+PJ3vRC8YCervOJv5D4ghTZI6v5kYSJnoYAzPWfl2ty
	 FJM3NFBzj7YrgFS7nQWEuE4J3KVW+qvp+LshRPI5uXEE86DhAfWjo0XTWCVg7mnENa
	 euDi/TSufCWTDx4IqS/yDuWJ+18cgcIPE2kO3V/COkao0VyIjAN4GA4nMmohvPIc+/
	 sHlqHMOnqVy66cmZM28WcOaJLjMrIouVZ23flxvcCa1+C1HzoegiLKyvPToPbTELGP
	 x/8VqZiynaLwQ==
Date: Thu, 24 Apr 2025 13:44:22 +0100
From: Mark Brown <broonie@kernel.org>
To: "Rangoju, Raju" <raju.rangoju@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>
Subject: Re: [PATCH] spi: spi-mem: Add fix to avoid divide error
Message-ID: <a8f7bcf3-c2c8-4bea-b33a-af0afd46a0eb@sirena.org.uk>
References: <20250424121333.417372-1-Raju.Rangoju@amd.com>
 <8e9af5cf-0098-4b76-a945-f8a96b75e163@sirena.org.uk>
 <7166d32d-1172-4f43-8539-199791a1f82b@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H3c/q0mBaEmQz18u"
Content-Disposition: inline
In-Reply-To: <7166d32d-1172-4f43-8539-199791a1f82b@amd.com>
X-Cookie: Star Trek Lives!


--H3c/q0mBaEmQz18u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2025 at 05:57:38PM +0530, Rangoju, Raju wrote:

> Sure Mark. I'll respin V2 keeping just the relevant part of call trace and
> discarding rest of it.

It's fine - I cut a bunch of it out locally.

--H3c/q0mBaEmQz18u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgKMiUACgkQJNaLcl1U
h9AjFQf5Aa7BdpcxfkpemuUS7ylZ4VueiJZN/KTFC6EomJ2jTIUqsMrJ6sNdAY0J
kkmewdlfottcxAKzwt1EnOh8jSB+VlMQ545PRNxgWXA10SXK5HiYZCP2P17DtXIC
ILI9ARG2BpTS5m4xYgH+h07Gxm26PvNMtD8na69KL8auLgn6x1FZ9XBhiRkzVVJy
Eq5ovL2WNbQvVf04R7eI06H5qhCUbGabuugXCOVMZcTotb2AxppSAAeImd+QMZsu
48xYp2S5Bjb2AdOvpX/noXVX75JVq8qCVMsIfq0GF3XpE81InKQMG5T0xMCJwUl0
euRV2WJ9XI0KgF1ToEHluHuHo2Kwrw==
=stLT
-----END PGP SIGNATURE-----

--H3c/q0mBaEmQz18u--


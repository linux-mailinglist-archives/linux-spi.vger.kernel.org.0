Return-Path: <linux-spi+bounces-9781-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D415B3BF04
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 17:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0214466FBB
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D8D322DA5;
	Fri, 29 Aug 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgleI0+u"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED86313529;
	Fri, 29 Aug 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480594; cv=none; b=BaO5U7M/LoJY2lmx6WdzaIUtGp1VTdz+utt6aIUYMpV6VXwsaDpiPShzLNbu+bFButtYODhctP9u6LOqGPpJpMA4G8nYK6M/UPOOzZ7xqZH/PPeiDSo05Ks6aPDKbsXDuwGZFsswC1jyeLBKJJr94bVc8giHoEwEylpL2Twkbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480594; c=relaxed/simple;
	bh=FJtaleC68nhBHq+4faUuH/z5iHXXo3ZXutIEf+99VKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COaJkylpvkPuNv9Es9ONm6c/FFsnjrE3RGEnHlvVIf6IhVvLEjwGqU+asRGXXVg6eSO511RubZ9P7seH58wZzhse8ZyqdMSUyPmUyFWN70yENQ9ZqVSpJU/3/lM1aSQz4uzwsdefzxuwDxVc6tTA6SxJwT3veo6ojzT77eM4X1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgleI0+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27324C4CEF0;
	Fri, 29 Aug 2025 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756480594;
	bh=FJtaleC68nhBHq+4faUuH/z5iHXXo3ZXutIEf+99VKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgleI0+u1fSKPRmtgPucOUDLXfyM2Q7doDkt/Rbr2dC5a75yPl4Ew/36Qgp3hpHEW
	 eBoQlyXsAqIjJO+zmCJdgLTlmlCkExK/Mjk+z/C8umEta4IDUkBkvfrRhvJoro3F+f
	 OorXXLupNXgYoOPXvKug5gsNrJWWQzIbXtLXH+KRwLJceABl5rSHi9OlssteaWo6aC
	 db3eBjTplH50HeQgU3ltTGfRae3BTZi3I0STSAlOVe3LFpjL3p64ZBDFn85LvqCHYW
	 jdTuvDkbMYzRM50uFhJ4HaCF9Qw/H3cHignuSEbCTmRWa95GV0CHWW7Tu8cncQZYgl
	 r8PWQlHIgKLzw==
Date: Fri, 29 Aug 2025 16:16:29 +0100
From: Conor Dooley <conor@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liang Yang <liang.yang@amlogic.com>,
	Feng Chen <feng.chen@amlogic.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v4 1/3] spi: dt-bindings: add Amlogic A113L2 SFC
Message-ID: <20250829-ignore-scheme-d3d8b67ea125@spud>
References: <20250829-spifc-v4-0-1e57fd39f584@amlogic.com>
 <20250829-spifc-v4-1-1e57fd39f584@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/dYG5m5bU/0llhy+"
Content-Disposition: inline
In-Reply-To: <20250829-spifc-v4-1-1e57fd39f584@amlogic.com>


--/dYG5m5bU/0llhy+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--/dYG5m5bU/0llhy+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLHETQAKCRB4tDGHoIJi
0iQNAP9CvtzX1G5VfH9mTB3CnPaw1gwpTiQ3LJr6l25zrcRNDAD/T73b1fZtu7dk
NsdcwCV2Q3N3CloTLpWKP/u7Ii+XLgc=
=2/0u
-----END PGP SIGNATURE-----

--/dYG5m5bU/0llhy+--


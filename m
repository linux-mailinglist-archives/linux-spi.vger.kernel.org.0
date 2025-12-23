Return-Path: <linux-spi+bounces-12094-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CCDCD9AB5
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 15:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25DF5301EFCC
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34996332914;
	Tue, 23 Dec 2025 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6ox7ALc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE51B4F2C;
	Tue, 23 Dec 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500428; cv=none; b=R6JGzB0IGl7l8vBFyFg+cZHclvyQFAopQm3EOs579mgz03Efu6mmOsHsAnVP7hBQ4JI8tJTrJXX8YHGK0h7tJ6wO06wF7U7R586FVxNVsfiDLQzrxkyvdaAbDsJ5siqNsGUPA3WG1ySEmapYzUNqUgUYZMN3PRgfiC5JGHIqqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500428; c=relaxed/simple;
	bh=cGjjSeDUVRN7XKvY8GvELQoF2UpmS7flr7omeR8V4Fw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PDNze01a6gRYs14Hm6H1oQhPqF2Fhg3Fkz9rS3bZyIAL2e2kghXRKlxipuItxDuN6EOtwipg9RappRIns57EP8HhQEvcTXazuHnNVe1139/Levg1BwH5g/WN3YTAfz0KfEP9FLVmvhJ30W0xTUR0tz4yet+OWPTuoYhJcoGOCdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6ox7ALc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0E9C113D0;
	Tue, 23 Dec 2025 14:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766500427;
	bh=cGjjSeDUVRN7XKvY8GvELQoF2UpmS7flr7omeR8V4Fw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=m6ox7ALca3m3aGLWq4b/EqzotXs0co2YqPhCJuh5iAURIiqwAOop6bmscat9Q4Ezi
	 I9+2BkWjzX8XBEwCX/dSrg9Q45UlmmgjCR6wo9JyYivnY40bqBebnHVg/s2D8rSvGw
	 XMkSOzhqmApwVirnuxnczv2T+sfWGsrNc75COf9c33STMZw9UwtgucDzYtV8vanDnV
	 SSRusnEsNPIJglOfvs8fd+Vc1XybkfO3uXVZX6NxcoxDjJ1h267TiC0h7ltSH4cTVu
	 SroQWuxtWulq0jZVImAHKpU/vvZfFqr3JqF4fM742qHxrJlnptm4MR/dh6fKXE2xcG
	 FaD7HtE7OX7Iw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Geert Uytterhoeven <geert+renesas@glider.be>,
  Magnus Damm <magnus.damm@gmail.com>,  Vaishnav Achath
 <vaishnav.a@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  =?utf-8?Q?Herv=C3=A9?= Codina <herve.codina@bootlin.com>,  Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Pascal Eberhard <pascal.eberhard@se.com>,
  linux-spi@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 06/13] spi: cadence-qspi: Make sure we filter out
 unsupported ops
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-6-8ad505173e44@bootlin.com>
	(Miquel Raynal's message of "Fri, 19 Dec 2025 20:22:08 +0100")
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
	<20251219-schneider-6-19-rc1-qspi-v1-6-8ad505173e44@bootlin.com>
Date: Tue, 23 Dec 2025 15:33:40 +0100
Message-ID: <86cy45b73v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 19 2025, Miquel Raynal wrote:

> The Cadence driver does not support anything else than repeating the
> command opcode twice while in octal DTR mode. Make this clear by
> checking for this in the ->supports_op() hook.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


Return-Path: <linux-spi+bounces-9914-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52FFB440B3
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 17:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D887A13CB
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 15:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2652475CE;
	Thu,  4 Sep 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ym978ZfZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA001D95A3
	for <linux-spi@vger.kernel.org>; Thu,  4 Sep 2025 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999961; cv=none; b=W2DHTNflW8XUz1SxWnejLxnYgCZ/EjC/W4YFVjHog5EPr9FLNH4daA1wlbpM0rn4PnberFIzHGIl0rTv1s/pzQq8CJU9j71BEcMiIxxFRCw0HY1IVJuo8jlcanMbLE+G1ZfZVt9L42/krsAa8Cu2u1ZmQIVM/BM05pG9vO/xjQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999961; c=relaxed/simple;
	bh=DVpzoe+cvUIPBr58wnM4EFerySjoKjG3dIl55F1dw1Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MHTTe8oYsRD+Vb0B5q8sccvyPfjwHAYjWFbeRzWa3LWMKogjw1krnyfVw/Xev2bhHbvz/zWI0G4VlaJ93JxQEhvkeNVEIRFR5GWMXrPxNbN9GHTVy082vU/hghPdNLWtKrrVfLIyl/iQ/P0M166w5w7Mq8rGteXJ3SZ5ucIGl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ym978ZfZ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 31B79C8F1E4;
	Thu,  4 Sep 2025 15:32:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 529BD606BB;
	Thu,  4 Sep 2025 15:32:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0628D1C22D35B;
	Thu,  4 Sep 2025 17:32:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756999955; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HLIbAkeU1jgbmqyWLMs3WMOPlDHMfnTByF+G6ivDAB0=;
	b=ym978ZfZSDtQLPnQc0ywN4zXR7rcJSBU0w8Ikuq7Gtj7UmDs2NyYFrs3QDFTgCiLmavqC+
	Emwy41MVYtDjKErlE0zuPEfF5lcUmpMb4HEa9/dgBN0JF30wgE7913rp3+ZvRmV7noWxTs
	NHGwJfGDnwgU24uGIDl3T+PqV7TQSCJ0LGp2VeEkM41aVuEdQYTC8Hve8+rQ5AD6iE5Ytf
	tYjgy1dQI8L41wwc2CUtxltU957PEKKF2Gfkhe1Tjj3p4rIGL8gDu06z7G2qQMIa8Zm5jU
	s/C2cehdiKfic44OVeSx3KwdlPiF8uDvQYjT7+q6FtrJXos56DDm3NK3l8UuHw==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Sep 2025 17:32:25 +0200
Message-Id: <DCK4I00CCR4R.2K7P9IEDI0OA2@bootlin.com>
Subject: Re: [PATCH 3/4] spi: cadence-quadspi: Fix cqspi_setup_flash()
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>, <u-kumar1@ti.com>
To: "Santhosh Kumar K" <s-k6@ti.com>, <miquel.raynal@bootlin.com>,
 <broonie@kernel.org>, <vigneshr@ti.com>, <marex@denx.de>,
 <computersforpeace@gmail.com>, <grmoore@opensource.altera.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250904133130.3105736-1-s-k6@ti.com>
 <20250904133130.3105736-4-s-k6@ti.com>
In-Reply-To: <20250904133130.3105736-4-s-k6@ti.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Santhosh,

On Thu Sep 4, 2025 at 3:31 PM CEST, Santhosh Kumar K wrote:
> The 'max_cs' stores the largest chip select number. It should only
> be updated when the current 'cs' is greater than existing 'max_cs'. So,
> fix the condition accordingly.

Good catch. Current code can only work with one chip-select.

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Maybe we should error out if we don't enter the loop, ie if we have no
flash declared?
 - Before your patch, cqspi->num_chipselect was set to num-cs DT prop or
   CQSPI_MAX_CHIPSELECT as fallback.
 - After your patch, cqspi->num_chipselect is set to one.

In neither case do we get an error if no flash is defined in DT.

We could either return some error code or set cqspi->num_chipselect=3D0
which will lead to spi_register_controller() to fail [0].

[0]: https://elixir.bootlin.com/linux/v6.16.4/source/drivers/spi/spi.c#L332=
2-L3329

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



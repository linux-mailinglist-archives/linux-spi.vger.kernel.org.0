Return-Path: <linux-spi+bounces-12092-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 480F1CD9A3D
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 15:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A21803049D3A
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 14:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7824533A714;
	Tue, 23 Dec 2025 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXzJo+PK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FCC334C02;
	Tue, 23 Dec 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500164; cv=none; b=TjH9deFCTsQjPgR//q1iyB9ohqLs3rAyu2gKumR5mxZ+p0qwQFwC9f7wdrdcjMAmGhH4iLolLh01fiCyKDDkNAX+tvCyBVLdRtTNG8Ryfyy+67hoGUU+NxFXBrxEwjxvYQJVcePjfBkW+Q92SRMI5EfJLM8HCOUAwCIHu5Bn+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500164; c=relaxed/simple;
	bh=bCMDG0rh+4NosOkkiYki1ERbbuuJGolwnz2k8oHbP5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lhJIAdbeuxsv6DzK6LzE3rlqnnME0D1jqHBJoRYpcWdamGV4aR/1LJI2FZXzBIDaXlBBikXY15o/1SsTsr9/wa2nIY44isMNYP0AUgwo2dJfVsEEHsDHxYRWc4GOFGoSWZbahfM/BPGUTSEIzNyYBr0+AO1y7V7++/4MegJkyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXzJo+PK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BC3C113D0;
	Tue, 23 Dec 2025 14:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766500162;
	bh=bCMDG0rh+4NosOkkiYki1ERbbuuJGolwnz2k8oHbP5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZXzJo+PKXbHV48OXVOMb1d4XRRlWy+FUbu99/G08DslOaNc59Ysqzh3uC8brmXbw+
	 pNe2jbDOc8N2eCi4JhPDbsmGGtaTeBs+F/fEQN7SlBlLYAEHvM86/6YC6vgELX//tv
	 NhPrwas0dJdsc0zdsresebU0mcxjgnRVJr6wa9HhsDPibhEhD/4HZOSueQZwjJOGYP
	 Alag5+KY8BfNRHBuAnKlK8cdxDblY8d+ecVpA1UHVJgVMHkckcGzrUMhrzUgtWrK+u
	 1aXftqCTAasfHKnP8zm21H9RWFdi7rYqRidRL4AslI85Kx+59u0Df7HIh9N16QqSKf
	 JepN7DB0rwQzA==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
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
Subject: Re: [PATCH 04/13] spi: cadence-qspi: Fix ORing style and alignments
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-4-8ad505173e44@bootlin.com>
	(Miquel Raynal's message of "Fri, 19 Dec 2025 20:22:06 +0100")
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
	<20251219-schneider-6-19-rc1-qspi-v1-4-8ad505173e44@bootlin.com>
Date: Tue, 23 Dec 2025 15:29:15 +0100
Message-ID: <86lditb7b8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 19 2025, Miquel Raynal (Schneider Electric) wrote:

> These definitions do not follow the standard patterns. Alignments are
> incoherent and the logical OR symbols '|' are misplaced. Reorganize
> these definitions.
>
> There is no functional change.
>
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


Return-Path: <linux-spi+bounces-12276-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DA5D0EBF6
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 12:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00FE6300DA64
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 11:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6713382CE;
	Sun, 11 Jan 2026 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLlP94D9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854450094C;
	Sun, 11 Jan 2026 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768132350; cv=none; b=KVcRCq/qeq2p4oHcFflsuXfZAoRpYG4d3VO+7bw0owjz5QN2jkZgRcELA1pPyVdfamoWIwtedDliLHZ2wimJY7+mzB4BUXsBnD8FyW8dZ2Rhc2Uy6KqTPm5VeC04ERmTkLiKuEs2h9qG7Gqdvo2tTWg72NE7b4J0jwX3U4fCYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768132350; c=relaxed/simple;
	bh=0GkxFneeSyIWyVZyFNFfxwxn7XkF3NPIGEPeRDVQdpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tL5iNrRqlK+N9uW+Zv9yZpBFyi5jm7YwIcnlAaXwIaSS7KidQEXKd8AfWjRknKEQCf9fO/1F/wdLOHlGF0d3jvRhefM0xIjLbohDxEit4VL5dv4SP7J2Ea1fNhe1y3IRLIzhozyllsDjq5xW2Aw2e7NTKeKDiqjC7xyGW2lJcD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLlP94D9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCEDC4CEF7;
	Sun, 11 Jan 2026 11:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768132350;
	bh=0GkxFneeSyIWyVZyFNFfxwxn7XkF3NPIGEPeRDVQdpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lLlP94D9FgPuuqpCfGCxs4FacmAftfpMu+gA7Zak8eY5OKry7s27v6VE2geRABPxU
	 iAowf+1NOzi4pp6xqR3+o1G755Shv23q8rf4DjeisMfo6tGbTnfzl/WYcZjUy1nbU5
	 892yqFaTy8bzm0Na67ATbn1Kq1/lDz72XwHBAwOWq2DgLY0tpz64GGopCj6gz6KuB4
	 rH+R32+978oZrcq7aroZewgms5GQSpfu1zefPeKAQpagsOz3ocv6sQRMbU09G2BFwD
	 xjSkhvezAGjZhr3eBNOjKpDQYkn0MGP7sz3PEJEvUkXbrAeHvbD2D33eNV59sewHyD
	 JWzeDCPA0g1sQ==
Date: Sun, 11 Jan 2026 11:52:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Sean Anderson
 <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/9] spi: dt-bindings: change spi-{rx,tx}-bus-width
 to arrays
Message-ID: <20260111115219.296e8205@jic23-huawei>
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-1-145dc5204cd8@baylibre.com>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
	<20251219-spi-add-multi-bus-support-v4-1-145dc5204cd8@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 15:32:09 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Change spi-rx-bus-width and spi-tx-bus-width properties from single
> uint32 values to arrays of uint32 values. This allows describing SPI
> peripherals connected to controllers that have multiple data lanes for
> receiving or transmitting two or more words in parallel.
> 
> Each index in the array corresponds to a physical data lane (one or more
> wires depending on the bus width). Additional mapping properties will be
> needed in cases where a lane on the controller or peripheral is skipped.
> 
> Bindings that make use of this property are updated in the same commit
> to avoid validation errors.
> 
> The adi,ad4030 binding can now better describe the chips multi-lane
> capabilities, so that binding is refined and gets a new example.
> 
> Converting from single uint32 to array of uint32 does not break .dts/
> .dtb files since there is no difference between specifying a single
> uint32 value and an array with a single uint32 value in devicetree.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


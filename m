Return-Path: <linux-spi+bounces-4479-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6746966863
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 19:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057FA1C23CD3
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CE21B3B3D;
	Fri, 30 Aug 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqffZCvC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A190714A4EA;
	Fri, 30 Aug 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040185; cv=none; b=IJptWb0K7cXhoKc0rxeT7lBI1gbU4YzNyg3HwtERd4yBH91HLHHuGfhn907JnUG5RK75B75pGX8FFimqO32pNh4/NUW4FDgDOXYVeFH3KpD7g8xzuT6pIq2mXn21+q5zaCgptr1hLNsnpYPEDQ1f6TKKKzyT/RUuC+7Xifn/Wkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040185; c=relaxed/simple;
	bh=FB7PpI5iPC/F0LtJ8ZjLm/Jv7SrdEq0HWbBLUhfDYv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSnX+1QS2hYcZciFuYXElppYXu4GfyMpDFKvsLrqL4dSrIgdnZCCVQ47ORxFhJJIiVyXFwJYK0aetkaaMXeCklwTr4rvwBb6dQRoz85XBEryPhOV/5wyQcsliGT0Gl0/IBpH9CA4evYKDqIsPMuvtcwRuY1KrKMMTP+BHrHdNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqffZCvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10340C4CEC2;
	Fri, 30 Aug 2024 17:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725040185;
	bh=FB7PpI5iPC/F0LtJ8ZjLm/Jv7SrdEq0HWbBLUhfDYv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pqffZCvCHCG4kR497a+ipdWAzBvRbXf6kamNrrc9GTzbLR4GUBEyhwtJDz0TVtfz3
	 +y9yYH/XG9cJDED9YKlAE+dx203ZmGzmck7fKjrs77iyy8dLucnVf12HyTfd0b1XpD
	 djVLbKs6fnJ+3Qs0/5Lo7yBggQhFTCK0nnlxhJVWAA02keS4moOBXNt+ye5rsQ4IrG
	 Yamro9r9g2LtWVjixKVEPs1hu0s+8ac2QNzX0RPE8i5aYA5b2ZL5HuW7vNRCFY/cDQ
	 LJzVfs4q8h95jiSJJWAHaXdA2FTr8Lto/PvVRuwdBLea3QO5IcS2e2PIOWNJ5Wg1Zs
	 kelKRqTvevMuQ==
Date: Fri, 30 Aug 2024 10:49:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller"
 <davem@davemloft.net>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Mack
 <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert
 Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Yang Ruibin <11162571@vivo.com>
Subject: Re: [PATCH v2] drivers: spi: Insert the missing pci_dev_put()before
 return
Message-ID: <20240830104944.3f62e855@kernel.org>
In-Reply-To: <4e2ad62b-b11e-40db-9cd9-a26f7642c735@kernel.org>
References: <20240829033511.1917015-1-11162571@vivo.com>
	<CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
	<4e2ad62b-b11e-40db-9cd9-a26f7642c735@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 19:10:20 +0200 Krzysztof Kozlowski wrote:
> Cc Greg, Jakub, David and Paolo,

Thanks for the heads up!

I double checked the last 12mo of networking patches, FWIW.


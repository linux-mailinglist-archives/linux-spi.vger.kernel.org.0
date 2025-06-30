Return-Path: <linux-spi+bounces-8874-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76B2AED562
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 09:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E87166D87
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 07:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0A81E7C34;
	Mon, 30 Jun 2025 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz0GRQRd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077511A2643;
	Mon, 30 Jun 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267833; cv=none; b=ECQq29qZG8c8Ezs/FsrMui1bO36univCHIJsvr+VZfOnlCXzFY+jZS4L3Qld12fnX0kjhPFLU0AoLM2je9OksbNeuqEu+SUyCMMo2M4MpzlQOtqNuNK30aQ7A8W18RXcN7384Ms9CwwvgB8fnTKTrAYJ3Nw3JW1i6F3mTkt2khg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267833; c=relaxed/simple;
	bh=8LwWcL/hfZA2j32lefUf/CPEs9K2wl3Sf8cyvU/E/lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L57txmmhQ0LahZffQLMAeO/D4lKiu4+u0Bwz7gbbr5pv9jIjJGEebYYuyYf0V1hhb+BbFhnI0ZIG1/CjyHhMBWJYScvMh1XfeihFE/IizpQR92i87r5trfeQcfMohmwX2gb/u0uXa+FIIbtFxbztRLbVd7/8wAdHr0AODTgzVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz0GRQRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E90C4CEE3;
	Mon, 30 Jun 2025 07:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751267832;
	bh=8LwWcL/hfZA2j32lefUf/CPEs9K2wl3Sf8cyvU/E/lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wz0GRQRdQNz5Yif1YOcTtRFUXi1c6JVSR0V2aLYHWbLenFhxyNnL2akbcAoHXNjqe
	 QyKC8Anw39HPGPdy1RteDRZZS9FdiWHwn1L/iV3wO7SoaCFksdmKkpQXsWY/XZuqRs
	 g+OwUb6xvSKSzVKb9PpPFd7rkEzN7S5VHEK4tEHvJm2b4Sel5X19rLn/VyZeE03gOB
	 BwmDIyTwptn00LersUVi4kBO/CqhtCw621lr5HMT4z2ZxXgCCNhN8gopaAY4t8r1W2
	 l+5WAsKZQ4ZVhimRZzsyyzJ3wmh9/OebkB/uxpxj9odU3esMhC3Re0hQ2P7xoYm9Xr
	 wTuOB0cC1LfTg==
Date: Mon, 30 Jun 2025 09:17:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Longbin Li <looong.bin@gmail.com>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/4] spi: dt-bindings: spi-sg2044-nor: Change SOPHGO
 SG2042
Message-ID: <20250630-ancient-quail-of-joy-effd60@krzk-bin>
References: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
 <20250629-sfg-spifmc-v3-1-28db1f27e999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250629-sfg-spifmc-v3-1-28db1f27e999@gmail.com>

On Sun, Jun 29, 2025 at 04:23:10PM +0800, Zixian Zeng wrote:
> SG2042 is not fully compatiable with SG2044,

Typo, run spellcheck.

> So it is necessary to become independent const

No capital letters after ,. Anyway, explain why it is not fully
compatible.

Best regards,
Krzysztof



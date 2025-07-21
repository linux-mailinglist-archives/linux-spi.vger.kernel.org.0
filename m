Return-Path: <linux-spi+bounces-9147-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C921DB0C736
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42F91885A96
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9A2DC33A;
	Mon, 21 Jul 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsNd9AKH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E019DF62;
	Mon, 21 Jul 2025 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110247; cv=none; b=gNIMJ8qvvazmSCNkuUYz7lsqlnsKAhr4oEpcsvUSenlvDnIlZ4agaAzwfzHNkCB9vBEoPIazx5ifiofegav9Dxk0uhu9jJOSdbz8iAjgyCDYRR4JSrIUO+IzXQs8/A2LYXUQgF7wEsjdxjY7ZNozpAPpJ8C2uU3QnaxEkhfQZNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110247; c=relaxed/simple;
	bh=FLrgL/2CQHP/2rDn4k8Q9+fTGuPnmR1UdDZyhqyII30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlQRzt6APcux+IH9lHWutwGhAOw8Ssat6xcjCyeOCzfHB3L7ANadSRLv47SlZi/WYRpak3RDWMTOpSyAEAZbZnlyArCouQ82VGM1cRYR02NwHLKkAw9Yn+QUZZd0aidDkyIrCbEURZzD9dZ+DVZnozemBD9DnHT7y4c8P2D0xUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsNd9AKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7ADC4CEED;
	Mon, 21 Jul 2025 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753110246;
	bh=FLrgL/2CQHP/2rDn4k8Q9+fTGuPnmR1UdDZyhqyII30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DsNd9AKHEl+5WkV7edBAvBM4qUfQGgPFJ/0UEUsVYqkGNqOYXvpZHTqQ0xrOpYHbw
	 WMAFA8BP4vQxeWzIGwNtCBT3/VqQMvFIJ2XqTFKX12vGbfx8PFPUnTnonzso5vT9VM
	 Hmu+g5eCLqDXj4O8P4gj3OLbmhs/h0wx4BLpwErG/EBzWL9FA8XBxtVoemQg2PmSC1
	 dFazGm3Yn93j6sykZ6I+sJ6Qq4WGi6M1vsWn9Zn7lfrW7PlIRFsmqK+fTW83UcTcDn
	 dUL9vjL0rB92sheTqOMpWuBVC/T5RIUBG46TjUiOQmlSq+ucs86spaxg+txZmV2c5D
	 gFHHEAmmPB9Kg==
Date: Mon, 21 Jul 2025 10:04:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Mark Brown <broonie@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-spi@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>, sophgo@lists.linux.dev,
	Chen Wang <unicorn_wang@outlook.com>, linux-mtd@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Michael Walle <mwalle@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v4 1/4] spi: dt-bindings: spi-sg2044-nor: Change SOPHGO
 SG2042
Message-ID: <175311024481.634831.11395873009603964562.robh@kernel.org>
References: <20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com>
 <20250720-sfg-spifmc-v4-1-033188ad801e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720-sfg-spifmc-v4-1-033188ad801e@gmail.com>


On Sun, 20 Jul 2025 16:31:43 +0800, Zixian Zeng wrote:
> With further testing, directly using the spi-sg2044-nor driver on SG2042
> does not work. SG2042 is found to lack full compatibility with SG2044.
> SG2044 has OPT register and it's necessary to write but SG2042 does not.
> Due to other possible hardware detail differences, it is better
> to bind SG2042 independently.
> 
> Fixes: 8450f1e0d3d0 ("spi: dt-bindings: spi-sg2044-nor: Add SOPHGO SG2042")
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



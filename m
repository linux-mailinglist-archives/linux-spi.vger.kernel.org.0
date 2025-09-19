Return-Path: <linux-spi+bounces-10179-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC3DB8B357
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 22:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21E5A05C1A
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 20:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1891DF74F;
	Fri, 19 Sep 2025 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el2P5cI5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8C1FB3;
	Fri, 19 Sep 2025 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314832; cv=none; b=lj4smv3C96qUCtkj7PhZOte9gyh1QOiHoowkW7qA62fOTknJRiwhYrGTBlAXCyPEhJxAMFnrEQ3eC9kLQ5gfLaESXTd/9WJZLuV8L5La3HhYWmPES53Mb3yyNp5AwTYRlS8xzbpPTUQqA8zX7rAErDU5Lt+IfcckWUsbqci6iXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314832; c=relaxed/simple;
	bh=8ZdaVlsLZ6+YqF2PuATIawPN2p3wYF0R7tpv5xXnP8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4FkFTJ76skyv8Ay5+HWkSSrLK3ss8nXjGqIPlHF35w6jYlwsEKnX4y7ixd86+TrV6FOV6bfoc3bf/Tb+9DWQmnFUPP6IXCcjfcCU613aM3AWtLzOFBDYjW1BBkXVdVRVokJBO7rIsuTOti13oqD299S7NN4pznu4G/NUTfI7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el2P5cI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87121C4CEF0;
	Fri, 19 Sep 2025 20:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758314831;
	bh=8ZdaVlsLZ6+YqF2PuATIawPN2p3wYF0R7tpv5xXnP8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=el2P5cI5c1PQLUF1JQ9+vMHslN9O+S4VdFuzZEypxycWiaT8dz+kwJvqfmqweFFOp
	 9o0OxuGVX5XGmf1IRbLnGHAntNslP/aveO+Sk6okFX5gbcM9aLXgyLhdOGZqRXiph6
	 OB4AN5c+YTkq7a2p4EEMx1+QFOdI7nMPrsgfoL+CrS8o7FR72RJ44qxiCmwuJNdB6q
	 AshlowEhC8N0XIDT6WaL33UfgkZK4mnkO1g3fpk/pcQ1fbhS3lUxnq/ywcleuQ3Vbx
	 Q1mO+p56dkqr2MBsFL/GRb8u2ErSty2BwsfQjhmEajtnP3poyJAjYn+rWiNqzWqO+T
	 i7WgYF5X5t7Jw==
Date: Fri, 19 Sep 2025 15:47:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: alex@ghiti.fr, conor+dt@kernel.org, spacemit@lists.linux.dev,
	broonie@kernel.org, linux-spi@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, dlan@gentoo.org,
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
	krzk+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
	ziyao@disroot.org
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Message-ID: <175831481987.2188907.2053375143678932465.robh@kernel.org>
References: <20250919155914.935608-1-elder@riscstar.com>
 <20250919155914.935608-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919155914.935608-2-elder@riscstar.com>


On Fri, 19 Sep 2025 10:59:11 -0500, Alex Elder wrote:
> Add support for the SPI controller implemented by the SpacemiT K1 SoC.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - Use enum rather than const for the binding compatible string
>     - Omit the label and status property in the binding example
>     - No more spacemit,k1-ssp-id property
>     - Interrupts no longer specified with interrupts-extended
> 
>  .../bindings/spi/spacemit,k1-spi.yaml         | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



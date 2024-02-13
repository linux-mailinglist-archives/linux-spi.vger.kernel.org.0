Return-Path: <linux-spi+bounces-1308-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AEB853183
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 14:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0411F279C4
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 13:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2507855775;
	Tue, 13 Feb 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAMkzeJy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752455769;
	Tue, 13 Feb 2024 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830048; cv=none; b=Q2Y9rQjg891Tz1Zl9olfhbn79NbDUInEsDI6a5czK0FYGPSlpF6YYuBvubPwqAuDhvAsEiFRHKhsSiOKfVUfM8TGxVCKLBhpl+qbhTM1yikIK7l23+mGMcYXQy3gfOJvpkShfa7GMvbj1RQnQbDIGo6ovIu5VP27qS9+RWasMWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830048; c=relaxed/simple;
	bh=+vPxa+J/7hvWU17r1zp1OBnxkzfzLxPHNrKMEj/0zHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeXfIlCS7QOucrDNNoJNLSOuZ2NGNKcJxComBqtapZDbHP8yDeSg8jc6dHo7ovPZrT3u7FFnL7WItqje0AUw4uiYmNT1ujiu2/PBJNCRBjKuJass6SdlzGkOsWUkVs82zefmSun+zBEfnPuCvihx+FINryv14au8/6ZrZX67rt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAMkzeJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7880AC433C7;
	Tue, 13 Feb 2024 13:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707830047;
	bh=+vPxa+J/7hvWU17r1zp1OBnxkzfzLxPHNrKMEj/0zHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAMkzeJy/N+tXl6fJq0i5v/9/D7xKPiPfkk8frxKtzxqgTm6cNqAPXlx5mpeMynZm
	 O9LaDS26HkHo1o+t2sBfTVm+PnNvnkWI50/XnL1Kg63X0Xq1zjET1euoaLzUHi+Cdz
	 eIVwTGN4SZig9BQKzob5vpyCYpRCRf2WFQQBmfXsHtWDZUTTiQmeKK4vrjq41z+NNt
	 1U3GluvfX5JtfgQ4lc87G1cxIkquX+8eG3Yl0RRwdSwZJkl99IdksbSsYM76WTfCbQ
	 JLw9i612XyMWFhObBP4mCagDCE8XRZCOd2unYxJ+ThKA7CRPiaLdTpL/LPediFjNRp
	 enjhVdi+75UnQ==
Date: Tue, 13 Feb 2024 07:14:05 -0600
From: Rob Herring <robh@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org, semen.protsenko@linaro.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org, peter.griffin@linaro.org,
	kernel-team@android.com, willmcvicker@google.com,
	devicetree@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH v2 01/12] spi: dt-bindings: introduce FIFO depth
 properties
Message-ID: <20240213131405.GA1047438-robh@kernel.org>
References: <20240212140331.915498-1-tudor.ambarus@linaro.org>
 <20240212140331.915498-2-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212140331.915498-2-tudor.ambarus@linaro.org>

On Mon, Feb 12, 2024 at 02:03:20PM +0000, Tudor Ambarus wrote:
> There are SPI IPs that can be configured by the integrator with a
> specific FIFO depth depending on the system's capabilities. For example,
> the samsung USI SPI IP can be configured by the integrator with a TX/RX
> FIFO from 8 byte to 256 bytes.
> 
> Introduce the ``fifo-depth`` property for such instances of IPs where the
> same FIFO depth is used for both RX and TX. Introduce ``rx-fifo-depth``
> and ``tx-fifo-depth`` properties for cases where the RX FIFO depth is
> different from the TX FIFO depth.
> 
> Make the dedicated RX/TX properties dependent on each other and mutual
> exclusive with the other.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  .../bindings/spi/spi-controller.yaml          | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)

With the indentation fixed,

Reviewed-by: Rob Herring <robh@kernel.org>


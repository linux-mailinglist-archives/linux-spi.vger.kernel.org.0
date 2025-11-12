Return-Path: <linux-spi+bounces-11178-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF23C54067
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 19:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174DD3AFDF3
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C7734404F;
	Wed, 12 Nov 2025 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srnaOMbM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999042D662F;
	Wed, 12 Nov 2025 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973797; cv=none; b=iS7bNv0peCHS/hk/0Kn6naCB8KMK4F7VXU2NmOVUu6Pt1x7WLLnBHYmiW1XVSvL7nnCC5GXVp00mSjliG4gjirq+dVjYGnjupTstmorgYhIsUUXvfiM9zmOdfdAaDkRpTYvGDLDkuFiU39LLoPlL/srY9lhYwoVtYaQgk9CclGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973797; c=relaxed/simple;
	bh=wnhEjBehMvH+VcTKME6K3P5TFtwHDoZ1sl5SUn95RW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxAAPPRQoh+8On4olaZpNJra4GX5WeYfFMs9NpSBWINtkmv5Fb0K9UyM81soGyv+zaf6LS7PEUA8jVDt79qb7TW+yvpP4fTYO3LDJ1YFU7aow3ZQKId4Xh9e1c6Gpo2JoyexifC3FQ646/JgLniibQ8umfVhDomzH2/f3598idc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srnaOMbM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458CAC16AAE;
	Wed, 12 Nov 2025 18:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762973797;
	bh=wnhEjBehMvH+VcTKME6K3P5TFtwHDoZ1sl5SUn95RW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srnaOMbMhtXpMh0YneM2DfkFDH+Lx13tpS+EcJAmlFp2fwuGJGV9FS5Avhee2oZVG
	 0H2MW4ubKyxNwMZizzrkoecvpHnFVhcd1dvIVqkkaO5AFBG4Iu0eKCdA8rPrgmisln
	 br6RKTVOKvo2yCfUBK4a9mTUKimw7R0RrBPUZl++Na3MPo/LWSOevAWtAlQ1ws60IC
	 0ZeoyoGmZbDGpgQderwSS9ILifWnuQMhFRy6hlmT1GdasuSYWtGu+d1jkr5BQOJ98a
	 nwj6RcQleIQ0vVazB4LcROCnt47uek29cKIhfdiscP6X5FqNvAJuh45/KT9QKzagMC
	 l+dRBGK6Kaqqg==
From: Conor Dooley <conor@kernel.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org,
	dlan@gentoo.org,
	pjw@kernel.org,
	Alex Elder <elder@riscstar.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Frank.li@nxp.com,
	p.zabel@pengutronix.de,
	guodong@riscstar.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	apatel@ventanamicro.com,
	joel@jms.id.au,
	geert+renesas@glider.be,
	cyy@cyyself.name,
	heylenay@4d2.org,
	fustini@kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/9] spi: enable the SpacemiT K1 SoC QSPI
Date: Wed, 12 Nov 2025 18:56:13 +0000
Message-ID: <20251112-approve-cartload-5a3f3d017c2d@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=667; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=QYu7vucndkkkm6zIRBflLJq+QN7l+LYv149tZnZO9JA=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkiN3zNru+5vrOwp/Rz57QPF0siN74LWmjWFmwkmrJlT WXT0jO7O0pZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRxncM/504dq80vna35Mah qosqqxYf60yNrpxfZs84sf6GrdT7BccYGa6wCbqpJJyfnZ0nOVHhGMfynQ7/ZfOmzTxl+GeiyLY ZiWwA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 27 Oct 2025 08:29:58 -0500, Alex Elder wrote:
> This series adds support for the SpacemiT K1 SoC QSPI.  This IP is
> generally compatible with the Freescale QSPI driver, requiring three
> minor changes to enable it to be supported.  The changes are:
>   - Adding support for optional resets
>   - Having the clock *not* be disabled when changing its rate
>   - Allowing the size of storage blocks written to flash chips
>     to be set to something different from the AHB buffer size
> 
> [...]

Applied to riscv-config-for-next, thanks!

[9/9] riscv: defconfig: enable SPI_FSL_QUADSPI as a module
      (no commit info)

Thanks,
Conor.


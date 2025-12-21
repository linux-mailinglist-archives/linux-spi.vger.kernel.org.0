Return-Path: <linux-spi+bounces-12064-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 830BECD3F07
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 12:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED7F130010DC
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 11:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BBF28A701;
	Sun, 21 Dec 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqr4B5LG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503A3A1E60;
	Sun, 21 Dec 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766315120; cv=none; b=uppBhF50fymEhM0PQsjT3hANfsFiZ9/3c8ECN1MDa70De2Arwqfx+qNAC4FukepS7KXpcvs3tXnxu3VveGrtD5Ye6OjfUeh3fK1iHSQg32fBOJzO1EFamGPR82xdW48xYD/pCgo49SX8oIsv8ojyvKV0yuNJ3vlqfpsSY55XsbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766315120; c=relaxed/simple;
	bh=Nz3+VHR47YCuwduLdUUzntSPalUFZ+BG9nDzXt1o60E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTRC7qj0Zlo9GaaKKPCDfI4Tf1LTW8i7Y/wcESDCXkYBv9OCuGW0isfAxUA2SVBBPqiTm4de3fjjcIbbou0Bhizc0PnWWbISAGQ8ppj2HenHySQ7vCYZyOJnbWzcOawNBjHnwl8WSfDZvU1vvEMhLITxV6WL7Bs09iPmKYNM3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqr4B5LG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566F9C116C6;
	Sun, 21 Dec 2025 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766315119;
	bh=Nz3+VHR47YCuwduLdUUzntSPalUFZ+BG9nDzXt1o60E=;
	h=From:To:Cc:Subject:Date:From;
	b=jqr4B5LG5KvlEkHo7eM2Pv4kQhvlIRCRVAi1VmIBEKlRNBZuaRX0XdVXFvrQtZnlT
	 zAUZwyXj/PWWCZKoTr7wILTrzwYrunkKBYSNJVOkv9APCv61PVroCrJiU0eaDSitO1
	 +RL54HIp4tnV1KsBjIVhNgFhLkjVm1JlpzB1hcrJn/Uz3gJo+sjplO/j/HF+cYmN8r
	 e3mjY4CP3vz/NrZ2NcMQrKRjv2TpmS6mE2D7DBY4p7Y3Puk8OvWINp+S9dkdX7ao/p
	 xRn7s6ZnS7AcKxrilXoF4ARoZQw7JGNFgs969J5XyyNW/G6GydJuO/p2DhUJIU7vyn
	 X6eTiJFYIDTfA==
Received: by wens.tw (Postfix, from userid 1000)
	id 3488B5FDFB; Sun, 21 Dec 2025 19:05:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] arm64: allwinner: a523: Support SPI controllers
Date: Sun, 21 Dec 2025 19:05:07 +0800
Message-ID: <20251221110513.1850535-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This series adds support for the SPI controllers found in the Allwinner
A523 SoC family. The SPI controller is almost the same as the ones in
previous generations, except that it moved the "RX buffer count"
register field to a separate register, and that register now reports
the total count for RX buffer and FIFO.

In practice the driver has never cared about the buffer count, but if
any implementation were to use it, this counts as a non-backward
compatible change.

Also, one of the SPI controllers supports DBI mode, acting as a display
interface. There is no infrastructure for DBI interface controllers in
the kernel, so only a separate compatible is added for it.

Patch 1 adds compatible strings for the new variants.

Patch 2 adds driver support for the new SPI controller variant.

Patch 3 adds device nodes for the SPI controllers to the dtsi file,
along with pinmux settings for spi0 on the PC pins, a common usage for
SPI-NOR flashes to boot from.

Patch 4 enables the SPI-NOR flash found on the Radxa Cubie A5E.


Please take a look and try it out.


Thanks
ChenYu


Chen-Yu Tsai (4):
  spi: dt-bindings: sun6i: Add compatibles for A523's SPI controllers
  spi: sun6i: Support A523's SPI controllers
  arm64: dts: allwinner: sun55i: Add SPI controllers
  arm64: dts: allwinner: t527: orangepi-4a: Enable SPI-NOR flash

 .../bindings/spi/allwinner,sun6i-a31-spi.yaml |  4 +
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 94 +++++++++++++++++++
 .../dts/allwinner/sun55i-t527-orangepi-4a.dts | 15 +++
 drivers/spi/spi-sun6i.c                       | 11 ++-
 4 files changed, 120 insertions(+), 4 deletions(-)

-- 
2.47.3



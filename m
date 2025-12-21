Return-Path: <linux-spi+bounces-12065-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5B0CD3F0D
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 12:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4C24300B901
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 11:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989328C869;
	Sun, 21 Dec 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci0ELuQm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D508817B43F;
	Sun, 21 Dec 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766315120; cv=none; b=dY0lZTUxK5QPrTk6xQAzu89ZYqrLmWvYAc2aRuIH4cyt3QIi44gygWKrE3Kf9aKke1gq/QLIPhK8IhY6WrAYDc/o1G7usQ72gtLYrc7ekXcpx5RCflvLgO1G9NUHZgIzxcfYVM1X8GW5Boa8jpqXcbnyhM6/yUJe78APso5L41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766315120; c=relaxed/simple;
	bh=SgM8LmbKsO/V0BAs72Ln5nuOFUP4AR1J+W8Vnt8HIOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pciLR1jCY9JYcR6d7Ud3xz66Pq0rcoTo9v42sBF18Y/2vy9f6YSg6z29MaN22Y4rsetbV1DHY+cRsocbPVJQlbWb7Epd6wKMYDpWiTKBDmy92KPOrm8J4S9tIUcr0e0gnsDeYJh43fkrh0O+X3yq2Ph4O5MBB6KT1H8wDt8ofYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci0ELuQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53289C4CEFB;
	Sun, 21 Dec 2025 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766315119;
	bh=SgM8LmbKsO/V0BAs72Ln5nuOFUP4AR1J+W8Vnt8HIOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ci0ELuQmRBVBp53Sh75c5jhe1Fb1nawO/JXgGalOJqmBUS5EPw7EwpyP3oq868NqP
	 988tnyH0+H2KzxTr2l21ORdoWKhF2GoQkkaYeVR4RpYUmqqi0u1wrFmR4wJwdnGqVm
	 QIhSbzw3osVPD5QM5DEWyxnKkFMxo7IDA9xP98TrNtS75S/FCkfBd1osamnkqsiJOc
	 /DZAGf2Zr+cG+YxrkO0vsdHHK2x+l4boymMqetrdUyvuZXdmvDVIuQ5cXFM+BDAwzs
	 r2TLvhO9a0FktHtqxlQeHaWXPFAxmfYdDbXncVpYJ0UIx8V6sSGZYqbqD1y0lkZC8O
	 Hx2NDbuCg3Tvg==
Received: by wens.tw (Postfix, from userid 1000)
	id 3ECE25FCB3; Sun, 21 Dec 2025 19:05:17 +0800 (CST)
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
Subject: [PATCH 1/4] spi: dt-bindings: sun6i: Add compatibles for A523's SPI controllers
Date: Sun, 21 Dec 2025 19:05:08 +0800
Message-ID: <20251221110513.1850535-2-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251221110513.1850535-1-wens@kernel.org>
References: <20251221110513.1850535-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The A523 has four SPI controllers. One of them supports MIPI DBI mode
in addition to standard SPI.

Compared to older generations, this newer controller now has a combined
counter for the RX FIFO ad buffer levels. In older generations, the
RX buffer level was a separate bitfield in the FIFO status register.

In practice this difference is negligible. The buffer is mostly
invisible to the implementation. If programmed I/O transfers are limited
to the FIFO size, then the contents of the buffer seem to always be
flushed over to the FIFO. For DMA, the DRQ trigger levels are only tied
to the FIFO levels. In all other aspects, the controller is the same as
the one in the R329.

Add new compatible strings for the new controllers.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index 3b47b68b92cb..1b91d1566c95 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - const: allwinner,sun50i-r329-spi
+      - const: allwinner,sun55i-a523-spi
       - const: allwinner,sun6i-a31-spi
       - const: allwinner,sun8i-h3-spi
       - items:
@@ -35,6 +36,9 @@ properties:
           - const: allwinner,sun20i-d1-spi-dbi
           - const: allwinner,sun50i-r329-spi-dbi
           - const: allwinner,sun50i-r329-spi
+      - items:
+          - const: allwinner,sun55i-a523-spi-dbi
+          - const: allwinner,sun55i-a523-spi
 
   reg:
     maxItems: 1
-- 
2.47.3



Return-Path: <linux-spi+bounces-8214-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7380AABD418
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 12:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FAC3A2D0A
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EFD26AA85;
	Tue, 20 May 2025 10:01:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082E264F9B;
	Tue, 20 May 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747735277; cv=none; b=IWGtpYOWcAlBcw4rdhIMufTpYOrD+nhNU2eajF8lyiszVf7ScOpVwRFaEO9SzEmnAUnves9t7qm5u94QINyOb9BXGgMliPaVwf6mmLB4lZc3hOREfjvXQJdX+4+gTVQxNy/TtA5YNA4zDA524jjklTQ/DS5TIBN5+YuwidEmcU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747735277; c=relaxed/simple;
	bh=fAoZuInaKK7IcGVyGFNhXp+fd4hHEJGf/PXCY8Y/URY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NF1ZskKw7jAcNUaZ95kwD55B3DiGvXtGc4o0B4vZ6cco2gROSYJahIfc2F4vOoQ/Ku1uko2fDe3wNSKiT44RmiHBBr9dIbgIT89Uj7Hs4G2IGkUwGcbkme6J3Tm4nhutJ8zrEiXB6wbEC3PW5k56mJECXONAadGF0N9aJnWxYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c04:7a30:290:8105:3706:5628])
	by smtp.qiye.163.com (Hmail) with ESMTP id 15b89590f;
	Tue, 20 May 2025 18:01:06 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>,
	Rob Herring <robh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: rockchip: Add spi nodes for RK3528
Date: Tue, 20 May 2025 18:01:00 +0800
Message-Id: <20250520100102.1226725-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQkkeVk4eTUxPQkgZHRkfGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtPQUwaSEtBSUJLQUNKS05BSExLTUFOTUlDWVdZFhoPEh
	UdFFlBWU9LSFVKS0lPT09LVUpLS1VLWQY+
X-HM-Tid: 0a96ed23c4c403a2kunm0a9e35a49faac
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogg6SQw4CDEwNho5PQg*Ni9N
	IgkwCVFVSlVKTE9MTEhOSU1MT0lNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS09BTBpIS0FJQktBQ0pLTkFITEtNQU5NSUNZV1kIAVlBSk9NTDcG

There are 2 SPI controllers on the RK3528 SoC, describe it.
Tested using st7789v chip with spi-cpha and spi-cpol properties.

[   10.831306] fb_st7789v spi0.0: fbtft_property_value: buswidth = 8
[   11.042915] graphics fb0: fb_st7789v frame buffer, 240x320, 150 KiB
 video memory, 4 KiB buffer memory, fps=20, spi0.0 at 15 MHz

Chukun Pan (2):
  spi: dt-bindings: Add rk3528-spi compatible
  arm64: dts: rockchip: Add spi nodes for RK3528

 .../devicetree/bindings/spi/spi-rockchip.yaml |  1 +
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 28 +++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.25.1



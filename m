Return-Path: <linux-spi+bounces-3931-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4FD9396BD
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jul 2024 00:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74AE51F22063
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 22:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432944438B;
	Mon, 22 Jul 2024 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5zCVtN9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D83D1401B
	for <linux-spi@vger.kernel.org>; Mon, 22 Jul 2024 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689015; cv=none; b=T9VpNBhz/ysxzxjAFf9e1JC9Ou6MGqbJqUddKE+ywktm5XIDtRmNdHxz98kpW0MQImrjJYhHisPZu6aOk+ZN9K+Gw5gYJBmHoFQCr8N/6sEiUcHYNxyXsK7WoI/7ttUu93w7Tlop8X93zKFAB/chWRbvFTlnICW8Xg1knv+1ATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689015; c=relaxed/simple;
	bh=vKSH3/w0Ux3R12XgUNRpI5fsYTDusNsQjMzC4xruUO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Ve0/8eSN/PqyEeDGIpDKJcEpUM5qpc31kfBbrJcBpQtnKjSaVCwPif+k2+0nvdPS+KH3NdnKsKTGfK6bnnT/NobopXHi4WykCXWWMHJavRP1qutnLH6iQWj60sTp5EwfFtaQc6ObNYV08N9fN5HK3VlUbMCKX1P+/p+ouchTU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5zCVtN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8B35C116B1;
	Mon, 22 Jul 2024 22:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721689014;
	bh=vKSH3/w0Ux3R12XgUNRpI5fsYTDusNsQjMzC4xruUO8=;
	h=Subject:From:Date:To:From;
	b=J5zCVtN9oc7ArKeLn8fV5acsynZLUeb2caOsd74RTZXGvuurNnIqr70+HLPxnuz1Q
	 51H3IEBx57ch0VPZpBTjVSiCRq09cR8BNGtMl6yGHWfEQXqpPEAb+ckqf+KXcArsOv
	 t7zg0Dezuiw3/5d3dkBUrjC3hOvRCqNo+/Hey937YCkYO6HMsibJ1ouKAK9rcdk4qH
	 +ixnozWK5057lu69EKmUJcQS5ji2kfrhi0Kwq6nyUIIeC+8hNVywYQZB96VRUEvB8k
	 ywa+mJ9J4+9o0s/xd25++cOYva3tQgwfJsfXMN7nS9OpUCbG0vNPPGjAGTuZLQpxP9
	 r/oGS78ewiXBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95B53C43443;
	Mon, 22 Jul 2024 22:56:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <172168901459.14995.16672584877470490433.git-patchwork-housekeeping@kernel.org>
Date: Mon, 22 Jul 2024 22:56:54 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: axi-spi-engine: add offload support (2024-07-22T21:57:08)
  Superseding: [v2] spi: axi-spi-engine: add offload support (2024-05-11T00:44:24):
    [RFC,v2,1/8] spi: dt-bindings: spi-peripheral-props: add spi-offloads property
    [RFC,v2,2/8] spi: add basic support for SPI offloading
    [RFC,v2,3/8] spi: add support for hardware triggered offload
    [RFC,v2,4/8] spi: add offload xfer flags
    [RFC,v2,5/8] spi: dt-bindings: axi-spi-engine: document spi-offloads
    [RFC,v2,6/8] spi: axi-spi-engine: add offload support
    [RFC,v2,7/8] dt-bindings: iio: adc: adi,ad7944: add SPI offload properties
    [RFC,v2,8/8] iio: adc: ad7944: add support for SPI offload


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Return-Path: <linux-spi+bounces-11553-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D614CC8788F
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 00:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81A2134E7BB
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 23:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF99B2F260C;
	Tue, 25 Nov 2025 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pit+/8Xc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899301DDC2C
	for <linux-spi@vger.kernel.org>; Tue, 25 Nov 2025 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764115068; cv=none; b=e3b1R7RC/R3tTyBU/NyJ/87DAucCw6Y0FIkNdy+ejG0IrtuNB+9gDEtwz9yFDRwoMOO/OYN7OEIOn3Oaxh1emVkJ1imppFAm+aDwDwIIuEVyg6e91KlJSI7AEPkjgsJP37Rsd0dj9TfU15Za0/UESNq3cB9mHukyKhZwYXCBxcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764115068; c=relaxed/simple;
	bh=2uF1c1exoSUAbDMXJgrvENwy616lKmfqDSjjkuMRgGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mbyGfZ3Ek2HFzKaH+2vv+MNalnTonLbnnpUvJOeQj1czCWCzFn513aNyNTz/wsqfVqjSQNw5i5MksqGF6HSeNwAqP1+J9oI71j/BcH7b0YDc014jzD3Wbd4t3U1at77+3z8fY+iAoTzRtn0h/0tAeHLCv5o6525H61E8n3/pFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pit+/8Xc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087A5C4CEF1;
	Tue, 25 Nov 2025 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764115068;
	bh=2uF1c1exoSUAbDMXJgrvENwy616lKmfqDSjjkuMRgGo=;
	h=Subject:From:Date:To:From;
	b=pit+/8Xcx4FxmbOjeJ699pvzErccQkEvDnaJwiochME3e6/HIv4zXnyJo9YHCHupa
	 g+xgErBM6iPK+C0UhHnAok5c0UKJlbPz79YuX/FeGSDl8TDq8IZeBu2s9EjbMjDi7V
	 9HDNULDXW60C4x/dvWTMc2slYVR3k9hNIBui7yIS9ZZBUJFC0Ar7+LnbXqnes7gH8F
	 cA5E2tY5NbEqAWk4biH0glpZ+zxboRduYgAQbVfH3+ec5TiQZSLhz77r5mYv01SXEN
	 QezMtL8ySXclswX0pZUj6jsVLdzdRtkFOmX0zsVvLzKXl/8ViIWYZDG2AsX+c9FcyR
	 L5TqmzWlaqR6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72E75380AAE2;
	Tue, 25 Nov 2025 23:57:11 +0000 (UTC)
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
 <176411502992.958207.14455450697977118929.git-patchwork-housekeeping@kernel.org>
Date: Tue, 25 Nov 2025 23:57:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] spi: airoha: add support of en7523 SoC (for 6.19) (2025-11-25T23:40:44)
  Superseding: [v5] spi: airoha: add support of en7523 SoC (for 6.19) (2025-11-25T19:16:32):
    [v5,1/3] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
    [v5,2/3] dt-bindings: spi: airoha: add compatible for EN7523
    [v5,3/3] arm: dts: airoha: en7523: add SNAND node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



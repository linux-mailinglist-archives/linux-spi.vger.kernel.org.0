Return-Path: <linux-spi+bounces-10296-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB587B9F606
	for <lists+linux-spi@lfdr.de>; Thu, 25 Sep 2025 14:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CAA19C138F
	for <lists+linux-spi@lfdr.de>; Thu, 25 Sep 2025 12:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17F41C84B8;
	Thu, 25 Sep 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kF5CysXJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDD41B4244
	for <linux-spi@vger.kernel.org>; Thu, 25 Sep 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805021; cv=none; b=FkBsFtVwBjZxaNj+4UEYyjs/hD36T9zQZCAnM9NphvEgUkszLwjQz/tnBNetFjSXk7kq4Z68DNRX+nvnFah1WMKrRI+QzdRZX6sHA9yjGQBwSFHr5M4yoSc0VEfNdGKFFeM6zfZDqc4JIpiu9HX9E6ZW+A1hZmGqlzccRLE3QlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805021; c=relaxed/simple;
	bh=gvuBZx4hkjZikbdemWxoYHo4sCeJEFXyeFpXY3kShoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IYXNP4meUdx6aJ2KzAxEkDxXRziX+Drw19Cx/oylblnI7Dz+Q7rpUjUtTD/K6L4ZOw2cKAP31bHojSAtJNWKWEsi1F+6DUHr8iRbTM5InN4PfWNEKfuC9FDbei8s1evWOrkm5KF5JZ7V52/FQLI4xFVpA/0O6F2J9pTPmrKjViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kF5CysXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F757C4CEF0;
	Thu, 25 Sep 2025 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758805021;
	bh=gvuBZx4hkjZikbdemWxoYHo4sCeJEFXyeFpXY3kShoU=;
	h=Subject:From:Date:To:From;
	b=kF5CysXJhHQjVVa2xqGXSw2vETLXS9LUG0kf5TwUFZ0FNBnzWZ/NXRgoJPgPrR1wZ
	 9NoJuyCCPWFxijEI1TaCNhBb5H6dBvdyzefsKDrcTdps1L18Xc8iET2B2gFVAx3V4W
	 B64qIv0qXBbJr7QEDY+Wb4sMCnaMiEYD3e3T+2BoeROoO7KU3JLMEZP2Jb2xR3oDRH
	 yS4Wv16OfdTBjIFCB3J8g3RumoAY+mkDZDad5Jo+Uea2gB5+cIllKGds1oGR5ENNsW
	 TpsZe3UjzXhR/dQXdAf/rYCbjn+SycgJHN9ohtdoZtRz07IKZEu+cigNOgF5OOqJvr
	 Lhe/DB84gbjjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E9439D0C21;
	Thu, 25 Sep 2025 12:56:58 +0000 (UTC)
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
 <175880501704.2967590.4005394285237436789.git-patchwork-housekeeping@kernel.org>
Date: Thu, 25 Sep 2025 12:56:57 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: support the SpacemiT K1 SPI controller (2025-09-25T12:17:10)
  Superseding: [v3] spi: support the SpacemiT K1 SPI controller (2025-09-22T16:17:13):
    [v3,1/3] dt-bindings: spi: add SpacemiT K1 SPI support
    [v3,2/3] spi: spacemit: introduce SpacemiT K1 SPI controller driver
    [v3,3/3] riscv: dts: spacemit: define a SPI controller node
  Superseding: [v4] spi: support the SpacemiT K1 SPI controller (2025-09-25T12:09:05):
    [v4,1/3] dt-bindings: spi: add SpacemiT K1 SPI support
    [v4,2/3] spi: spacemit: introduce SpacemiT K1 SPI controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



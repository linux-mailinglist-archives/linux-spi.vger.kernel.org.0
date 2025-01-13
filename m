Return-Path: <linux-spi+bounces-6350-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC4A0C443
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 22:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068587A26F1
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 21:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2361EE7A4;
	Mon, 13 Jan 2025 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzFIOsDy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B971EE028
	for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2025 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805372; cv=none; b=oq3VtJgBKYGCemL14HHoNBTK3FtfY1YXsFcmQdCzeWXRW57f7oJRPhQhykFmIo/qCM+68mAGZyRqJ6z4FOyDvDS2WKYFYywhjZy439BTJEWcVc7UU/ynKJwi6YOtg2hn08MUItW2Lt14MRtzYPi46Kv45JxcV7RcS+hy6s9W8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805372; c=relaxed/simple;
	bh=tczRwVm0/WmI0VSicZRL6HEvijq16NZ4aKggECRkmiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rtVp3KCIK5bs4GGu/P9+t73s7Ii3TeddBk4C8noEM3fDS/nywKFu9R9A7yMtXdEQdbOaoZnpVKh2ySVYmuu+XGSMQG0r2iO5J7WVJTJv+sV8z9cqPHMkuqvlGjV5j7oLmDwbkHkfe6eKJ14NHWdaMTjE6tyq33iICpGWQAGzG2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzFIOsDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33FDC4CEDD;
	Mon, 13 Jan 2025 21:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736805371;
	bh=tczRwVm0/WmI0VSicZRL6HEvijq16NZ4aKggECRkmiw=;
	h=Subject:From:Date:To:From;
	b=JzFIOsDyVvLZ3hCkeQVSWm4Ky/y/dg/eDzuj1rl/wljRmAyW5E85pBkWaK6hwI5um
	 upEPQas0v7OTWao+Uh56590in/hIa+13+iaRe9q5xS7rSC0jciHH8Y+t/PxV15Hebt
	 Z7X+zrWUOVcxpSrIs89r/bc1p0YzrBQG85y3J+ulyW50bNShtsu1/IvM6zBXdXjtB4
	 +cfrpe4fDxzASThA911Fs4JwW6sa2ntd6nlJnumU4hp7VGAhIyUyEzrfMsxfbEZsYZ
	 1GcgHKi8LoRujHDl+4wgd1puLlXQyKSovq/68eX/6BTGeNjDcDLidsEw019tDEF+JR
	 2MLW24N+euVHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7BC77380AA5F;
	Mon, 13 Jan 2025 21:56:35 +0000 (UTC)
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
 <173680539406.3645582.13932066637746998410.git-patchwork-housekeeping@kernel.org>
Date: Mon, 13 Jan 2025 21:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] spi: axi-spi-engine: add offload support (2025-01-13T21:00:05)
  Superseding: [v6] spi: axi-spi-engine: add offload support (2024-12-11T20:54:37):
    [v6,01/17] spi: add basic support for SPI offloading
    [v6,02/17] spi: offload: add support for hardware triggers
    [v6,03/17] dt-bindings: trigger-source: add generic PWM trigger source
    [v6,04/17] spi: offload-trigger: add PWM trigger driver
    [v6,05/17] spi: add offload TX/RX streaming APIs
    [v6,06/17] spi: dt-bindings: axi-spi-engine: add SPI offload properties
    [v6,07/17] spi: axi-spi-engine: implement offload support
    [v6,08/17] iio: buffer-dmaengine: split requesting DMA channel from allocating buffer
    [v6,09/17] iio: buffer-dmaengine: add devm_iio_dmaengine_buffer_setup_with_handle()
    [v6,10/17] iio: adc: ad7944: don't use storagebits for sizing
    [v6,11/17] iio: adc: ad7944: add support for SPI offload
    [v6,12/17] doc: iio: ad7944: describe offload support
    [v6,13/17] dt-bindings: iio: adc: adi,ad4695: add SPI offload properties
    [v6,14/17] iio: adc: ad4695: Add support for SPI offload
    [v6,15/17] doc: iio: ad4695: add SPI offload support
    [v6,16/17] iio: dac: ad5791: sort include directives
    [v6,17/17] iio: dac: ad5791: Add offload support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



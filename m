Return-Path: <linux-spi+bounces-6678-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FF1A2CE89
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 21:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5022D3A446D
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F621ADFE4;
	Fri,  7 Feb 2025 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxgrDRWT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B251ACEB7
	for <linux-spi@vger.kernel.org>; Fri,  7 Feb 2025 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961797; cv=none; b=nYa5Y+3dTpQMbxCLM17a5KyKSif/HZjEnbHNvtqXnsXh8xFl1CmKnXOB2x7+WV3w36uuF/a4EIRcvY0gr4XKJX0GsE1WroLNE1+eJx8i+/mci+frpiCMlbvcFdWD11GBG+imip/XKHpmnLFl7SEWMnxKw7rmcpjxlMmc+hiwbkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961797; c=relaxed/simple;
	bh=ZVnrZI14d3iyyvQLQtU042VdWcEQ6ez/6uyUJHfD3p0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RpayHUjPilEEi2CsYRXU8Np++UkHvaWprNzlGQq4VUcPywv96eARPszBeJHmz/7yiuLsWNUJP77tB3uypAOtznM0R2UVUgHQYKBbCN/DVkTNJmzWPAz4ecrruDNkBQswj2LXYurYa09aBxEf6hnfK2KQtL5k+KhM+37r+tAYmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxgrDRWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDED6C4CED1;
	Fri,  7 Feb 2025 20:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738961796;
	bh=ZVnrZI14d3iyyvQLQtU042VdWcEQ6ez/6uyUJHfD3p0=;
	h=Subject:From:Date:To:From;
	b=MxgrDRWTIecF1HTpKtuWV9KYcx+nZZE0lJ94DqqPJ0qIkEpSIGqd/kkmpGdDOJjXt
	 lNfd2eogv1pkuv5B1K0x2KsvY5VcSt3f6xl4wl4+a1wvl+USFVVA/OBh13GQb68Cue
	 tx5Kj7j2tl7WR7vfySH9Z7tKLMHlktpXp9jNKyFaNOYgTKwntVeIPGOgso0M8XDsaC
	 0Y3vpAmmg/epICUPowqbYDErNrBeE6AwoB6C9XHj9MFsnuKa02sF027sqK2byz8AY7
	 87fAGAOSQIZFVl1EBb6d+WjM1OI/CtWF9A9QOnA5BEcJL9MzbuCXTrRdzNrkm5MTL1
	 eooyZz+Uhvf0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFB5380AAF5;
	Fri,  7 Feb 2025 20:57:05 +0000 (UTC)
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
 <173896182444.2380122.5954164234607262168.git-patchwork-housekeeping@kernel.org>
Date: Fri, 07 Feb 2025 20:57:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v8] spi: axi-spi-engine: add offload support (2025-02-07T20:08:57)
  Superseding: [v7] spi: axi-spi-engine: add offload support (2025-01-13T21:00:05):
    [v7,01/17] spi: add basic support for SPI offloading
    [v7,02/17] spi: offload: add support for hardware triggers
    [v7,03/17] dt-bindings: trigger-source: add generic PWM trigger source
    [v7,04/17] spi: offload-trigger: add PWM trigger driver
    [v7,05/17] spi: add offload TX/RX streaming APIs
    [v7,06/17] spi: dt-bindings: axi-spi-engine: add SPI offload properties
    [v7,07/17] spi: axi-spi-engine: implement offload support
    [v7,08/17] iio: buffer-dmaengine: split requesting DMA channel from allocating buffer
    [v7,09/17] iio: buffer-dmaengine: add devm_iio_dmaengine_buffer_setup_with_handle()
    [v7,10/17] iio: adc: ad7944: don't use storagebits for sizing
    [v7,11/17] iio: adc: ad7944: add support for SPI offload
    [v7,12/17] doc: iio: ad7944: describe offload support
    [v7,13/17] dt-bindings: iio: adc: adi,ad4695: add SPI offload properties
    [v7,14/17] iio: adc: ad4695: Add support for SPI offload
    [v7,15/17] doc: iio: ad4695: add SPI offload support
    [v7,16/17] iio: dac: ad5791: sort include directives
    [v7,17/17] iio: dac: ad5791: Add offload support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Return-Path: <linux-spi+bounces-6037-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9789ED920
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 22:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045601882E22
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CB91EC4C4;
	Wed, 11 Dec 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjbCS4Bt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48BF1DDC29
	for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954189; cv=none; b=KK7DgIGEo2NH7hSjNV/IoE7GFM50yIqVijaruXyuEkxqtuOawGCj2ajrcwV6UpbOzMzep/km0TJDmqeppQvXjKmLDO21waRoWlUEwpJp+E2GUD7/N2yINWQLni0ezmFHYgkiR9iNQj8w0+mkSpOfAxXiuz+8evC9hkRMdtUk+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954189; c=relaxed/simple;
	bh=j9F1YZWRBDN8WE9LMAYGGFkO1uMupBzKtitqEJoL48g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DWi3bEixDs21udCcPaCmcgta00mskSFra4EgGtHUQ7H4/fRWFQrls0aTZhEdH7sFEYqw3qhCB9Mn5fBwdFxrN4PMPGyfVRzbq7vm3QERrEBMz3TYzvud8EvjlG0oEtM+5V0zrulhCGoMZWTGCEaemRIH64mJRRWB1xck4kNzqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjbCS4Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C47CC4CED2;
	Wed, 11 Dec 2024 21:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733954189;
	bh=j9F1YZWRBDN8WE9LMAYGGFkO1uMupBzKtitqEJoL48g=;
	h=Subject:From:Date:To:From;
	b=UjbCS4BtekShw1g/4KSHZttmgMD9/UOFSmq/HE+iZg0LmNzCg6B3jvLy9LRkI1dmi
	 Ad3jHSBUNPtL5hdj0OBibVLVw8u9Q9pO1auf+e+CXlbUarDvo5qP4dyxhT+meyGSXe
	 INNQnNFTGEclBqIr/NeKK3UJ1Ps+nyHlPPl7ENMtIH7zQaFz5vk/xZuPZe0oTxP/EJ
	 NYosQdE7W0R1svM0J2b3TiauxU0f8vmsApakkfkxziQzo4F7YX7zaIqkSu8AI1eWmt
	 JH8euLKFpGfIRrJ3vjwO0W+5bbgqYJCwe75BdnWHhAvao6rTvRbCTRyx5ldyXxqVwC
	 +2rQIPoF+EdTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F28380A965;
	Wed, 11 Dec 2024 21:56:46 +0000 (UTC)
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
 <173395420487.1725041.13787539111386764128.git-patchwork-housekeeping@kernel.org>
Date: Wed, 11 Dec 2024 21:56:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] spi: axi-spi-engine: add offload support (2024-12-11T20:54:37)
  Superseding: [v5] spi: axi-spi-engine: add offload support (2024-11-15T20:18:39):
    [v5,01/16] spi: add basic support for SPI offloading
    [v5,02/16] spi: offload: add support for hardware triggers
    [v5,03/16] spi: dt-bindings: add trigger-source.yaml
    [v5,04/16] spi: dt-bindings: add PWM SPI offload trigger
    [v5,05/16] spi: offload-trigger: add PWM trigger driver
    [v5,06/16] spi: add offload TX/RX streaming APIs
    [v5,07/16] spi: dt-bindings: axi-spi-engine: add SPI offload properties
    [v5,08/16] spi: axi-spi-engine: implement offload support
    [v5,09/16] iio: buffer-dmaengine: document iio_dmaengine_buffer_setup_ext
    [v5,10/16] iio: buffer-dmaengine: add devm_iio_dmaengine_buffer_setup_ext2()
    [v5,11/16] iio: adc: ad7944: don't use storagebits for sizing
    [v5,12/16] iio: adc: ad7944: add support for SPI offload
    [v5,13/16] doc: iio: ad7944: describe offload support
    [v5,14/16] dt-bindings: iio: adc: adi,ad4695: add SPI offload properties
    [v5,15/16] iio: adc: ad4695: Add support for SPI offload
    [v5,16/16] doc: iio: ad4695: add SPI offload support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Return-Path: <linux-spi+bounces-8851-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8C0AEC359
	for <lists+linux-spi@lfdr.de>; Sat, 28 Jun 2025 01:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314934A695E
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 23:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C6E290D87;
	Fri, 27 Jun 2025 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdDj9qBd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2639855
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751068738; cv=none; b=IyQYYnOTGHv9FjBNv3IrZTc9lZR28xEFfrVL2qY8Q5FHlBrua9l/LgDevsg1wv5wDla8A0o84sHGqwnAd+ciR+g5N1az9wVyVc65tZLkHoqLuDd7R6E6CboflOkuax+DGhHILuTbLMT+yorf6Ocs3MzbCA/vc2nmNG+VAbVz5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751068738; c=relaxed/simple;
	bh=d6lfo+dUb7AdvuMQIIiqmfKwMpLyQFYI20YdOSItUuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gRwrLeVIL71nDlidZJkrYiW8m+goQi2nIWcjXkWgLn8cS0MKLNDL+/rjIzPX4bwMxLDT0XMdofWQ6B80SBJYlwLSGCP7jACD10f/n4QhIf2Jj/OWnJkUhwuzu94r/CKynMh1GXG4l+WovJF09L2//OetTyBY55AhWp3v/IX7A4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdDj9qBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01A9C4CEE3;
	Fri, 27 Jun 2025 23:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751068737;
	bh=d6lfo+dUb7AdvuMQIIiqmfKwMpLyQFYI20YdOSItUuc=;
	h=Subject:From:Date:To:From;
	b=HdDj9qBdNI1QbH0Fu166XOPfT6MRhBgO7wuLebSUutHslo+Jt1dcs61EvL/ttSGkH
	 +Y/bsRplB0xu5sypqpLCc8J4WII+7YCe2pcrzljiV2G/VVAFC2TS3sFFRmalmyVUnb
	 7csAEwJG1Sck1mymjLQ+S7/ToTIWaKPdNjGzZOJKfifwTY+PgRZHtOu4nWpeTYG5oJ
	 eNvlv2cUjwqRxW0W1libWaZhKjLhEJTODGKLqjouMdWapSF4wgyMOeZg5IWOXDHiSz
	 kVoxYT8925z87KsTWeHpouFsdbaWhOzZfjt/T4yNNv+M5pW9TN7NnC32LY5RboJvfO
	 2EKdxNKA/GxwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B129138111CE;
	Fri, 27 Jun 2025 23:59:24 +0000 (UTC)
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
 <175106876333.2092946.3365886266752594600.git-patchwork-housekeeping@kernel.org>
Date: Fri, 27 Jun 2025 23:59:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] iio: adc: ad7173: add SPI offload support (2025-06-27T23:39:56)
  Superseding: [v1] iio: adc: ad7173: add SPI offload support (2025-06-20T22:20:06):
    [1/9] iio: adc: ad_sigma_delta: sort includes
    [2/9] iio: adc: ad_sigma_delta: use u8 instead of uint8_t
    [3/9] iio: adc: ad_sigma_delta: use BITS_TO_BYTES() macro
    [4/9] iio: adc: ad_sigma_delta: refactor setting read address
    [5/9] iio: adc: ad_sigma_delta: use spi_optimize_message()
    [6/9] dt-bindings: trigger-source: add ADI Util Sigma-Delta SPI
    [7/9] spi: offload trigger: add ADI Util Sigma-Delta SPI driver
    [8/9] iio: adc: ad_sigma_delta: add SPI offload support
    [9/9] iio: adc: ad7173: add SPI offload support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



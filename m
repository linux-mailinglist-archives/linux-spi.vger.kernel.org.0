Return-Path: <linux-spi+bounces-12055-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2A3CD211D
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 22:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C7FD300182D
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 21:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F1D2BE7AB;
	Fri, 19 Dec 2025 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlcC9Yqw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0B29C321
	for <linux-spi@vger.kernel.org>; Fri, 19 Dec 2025 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766181598; cv=none; b=S9sBr2nhVQXgPXIG/Ua7DvD0TH3WaJ4QoVRtsZ/2zNf0Gs7idSl6jD052rGooL0+mg9pa78+di/OeIXJWMxRPSMCd+n4JAWUTrUvnfBJU6d51T/dJX+C7c+E04jp5xft7S8yDr5rsPsdPh1sGMWAJLQuSlIJUE3f1enLmO8OnqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766181598; c=relaxed/simple;
	bh=pCQi7AfYoFtMWYkRb28YXsNvodzf56tAnrCZjyGXe2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rIHkDSF4S/ZbmWTtRTRUkn1kAxahQptVp9CDecF4vIOvPWXfr1nCpusPybhfDEP3SPxLXrRuSDHC7uc2ZS5zD232twHYVCyouaBZQJA/CvllfLU04RLKrG4Il06sydaMStuGUb0zM3MfFOlCvWU+IfAj0Nn/wOAHBY+zU5KYXoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlcC9Yqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52E9C4CEF1;
	Fri, 19 Dec 2025 21:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766181597;
	bh=pCQi7AfYoFtMWYkRb28YXsNvodzf56tAnrCZjyGXe2w=;
	h=Subject:From:Date:To:From;
	b=XlcC9Yqwi23cFM78vrvwH07caA53kNAqujYinaGWYu5OTj14axYTuBtrTHhd/oqkX
	 yJ1kQORjDfoQWg/i2nqNvJkGx3K4/stSr2xrd1rX2rN0V74LkZi5n5AJTBXkVZqkXq
	 ugWsveuNV+JUuyNoDiY3hLQGA0paCP1UrswVtKTmglLVZbEJK4f0VSIjMgiI6f/Zus
	 rsLoPw5sgpssdKYeYEV8ZdUEzACp4kjdL13Y5EBlNxKJppAp0oybq6hiKgbTZtDO4f
	 9wGY/hsl6oUk5bMAQSi92fAts8U3euH2QDnsANh9yYBeIEMxAIonCcEXCzZk169p14
	 fnTN+WVsubyiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7E0D439B167B;
	Fri, 19 Dec 2025 21:56:47 +0000 (UTC)
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
 <176618140602.4029096.13491342736045794326.git-patchwork-housekeeping@kernel.org>
Date: Fri, 19 Dec 2025 21:56:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: add multi-lane support (2025-12-19T21:32:08)
  Superseding: [v3] spi: add multi-lane support (2025-12-02T02:20:39):
    [v3,1/7] spi: dt-bindings: Add data-lanes property
    [v3,2/7] spi: Support controllers with multiple data lanes
    [v3,3/7] spi: add multi_lane_mode field to struct spi_transfer
    [v3,4/7] spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE
    [v3,5/7] dt-bindings: iio: adc: adi,ad7380: add spi-lanes property
    [v3,6/7] iio: adc: ad7380: Add support for multiple SPI lanes
    [v3,7/7] dt-bindings: iio: adc: adi,ad4030: add data-lanes property


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



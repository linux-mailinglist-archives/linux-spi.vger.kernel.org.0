Return-Path: <linux-spi+bounces-3157-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104838D4F7F
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAD12854D7
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9031F95A;
	Thu, 30 May 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMa4JBrf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC3D1F94C
	for <linux-spi@vger.kernel.org>; Thu, 30 May 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084605; cv=none; b=kFrW6gb8mleI3Z+TTFKSfvLd7v7QN2STfPvuNKydwMmk21Kfa6E8gj2NIaDsnH83qg+jdWwQCINXTRdn/qbEUgoXfYnKeceCwX1MBUxZSgpHr9FGNRWa8igkTy+dxHAP082DSWp2zQtniQBL780i3j/Sxg9km5jb12OaqH/jnrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084605; c=relaxed/simple;
	bh=RtE8tVGxlAb2EzqHFRDsw5t6MnWOrAo8ff55Ufyvb2I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dnc2IQ5MEKdTBq6lbCXNIX0iPN0ZmWhyxr+MLx5saG06ZcGkpt9xHMVL/HwbXWJU8cEnFoJARJVE7zeBJwYG+sqH7h13eZf2j9ScpCevakk7zraSGHInG17GRIIxtYk9SWet41btWXdRbt4UkFRwiVdoDxcaCUCcd5ckDUPnEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMa4JBrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C594FC2BBFC;
	Thu, 30 May 2024 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717084604;
	bh=RtE8tVGxlAb2EzqHFRDsw5t6MnWOrAo8ff55Ufyvb2I=;
	h=Subject:From:Date:To:From;
	b=eMa4JBrfbaNiDXraWG57UnhiakSHimatzQ997VQOymq0k2kkaordUToojvj3LWUuI
	 bksUWHOV3RZFbE+h0wDku7mLyQkdm6VRJA7MBmxJGV+Xnv9rvGdoYNWGFE1GoF61zE
	 1QfggWbaxvdJXAMogEoUNZOs/vxgKg/3pmSmj94Hh5QLOzgOdP6Gof9bAAlyKHZN8h
	 gkPWjntiKJbcVuk4r38VrvYo/9HQTqm5b4+xTtFDqaa+eV9HUYTMjguY29bHvldjZt
	 WnXq7EdBT/0vm+UYmbTDjV7h5pqQe7hbL3g0MXS1NZBGGlMqlA0QaLjWHR3e+McpPD
	 T95uQdSy/JkCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B51C4CF21F2;
	Thu, 30 May 2024 15:56:44 +0000 (UTC)
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
 <171708460473.16890.13895523356726137871.git-patchwork-housekeeping@kernel.org>
Date: Thu, 30 May 2024 15:56:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: pxa2xx: Get rid of an additional layer in PCI driver (2024-05-30T15:09:59)
  Superseding: [v1] spi: pxa2xx: Get rid of an additional layer in PCI driver (2024-05-17T19:47:35):
    [v1,01/10] spi: pxa2xx: Reorganize the SSP type retrieval
    [v1,02/10] spi: pxa2xx: Remove no more needed driver data
    [v1,03/10] spi: pxa2xx: Remove hard coded number of chip select pins
    [v1,04/10] spi: pxa2xx: Utilise temporary variable for struct device
    [v1,05/10] spi: pxa2xx: Print DMA burst size only when DMA is enabled
    [v1,06/10] spi: pxa2xx: Remove duplicate check
    [v1,07/10] spi: pxa2xx: Remove superflous check for Intel Atom SoCs
    [v1,08/10] spi: pxa2xx: Extract pxa2xx_spi_platform_*() callbacks
    [v1,09/10] spi: pxa2xx: Move platform driver to a separate file
    [v1,10/10] spi: pxa2xx: Convert PCI driver to use spi-pxa2xx code directly


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



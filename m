Return-Path: <linux-spi+bounces-11129-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E2CC41A9D
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 21:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA713AAEC2
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 20:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480622F5A1A;
	Fri,  7 Nov 2025 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY+5DTRH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239172D94A1
	for <linux-spi@vger.kernel.org>; Fri,  7 Nov 2025 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549049; cv=none; b=FxYbBvc+0XGAGED6FrYcwXo6Us3ecft2kuJO2nQFftaYXDv+lTNxZxQ1LFyvLO/GsZNMLiS9f3wDZnfCmRzIZcWAE5uk/NGE7PT+6IqZsuf3O6/cMBA1biCYNzpKSipjaWTJE7iWOu9B9SBcuVaJhA4OcU/BldKV64eEo9Ak+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549049; c=relaxed/simple;
	bh=LvzVmGisAt2dYEEnnEmvGfvWFM5l+bkZUs/Mt/gNb8o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=MLT5jtMi6GfDIx9xjHDKYnomWe3/KVGIdo/w2N5JYATQkCwqj8NHhS8j9M8fALoaxvAUHExcSgKMj6JerrJROmeL8VOZM0YxJo4908FQK2fnCteq41zKpWw+2kHn3KIQnkFmsLNk07glYsMLwAcKO3pN07cGPq5SYHIjX1FA0fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY+5DTRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C798C4CEF5;
	Fri,  7 Nov 2025 20:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762549048;
	bh=LvzVmGisAt2dYEEnnEmvGfvWFM5l+bkZUs/Mt/gNb8o=;
	h=Subject:From:Date:To:From;
	b=KY+5DTRHq7t/cHtbe3+D5BVsiA0LLKaxvES3bJ39mM7jNeitJhUhqlYgBka2JeQ60
	 BxOyGkgCMOa73QeSvfYyQt3VHa9xvrjSD9wqprt5JkYgrWJtIjJBOFh6IT61ZAmVvx
	 DSpZbO2ZnOf2efIWyBYfYfYC9iWJdmEvy9zo/JqXKrO24VHXVJWI+IgCQCBk8F64mi
	 AboNEfwQi255fG/iybVyBTcTelY7fh97J3FYWAEndGh4dPF8+87cLohBH7i0Y6x4Rd
	 ZJAx0dZqvqa9UDDNsKVnq82xzhvSJNtnqGqs88o7Ga8NKZxReHKdTNQkifwUkCEXVr
	 HNRtqnyo8W1lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEFE39FEB7F;
	Fri,  7 Nov 2025 20:57:01 +0000 (UTC)
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
 <176254902022.1156806.1781823179468867621.git-patchwork-housekeeping@kernel.org>
Date: Fri, 07 Nov 2025 20:57:00 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: add multi-bus support (2025-11-07T20:52:47)
  Superseding: [v1] spi: add multi-bus support (2025-10-14T22:02:10):
    [1/6] dt-bindings: spi: Add spi-buses property
    [2/6] spi: Support multi-bus controllers
    [3/6] spi: add multi_bus_mode field to struct spi_transfer
    [4/6] spi: axi-spi-engine: support SPI_MULTI_BUS_MODE_STRIPE
    [5/6] dt-bindings: iio: adc: adi,ad7380: add spi-buses property
    [6/6] iio: adc: ad7380: Add support for multiple SPI buses


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



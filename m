Return-Path: <linux-spi+bounces-2393-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D66A28A7C9F
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 08:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F0F3B223DE
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 06:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47640657C3;
	Wed, 17 Apr 2024 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ8rTjG/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AE229D06
	for <linux-spi@vger.kernel.org>; Wed, 17 Apr 2024 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337041; cv=none; b=M0xeFrGEU2cHxWwkw5VqV4TOUoYTxZFYyOfK67k82NfzTMUvm0u3drrPqLV0DtZkTgOB3eznZmZb0lbeluoDwPRaNORgN97Nv7wJ+Hk4JTbB97pzVgkzPaF6SPDAGgEOLl5N/LCpxw4mCBp7JusFXkOFRqolpnRovGlkfY3eTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337041; c=relaxed/simple;
	bh=55datWgwMsoj3qMNgLpuLKrcrB6ImIUEJsQZxrZycp4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NObIwhkJ0o22r7frmpFvT/2tQqjk+l9rY58aymXYX21EjYNLYK1qFIuOXzmJlrQwCMe9kvuxkfOi6oELKJJio173+ghVIm1H0a3jzPjr1wGdcsCEohV5W+KuCEbXQFUFOrxhS4CLgVLel0Dq6jyVxL6LGtsILIryGqs/zMG6wPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ8rTjG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93D13C072AA;
	Wed, 17 Apr 2024 06:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713337040;
	bh=55datWgwMsoj3qMNgLpuLKrcrB6ImIUEJsQZxrZycp4=;
	h=Subject:From:Date:To:From;
	b=VZ8rTjG/u+5GXoZXy905Trrg5dPf76HuczUs27waL2bHl8AWXfJnz7OxSYslFSs9m
	 ydKBgUaOTvyFp8m69cg3kVPQ/L0zBXJ7FyhYX+G7oH6mpJsssJ6WrNvZKXBFYk+XYr
	 UrGfvK+QhWkuSkIpl8BGImz9XJNQTCUw9SYsaAAsafznBFa07tiSIoIO4QdJyq4BOf
	 zZjCQB25MS8v1oV43mjhVBoIK4z4pI+E8dnHaxAGek36X2kEmgaApplJFuGPSNWEUo
	 nenPJHYJc1M+pK5COkawG9f0zJmK1c8oTFcEP81qV4l87NtTw+QPJYBuxiAx9ivsfu
	 LeF6d205CzMSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BAD6D5B3FE;
	Wed, 17 Apr 2024 06:57:20 +0000 (UTC)
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
 <171333704056.31888.14673150589463080184.git-patchwork-housekeeping@kernel.org>
Date: Wed, 17 Apr 2024 06:57:20 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add add SPI-NAND Flash controller driver for EN7581 (2024-04-17T06:45:49)
  Superseding: [v1] Add add SPI-NAND Flash controller driver for EN7581 (2024-04-11T11:08:35):
    [1/3] dt-bindings: spi: airoha: Add YAML schema for SNFI controller
    [2/3] arm64: dts: airoha: add EN7581 spi-nand node
    [3/3] spi: airoha: add SPI-NAND Flash controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



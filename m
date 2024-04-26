Return-Path: <linux-spi+bounces-2541-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832A18B336A
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 10:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F23F281507
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 08:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1332B13A402;
	Fri, 26 Apr 2024 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u61KqTRk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C625B5BE
	for <linux-spi@vger.kernel.org>; Fri, 26 Apr 2024 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121803; cv=none; b=gUtk2ESmf7VP+hH0dvM4ehpOnV158Op/gtgpWU54b9UXKZTesCbGKAhRLBYEzctKvysBPO4L+BIIH+fUcsgHSZeL7RktrP6nB+z4YkscOXawZkn0dA+WsfzKvyhf8ktlQMpMNBE6hUGkZWMpGTXJmgQf5rjpEsJ0YxmfTBgzKjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121803; c=relaxed/simple;
	bh=+EjXAUMfjxKsN/6EEK14soFCffFAOz2JjE3ZNW8amwU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nFsXT/L+8BUEGxgtbyc3qkF+PPkFZuQUV0Nm8Co+qi3jKuq8dFH6VVnr/EyUelu/lOifJSsKtfd2k0b2dhTEhLjFp2bGeJzaDzvxCVoBAVnCWaXMbbmiRGKa/w9PVt0/cTSZDttwjIXwMQw3WRgc6bhEI4lxrm+1kliJEyjOCiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u61KqTRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74AA5C113CD;
	Fri, 26 Apr 2024 08:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714121802;
	bh=+EjXAUMfjxKsN/6EEK14soFCffFAOz2JjE3ZNW8amwU=;
	h=Subject:From:Date:To:From;
	b=u61KqTRkySyWH0X7HiLapntxWMFsRDax7xd7KvseLuTj4AkwXCpeSh9TEXYSle4nl
	 3uhcP8Y/w9GnJd1PWB/iKR+GADd7CJjTP7xiLw9pSjSgvEsreY1EjjSF5uzztID9+f
	 Y1n3NA5Y9MYElTatRGtzfR/WpGB0n+0bhp9UTncG5DPGxOLcU5hezNnbNLeGrXwqSS
	 UpNs5tFA/D//YWx50UWJB2DzNm1rvvBHb8h6FLnsHllV05vaScDyEtBkC4+WQf8iLy
	 /gYnuLzA0/qA4+aPUfptu2V+sFvD856gdgZ/W6Uj2XE0jkQZMf33UYYhUlogzoND3T
	 IQQU+fITLnl0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 633E5C54BA9;
	Fri, 26 Apr 2024 08:56:42 +0000 (UTC)
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
 <171412180240.24858.15836042117961235960.git-patchwork-housekeeping@kernel.org>
Date: Fri, 26 Apr 2024 08:56:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add add SPI-NAND Flash controller driver for EN7581 (2024-04-26T08:30:50)
  Superseding: [v3] Add add SPI-NAND Flash controller driver for EN7581 (2024-04-23T10:16:34):
    [v3,1/3] dt-bindings: spi: airoha: Add YAML schema for SNFI controller
    [v3,2/3] arm64: dts: airoha: add EN7581 spi-nand node
    [v3,3/3] spi: airoha: add SPI-NAND Flash controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



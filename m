Return-Path: <linux-spi+bounces-5140-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC21F993F7B
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 09:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5001C21D4D
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 07:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015E31C4613;
	Tue,  8 Oct 2024 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHMeP7qD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C1192D9E
	for <linux-spi@vger.kernel.org>; Tue,  8 Oct 2024 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370565; cv=none; b=Flr7BQPMT8WaJgo5pSq5ba8Xo4FxBc+ELfN3QBi599FHy2hUzHkQJsqgM6cuG2JbzqeDbCzVntQRS+W5DYUwNaxgz8exJNFHFken20psDgbWJj5hCGkzRdajArh9xYWfsbjeCNCzKF6EQifXcz4NIq+AqnGysLbQAY48FGoy+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370565; c=relaxed/simple;
	bh=yCS/mmyWz09ylLVnleEGs1mg8zj0uEhbvQIQ95LMu2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Y/Ae5BPNVTPVSPdnmHLzpWKNgGdBuIyIAx/YJpK05gRIKm3QFyqAxDXNVP6sEG6BGK2/Ua7q9zXwYatWGFi82wqqStbmzz2baxhyApMc/awXA05FwxoQt+7lMY4iU7MTSzVYrKSogqCIUtkftXEbcL3Yx7ZhHMYvUOnsePZayZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHMeP7qD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6676BC4CEC7;
	Tue,  8 Oct 2024 06:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728370565;
	bh=yCS/mmyWz09ylLVnleEGs1mg8zj0uEhbvQIQ95LMu2o=;
	h=Subject:From:Date:To:From;
	b=pHMeP7qDNH+vm3iAyoaaT3kF/9C5AtgKX0k32UIdLC+LMCCZBEwEu3GXjKvEVdVgW
	 /vKbvTQ/kmiePwLZIZmMGrS8Hhd6kKFZDlwvZOzjvnBUXi/83YijYtekvVdE6IpJdF
	 QYhpn4eSPkPBwbhWotbyp7eDaLHKCXAm/HDwS4pSlk8JXEppYdmi6b67+wadnINNTU
	 zaBtZiNnJDE8z6lrnzNLzYGdgRZivhMDQlFg3x/BGfgQUBbq7b1kWkKGX+ceXsQiCO
	 3DNM0Uz58rW22bseHVBqf1QYwxkKbEdi2PXcz5G5MxAuhN/JoBe+2bMq/4Z6vvdgqk
	 QNWHq4qzwXEkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1073803262;
	Tue,  8 Oct 2024 06:56:10 +0000 (UTC)
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
 <172837056914.110414.4240242014739913333.git-patchwork-housekeeping@kernel.org>
Date: Tue, 08 Oct 2024 06:56:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-fsl-dspi: Fix casting warnings (2024-10-08T05:55:45)
  Superseding: [v1] spi: spi-fsl-dspi: Fix casting warnings (2024-09-27T13:28:32):
    [1/4] spi: spi-fsl-dspi: Fix casting warnings
    [2/4] spi: spi-fsl-qspi: Fix casting warnings
    [3/4] spi: spi-imx: Fix casting warnings
    [4/4] spi: spi-nxp-fspi: Fix casting warnings


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



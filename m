Return-Path: <linux-spi+bounces-9699-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6001CB39AB7
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 12:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A89F16D376
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FBA30C62D;
	Thu, 28 Aug 2025 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADOGMVbz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880A17A2E3
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378611; cv=none; b=nuwUCYTsjGkLUiZAaEtbjIKUjvWy1OyS9vRvNRM1io8JM7SwOxhfWCKLSQCfawOmdzEXB54/7RL0VYFh/xfXhHyo7t+tAdgILzQ+qTkfdtcm3+iYHqdOL4BKbxSGRylE337xMmpPxZMv3RJ0BnBqk+ICPKTWMHn29vRBaei1NvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378611; c=relaxed/simple;
	bh=OKVaRmzhj3F5Dgc3isrXXqXrtAdSIHL0eQy3P/Z6FxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pIZIcPHXNzIAB8JR4CIjPUUMVYbdHGBbwU/ks6eTfrEntxBvRBx3YRjKQH2vUpezfBbx9Q5zlH/bzHpZF08u/5ByhET61l9bXXwwetW7URQK+M7di7jPqEWbgpDaUbjh7rH7QyR1alzR/kV+rFboLuIupTKBKPhZFsC4rHxIpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADOGMVbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A170C4CEEB;
	Thu, 28 Aug 2025 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756378611;
	bh=OKVaRmzhj3F5Dgc3isrXXqXrtAdSIHL0eQy3P/Z6FxI=;
	h=Subject:From:Date:To:From;
	b=ADOGMVbztVArmQiTGNKvQrQCW6R0P5YmIf/P8KDHy2ADSOHUqbTpEyg/mk8XURAl1
	 r/on3mEtwD7q5oDI7M85gWbUiYTu4I9Bpof+Bxq2Hmlm2hJh43Hj1VIUOdsNL6uQK4
	 mYL8O7iDL9aCW/N/j/8sFKmVNkmso+4B1LNYkmaIhoabsWJtjn6XRB1E07fKkRYRVA
	 2lEPbFMKlWq7oABZo/EEBLH0T2CcckYRqNYGbGJ0QFeH2sI3YHDi8jJsuNYG+Kr3Nx
	 sVrY/MWdmm216zTRURHV5yy8uKG0zN61lupwrRk9bRLo3LFlMR22auNq7PuEuAttws
	 AbT4v+aI9bYDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF7B383BF63;
	Thu, 28 Aug 2025 10:56:59 +0000 (UTC)
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
 <175637861830.1407541.3487424855300616002.git-patchwork-housekeeping@kernel.org>
Date: Thu, 28 Aug 2025 10:56:58 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-fsl-lpspi: Generic fixes and support for S32G devices (2025-08-28T10:14:39)
  Superseding: [v1] spi: spi-fsl-lpspi: Generic fixes and support for S32G devices (2025-08-14T16:06:40):
    [01/13] spi: spi-fsl-lpspi: Fix transmissions when using CONT
    [02/13] spi: spi-fsl-lpspi: Set correct chip-select polarity bit
    [03/13] spi: spi-fsl-lpspi: Reset FIFO and disable module on transfer abort
    [04/13] spi: spi-fsl-lpspi: Clear status register after disabling the module
    [05/13] spi: spi-fsl-lpspi: Enumerate all pin configuration definitions
    [06/13] spi: spi-fsl-lpspi: Add DT property to override default pin config
    [07/13] spi: spi-fsl-lpspi: Constify devtype datas
    [08/13] spi: spi-fsl-lpspi: Make prescale erratum a bool
    [09/13] spi: spi-fsl-lpspi: Parameterize reading num-cs from hardware
    [10/13] spi: spi-fsl-lpspi: Add compatible for S32G
    [11/13] dt-bindings: lpspi: Update maximum num-cs value
    [12/13] dt-bindings: lpspi: Document nxp,lpspi-pincfg property
    [13/13] dt-bindings: lpspi: Document support for S32G


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



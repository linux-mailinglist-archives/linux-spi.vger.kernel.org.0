Return-Path: <linux-spi+bounces-1647-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D4873893
	for <lists+linux-spi@lfdr.de>; Wed,  6 Mar 2024 15:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5B8282BCF
	for <lists+linux-spi@lfdr.de>; Wed,  6 Mar 2024 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525B812FB0F;
	Wed,  6 Mar 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6AO94NA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44D13173F
	for <linux-spi@vger.kernel.org>; Wed,  6 Mar 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734232; cv=none; b=BBZHdI5y9P8T4I8QadQKuNyNpwpNBNojTRqH+wHLbCfBr7REHvngcFEnOCb742HEuaxdqEqIdIXAYDXJ0zMi7k3kvu71HuwsMxLlrcvADzqKkk4RuzKBB+M9CNdlRdQcO+1l8bigKESpKl17PVZ89EBAMUKnZ69uxmAbmAxphI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734232; c=relaxed/simple;
	bh=l2BK4V6vH1+r4sthOfNLJHzceJ6mGk8MZDmM6avRhWc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mCKzceMQWyrXnrggZj5/uXlpdKYwYsGsa5KOyRhFXOOmydH5Mu7X00i86nhMs6rCr8sXaagttsgBbmYwbSrPxvPK8VD3BcKq55vSBVtDrvEKhrpWPbjEa5Y6mdhYmHzMKdbrguTtMiepJDtT5SgZAD2y/EIiMHG4kxuvDWjGLpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6AO94NA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8D9EC433C7;
	Wed,  6 Mar 2024 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709734231;
	bh=l2BK4V6vH1+r4sthOfNLJHzceJ6mGk8MZDmM6avRhWc=;
	h=Subject:From:Date:To:From;
	b=F6AO94NAZpDq9sBMR2IUzAkhBiG78Jbj07oQVbNaFu8ekXq5FFT6guy0xgh26m9+q
	 XviPavud2b5NDcGtjoHfJjdku7gCmaJ3GlKl4MGJzfStLVvE2E1LrUqkkieZYTVsKw
	 8O1XVI0ioDuiy1l+itsyYSXjwFYHbv5C9eyYsvrcmbVS+y0J2EfG9aDomCD/xiv1ZD
	 90USK1pm+9XQznwsQswtoHXNvUJRHyXsnXm+yFSapIkpnXSi8I2zWzSAm1/qztoMa9
	 x35xQky6q3PHfbixYgktvcpWFG5QvrjAAM3H4MuDxnoZTAReQS37TOneosvdjd6ReO
	 uSDGczSvqbm9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97551D84BDB;
	Wed,  6 Mar 2024 14:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <170973423154.18449.17919600044467225114.git-patchwork-summary@kernel.org>
Date: Wed, 06 Mar 2024 14:10:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: s3c64xx: remove OF alias ID dependency
  Submitter: Tudor Ambarus <tudor.ambarus@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=826671
  Lore link: https://lore.kernel.org/r/20240216070555.2483977-1-tudor.ambarus@linaro.org
    Patches: [v3,01/12] spi: dt-bindings: introduce FIFO depth properties
             [v3,02/12] spi: s3c64xx: define a magic value
             [v3,03/12] spi: s3c64xx: allow full FIFO masks
             [v3,04/12] spi: s3c64xx: determine the fifo depth only once
             [v3,05/12] spi: s3c64xx: retrieve the FIFO depth from the device tree
             [v3,06/12] spi: s3c64xx: allow FIFO depth to be determined from the compatible
             [v3,07/12] spi: s3c64xx: let the SPI core determine the bus number
             [v3,08/12] spi: s3c64xx: introduce s3c64xx_spi_set_port_id()
             [v3,09/12] spi: s3c64xx: get rid of the OF alias ID dependency
             [v3,10/12] spi: s3c64xx: deprecate fifo_lvl_mask, rx_lvl_offset and port_id
             [v3,11/12] spi: s3c64xx: switch gs101 to new port config data
             [v3,12/12] spi: s3c64xx: switch exynos850 to new port config data


Total patches: 12

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




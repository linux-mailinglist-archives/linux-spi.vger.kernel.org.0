Return-Path: <linux-spi+bounces-5070-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F22398B143
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 02:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E841C21B3F
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 00:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D2821105;
	Tue,  1 Oct 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q273keUS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54212EEC5
	for <linux-spi@vger.kernel.org>; Tue,  1 Oct 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727740828; cv=none; b=fKco3OuMaRbzFHxKI8XUY6x2XPg1L7DGMRkLOpA5GspxYkTw9QTgo7zFLbARbYxIuK0fBjWRmZ+enA9suXsK+6I7s7g2MTsDcicU8gejSEK42TF66oBrIm4/pOLUa34K5+AZvYHyxFSFOp7Ml8BlkC6ZvJUb2U+DuJFSxpPdEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727740828; c=relaxed/simple;
	bh=TQXRqcwhqDpV/zQS3NrT+KUUiz8on54PXNxInjOMmx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ganRGVbLSwNTdMoFWzlnGUlaVQDMOqAY27Rb66qmW2MwY0hsTYb76fnmX4qCJBeDuOMWONfQL3t7Al06uV2++HHcrsNYB9p/Ox6rWWMAa4IW5G5fbKf3unc43cjNARN6uZk2+j89W4RoP2Sz1hfnJznbaEcVaBDbaUz8crgLmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q273keUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC69DC4CEC7;
	Tue,  1 Oct 2024 00:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727740827;
	bh=TQXRqcwhqDpV/zQS3NrT+KUUiz8on54PXNxInjOMmx0=;
	h=Subject:From:Date:To:From;
	b=q273keUSB7g5I3zqROpvTIRFHVNM2WDe21+dk+ER80PaHmnXGD76g9nCXNn2tVU42
	 F8FBPp/cW/oUSV7NRFHgMElP8K6VvoJU9h2TZppUsL4PntlvYUhPZ1k8bKzp0RYReJ
	 M694aggMfBxrfC6WNJ/EEh8WDXEZxXgNbf7WxzXxgqtcWwFrVMrBoedXrU2fhBsWfV
	 WzEH/+1XlfdzL6ip/jdQAHttYNSG9Xoag+N7sHVtypdoD8+2zkwNwc0TGg2obz0uuI
	 sp6SE+Otpba0NbEAS1hKtELdVwTfYvkZZVSI2C0oLeNcGnEw8V4y5N/ct23J6fqbPR
	 UP7bhVr/TUJgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 014E23804CB9;
	Tue,  1 Oct 2024 00:00:31 +0000 (UTC)
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
 <172774083049.4017466.5410347569781637269.git-patchwork-summary@kernel.org>
Date: Tue, 01 Oct 2024 00:00:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi_amd: Performance Optimization Patch Series
  Submitter: Raju Rangoju <Raju.Rangoju@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=892793
  Lore link: https://lore.kernel.org/r/20240925133644.2922359-1-Raju.Rangoju@amd.com
    Patches: [V2,1/8] spi: spi_amd: Sort headers alphabetically
             [V2,2/8] spi: spi_amd: Enable dual and quad I/O modes
             [V2,3/8] spi: spi_amd: Replace ioread/iowrite calls
             [V2,4/8] spi: spi_amd: Updates to set tx/rx count functions
             [V2,5/8] spi: spi_amd: Optimize IO operations
             [V2,6/8] spi: spi_amd: Add support for HID2 SPI controller
             [V2,7/8] spi: spi_amd: Set controller address mode
             [V2,8/8] spi: spi_amd: Add HIDDMA basic read support

Series: Improve error handling in Rockchip SPI drivers
  Submitter: Dragan Simic <dsimic@manjaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=893053
  Lore link: https://lore.kernel.org/r/cover.1727337732.git.dsimic@manjaro.org
    Patches: [1/5] spi: rockchip: Perform trivial code cleanups
             [5/5] spi: rockchip-sfc: Use dev_err_probe() in the probe path

Series: Add dev_warn_probe() and improve error handling in Rockchip SPI drivers
  Submitter: Dragan Simic <dsimic@manjaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=893723
  Lore link: https://lore.kernel.org/r/cover.1727601608.git.dsimic@manjaro.org
    Patches: [v3,1/5] spi: rockchip: Perform trivial code cleanups
             [v3,3/5] spi: rockchip-sfc: Use dev_err_probe() in the probe path

Series: spi: replace and remove {devm_}spi_alloc_master/slave()
  Submitter: Yang Yingliang <yangyingliang@huaweicloud.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=885878
  Lore link: https://lore.kernel.org/r/20240902125947.1368-1-yangyingliang@huaweicloud.com
    Patches: [-next,1/7] media: usb/msi2500: switch to use spi_alloc_host()
             [-next,2/7] media: netup_unidvb: switch to use devm_spi_alloc_host()
             [-next,3/7] spi: ch341: switch to use devm_spi_alloc_host()
             [-next,4/7] spi: slave-mt27xx: switch to use spi_alloc_target()
             [-next,5/7] video: fbdev: mmp: switch to use spi_alloc_host()
             [-next,7/7] spi: remove {devm_}spi_alloc_master/slave()


Total patches: 18

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




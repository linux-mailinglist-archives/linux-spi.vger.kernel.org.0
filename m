Return-Path: <linux-spi+bounces-605-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D8283722C
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 20:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C4B28F523
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 19:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63973F8C4;
	Mon, 22 Jan 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CciTQ8pt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28AD3EA8E
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949882; cv=none; b=oIl+i/f74pDhiu9BviqgBRUV/pZrkNxKAzKV3Kc+s72Zm1cYMnOE4PDSKPP4KjRQvy6JHXTlKhgvDkUvnABUrXzMGgU3XHgxMAdGmUt2+0z7Pjo31cG+v70SI8/wfnKRL43a3344jQjutxyHF9Yv1bR7LZAwKvHMOVzwm54e6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949882; c=relaxed/simple;
	bh=9L40RUVUs1hzk9AMwWkM939R3xoLxndViDnkiTdIAbQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rLvW3Sp/fZrpyd6JE/VtFLanupjAK1WOakCnH8znw5n8M3SNJViboHQCXsKpsog4eVOjrkYeHae8CZPIfE4fWM2OwaXWOtNX/9MhsAQ2FXsMxMCsBWzSkeyeCmuIh5T7i/sAqgxdngbEtzpswNiTAL1JbQR24hN8LwWj8QSbYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CciTQ8pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D90AC43394;
	Mon, 22 Jan 2024 18:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705949882;
	bh=9L40RUVUs1hzk9AMwWkM939R3xoLxndViDnkiTdIAbQ=;
	h=Subject:From:Date:To:From;
	b=CciTQ8ptxpgKCf4+4UvUCsjdXGFfZcyfl/zYQa27bBvsOzO1s9yA99TaT3lPScOsn
	 X36mf+W6K7eaSh+7mapv7Cj3aUxGcRiNlGJilVkh5kDJa7QdTQ/vrTfPnWTqAIlql+
	 NuQ5AAS5RRZe8sNoH/8DyLMIQOaUnqdFDF50bDIU5Qf31hwQWaygp1u5JPQUQf9K12
	 Zh9q23nwSQ3kOd+q3EFeddkubCjQ9K5n84oHhPHDnDxZJ9p9s/TPDYLii8W5W2r7+5
	 2/hsfHLtiZA1VmXoU0KkIo7ZsVSayTYrmszMJdo6LBaZ5iJjVM81Qu4ToT5nfJVqjr
	 RQWbiHSr1Zdsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27ED7D8C9A8;
	Mon, 22 Jan 2024 18:58:02 +0000 (UTC)
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
 <170594988208.26363.6546714458228909127.git-patchwork-housekeeping@kernel.org>
Date: Mon, 22 Jan 2024 18:58:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: get rid of some legacy macros (2024-01-22T18:07:13)
  Superseding: [v1] spi: get rid of some legacy macros (2024-01-15T20:12:50):
    [01/33] fpga: ice40-spi: Follow renaming of SPI "master" to "controller"
    [02/33] ieee802154: ca8210: Follow renaming of SPI "master" to "controller"
    [03/33] iio: adc: ad_sigma_delta: Follow renaming of SPI "master" to "controller"
    [04/33] Input: pxspad - follow renaming of SPI "master" to "controller"
    [05/33] Input: synaptics-rmi4 - follow renaming of SPI "master" to "controller"
    [06/33] media: mgb4: Follow renaming of SPI "master" to "controller"
    [07/33] media: netup_unidvb: Follow renaming of SPI "master" to "controller"
    [08/33] media: usb/msi2500: Follow renaming of SPI "master" to "controller"
    [09/33] media: v4l2-subdev: Follow renaming of SPI "master" to "controller"
    [10/33] misc: gehc-achc: Follow renaming of SPI "master" to "controller"
    [11/33] mmc: mmc_spi: Follow renaming of SPI "master" to "controller"
    [12/33] mtd: dataflash: Follow renaming of SPI "master" to "controller"
    [13/33] mtd: rawnand: fsl_elbc: Let .probe retry if local bus is missing
    [14/33] net: ks8851: Follow renaming of SPI "master" to "controller"
    [15/33] net: vertexcom: mse102x: Follow renaming of SPI "master" to "controller"
    [16/33] platform/chrome: cros_ec_spi: Follow renaming of SPI "master" to "controller"
    [17/33] spi: bitbang: Follow renaming of SPI "master" to "controller"
    [18/33] spi: cadence-quadspi: Don't emit error message on allocation error
    [19/33] spi: cadence-quadspi: Follow renaming of SPI "master" to "controller"
    [20/33] spi: cavium: Follow renaming of SPI "master" to "controller"
    [21/33] spi: geni-qcom: Follow renaming of SPI "master" to "controller"
    [22/33] spi: loopback-test: Follow renaming of SPI "master" to "controller"
    [23/33] spi: slave-mt27xx: Follow renaming of SPI "master" to "controller"
    [24/33] spi: spidev: Follow renaming of SPI "master" to "controller"
    [25/33] staging: fbtft: Follow renaming of SPI "master" to "controller"
    [26/33] staging: greybus: spi: Follow renaming of SPI "master" to "controller"
    [27/33] tpm_tis_spi: Follow renaming of SPI "master" to "controller"
    [28/33] usb: gadget: max3420_udc: Follow renaming of SPI "master" to "controller"
    [29/33] video: fbdev: mmp: Follow renaming of SPI "master" to "controller"
    [30/33] wifi: libertas: Follow renaming of SPI "master" to "controller"
    [31/33] spi: fsl-lib: Follow renaming of SPI "master" to "controller"
    [32/33] spi: Drop compat layer from renaming "master" to "controller"
    [33/33] Documentation: spi: Update documentation for renaming "master" to "controller"


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



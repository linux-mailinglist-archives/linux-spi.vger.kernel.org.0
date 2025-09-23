Return-Path: <linux-spi+bounces-10238-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96325B95BD0
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 13:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F28116DCA1
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BD331DD87;
	Tue, 23 Sep 2025 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3gJoQGy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD24369A
	for <linux-spi@vger.kernel.org>; Tue, 23 Sep 2025 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758628307; cv=none; b=ep3kfBXGNdS+vz1KOIMU5V+6TbIW3/ahRZwaH8+VsD87ieUZ2z3fYvorJX+oz/tfZ6aoXP9vkeU3NUEtg66uxSN+7LQNRDqmsDjyln6DnlcV4ry9t4C/rE29zPlHmx1v0L34dAFEpJNVgHsWXB3NsiS65B+KeYsvPaIOM5+DNz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758628307; c=relaxed/simple;
	bh=kqWgoUJRZUZx+VH70QDHfk5Wey8NenyPerhxodQ+UIw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KxTOlFkeMcitQ1NXg5VV0xZTmEFWpxXecdWDuLpgEz49zf61Ivh8p54kH939OORVuljO65M8yx0ODykbM91TzYUAKxONmrQcGcoDQCNp0l0ikzT6v8MhCAML9hqlnPyL8OlGR+bjwQJwTKWxotECZGlaDGVW4c5J2D/VmOs7HrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3gJoQGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239C1C4CEF5;
	Tue, 23 Sep 2025 11:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758628307;
	bh=kqWgoUJRZUZx+VH70QDHfk5Wey8NenyPerhxodQ+UIw=;
	h=Subject:From:Date:To:From;
	b=j3gJoQGysRfM+Zop7mSANso/+j7b1T22D/VzCHzoHRYrdc3nY91PpACH4OeMi1hVu
	 d/As70d9PHhziw3UBFIrZLBPvwn+u6x8A/MNLvewz7K9//fmZNy5y6svoRj00Md9+G
	 ZSfzziSvjcb8eB1B3eehraDMVOU+frDSPRcMQNM6A16znbET0JW/rIsCt8l86mvU+k
	 K9nQZAOzXJx441i9xzWHOwJTMXh87fxTsu62FCeMjJmLA8r+V8LoqLrgLy17W9vk9Z
	 pJUwI3KlpJC24s6v09xSNJ2y0qtXpJDZ7GG/OD3eYHFtg9c3ug8F3wtPLYeBCkqmaW
	 LKNjdyeRQQGlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7492D39D0C20;
	Tue, 23 Sep 2025 11:51:45 +0000 (UTC)
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
 <175862830399.1398273.16952907817367866640.git-patchwork-summary@kernel.org>
Date: Tue, 23 Sep 2025 11:51:43 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: multi CS cleanup and controller CS limit removal
  Submitter: Jonas Gorski <jonas.gorski@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1002622
  Lore link: https://lore.kernel.org/r/20250915183725.219473-1-jonas.gorski@gmail.com
    Patches: [v2,1/7] spi: fix return code when spi device has too many chipselects
             [v2,2/7] spi: keep track of number of chipselects in spi_device
             [v2,3/7] spi: move unused device CS initialization to __spi_add_device()
             [v2,4/7] spi: drop check for validity of device chip selects
             [v2,5/7] spi: don't check spi_controller::num_chipselect when parsing a dt device
             [v2,6/7] spi: reduce device chip select limit again
             [v2,7/7] spi: rename SPI_CS_CNT_MAX => SPI_DEVICE_CS_CNT_MAX

Series: Virtio SPI Linux driver
  Submitter: Haixu Cui <quic_haixcui@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=999938
  Lore link: https://lore.kernel.org/r/20250908092348.1283552-1-quic_haixcui@quicinc.com
    Patches: [v10,1/3] virtio: Add ID for virtio SPI
             [v10,2/3] virtio-spi: Add virtio-spi.h
             [v10,3/3] SPI: Add virtio SPI driver

Series: spi: rpc-if: Add resume support for RZ/G3E
  Submitter: Biju Das <biju.das.jz@bp.renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1004630
  Lore link: https://lore.kernel.org/r/20250921112649.104516-1-biju.das.jz@bp.renesas.com
    Patches: [1/2] spi: rpc-if: Drop deprecated SIMPLE_DEV_PM_OPS
             [2/2] spi: rpc-if: Add resume support for RZ/G3E


Total patches: 12

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




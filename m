Return-Path: <linux-spi+bounces-1400-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CDA857720
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 08:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2E91F233DC
	for <lists+linux-spi@lfdr.de>; Fri, 16 Feb 2024 07:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2380017BCC;
	Fri, 16 Feb 2024 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUuwxPv7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC21BC2A
	for <linux-spi@vger.kernel.org>; Fri, 16 Feb 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070183; cv=none; b=V5OAK1GeuHGoa4tUpEdoZKzdJy9oox4Y81nkXr+ujKL8ls2rL6DqCnQHVDS2NpEQPnBugek2w38h7ts1Xi4w/j75AnT2ANyJPb1Ki9r0iY21I20ppL8KuVb09PbHlCneeAzTV2MQxLwAU3dnUauxeXKK9l0sR2clHksIlDhp+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070183; c=relaxed/simple;
	bh=OUzVTKSDTG3Dh1zgMAuDCtJtySC7lRTHx/SYb4zoKxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=K/zQxGIlRt09wfSfzoDwsGM1zHJF+uTOtVJmyL27+eukn+oQsmpmq7bXNqz2vlfxtYJoeGZC/JCWhHLa8f4F8CQn4pDanaSmgtKOXaviJ3RFn/bkfMNu5/XhPZhc+Y+VzCQKVcfii6PbebyrFHD0LkHo+UJ5uK/hS+RUcTMx2Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUuwxPv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6861DC43399;
	Fri, 16 Feb 2024 07:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708070182;
	bh=OUzVTKSDTG3Dh1zgMAuDCtJtySC7lRTHx/SYb4zoKxM=;
	h=Subject:From:Date:To:From;
	b=BUuwxPv7ONpzQIbTCrdicVgSgeLSGvxZ/6Bbb1CPW2WWC+ub/q3KxwSdLkKRBS+2w
	 ywEBYAtCebKTnoNuvrfoRE/uRIAJu0G0nfr7hb0QMZaY95BEfD0Prk+KNvR0S6ffKL
	 noKSYsxrJahLDElHXx2fs6AmPHMxOUdjDz95/iEvfrT8h8Txo2JSfr9/d8U+54WMho
	 x+eI2MOzFmbty1kkzixqtoDD4MDx0/p+DL23sROSBNai0peFkXZZkuZpkgDvPxyIKi
	 OzRUDR2Fge1WYyk2tbQwFfWowF0m+KOBmsg3aCAFgWmLJU2xgB6tn0L5E91HXZekY5
	 Zw9s76QK4XHnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45412D8C966;
	Fri, 16 Feb 2024 07:56:22 +0000 (UTC)
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
 <170807018222.17459.17345161599203898642.git-patchwork-housekeeping@kernel.org>
Date: Fri, 16 Feb 2024 07:56:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: s3c64xx: remove OF alias ID dependency (2024-02-16T07:05:43)
  Superseding: [v2] spi: s3c64xx: remove OF alias ID dependency (2024-02-12T14:03:19):
    [v2,01/12] spi: dt-bindings: introduce FIFO depth properties
    [v2,02/12] spi: s3c64xx: define a magic value
    [v2,03/12] spi: s3c64xx: allow full FIFO masks
    [v2,04/12] spi: s3c64xx: determine the fifo depth only once
    [v2,05/12] spi: s3c64xx: retrieve the FIFO depth from the device tree
    [v2,06/12] spi: s3c64xx: allow FIFO depth to be determined from the compatible
    [v2,07/12] spi: s3c64xx: let the SPI core determine the bus number
    [v2,08/12] spi: s3c64xx: introduce s3c64xx_spi_set_port_id()
    [v2,09/12] spi: s3c64xx: get rid of the OF alias ID dependency
    [v2,10/12] spi: s3c64xx: deprecate fifo_lvl_mask, rx_lvl_offset and port_id
    [v2,11/12] spi: s3c64xx: switch gs101 to new port config data
    [v2,12/12] spi: s3c64xx: switch exynos850 to new port config data


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



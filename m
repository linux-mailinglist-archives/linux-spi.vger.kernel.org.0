Return-Path: <linux-spi+bounces-11476-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D33DBC7FC5D
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 10:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A103B4E42A9
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DB124B28;
	Mon, 24 Nov 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDwSi/iO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7E279334
	for <linux-spi@vger.kernel.org>; Mon, 24 Nov 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763978274; cv=none; b=uD/8xLTUF7P0GHYN/smMWvVCVRhfmvYILZHpEWe96hFOs+vaPHa+4vGbEc2pxMB1HDevb8yf/QRoIWEVtk4IWu1tSg3bE2TFjeHXQIWZWAb/A86mpdTHFL9RM3miRmWgTHVqV6yOPKuMl6PvYdW5AWedMWaqXYCIZ7rVgiG9m8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763978274; c=relaxed/simple;
	bh=3CzWuh4IMX9CBPvL53lYdYW3iOHnf4epPueAJHzNrG0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Jjo6+FOr1dN2tVKvy9ARVt9YxURcUevhpAkVCARRuGvKLfwd3D1RxJAQO/6qEBza4b/go8G95/sZ+jRzmQXVJe8ZkNRarJZzxZuMPBwfDBbc5d4KwC26TneaNqHdfazy06Rdw3JqcRp/GZ4ZR6vf81l30Dy8kRPqPDgjO+Z+vts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDwSi/iO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606B9C4CEF1;
	Mon, 24 Nov 2025 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763978274;
	bh=3CzWuh4IMX9CBPvL53lYdYW3iOHnf4epPueAJHzNrG0=;
	h=Subject:From:Date:To:From;
	b=UDwSi/iOZGewdyO3WpsrI3ZYbMJzbxnHS3RlbHiFpV1rlDSZ/CGnqdAMBwvIdigsH
	 IehPQSXpe3mmZhdWTNZDisZpvTIMccsc6zllJCCWsXU++9c2/IGADL5ZQbXDxRgwki
	 kyjhIaC0JUtSHKP5BcG1Ho8/NhaCDq2YpGmRybsZHNysaJnoQ0RyeD8VUwILUPMtKO
	 9uTWCpOhXrxpmVOYNJiZTfi9R9oxNRYtW4Ns+WEwcldnEy5aLALrcxzjQCgWniXN9c
	 qBTC4GZsqaeEYS3PQ3iaK7AJaoRFxCOIqZ1BmJR28k6EDQMWtPUO3gL923aCrmSn4u
	 Lni9A4Nmetynw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEC6D3A86259;
	Mon, 24 Nov 2025 09:57:18 +0000 (UTC)
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
 <176397823727.3659436.424302133878043357.git-patchwork-housekeeping@kernel.org>
Date: Mon, 24 Nov 2025 09:57:17 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Add support for NXP XSPI (2025-11-24T09:25:20)
  Superseding: [v4] Add support for NXP XSPI (2025-11-19T10:42:27):
    [v4,1/2] dt-bindings: spi: Document imx94 xspi
    [v4,2/2] spi: add driver for NXP XSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



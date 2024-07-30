Return-Path: <linux-spi+bounces-4091-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6017A94113B
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 13:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17234282CE9
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 11:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCEA19307A;
	Tue, 30 Jul 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU/7nhOo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495E118C336
	for <linux-spi@vger.kernel.org>; Tue, 30 Jul 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722340587; cv=none; b=oAYtZiai91DTCKKTPHv+59NKX1ZIoQbZXBg0q67Rj2u9i6reDrmDvz65Q7v1hoRxf3kQFNxu3U8qsLXbjDmaledaTrQ0fGbJMNA/6Jq16REp4qJRQEAVlM4ZGs1ccmkGbJXDU+HxxWVFjwIaHgLeCTp1A9G0Q5iafTL41oI/7EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722340587; c=relaxed/simple;
	bh=79MuZmBIpYaqZwAkMqpTyi6owN0CuktR3TDDxU15nBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=m27xZepltfhqeMgUWqCwt2qjHGPrC4dEJ51+w6OdYjQctQKE6QuWaOrfNb9URx5Jr4DKcFJtXK5QhNu1JrjlTO6GjupFdFbndcagQMFam6m9ibSsESFdPje7Ubm3UEAM6sX3pJ8IWPGNgPCw8CRGjewuObVrBnvviv+W5Qk2nDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU/7nhOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF82FC4AF09;
	Tue, 30 Jul 2024 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722340586;
	bh=79MuZmBIpYaqZwAkMqpTyi6owN0CuktR3TDDxU15nBU=;
	h=Subject:From:Date:To:From;
	b=XU/7nhOoA+aXbYJM7ZFxuh97xuHJrCxZfz7eGz0lVhh4JuCv5XwmSUSorXOhPs/f9
	 Ng9zdCfatLO0zBow5arbA7sVtGmeyRvy7WKcqUGb2F4+TIPqPNwGbP6qwiROfvJCGE
	 yqLWLIJ1MZSjY6/fmNuo+HdMcTQeUklGFuWvTULXRx1FNsN82w+vX70T/+Yw0V4XXU
	 jjGTUj3YhjboetNXKuZB809qsLU136ukgxsCxd8qtFta/gqicZtz6tvH/57sbVGSj5
	 AiZoO0qYoBBt8WosxIrNizKfBa1k+DFlLe5frd2QIaVVFehG0CTBPjlojiwSoYKvo4
	 JvbzZLScmE6vA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0241C4332C;
	Tue, 30 Jul 2024 11:56:26 +0000 (UTC)
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
 <172234058678.29909.647472715747287753.git-patchwork-housekeeping@kernel.org>
Date: Tue, 30 Jul 2024 11:56:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v12] Marvell HW overlay support for Cadence xSPI (2024-07-30T11:45:25)
  Superseding: [v11] Marvell HW overlay support for Cadence xSPI (2024-07-24T15:47:31):
    [v11,1/9] spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
    [v11,2/9] spi: cadence: Add static PHY configuration in Marvell overlay
    [v11,3/9] spi: cadence: Add clock configuration for Marvell xSPI overlay
    [v11,4/9] spi: cadence: Add Marvell SDMA operations
    [v11,5/9] spi: cadence: Add Marvell xSPI interrupt changes
    [v11,6/9] spi: cadence: Add Marvell xfer operation support
    [v11,7/9] spi: cadence: Change resource mapping
    [v11,8/9] spi: cadence: Change cs property reading.
    [v11,9/9] spi: cadence: Try to read spi-tx/rx-bus width property using ACPI


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



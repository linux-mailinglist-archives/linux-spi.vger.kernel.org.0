Return-Path: <linux-spi+bounces-9184-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BFDB11B5A
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 11:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EB6AC1910
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 09:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3A1198E8C;
	Fri, 25 Jul 2025 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT1eKA93"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08792D3A71
	for <linux-spi@vger.kernel.org>; Fri, 25 Jul 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437522; cv=none; b=ZkbjmZyNvXASGOG1rRJBGv2kFOsZMCHS9pn4w/OkIqrBV5IkmXD1SjqE+AuxI+GtNv1J4nd1Hnvs1iyV4GknB6GGbe/+VAkGEjSURrf+WIeKKL++7O37dOe73VPqn2jVGosBK0eMdFi8r9HCOowj9tykUxMqNflc0AYmiaNqmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437522; c=relaxed/simple;
	bh=RO5m0jJcPFmRr2EPKb1Y5P0EvactRXwL3iHuZd0INfo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=F8vuIj5GK0TU1JZ8qXZytjXW7O2RSXswqAAsP47yP9hLCjPz9v14XOdtqXnXnmWMK8FPOygm7I9tE6jC8h240/Cqn+LOZ8ffH5Op6y+wthvLZ1RjKjnLRs5AK2/l7GsloRCuIIWC3mXAnI5OGXkfeVMBGmmh7y73Gh6kbTSiC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT1eKA93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C76C4CEE7;
	Fri, 25 Jul 2025 09:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753437521;
	bh=RO5m0jJcPFmRr2EPKb1Y5P0EvactRXwL3iHuZd0INfo=;
	h=Subject:From:Date:To:From;
	b=kT1eKA93IIFZ9ANtmcd2hPKZSWLrWGbjYm3DUWAUdQjU+mOGmJYkq1W4vLEMTmU58
	 PKORu1VHmQXzuD+T0jQBTwloZHcxr0Q39ix91ww9++Pn8mdyak9zI4wVD1+qqlKTKr
	 Ghhmjahw5vFDSg+hVfH5OxMfpOX40jZN6/jVV/7NWF2mSBXojT2eBlxxsV2H8oM9xs
	 44FRaTQxHaRP3FRx9pmNWbaXrWTu6lcj0f+w9MlbzucUL/+dTAAbFAlSOMtL9koz2z
	 N9kgWJtPkjzpguxZ2JUVWdL62d6ge4i5v/QiyiX+nl2hVG8xzYkeh0tHqpWfuc12pU
	 83OZvh00I8YsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D14383BF5B;
	Fri, 25 Jul 2025 09:59:00 +0000 (UTC)
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
 <175343753874.3074871.14749538077034624125.git-patchwork-housekeeping@kernel.org>
Date: Fri, 25 Jul 2025 09:58:58 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] Virtio SPI Linux driver (2025-07-25T09:41:41)
  Superseding: [v6] Virtio SPI Linux driver (2025-07-24T09:27:43):
    [RFC,v6,1/3] virtio: Add ID for virtio SPI
    [RFC,v6,2/3] virtio-spi: Add virtio-spi.h
    [RFC,v6,3/3] SPI: Add virtio SPI driver.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


